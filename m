From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Could ceph-deploy handle unknown or custom distribution? (Was: Mourning
 the demise of mkcephfs)
Date: Mon, 18 Nov 2013 19:05:06 +1300
Message-ID: <5289AE12.6020102@catalyst.net.nz>
References: <5281192D.4090707@bob-the-boat.me.uk> <CANtztVwJyK7C5LS1G3YCLh-0T0VODCsUuWE1ADz_PupJe4nAAQ@mail.gmail.com> <5282F309.2030104@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030302090104000609070002"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:34835 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab3KRGFN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 01:05:13 -0500
In-Reply-To: <5282F309.2030104@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <alfredo.deza@inktank.com>, "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030302090104000609070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/13 16:33, Mark Kirkwood wrote:
> I believe he is using a self built (or heavily customized) Linux
> installation - so distribution detection is not going to work in this
> case. I'm wondering if there could be some sensible fall back for that,
> e.g:
>
> - refuse to install or purge
> - assume sysv init
>

It was raining here on Saturday so I thought I'd take a look at if this 
was even feasible (see attached). These patches are a rough experiment 
to see what *might* be involved in getting to a point where you could 
get a system going on one of the distributions (or a custom build) that 
we currently do not support. So view as a thought-in-progress rather 
than even wip :-) It could also be quite the wrong approach - that is 
ok, just let me know what you think. Hopefully even if it is wrong, it 
may help stimulate discussion (or patches) for how to do it right!

The 1st patch defines an 'unknown' distribution for cases where one of 
our well known cases is *not* detected. With it applied I can create 
mons and it will start them directly with ceph-mon.

The 2nd and 3rd patch do similarly for osd, defining a type of startup 
called 'direct' to mark the osd instance with. I needed to patch 
ceph-disk as well so it could start the resulting osd directly with 
ceph-osd, and add it into the crushmap at a (hopefully) sensible place.

(BTW I did want to do this all in ceph-deploy, but right now it does not 
know how to get an osd's id number from a disk device - mind you this 
could be useful to add for things like 'list' and 'destroy'... but I 
digress).

Anyway I have attached a log of me getting a system of 2 Archlinux nodes 
up. These were KVM guests built identically and ceph (0.72) was compiled 
from src and installed.

Cheers

Mark




--------------030302090104000609070002
Content-Type: text/x-patch;
 name="ceph-deploy-unknown-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph-deploy-unknown-0.patch"

commit 0629a803d7a1ecb651ed34c402c41f72bafaec7d
Author: Mark Kirkwood <mark.kirkwood@gmail.com>
Date:   Sun Nov 17 00:43:20 2013 +1300

    Initial prototype for handling unknown distribution types.

