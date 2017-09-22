From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: migrated ceph disk wont start
Date: Fri, 22 Sep 2017 12:15:51 -0400
Message-ID: <CAGbviv+E_QKCDB_ajwzgK4jHWCbJZg1GNNxkQ_PFJpqPP4eknw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:55294 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdIVQPy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Sep 2017 12:15:54 -0400
Received: by mail-lf0-f45.google.com with SMTP id k23so1603311lfi.11
        for <ceph-devel@vger.kernel.org>; Fri, 22 Sep 2017 09:15:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I took a physical disk from one storage server and put it into
another, but now it will not start on the new server.

This is ceph 10.2.9, the disk uses dmcrypt with a luks key, the
journal and data are on the same disk so there are 3 partitions on the
device - data, journal, and lockbox.  When the device is triggered,
the lockbox partition mounts, but the journal and data partitions fail
to mount.  It fails when trying to read the ceph-fsid info from the
mounted lockbox partition which is not present (and is not present on
any other working disks with a lockbox either).  Something is
confusing the ceph-disk activate/trigger process,  but its not clear
to me how to correct it.  Any suggestions would be welcomed.

The error in the log looks like this:

Sep 22 11:56:26 ss005 systemd[1]: Starting Ceph disk activation: /dev/sdf2...
Sep 22 11:56:26 ss005 sh[138414]: main_trigger: main_trigger:
Namespace(cluster='ceph', dev='/dev/sdf2', dmcrypt=None,
dmcrypt_key_dir='/etc/ceph/dmcrypt-keys', func=<function main_trigger
at 0x7f4edd22a8c0>, log_stdout=True, prepend_to_path='/usr/bin',
prog='ceph-disk', setgroup=None, setuser=None,
statedir='/var/lib/ceph', sync=True, sysconfdir='/etc/ceph',
verbose=True)
Sep 22 11:56:26 ss005 sh[138414]: command: Running command: /sbin/init --version
Sep 22 11:56:26 ss005 sh[138414]: command_check_call: Running command:
/bin/chown ceph:ceph /dev/sdf2
Sep 22 11:56:26 ss005 sh[138414]: command: Running command:
/sbin/blkid -o udev -p /dev/sdf2
Sep 22 11:56:26 ss005 sh[138414]: command: Running command:
/sbin/blkid -o udev -p /dev/sdf2
Sep 22 11:56:26 ss005 sh[138414]: main_trigger: trigger /dev/sdf2
parttype 45b0969e-9b03-4f30-b4c6-5ec00ceff106 uuid
e834dd21-c52e-4e11-b1ad-20ca287c2b1c
Sep 22 11:56:26 ss005 sh[138414]: command: Running command:
/usr/sbin/ceph-disk --verbose activate-journal --dmcrypt /dev/sdf2
Sep 22 11:56:26 ss005 sh[138414]: main_trigger:
Sep 22 11:56:26 ss005 sh[138414]: main_trigger: command: Running
command: /sbin/blkid -o udev -p /dev/sdf2
Sep 22 11:56:26 ss005 sh[138414]: command: Running command:
/sbin/blkid -o udev -p /dev/sdf2
Sep 22 11:56:26 ss005 sh[138414]: get_dmcrypt_key: FSID PATH:
/var/lib/ceph/osd-lockbox/e834dd21-c52e-4e11-b1ad-20ca287c2b1c
Sep 22 11:56:26 ss005 sh[138414]: Traceback (most recent call last):
Sep 22 11:56:26 ss005 sh[138414]:   File "/usr/sbin/ceph-disk", line
9, in <module>
Sep 22 11:56:26 ss005 sh[138414]:
load_entry_point('ceph-disk==1.0.0', 'console_scripts', 'ceph-disk')()
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 5096, in
run
Sep 22 11:56:26 ss005 sh[138414]:     main(sys.argv[1:])
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 5047, in
main
Sep 22 11:56:26 ss005 sh[138414]:     args.func(args)
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 4803, in
<lambda>
Sep 22 11:56:26 ss005 sh[138414]:     func=lambda args:
main_activate_space(name, args),
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 3799, in
main_activate_space
Sep 22 11:56:26 ss005 sh[138414]:     dev = dmcrypt_map(args.dev,
args.dmcrypt_key_dir)
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 3097, in
dmcrypt_map
Sep 22 11:56:26 ss005 sh[138414]:     dmcrypt_key =
get_dmcrypt_key(part_uuid, dmcrypt_key_dir, luks)
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 1156, in
get_dmcrypt_key
Sep 22 11:56:26 ss005 sh[138414]:     raise Error('No cluster uuid assigned.')
Sep 22 11:56:26 ss005 sh[138414]: ceph_disk.main.Error: Error: No
cluster uuid assigned.
Sep 22 11:56:26 ss005 sh[138414]: Traceback (most recent call last):
Sep 22 11:56:26 ss005 sh[138414]:   File "/usr/sbin/ceph-disk", line
9, in <module>
Sep 22 11:56:26 ss005 sh[138414]:
load_entry_point('ceph-disk==1.0.0', 'console_scripts', 'ceph-disk')()
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 5096, in
run
Sep 22 11:56:26 ss005 sh[138414]:     main(sys.argv[1:])
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 5047, in
main
Sep 22 11:56:26 ss005 sh[138414]:     args.func(args)
Sep 22 11:56:26 ss005 sh[138414]:   File
"/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 4482, in
main_trigger
Sep 22 11:56:26 ss005 sh[138414]:     raise Error('return code ' + str(ret))
Sep 22 11:56:26 ss005 sh[138414]: ceph_disk.main.Error: Error: return code 1
Sep 22 11:56:26 ss005 systemd[1]: ceph-disk@dev-sdf2.service: Main
process exited, code=exited, status=1/FAILURE
Sep 22 11:56:26 ss005 systemd[1]: Failed to start Ceph disk
activation: /dev/sdf2.
Sep 22 11:56:26 ss005 systemd[1]: ceph-disk@dev-sdf2.service: Unit
entered failed state.
Sep 22 11:56:26 ss005 systemd[1]: ceph-disk@dev-sdf2.service: Failed
with result 'exit-code'.
