#!/usr/bin/python
import simplejson as json
import subprocess
import shlex

def runProcess(command):
    p = subprocess.Popen(command, stdout=subprocess.PIPE)
    while p.poll() is None:
        line = p.stdout.readline()
        yield line
def getOutput(command):
    command = shlex.split(command)
    return [line.decode('utf-8') for line in runProcess(command)]

class i3(object):
    def msg(self, message='', t='command'):
        return [json.loads(x) for x in getOutput('i3-msg -t %s %s'%(t, message)) if x][0]
    def get_workspaces(self):
        return self.msg(t='get_workspaces')
    def get_outputs(self):
        return self.msg(t='get_outputs')
    def get_tree(self):
        return self.msg(t='get_tree')
    def get_bar_config(self, bar_id):
        return self.msg(t='get_bar_config')
    def get_version(self):
        return self.msg(t='get_version')
class node(object):
    def __init__(self, item):
        self.border = item['border']
        self.current_border_width = item['current_border_width']
        self.floating = item['floating']
        self.floating_nodes = item['floating_nodes']
        self.focus = item['focus']
        self.focused = item['focused']
        self.fullscreen_mode = item['fullscreen_mode']
        self.geometry = item['geometry']
        self.id = item['id']
        self.last_split_layout = item['last_split_layout']
        self.layout = item['layout']
        self.name = item['name']
        self.nodes = [node(x) for x in item['nodes']]
        self.orientation = item['orientation']
        self.percent = item['percent']
        self.rect = item['rect']
        self.scratchpad_state = item['scratchpad_state']
        self.swallows = item['swallows']
        self.type = item['type']
        self.urgent = item['urgent']
        self.window = item['window']
        self.window_rect = item['window_rect']
        self.workspace_layout = item['workspace_layout']
        self.original = item
    def __str__(self):
        return str(self.original)
a = i3()
tree=node(a.get_tree())
for item in tree.nodes:
    print(item)
