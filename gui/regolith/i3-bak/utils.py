import subprocess
from i3ipc import Connection

i3 = Connection()
# Print the name of the focused window
focused = i3.get_tree().find_focused()
print('Focused window %s is on workspace %s' %
      (focused.name, focused.workspace().name))

def command(cmd):
    print("Executing i3 command: %s" % cmd)
    i3.command(cmd)

def run_dmenu(menu, *args):
    """ Run dmenu
        args : args passed to dmenu
        menu: list of possible choices
    returns the selected choice


    """
    process = subprocess.Popen(["dmenu"] + list(args),
        stdout=subprocess.PIPE,
        stdin=subprocess.PIPE)
    out = process.communicate(input=("\n".join(menu)+"\n").encode('utf-8'))[0]
    return out.strip().decode('utf-8')

def get_workspace_names():
    """ Get the list of workspace names

    """
    workspaces = i3.get_workspaces()
    return [x.name for x in workspaces]

def insert_new_workspace(workspaces, name):
    new_index = 1
    for workspace in workspaces:
        (w_index, w_name) = int(workspace[0]), workspace[3:]
        if w_name < name:
            new_index = w_index + 1
        else:
            new_name = "%i: %s" % (w_index+1, w_name)
            command('rename workspace "%s" to "%s"' % (workspace, new_name))
    new_name = "%i: %s" % (new_index, name)
    return new_name


def sort_workspaces():
    names = get_workspace_names()
    names = names.sort(key=lambda x: x[3:])
    for i, name in enumerate(get_workspace_names()):
        if name[0].isdigit():
          w_name = name[3:]
          new_name = "%i: %s"  % (i+1, w_name)
        else:
            new_name = "%i: %s" % (i+1, name); 
        if new_name != name:
            cmd = 'rename workspace "%s" to "%s"' % (name, new_name)
            command(cmd)
