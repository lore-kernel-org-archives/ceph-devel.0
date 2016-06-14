From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: ceph-disk permissions errors when using dmcrypt/plain keys
Date: Tue, 14 Jun 2016 10:42:57 -0400
Message-ID: <CAGbvivLErxQW8EkXvwNN9WAiasxsOM5YQL+MqxtaHpRPxRxA1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38718 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbcFNOnK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2016 10:43:10 -0400
Received: by mail-it0-f54.google.com with SMTP id h190so68305017ith.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jun 2016 07:43:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

ceph-disk throws permissions errors when trying to create journals.  I
see reference to the same issue in ceph-docker, but in this case we
are not using docker at all so perhaps it is a more generic error?

Ceph 10.2.1
Ubuntu 14.04.4

Logs from /var/log/upstart/ceph-disk-_dev_sdc1_20742.log

main_trigger: main_trigger: Namespace(cluster='ceph', dev='/dev/sdc1',
dmcrypt=None, dmcrypt_key_dir='/etc/ceph/dmcrypt-keys', func=<function
main_trigger at 0x7f67311e0d70>, log_stdout=True,
prepend_to_path='/usr/bin', prog='ceph-disk', setgroup=None,
setuser=None, statedir='/var/lib/ceph', sync=True,
sysconfdir='/etc/ceph', verbose=True)
command: Running command: /sbin/init --version
command: Running command: /sbin/blkid -o udev -p /dev/sdc1
command: Running command: /sbin/blkid -o udev -p /dev/sdc1
main_trigger: trigger /dev/sdc1 parttype
4fbd7e29-9d25-41b8-afd0-5ec00ceff05d uuid
755c6c87-0993-47e2-9614-5bf38298f56e
command: Running command: /usr/sbin/ceph-disk --verbose activate
--dmcrypt /dev/sdc1
main_trigger:
main_trigger: main_activate: path = /dev/sdc1
get_dm_uuid: get_dm_uuid /dev/sdc1 uuid path is /sys/dev/block/8:33/dm/uuid
command: Running command: /sbin/blkid -o udev -p /dev/sdc1
command: Running command: /sbin/blkid -o udev -p /dev/sdc1
command: Running command: /sbin/blkid -o udev -p /dev/sdc1
command: Running command: /sbin/blkid -o udev -p /dev/sdc1
command: Running command: /usr/bin/ceph --name
client.osd-lockbox.755c6c87-0993-47e2-9614-5bf38298f56e --keyring
/var/lib/ceph/osd-lockbox/755c6c87-0993-47e2-9614-5bf38298f56e/keyring
config-key get dm-crypt/osd/755c6c87-0993-47e2-9614-5bf38298f56e/luks
get_dmcrypt_key: stderr obtained
'dm-crypt/osd/755c6c87-0993-47e2-9614-5bf38298f56e/luks'

