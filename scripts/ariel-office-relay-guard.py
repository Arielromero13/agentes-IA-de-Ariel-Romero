#!/usr/bin/python3
import json, os, subprocess
HERMES = 'hermes-agent-7yvk-hermes-agent-1'
RELAY = 'ariel-hermes-private-relay'
def inspect(name):
    return json.loads(subprocess.check_output(['docker', 'inspect', name], timeout=10))[0]
def netns(container):
    return os.readlink('/proc/' + str(container['State']['Pid']) + '/ns/net')
h, r = inspect(HERMES), inspect(RELAY)
if not h['State']['Running']:
    raise SystemExit(0)
mode = r['HostConfig']['NetworkMode']
if mode not in ('container:' + HERMES, 'container:' + h['Id']):
    raise SystemExit('Relay points to a different container; manual recreation required')
if not r['State']['Running'] or netns(h) != netns(r):
    subprocess.run(['docker', 'restart', '--time', '3', RELAY], check=True, timeout=30)
    r = inspect(RELAY)
    if netns(h) != netns(r):
        raise SystemExit('Relay network namespace still mismatched')
    print('Recovered DeskRPG private relay after Hermes restart')
