From: Tommi Virtanen <tv@inktank.com>
Subject: OSD hotplugging & Chef cookbook ("chef-1")
Date: Mon, 7 May 2012 15:58:19 -0700
Message-ID: <CADvuQRHwR5M_bvUsSMR=9qUuoYY_qRdTA5Sac=troYNxhaFxNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:54822 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2EGW6k convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 May 2012 18:58:40 -0400
Received: by dajt11 with SMTP id t11so1752161daj.10
        for <ceph-devel@vger.kernel.org>; Mon, 07 May 2012 15:58:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi. I've been working on easy deployability and manageability of Ceph.
This work is intended to be a complete replacement for mkcephfs, and
integrate new product features instead of just automating the
previous, clumsier, administration mechanisms. I'm using Chef to
create and expand the cluster, but most of the new functionality is in
making the OSDs more dynamic.

The current work is in a branch called "ceph-1", and will be improved
upon, but it is now at a stage where others should start looking at
it.

Here's a quick intro to what's there right now. Apologies for the
formatting, I need to be on a plane fairly soon.. Rest assured, any
command that looks clumsy is that way mostly because I haven't had
time to make it prettier. I'll go through this with our QA and tech
writer once the dust settles, to clean up the instructions.


Limitations (all to be removed later):
- supports only 1 monitor
- journal is a file inside osd data directory
- only supports 1 cluster (name hardcoded to "ceph"); later you will
be able to run multiple clusters on the same hardware
- no rgw, mds, or anything else but a RADOS/rbd cluster tested yet
- no integration with e.g. OpenStack yet


Open questions:
- I removed the sysv-style init script (from the debian packaging).
I'm not sure what to do with that. Older debs will still need it?
- details of what goes where in e.g. the chef environment will change;
input is welcome



How to try it out:

