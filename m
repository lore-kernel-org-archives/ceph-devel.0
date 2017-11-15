From: Wei Jin <wjin.cn@gmail.com>
Subject: Re: ceph-deploy failed to deploy osd randomly
Date: Wed, 15 Nov 2017 21:31:49 +0800
Message-ID: <CAPpSHbUxYxekAOib+jE7y+7nQE44GkBwbrWN3FFaUh2Ev3ENvg@mail.gmail.com>
References: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com> <AC28A0DB-A570-44F4-85E0-00835B91B1E9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:44511 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbdKONbv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Nov 2017 08:31:51 -0500
Received: by mail-wm0-f54.google.com with SMTP id r68so3054270wmr.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Nov 2017 05:31:51 -0800 (PST)
In-Reply-To: <AC28A0DB-A570-44F4-85E0-00835B91B1E9@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

I tried to do purge/purgedata and then redo the deploy command for a
few times, and it still fails to start osd.
And there is no error log, anyone know what's the problem?
BTW, my os is dedian with 4.4 kernel.
Thanks.


On Wed, Nov 15, 2017 at 8:24 PM, Wei Jin <wjin.cn@gmail.com> wrote:
> Hi, List,
>
> My machine has 12 SSDs disk, and I use ceph-deploy to deploy them. But fo=
r
> some machine/disks=EF=BC=8Cit failed to start osd.
> I tried many times, some success but others failed. But there is no error
> info.
> Following is ceph-deploy log for one disk:
>
>
> root@n10-075-012:~# ceph-deploy osd create --zap-disk n10-075-094:sdb:sdb
> [ceph_deploy.conf][DEBUG ] found configuration file at:
> /root/.cephdeploy.conf
> [ceph_deploy.cli][INFO  ] Invoked (1.5.39): /usr/bin/ceph-deploy osd crea=
te
> --zap-disk n10-075-094:sdb:sdb
> [ceph_deploy.cli][INFO  ] ceph-deploy options:
> [ceph_deploy.cli][INFO  ]  username                      : None
> [ceph_deploy.cli][INFO  ]  block_db                      : None
> [ceph_deploy.cli][INFO  ]  disk                          : [('n10-075-094=
',
> '/dev/sdb', '/dev/sdb')]
> [ceph_deploy.cli][INFO  ]  dmcrypt                       : False
> [ceph_deploy.cli][INFO  ]  verbose                       : False
> [ceph_deploy.cli][INFO  ]  bluestore                     : None
> [ceph_deploy.cli][INFO  ]  block_wal                     : None
> [ceph_deploy.cli][INFO  ]  overwrite_conf                : False
> [ceph_deploy.cli][INFO  ]  subcommand                    : create
> [ceph_deploy.cli][INFO  ]  dmcrypt_key_dir               :
> /etc/ceph/dmcrypt-keys
> [ceph_deploy.cli][INFO  ]  quiet                         : False
> [ceph_deploy.cli][INFO  ]  cd_conf                       :
> <ceph_deploy.conf.cephdeploy.Conf object at 0x7f566b82a110>
> [ceph_deploy.cli][INFO  ]  cluster                       : ceph
> [ceph_deploy.cli][INFO  ]  fs_type                       : xfs
> [ceph_deploy.cli][INFO  ]  filestore                     : None
> [ceph_deploy.cli][INFO  ]  func                          : <function osd =
at
> 0x7f566ae9a938>
> [ceph_deploy.cli][INFO  ]  ceph_conf                     : None
> [ceph_deploy.cli][INFO  ]  default_release               : False
> [ceph_deploy.cli][INFO  ]  zap_disk                      : True
> [ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks
> n10-075-094:/dev/sdb:/dev/sdb
> [n10-075-094][DEBUG ] connected to host: n10-075-094
> [n10-075-094][DEBUG ] detect platform information from remote host
> [n10-075-094][DEBUG ] detect machine type
> [n10-075-094][DEBUG ] find the location of an executable
> [ceph_deploy.osd][INFO  ] Distro info: debian 8.9 jessie
> [ceph_deploy.osd][DEBUG ] Deploying osd to n10-075-094
> [n10-075-094][DEBUG ] write cluster configuration to
> /etc/ceph/{cluster}.conf
> [ceph_deploy.osd][DEBUG ] Preparing host n10-075-094 disk /dev/sdb journa=
l
> /dev/sdb activate True
> [n10-075-094][DEBUG ] find the location of an executable
> [n10-075-094][INFO  ] Running command: /usr/sbin/ceph-disk -v prepare
> --zap-disk --cluster ceph --fs-type xfs -- /dev/sdb /dev/sdb
> [n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
> --cluster=3Dceph --show-config-value=3Dfsid
> [n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
> --check-allows-journal -i 0 --log-file $run_dir/$cluster-osd-check.log
> --cluster ceph --setuser ceph --setgroup ceph
> [n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
> --check-wants-journal -i 0 --log-file $run_dir/$cluster-osd-check.log
> --cluster ceph --setuser ceph --setgroup ceph
> [n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
> --check-needs-journal -i 0 --log-file $run_dir/$cluster-osd-check.log
> --cluster ceph --setuser ceph --setgroup ceph
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
> --cluster=3Dceph --show-config-value=3Dosd_journal_size
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid path is
> /sys/dev/block/8:17/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb2 uuid path is
> /sys/dev/block/8:18/dm/uuid
> [n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf
> --cluster=3Dceph --name=3Dosd. --lookup osd_mkfs_options_xfs
> [n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf
> --cluster=3Dceph --name=3Dosd. --lookup osd_fs_mkfs_options_xfs
> [n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf
> --cluster=3Dceph --name=3Dosd. --lookup osd_mount_options_xfs
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] zap: Zapping partition table on /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
> --zap-all -- /dev/sdb
> [n10-075-094][WARNIN] Caution: invalid backup GPT header, but valid main
> header; regenerating
> [n10-075-094][WARNIN] backup header from main header.
> [n10-075-094][WARNIN]
> [n10-075-094][WARNIN] Warning! Main and backup partition tables differ! U=
se
> the 'c' and 'e' options
> [n10-075-094][WARNIN] on the recovery & transformation menu to examine th=
e
> two tables.
> [n10-075-094][WARNIN]
> [n10-075-094][WARNIN] Warning! One or more CRCs don't match. You should
> repair the disk!
> [n10-075-094][WARNIN]
> [n10-075-094][DEBUG ]
> *************************************************************************=
***
> [n10-075-094][DEBUG ] Caution: Found protective or hybrid MBR and corrupt
> GPT. Using GPT, but disk
> [n10-075-094][DEBUG ] verification and recovery are STRONGLY recommended.
> [n10-075-094][DEBUG ]
> *************************************************************************=
***
> [n10-075-094][DEBUG ] GPT data structures destroyed! You may now partitio=
n
> the disk using fdisk or
> [n10-075-094][DEBUG ] other utilities.
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
> --clear --mbrtogpt -- /dev/sdb
> [n10-075-094][DEBUG ] Creating new GPT entries.
> [n10-075-094][DEBUG ] The operation has completed successfully.
> [n10-075-094][WARNIN] update_partition: Calling partprobe on zapped devic=
e
> /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> settle --timeout=3D600
> [n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/sd=
b
> /sbin/partprobe /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> settle --timeout=3D600
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] ptype_tobe_for_name: name =3D journal
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] create_partition: Creating journal partition num 2
> size 40960 on /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
> --new=3D2:0:+40960M --change-name=3D2:ceph journal
> --partition-guid=3D2:b7f01f38-f0d5-45ba-a913-ac7242820aed
> --typecode=3D2:45b0969e-9b03-4f30-b4c6-b4b80ceff106 --mbrtogpt -- /dev/sd=
b
> [n10-075-094][DEBUG ] Setting name!
> [n10-075-094][DEBUG ] partNum is 1
> [n10-075-094][DEBUG ] REALLY setting name!
> [n10-075-094][DEBUG ] The operation has completed successfully.
> [n10-075-094][WARNIN] update_partition: Calling partprobe on created devi=
ce
> /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> settle --timeout=3D600
> [n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/sd=
b
> /sbin/partprobe /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> settle --timeout=3D600
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb2 uuid path is
> /sys/dev/block/8:18/dm/uuid
> [n10-075-094][WARNIN] prepare_device: Journal is GPT partition
> /dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed
> [n10-075-094][WARNIN] prepare_device: Journal is GPT partition
> /dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] set_data_partition: Creating osd partition on /dev/=
sdb
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] ptype_tobe_for_name: name =3D data
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] create_partition: Creating data partition num 1 siz=
e 0
> on /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
> --largest-new=3D1 --change-name=3D1:ceph data
> --partition-guid=3D1:6e984e11-1b4b-4741-9080-131f13a73daa
> --typecode=3D1:89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be --mbrtogpt -- /dev/sd=
b
> [n10-075-094][DEBUG ] Setting name!
> [n10-075-094][DEBUG ] partNum is 0
> [n10-075-094][DEBUG ] REALLY setting name!
> [n10-075-094][DEBUG ] The operation has completed successfully.
> [n10-075-094][WARNIN] update_partition: Calling partprobe on created devi=
ce
> /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> settle --timeout=3D600
> [n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/sd=
b
> /sbin/partprobe /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> settle --timeout=3D600
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid path is
> /sys/dev/block/8:17/dm/uuid
> [n10-075-094][WARNIN] populate_data_path_device: Creating xfs fs on
> /dev/sdb1
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/mkfs -t =
xfs
> -f -i size=3D2048 -- /dev/sdb1
> [n10-075-094][DEBUG ] meta-data=3D/dev/sdb1              isize=3D2048
> agcount=3D4, agsize=3D55984277 blks
> [n10-075-094][DEBUG ]          =3D                       sectsz=3D4096  a=
ttr=3D2,
> projid32bit=3D1
> [n10-075-094][DEBUG ]          =3D                       crc=3D0        f=
inobt=3D0
> [n10-075-094][DEBUG ] data     =3D                       bsize=3D4096
> blocks=3D223937105, imaxpct=3D25
> [n10-075-094][DEBUG ]          =3D                       sunit=3D0      s=
width=3D0
> blks
> [n10-075-094][DEBUG ] naming   =3Dversion 2              bsize=3D4096
> ascii-ci=3D0 ftype=3D0
> [n10-075-094][DEBUG ] log      =3Dinternal log           bsize=3D4096
> blocks=3D109344, version=3D2
> [n10-075-094][DEBUG ]          =3D                       sectsz=3D4096  s=
unit=3D1
> blks, lazy-count=3D1
> [n10-075-094][DEBUG ] realtime =3Dnone                   extsz=3D4096
> blocks=3D0, rtextents=3D0
> [n10-075-094][WARNIN] mount: Mounting /dev/sdb1 on
> /var/lib/ceph/tmp/mnt.N8D5Kd with options
> rw,noexec,noatime,attr2,inode64,logbufs=3D8,logbsize=3D256k,noquota
> [n10-075-094][WARNIN] command_check_call: Running command: /bin/mount -t =
xfs
> -o rw,noexec,noatime,attr2,inode64,logbufs=3D8,logbsize=3D256k,noquota --
> /dev/sdb1 /var/lib/ceph/tmp/mnt.N8D5Kd
> [n10-075-094][WARNIN] populate_data_path: Preparing osd data dir
> /var/lib/ceph/tmp/mnt.N8D5Kd
> [n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
> /var/lib/ceph/tmp/mnt.N8D5Kd/ceph_fsid.11531.tmp
> [n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
> /var/lib/ceph/tmp/mnt.N8D5Kd/fsid.11531.tmp
> [n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
> /var/lib/ceph/tmp/mnt.N8D5Kd/magic.11531.tmp
> [n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
> /var/lib/ceph/tmp/mnt.N8D5Kd/journal_uuid.11531.tmp
> [n10-075-094][WARNIN] adjust_symlink: Creating symlink
> /var/lib/ceph/tmp/mnt.N8D5Kd/journal ->
> /dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed
> [n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
> /var/lib/ceph/tmp/mnt.N8D5Kd
> [n10-075-094][WARNIN] unmount: Unmounting /var/lib/ceph/tmp/mnt.N8D5Kd
> [n10-075-094][WARNIN] command_check_call: Running command: /bin/umount --
> /var/lib/ceph/tmp/mnt.N8D5Kd
> [n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
> /sys/dev/block/8:16/dm/uuid
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
> --typecode=3D1:4fbd7e29-9d25-41b8-afd0-062c0ceff05d -- /dev/sdb
> [n10-075-094][DEBUG ] Warning: The kernel is still using the old partitio=
n
> table.
> [n10-075-094][DEBUG ] The new table will be used at the next reboot.
> [n10-075-094][DEBUG ] The operation has completed successfully.
> [n10-075-094][WARNIN] update_partition: Calling partprobe on prepared dev=
ice
> /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> settle --timeout=3D600
> [n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/sd=
b
> /sbin/partprobe /dev/sdb
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> settle --timeout=3D600
> [n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
> trigger --action=3Dadd --sysname-match sdb1
> [n10-075-094][INFO  ] Running command: systemctl enable ceph.target
> [n10-075-094][INFO  ] checking OSD status...
> [n10-075-094][DEBUG ] find the location of an executable
> [n10-075-094][INFO  ] Running command: /usr/bin/ceph --cluster=3Dceph osd=
 stat
> --format=3Djson
> [ceph_deploy.osd][DEBUG ] Host n10-075-094 is now ready for osd use.
