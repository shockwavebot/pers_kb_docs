# introduction, concepts and types 
oc types 

# Login
oc login https://IP -u <USERNAME>
oc login https://IP:443 --token=<TOKEN>

# Context
oc config get-contexts
oc whoami --show-context  # show current context 

oc status 

# Projects 
oc projects             # list projects 
oc get projects         # list projects 
oc project myproj       # switch to myproj
oc new-project myproj   # create new proj

oc get all 
oc describe <resource>/<name>

# Apps 
# Add new app to the project
oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git