I need to leave to make to the airport in time, but the latest change
is still compiling :(
Wait till http://gitbuilder.ceph.com/ceph-deb-oneiric-x86_64-basic/ref/=
chef-1/sha1
says 4b75bccd52104d0ecd551e0656a30791b25fe032, hope for the best, and
proceed:


# create 3 vms running ubuntu 11.10 server; mine ended up being named
chef02, inst03, inst04
# they need to be able to talk to each other, so do not use KVM's
"user" networking, but NAT or bridged. (NAT is default for libvirt.)

# make sure your vm has a unique hostname first, or it'll get
confusing later; edit /etc/hostname, /etc/hosts, run "sudo hostname
newname", re-login

# source for this:
http://wiki.opscode.com/display/chef/Installing+Chef+Server+on+Debian+o=
r+Ubuntu+using+Packages

# figure out the IP address of your chef server vm
gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
gpg --export packages@opscode.com | sudo apt-key add -
sudo tee /etc/apt/sources.list.d/chef.list <<EOF
deb http://apt.opscode.com/ oneiric-0.10 main
deb-src http://apt.opscode.com/ oneiric-0.10 main
EOF
sudo apt-get update
sudo apt-get install chef
# answer using the IP address of your chef server vm
				=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4 Configuring chef =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
				=E2=94=82  This is the full URI that clients will use to connect to=
 the    =E2=94=82
				=E2=94=82  server.                                                 =
        =E2=94=82
				=E2=94=82  .                                                       =
        =E2=94=82
				=E2=94=82  This will be used in /etc/chef/client.rb as 'chef_server=
_url'.  =E2=94=82
				=E2=94=82                                                          =
        =E2=94=82
				=E2=94=82 URL of Chef Server (e.g., http://chef.example.com:4000): =
        =E2=94=82
				=E2=94=82                                                          =
        =E2=94=82
				=E2=94=82 http://192.168.122.168:4000/_____________________________=
_______ =E2=94=82
				=E2=94=82                                                          =
        =E2=94=82
				=E2=94=82                              <Ok>                        =
        =E2=94=82
				=E2=94=82                                                          =
        =E2=94=82
				=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

sudo apt-get install chef-server
# you MUST enter some password here or the installation will fail; no
human will need to type this ever again
			=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4 Configuring c=
hef-solr
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
			=E2=94=82  Set the password for the chef user in the AMQP server que=
ue. Use
               =E2=94=82
			=E2=94=82  RabbitMQ's rabbitmqctl program to set this password. The =
default
user           =E2=94=82
			=E2=94=82  and vhost are assumed (chef and /chef, respectively).
               =E2=94=82
			=E2=94=82  .
               =E2=94=82
			=E2=94=82  RabbitMQ does not have the capability to read the passwor=
d from
a file, and     =E2=94=82
			=E2=94=82  this will be passed via "" on the command-line. As such, =
do not
use shell       =E2=94=82
			=E2=94=82  meta-characters that could cause errors such as !.
               =E2=94=82
			=E2=94=82  .
               =E2=94=82
			=E2=94=82  This will be used in /etc/chef/solr.rb and /etc/chef/serv=
er.rb
as 'amqp_pass'.  =E2=94=82
			=E2=94=82
               =E2=94=82
			=E2=94=82 New password for the 'chef' AMQP user in the RabbitMQ vhos=
t
"/chef":             =E2=94=82
			=E2=94=82
               =E2=94=82
			=E2=94=82 aipo6EY2i_________________________________________________=
______________________
=E2=94=82
			=E2=94=82
               =E2=94=82
			=E2=94=82                                      <Ok>
               =E2=94=82
			=E2=94=82
               =E2=94=82
			=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

# if you use the chef web ui, you'll be typing this in a lot.. "foo"
is nice for demo-level security
			 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4 Configuring chef-server-webui
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90
			 =E2=94=82  This sets a temporary first-use password to log into the=
 Chef
Server WebUI   =E2=94=82
			 =E2=94=82  as the 'admin' user for the first time. Once logged in, =
the
password should  =E2=94=82
			 =E2=94=82  be changed immediately.
             =E2=94=82
			 =E2=94=82  .
             =E2=94=82
			 =E2=94=82  Once the chef-server-webui process is running, login usi=
ng the
username      =E2=94=82
			 =E2=94=82  'admin' using the password set here.
             =E2=94=82
			 =E2=94=82  .
             =E2=94=82
			 =E2=94=82  If a password is not entered, the webui default password=
 for
'admin' will    =E2=94=82
			 =E2=94=82  be used, which is displayed on the webui home page. The
password must be     =E2=94=82
			 =E2=94=82  at least 6 characters or the webui will not start proper=
ly.
             =E2=94=82
			 =E2=94=82  .
             =E2=94=82
			 =E2=94=82  This will be used in /etc/chef/webui.rb as
'web_ui_admin_default_password'.  =E2=94=82
			 =E2=94=82  .
             =E2=94=82
			 =E2=94=82
             =E2=94=82
			 =E2=94=82 New password for the 'admin' user in the Chef Server WebU=
I:
             =E2=94=82
			 =E2=94=82
             =E2=94=82
			 =E2=94=82 foo______________________________________________________=
____________________
=E2=94=82
			 =E2=94=82
             =E2=94=82
			 =E2=94=82                                    <Ok>
             =E2=94=82
			 =E2=94=82
             =E2=94=82
			 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98

# configure knife on the chef server
ssh ubuntu@chef02
mkdir -p ~/.chef
sudo cp /etc/chef/validation.pem /etc/chef/webui.pem ~/.chef
sudo chown -R $USER ~/.chef
knife configure -i
WARNING: No knife configuration file found
Where should I put the config file? [~/.chef/knife.rb]
Please enter the chef server URL: [http://ubuntu:4000] http://localhost=
:4000
Please enter a clientname for the new client: [ubuntu] chef-admin
Please enter the existing admin clientname: [chef-webui]
Please enter the location of the existing admin client's private key:
[/etc/chef/webui.pem] .chef/webui.pem
Please enter the validation clientname: [chef-validator]
Please enter the location of the validation key:
[/etc/chef/validation.pem] .chef/validation.pem
Please enter the path to a chef repository (or leave blank):
Creating initial API user...
Created client[chef-admin]
Configuration file written to /home/ubuntu/.chef/knife.rb

## OPTIONAL: if you want to use chef directly from your desktop,
configure that now, following the instructions on the webpage given at
the beginning
# knife-block is a nice utility for connecting to multiple
chef-servers, you might want that
# http://os.greenandsecure.co.uk/2012/03/using-multiple-chef-servers-wi=
th-knife/
# configure knife on your desktop machine; this writes to ~/.gem
gem1.9.1 install --no-rdoc --no-ri --user-install chef
gem1.9.1 install --no-rdoc --no-ri --user-install knife-block
ssh ubuntu@chef02 knife client create my-username -n -a -f /tmp/my-user=
name.pem
Created client[tv-test2]

mkdir ~/.chef
# grab the validation key
cd ~/.chef
scp ubuntu@chef02:/tmp/tv-test2.pem ~/.chef/my-username.pem
knife block new

This will create a new knife configuration file for you to use with kni=
fe-block
Please provide a friendly name for the new configuration file: test2
Please enter the url to your Chef Server: http://192.168.122.168:4000/
Please enter an existing username or clientname for the API:
[your-login] my-username
Please enter the validation clientname: [chef-validator]
Please enter the location of the validation key:
[/etc/chef/validation.pem] .chef/validation-test2.pem
Please enter the path to a chef repository (or leave blank):
*****

You must place your client key in:
  /home/your-login/.chef/my-username.pem
Before running commands with Knife!

*****

You must place your validation key in:
  /etc/chef/validation.pem
Before generating instance data with Knife!

*****
Configuration file written to /home/your-login/.chef/knife-test2.rb
/home/your-login/.chef/knife-test2.rb has been sucessfully created
The available chef servers are:
  ...
You are asking to change from test to test2. Are you sure? (Y/N) y
The knife configuration has been updated to use test2
## END OPTIONAL

# now configure the actual ceph cluster vms

# give them a data disk or two, in addition to the disk containing the
root filesystem
# (hint: for experiments ONLY, uncheck "Allocate entire disk now",
choose "Device type: Virtio disk", "Cache mode: writeback" for best
performance)

# again, ensure unique hostnames

# source for this:
http://wiki.opscode.com/display/chef/Installing+Chef+Client+on+Ubuntu+o=
r+Debian

# same stuff as beginning of the chef-server installation, repeat for e=
very vm
gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
gpg --export packages@opscode.com | sudo apt-key add -
sudo tee /etc/apt/sources.list.d/chef.list <<EOF
deb http://apt.opscode.com/ oneiric-0.10 main
deb-src http://apt.opscode.com/ oneiric-0.10 main
EOF
sudo apt-get update
sudo apt-get install chef
# answer using the IP address of your chef server vm
				=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4 Configuring chef =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
				=E2=94=82  This is the full URI that clients will use to connect to=
 the    =E2=94=82
				=E2=94=82  server.                                                 =
        =E2=94=82
				=E2=94=82  .                                                       =
        =E2=94=82
				=E2=94=82  This will be used in /etc/chef/client.rb as 'chef_server=
_url'.  =E2=94=82
				=E2=94=82                                                          =
        =E2=94=82
				=E2=94=82 URL of Chef Server (e.g., http://chef.example.com:4000): =
        =E2=94=82
				=E2=94=82                                                          =
        =E2=94=82
				=E2=94=82 http://192.168.122.168:4000/_____________________________=
_______ =E2=94=82
				=E2=94=82                                                          =
        =E2=94=82
				=E2=94=82                              <Ok>                        =
        =E2=94=82
				=E2=94=82                                                          =
        =E2=94=82
				=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

# copy the validation key over, run on your desktop
ssh chef02 sudo cat /etc/chef/validation.pem | ssh inst03 sudo tee
/etc/chef/validation.pem >/dev/null
# chef should now work on the new node! you can trigger a run manually:
ssh inst03 sudo chef-client

# if you set up your workstation as a knife client, you can do the
following there; if not, you have to do this logged in to the chef
server

# doublecheck
knife node list
  chef02
  inst03
  inst04
# clone the cookbook
git clone https://github.com/ceph/ceph-cookbooks.git
cd ceph-cookbooks
# edit ~/.chef/knife-test2.rb (or knife.rb if you don't use knife-block=
) and add
#   cookbook_path
["/home/something/path/to/your/clone/ceph-cookbooks"]

# currently the rgw cookbook forces us to have the apache2 cookbook
available; do that
# source: http://wiki.opscode.com/display/chef/Managing+Cookbooks+With+=
Knife
knife cookbook site download apache2
tar xzf apache2-1.1.8.tar.gz
knife cookbook upload apache2
# TODO cleanup the btrfs and parted cookbook remains
knife cookbook upload btrfs ceph
# let's create some roles (the cookbooks currently hardcode the
"ceph-mon" role name, you must use that name for now)
cat >ceph-mon.rb <<EOF
name "ceph-mon"
description "Ceph monitor server"
run_list(
	 'recipe[ceph::single_mon]'
)
EOF
cat >ceph-osd.rb <<EOF
name "ceph-osd"
description "Ceph object store"
run_list(
	 'recipe[ceph::bootstrap_osd]',
)
EOF
knife role from file ceph-mon.rb ceph-osd.rb

# create a chef environment to contain the configuration, set the ceph
branch to deploy (must be "chef-1" for now)
knife environment create demo2
#  "default_attributes": {
#    "ceph_branch": "chef-1"
#  },
knife node edit inst03
#  "chef_environment": "demo2",
#  "run_list": [
#    "recipe[ceph::apt]",
#    "role[ceph-mon]",
#    "role[ceph-osd]"
#  ]
knife node edit inst04
#  "chef_environment": "demo2",
#  "run_list": [
#    "recipe[ceph::apt]",
#    "role[ceph-osd]"
#  ]

# run chef-client a few rounds (first to get mon going, then to get
the osd bootstrap files in place)
ssh inst03 sudo chef-client
ssh inst03 sudo chef-client
ssh inst04 sudo chef-client