diff --git a/ceph_deploy/hosts/__init__.py b/ceph_deploy/hosts/__init__.py
index f4ba203..8f6a541 100644
--- a/ceph_deploy/hosts/__init__.py
+++ b/ceph_deploy/hosts/__init__.py
@@ -6,7 +6,7 @@ on the type of distribution/version we are dealing with.
 """
 import logging
 from ceph_deploy import exc, lsb
-from ceph_deploy.hosts import debian, centos, fedora, suse, remotes
+from ceph_deploy.hosts import debian, centos, fedora, suse, remotes, unknown
 from ceph_deploy.connection import get_connection
 
 logger = logging.getLogger()
@@ -62,6 +62,7 @@ def _get_distro(distro, fallback=None):
         'redhat': centos,
         'fedora': fedora,
         'suse': suse,
+        'unknown': unknown,
         }
     try:
         return distributions[distro]
@@ -79,4 +80,6 @@ def _normalized_distro_name(distro):
         return 'scientific'
     elif distro.startswith(('suse', 'opensuse')):
         return 'suse'
+    elif distro.startswith('unknown'):
+        return 'unknown'
     return distro
diff --git a/ceph_deploy/hosts/remotes.py b/ceph_deploy/hosts/remotes.py
index 62766f7..c759982 100644
--- a/ceph_deploy/hosts/remotes.py
+++ b/ceph_deploy/hosts/remotes.py
@@ -18,10 +18,21 @@ def platform_information():
         major_version = release.split('.')[0]
         codename = debian_codenames.get(major_version, '')
 
+    distro = str(distro).rstrip(),
+    distro = str(release).rstrip(),
+    distro = str(codename).rstrip()
+
+    if distro == '':
+        distro = 'unknown'
+    if release == '':
+        release = 'unknown'
+    if codename == '':
+        codename = 'unknown'
+
     return (
-        str(distro).rstrip(),
-        str(release).rstrip(),
-        str(codename).rstrip()
+        str(distro),
+        str(release),
+        str(codename)
     )
 
 
diff --git a/ceph_deploy/hosts/unknown/__init__.py b/ceph_deploy/hosts/unknown/__init__.py
new file mode 100644
index 0000000..d67ad7e
--- /dev/null
+++ b/ceph_deploy/hosts/unknown/__init__.py
@@ -0,0 +1,8 @@
+import mon
+
+# Allow to set some information about this distro
+#
+
+distro = None
+release = None
+codename = None
diff --git a/ceph_deploy/hosts/unknown/mon/__init__.py b/ceph_deploy/hosts/unknown/mon/__init__.py
new file mode 100644
index 0000000..fca0e0d
--- /dev/null
+++ b/ceph_deploy/hosts/unknown/mon/__init__.py
@@ -0,0 +1 @@
+from create import create
diff --git a/ceph_deploy/hosts/unknown/mon/create.py b/ceph_deploy/hosts/unknown/mon/create.py
new file mode 100644
index 0000000..ed2a3ba
--- /dev/null
+++ b/ceph_deploy/hosts/unknown/mon/create.py
@@ -0,0 +1,30 @@
+from ceph_deploy.hosts import common
+from ceph_deploy.lib.remoto import process
+
+
+def create(distro, args, monitor_keyring):
+    hostname = distro.conn.remote_module.shortname()
+    common.mon_create(distro, args, monitor_keyring, hostname)
+
+    # no idea about startup architecture so start directly, run + create keys
+    process.run(
+        distro.conn,
+        [
+            'ceph-mon',
+            '--cluster', args.cluster,
+            '-c', '/etc/ceph/{cluster}.conf'.format(cluster=args.cluster),
+            '-i', hostname,
+        ],
+        timeout=7,
+    )
+
+    process.run(
+        distro.conn,
+        [
+            'ceph-create-keys',
+            '--cluster', args.cluster,
+            '-i', hostname,
+        ],
+        timeout=7,
+    )
+

--------------030302090104000609070002
Content-Type: text/x-patch;
 name="ceph-deploy-unknown-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph-deploy-unknown-1.patch"

diff --git a/ceph_deploy/lsb.py b/ceph_deploy/lsb.py
index b7f3e73..2f608de 100644
--- a/ceph_deploy/lsb.py
+++ b/ceph_deploy/lsb.py
@@ -118,4 +118,6 @@ def choose_init(distro, codename):
     """
     if distro == 'Ubuntu':
         return 'upstart'
+    elif  distro == 'unknown':
+        return 'direct'
     return 'sysvinit'

--------------030302090104000609070002
Content-Type: text/x-patch;
 name="ceph-disk-unknown-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph-disk-unknown-0.patch"

*** ceph-disk.orig	Sun Nov 17 11:34:33 2013
--- ceph-disk	Mon Nov 18 13:21:20 2013
***************
*** 96,101 ****
--- 96,102 ----
      'upstart',
      'sysvinit',
      'systemd',
+     'direct',
      'auto',
      ]
  
***************
*** 1438,1443 ****
--- 1439,1470 ----
                      'osd.{osd_id}'.format(osd_id=osd_id),
                      ],
                  )
