From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk permissions errors when using dmcrypt/plain keys
Date: Tue, 14 Jun 2016 16:53:50 +0200
Message-ID: <57601A7E.3030600@dachary.org>
References: <CAGbvivLErxQW8EkXvwNN9WAiasxsOM5YQL+MqxtaHpRPxRxA1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:42637 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbcFNPBC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2016 11:01:02 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id EC40147E276
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jun 2016 16:53:57 +0200 (CEST)
In-Reply-To: <CAGbvivLErxQW8EkXvwNN9WAiasxsOM5YQL+MqxtaHpRPxRxA1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Could you please detail the steps to reproduce the problem ? There are =
tests verifying it works on ubuntu 14.04.4 but there apparently is a us=
e case missing.

Thanks for your help :-)

On 14/06/2016 16:42, Wyllys Ingersoll wrote:
> ceph-disk throws permissions errors when trying to create journals.  =
I
> see reference to the same issue in ceph-docker, but in this case we
> are not using docker at all so perhaps it is a more generic error?
>=20
> Ceph 10.2.1
> Ubuntu 14.04.4
>=20
> Logs from /var/log/upstart/ceph-disk-_dev_sdc1_20742.log
>=20
> main_trigger: main_trigger: Namespace(cluster=3D'ceph', dev=3D'/dev/s=
dc1',
> dmcrypt=3DNone, dmcrypt_key_dir=3D'/etc/ceph/dmcrypt-keys', func=3D<f=
unction
> main_trigger at 0x7f67311e0d70>, log_stdout=3DTrue,
> prepend_to_path=3D'/usr/bin', prog=3D'ceph-disk', setgroup=3DNone,
> setuser=3DNone, statedir=3D'/var/lib/ceph', sync=3DTrue,
> sysconfdir=3D'/etc/ceph', verbose=3DTrue)
> command: Running command: /sbin/init --version
> command: Running command: /sbin/blkid -o udev -p /dev/sdc1
> command: Running command: /sbin/blkid -o udev -p /dev/sdc1
> main_trigger: trigger /dev/sdc1 parttype
> 4fbd7e29-9d25-41b8-afd0-5ec00ceff05d uuid
> 755c6c87-0993-47e2-9614-5bf38298f56e
> command: Running command: /usr/sbin/ceph-disk --verbose activate
> --dmcrypt /dev/sdc1
> main_trigger:
> main_trigger: main_activate: path =3D /dev/sdc1
> get_dm_uuid: get_dm_uuid /dev/sdc1 uuid path is /sys/dev/block/8:33/d=
m/uuid
> command: Running command: /sbin/blkid -o udev -p /dev/sdc1
> command: Running command: /sbin/blkid -o udev -p /dev/sdc1
> command: Running command: /sbin/blkid -o udev -p /dev/sdc1
> command: Running command: /sbin/blkid -o udev -p /dev/sdc1
> command: Running command: /usr/bin/ceph --name
> client.osd-lockbox.755c6c87-0993-47e2-9614-5bf38298f56e --keyring
> /var/lib/ceph/osd-lockbox/755c6c87-0993-47e2-9614-5bf38298f56e/keyrin=
g
> config-key get dm-crypt/osd/755c6c87-0993-47e2-9614-5bf38298f56e/luks
> get_dmcrypt_key: stderr obtained
> 'dm-crypt/osd/755c6c87-0993-47e2-9614-5bf38298f56e/luks'
>=20
> run: cryptsetup --key-file - create
> 755c6c87-0993-47e2-9614-5bf38298f56e /dev/sdc1 --key-size 256
> run:
> run:
> command_check_call: Running command: /bin/chown ceph:ceph
> /dev/mapper/755c6c87-0993-47e2-9614-5bf38298f56e
> command: Running command: /sbin/blkid -p -s TYPE -o value --
> /dev/mapper/755c6c87-0993-47e2-9614-5bf38298f56e
> command: Running command: /usr/bin/ceph-conf --cluster=3Dceph
> --name=3Dosd. --lookup osd_mount_options_xfs
> command: Running command: /usr/bin/ceph-conf --cluster=3Dceph
> --name=3Dosd. --lookup osd_fs_mount_options_xfs
> mount: Mounting /dev/mapper/755c6c87-0993-47e2-9614-5bf38298f56e on
> /var/lib/ceph/tmp/mnt.1cqcTR with options noatime,inode64
> command_check_call: Running command: /bin/mount -t xfs -o
> noatime,inode64 -- /dev/mapper/755c6c87-0993-47e2-9614-5bf38298f56e
> /var/lib/ceph/tmp/mnt.1cqcTR
> activate: Cluster uuid is 74c33b34-ece5-11e3-aed4-000c2970ff98
> command: Running command: /usr/bin/ceph-osd --cluster=3Dceph
> --show-config-value=3Dfsid
> activate: Cluster name is ceph
> activate: OSD uuid is 755c6c87-0993-47e2-9614-5bf38298f56e
> allocate_osd_id: Allocating OSD id...
> command: Running command: /usr/bin/ceph --cluster ceph --name
> client.bootstrap-osd --keyring
> /var/lib/ceph/bootstrap-osd/ceph.keyring osd create --concise
> 755c6c87-0993-47e2-9614-5bf38298f56e
> command: Running command: /bin/chown -R ceph:ceph
> /var/lib/ceph/tmp/mnt.1cqcTR/whoami.20927.tmp
> activate: OSD id is 3
> activate: Initializing OSD...
> command_check_call: Running command: /usr/bin/ceph --cluster ceph
> --name client.bootstrap-osd --keyring
> /var/lib/ceph/bootstrap-osd/ceph.keyring mon getmap -o
> /var/lib/ceph/tmp/mnt.1cqcTR/activate.monmap
> got monmap epoch 1
> command_check_call: Running command: /usr/bin/ceph-osd --cluster ceph
> --mkfs --mkkey -i 3 --monmap
> /var/lib/ceph/tmp/mnt.1cqcTR/activate.monmap --osd-data
> /var/lib/ceph/tmp/mnt.1cqcTR --osd-journal
> /var/lib/ceph/tmp/mnt.1cqcTR/journal --osd-uuid
> 755c6c87-0993-47e2-9614-5bf38298f56e --keyring
> /var/lib/ceph/tmp/mnt.1cqcTR/keyring --setuser ceph --setgroup ceph
> 2016-06-07 13:50:02.003675 7fc73a1d7800 -1
> filestore(/var/lib/ceph/tmp/mnt.1cqcTR) mkjournal error creating
> journal on /var/lib/ceph/tmp/mnt.1cqcTR/journal: (13) Permission
> denied
> 2016-06-07 13:50:02.003741 7fc73a1d7800 -1 OSD::mkfs:
> ObjectStore::mkfs failed with error -13
> 2016-06-07 13:50:02.003798 7fc73a1d7800 -1  ** ERROR: error creating
> empty object store in /var/lib/ceph/tmp/mnt.1cqcTR: (13) Permission
> denied
> mount_activate: Failed to activate
> unmount: Unmounting /var/lib/ceph/tmp/mnt.1cqcTR
> command_check_call: Running command: /bin/umount -- /var/lib/ceph/tmp=
/mnt.1cqcTR
> Traceback (most recent call last):
>   File "/usr/sbin/ceph-disk", line 9, in <module>
>     load_entry_point('ceph-disk=3D=3D1.0.0', 'console_scripts', 'ceph=
-disk')()
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 496=
4, in run
>     main(sys.argv[1:])
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 491=
5, in main
>     args.func(args)
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
> 3269, in main_activate
>     reactivate=3Dargs.reactivate,
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
> 3026, in mount_activate
>     (osd_id, cluster) =3D activate(path, activate_key_template, init)
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
> 3202, in activate
>     keyring=3Dkeyring,
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 269=
5, in mkfs
>     '--setgroup', get_ceph_group(),
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 439=
,
> in command_check_call
>     return subprocess.check_call(arguments)
>   File "/usr/lib/python2.7/subprocess.py", line 540, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['/usr/bin/ceph-osd',
> '--cluster', 'ceph', '--mkfs', '--mkkey', '-i', '3', '--monmap',
> '/var/lib/ceph/tmp/mnt.1cqcTR/activate.monmap', '--osd-data',
> '/var/lib/ceph/tmp/mnt.1cqcTR', '--osd-journal',
> '/var/lib/ceph/tmp/mnt.1cqcTR/journal', '--osd-uuid',
> '755c6c87-0993-47e2-9614-5bf38298f56e', '--keyring',
> '/var/lib/ceph/tmp/mnt.1cqcTR/keyring', '--setuser', 'ceph',
> '--setgroup', 'ceph']' returned non-zero exit status 1
>=20
> Traceback (most recent call last):
>   File "/usr/sbin/ceph-disk", line 9, in <module>
>     load_entry_point('ceph-disk=3D=3D1.0.0', 'console_scripts', 'ceph=
-disk')()
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 496=
4, in run
>     main(sys.argv[1:])
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 491=
5, in main
>     args.func(args)
>   File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
> 4352, in main_trigger
>     raise Error('return code ' + str(ret))
> ceph_disk.main.Error: Error: return code 1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