# figure out what your ceph cluster uuid is; sorry, this is an eyeball
operation right now
ssh inst03 cat /var/lib/ceph/mon/ceph-single/log

# prep a disk for osd use; this can be done anywhere, in advance, and
a shelf of spare disks can be maintained at the data center
# run on inst03, inst04
# create a gpt partition with the magic uuid; repeat for /dev/vdb vdc e=
tc
sudo apt-get install gdisk
sudo gdisk /dev/vdb
GPT fdisk (gdisk) version 0.6.14

Partition table scan:
  MBR: not present
  BSD: not present
  APM: not present
  GPT: not present

Creating new GPT entries.

Command (? for help): o
This option deletes all partitions and creates a new protective MBR.
Proceed? (Y/N): y

Command (? for help): n
Partition number (1-128, default 1):
=46irst sector (34-16777182, default =3D 34) or {+-}size{KMGTP}:
Information: Moved requested sector from 34 to 2048 in
order to align on 2048-sector boundaries.
Use 'l' on the experts' menu to adjust alignment
Last sector (2048-16777182, default =3D 16777182) or {+-}size{KMGTP}:
Current type is 'Linux/Windows data'
Hex code or GUID (L to show codes, Enter =3D 0700):
4fbd7e29-9d25-41b8-afd0-062c0ceff05d
Changed type of partition to 'Unknown'

Command (? for help): w

=46inal checks complete. About to write GPT data. THIS WILL OVERWRITE E=
XISTING
PARTITIONS!!

Do you want to proceed, possibly destroying your data? (Y/N): y
OK; writing new GUID partition table (GPT).
he operation has completed successfully.

# mkfs and allocate disk to cluster; any filesystem is ok; use YOUR
uuid from mon
sudo mkfs -t ext4 /dev/vdb1
sudo mount -o user_xattr /dev/vdb1 /mnt
sudo ceph-disk-prepare --cluster-uuid=3D07535b46-8429-4efd-9b2d-6b11707=
52448 /mnt
sudo umount /mnt
# simulate hotplug event
sudo udevadm trigger --subsystem-match=3Dblock --action=3Dadd

# see it go!
sudo initctl list | grep ceph
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