+         elif os.path.exists(os.path.join(path, 'direct')):
+             # no idea about which init, start directly and set crush location
+             subprocess.check_call(
+                 args=[
+                     '/usr/bin/ceph-osd',
+                     #'--cluster', args.cluster,
+                     #'-c', '/etc/ceph/{cluster}.conf'.format(cluster=args.cluster),
+                     '-i', '{osd_id}'.format(osd_id=osd_id),
+                     ],
+                 )
+ 
+             # assume weight 1 (wrong but easy to change)!
+             subprocess.check_call(
+                 args=[
+                     '/usr/bin/ceph',
+                     #'--cluster', args.cluster,
+                     #'-c', '/etc/ceph/{cluster}.conf'.format(cluster=args.cluster),
+                     'osd',
+                     'crush',
+                      'add',
+                     'osd.{osd_id}'.format(osd_id=osd_id),
+                     '1',
+                     'root=default',
+                     'host={hostname}'.format(hostname=platform.node()),
+                     ],
+                 )
          else:
              raise Error('{cluster} osd.{osd_id} is not tagged with an init system'.format(
                      cluster=cluster,
***************
*** 1683,1690 ****
--- 1710,1722 ----
                      (distro, release, codename) = platform.dist()
                      if distro == 'Ubuntu':
                          init = 'upstart'
+                     if distro == 'unknown' or distro == '':
+                         LOG.debug('distro is empty, assuming init is direct')
+                         init = 'direct'
                      else:
                          init = 'sysvinit'
+             if init == 'direct':
+                 LOG.debug('init is direct')
  
              LOG.debug('Marking with init system %s', init)
              with file(os.path.join(path, init), 'w'):

--------------030302090104000609070002
Content-Type: text/plain; charset=UTF-8;
 name="NOTES-unknown"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="NOTES-unknown"

After applying patch for unknown distro
=======================================

State:

- monitors created and start ok
- osd created ok
  * not started (startup by ceph-disk)
  * no crush setting (set by init scripts)

Test on Archlinux hosts (zor[2,3]), running ceph-deploy from Ubuntu workstation 
(localhost)


1/ Do src build installing binaries and udev:

(zor2) $ sudo make install
(zor2) $ sudo cp udev/* /lib/udev/rules.d/
(zor2) $ cd /var/lib/ceph;sudo mkdir bootstrap-mds bootstrap-osd mds mon osd tmp
(zor2) $ sudo mkdir /etc/ceph

[same for zor3]


2/ Deploy with (patched) ceph-deploy 

(localhost) $ ceph-deploy new zor2
(localhost) $ ceph-deploy mon create zor2
(localhost) $ ceph-deploy gatherkeys zor2
(localhost) $ ceph-deploy disk zap zor2:/dev/vdb
(localhost) $ ceph-deploy disk zap zor3:/dev/vdb
(localhost) $ ceph-deploy osd prepare zor2:/dev/vdb
(localhost) $ ceph-deploy osd prepare zor3:/dev/vdb
(localhost) $ ceph-deploy osd activate zor2:/dev/vdb1
(localhost) $ ceph-deploy osd activate zor3:/dev/vdb1


3/ Check state

(localhost) $ ceph -c ceph.conf -k ceph.client.admin.keyring -s
    cluster de5d8fac-58b1-411a-8047-dd46d0d91246
     health HEALTH_OK
     monmap e1: 1 mons at {zor2=192.168.122.12:6789/0}, election epoch 2, quorum 0 zor2
     osdmap e36: 2 osds: 2 up, 2 in
      pgmap v55: 192 pgs, 3 pools, 0 bytes data, 0 objects
            70852 kB used, 6052 MB / 6121 MB avail
                 192 active+clean

(localhost) $ ceph -c ceph.conf -k ceph.client.admin.keyring osd tree
# id	weight	type name	up/down	reweight
-1	2	root default
-2	1		host zor3
1	1			osd.1	up	1	
-3	1		host zor2
0	1			osd.0	up	1	



--------------030302090104000609070002--