run: cryptsetup --key-file - create
755c6c87-0993-47e2-9614-5bf38298f56e /dev/sdc1 --key-size 256
run:
run:
command_check_call: Running command: /bin/chown ceph:ceph
/dev/mapper/755c6c87-0993-47e2-9614-5bf38298f56e
command: Running command: /sbin/blkid -p -s TYPE -o value --
/dev/mapper/755c6c87-0993-47e2-9614-5bf38298f56e
command: Running command: /usr/bin/ceph-conf --cluster=ceph
--name=osd. --lookup osd_mount_options_xfs
command: Running command: /usr/bin/ceph-conf --cluster=ceph
--name=osd. --lookup osd_fs_mount_options_xfs
mount: Mounting /dev/mapper/755c6c87-0993-47e2-9614-5bf38298f56e on
/var/lib/ceph/tmp/mnt.1cqcTR with options noatime,inode64
command_check_call: Running command: /bin/mount -t xfs -o
noatime,inode64 -- /dev/mapper/755c6c87-0993-47e2-9614-5bf38298f56e
/var/lib/ceph/tmp/mnt.1cqcTR
activate: Cluster uuid is 74c33b34-ece5-11e3-aed4-000c2970ff98
command: Running command: /usr/bin/ceph-osd --cluster=ceph
--show-config-value=fsid
activate: Cluster name is ceph
activate: OSD uuid is 755c6c87-0993-47e2-9614-5bf38298f56e
allocate_osd_id: Allocating OSD id...
command: Running command: /usr/bin/ceph --cluster ceph --name
client.bootstrap-osd --keyring
/var/lib/ceph/bootstrap-osd/ceph.keyring osd create --concise
755c6c87-0993-47e2-9614-5bf38298f56e
command: Running command: /bin/chown -R ceph:ceph
/var/lib/ceph/tmp/mnt.1cqcTR/whoami.20927.tmp
activate: OSD id is 3
activate: Initializing OSD...
command_check_call: Running command: /usr/bin/ceph --cluster ceph
--name client.bootstrap-osd --keyring
/var/lib/ceph/bootstrap-osd/ceph.keyring mon getmap -o
/var/lib/ceph/tmp/mnt.1cqcTR/activate.monmap
got monmap epoch 1
command_check_call: Running command: /usr/bin/ceph-osd --cluster ceph
--mkfs --mkkey -i 3 --monmap
/var/lib/ceph/tmp/mnt.1cqcTR/activate.monmap --osd-data
/var/lib/ceph/tmp/mnt.1cqcTR --osd-journal
/var/lib/ceph/tmp/mnt.1cqcTR/journal --osd-uuid
755c6c87-0993-47e2-9614-5bf38298f56e --keyring
/var/lib/ceph/tmp/mnt.1cqcTR/keyring --setuser ceph --setgroup ceph
2016-06-07 13:50:02.003675 7fc73a1d7800 -1
filestore(/var/lib/ceph/tmp/mnt.1cqcTR) mkjournal error creating
journal on /var/lib/ceph/tmp/mnt.1cqcTR/journal: (13) Permission
denied
2016-06-07 13:50:02.003741 7fc73a1d7800 -1 OSD::mkfs:
ObjectStore::mkfs failed with error -13
2016-06-07 13:50:02.003798 7fc73a1d7800 -1  ** ERROR: error creating
empty object store in /var/lib/ceph/tmp/mnt.1cqcTR: (13) Permission
denied
mount_activate: Failed to activate
unmount: Unmounting /var/lib/ceph/tmp/mnt.1cqcTR
command_check_call: Running command: /bin/umount -- /var/lib/ceph/tmp/mnt.1cqcTR
Traceback (most recent call last):
  File "/usr/sbin/ceph-disk", line 9, in <module>
    load_entry_point('ceph-disk==1.0.0', 'console_scripts', 'ceph-disk')()
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 4964, in run
    main(sys.argv[1:])
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 4915, in main
    args.func(args)
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
3269, in main_activate
    reactivate=args.reactivate,
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
3026, in mount_activate
    (osd_id, cluster) = activate(path, activate_key_template, init)
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
3202, in activate
    keyring=keyring,
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 2695, in mkfs
    '--setgroup', get_ceph_group(),
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 439,
in command_check_call
    return subprocess.check_call(arguments)
  File "/usr/lib/python2.7/subprocess.py", line 540, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['/usr/bin/ceph-osd',
'--cluster', 'ceph', '--mkfs', '--mkkey', '-i', '3', '--monmap',
'/var/lib/ceph/tmp/mnt.1cqcTR/activate.monmap', '--osd-data',
'/var/lib/ceph/tmp/mnt.1cqcTR', '--osd-journal',
'/var/lib/ceph/tmp/mnt.1cqcTR/journal', '--osd-uuid',
'755c6c87-0993-47e2-9614-5bf38298f56e', '--keyring',
'/var/lib/ceph/tmp/mnt.1cqcTR/keyring', '--setuser', 'ceph',
'--setgroup', 'ceph']' returned non-zero exit status 1

Traceback (most recent call last):
  File "/usr/sbin/ceph-disk", line 9, in <module>
    load_entry_point('ceph-disk==1.0.0', 'console_scripts', 'ceph-disk')()
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 4964, in run
    main(sys.argv[1:])
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 4915, in main
    args.func(args)
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
4352, in main_trigger
    raise Error('return code ' + str(ret))
ceph_disk.main.Error: Error: return code 1
