From: Wei Jin <wjin.cn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ceph-deploy failed to deploy osd randomly
Date: Wed, 15 Nov 2017 20:31:16 +0800
Message-ID: <CAPpSHbWSNgvBXtwj8Gt0S7sUqNdYOFWGRkzHLABQur8ijV9i0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2688090836212700711=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2688090836212700711==
Content-Type: multipart/alternative; boundary="f403045f7db01a5d9f055e04aefd"

--f403045f7db01a5d9f055e04aefd
Content-Type: text/plain; charset="UTF-8"

Hi, List,

My machine has 12 ssd
There are some errors for ceph-deploy.
It failed randomly

root@n10-075-012:~# *ceph-deploy osd create --zap-disk n10-075-094:sdb:sdb*
[ceph_deploy.conf][DEBUG ] found configuration file at:
/root/.cephdeploy.conf
[ceph_deploy.cli][INFO  ] Invoked (1.5.39): /usr/bin/ceph-deploy osd create
--zap-disk n10-075-094:sdb:sdb
[ceph_deploy.cli][INFO  ] ceph-deploy options:
[ceph_deploy.cli][INFO  ]  username                      : None
[ceph_deploy.cli][INFO  ]  block_db                      : None
[ceph_deploy.cli][INFO  ]  disk                          : [('n10-075-094',
'/dev/sdb', '/dev/sdb')]
[ceph_deploy.cli][INFO  ]  dmcrypt                       : False
[ceph_deploy.cli][INFO  ]  verbose                       : False
[ceph_deploy.cli][INFO  ]  bluestore                     : None
[ceph_deploy.cli][INFO  ]  block_wal                     : None
[ceph_deploy.cli][INFO  ]  overwrite_conf                : False
[ceph_deploy.cli][INFO  ]  subcommand                    : create
[ceph_deploy.cli][INFO  ]  dmcrypt_key_dir               :
/etc/ceph/dmcrypt-keys
[ceph_deploy.cli][INFO  ]  quiet                         : False
[ceph_deploy.cli][INFO  ]  cd_conf                       :
<ceph_deploy.conf.cephdeploy.Conf object at 0x7f566b82a110>
[ceph_deploy.cli][INFO  ]  cluster                       : ceph
[ceph_deploy.cli][INFO  ]  fs_type                       : xfs
[ceph_deploy.cli][INFO  ]  filestore                     : None
[ceph_deploy.cli][INFO  ]  func                          : <function osd at
0x7f566ae9a938>
[ceph_deploy.cli][INFO  ]  ceph_conf                     : None
[ceph_deploy.cli][INFO  ]  default_release               : False
[ceph_deploy.cli][INFO  ]  zap_disk                      : True
[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks
n10-075-094:/dev/sdb:/dev/sdb
[n10-075-094][DEBUG ] connected to host: n10-075-094
[n10-075-094][DEBUG ] detect platform information from remote host
[n10-075-094][DEBUG ] detect machine type
[n10-075-094][DEBUG ] find the location of an executable
[ceph_deploy.osd][INFO  ] Distro info: debian 8.9 jessie
[ceph_deploy.osd][DEBUG ] Deploying osd to n10-075-094
[n10-075-094][DEBUG ] write cluster configuration to
/etc/ceph/{cluster}.conf
[ceph_deploy.osd][DEBUG ] Preparing host n10-075-094 disk /dev/sdb journal
/dev/sdb activate True
[n10-075-094][DEBUG ] find the location of an executable
[n10-075-094][INFO  ] Running command: /usr/sbin/ceph-disk -v prepare
--zap-disk --cluster ceph --fs-type xfs -- /dev/sdb /dev/sdb
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
--cluster=ceph --show-config-value=fsid
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
--check-allows-journal -i 0 --log-file $run_dir/$cluster-osd-check.log
--cluster ceph --setuser ceph --setgroup ceph
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
--check-wants-journal -i 0 --log-file $run_dir/$cluster-osd-check.log
--cluster ceph --setuser ceph --setgroup ceph
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
--check-needs-journal -i 0 --log-file $run_dir/$cluster-osd-check.log
--cluster ceph --setuser ceph --setgroup ceph
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd
--cluster=ceph --show-config-value=osd_journal_size
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid path is
/sys/dev/block/8:17/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb2 uuid path is
/sys/dev/block/8:18/dm/uuid
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf
--cluster=ceph --name=osd. --lookup osd_mkfs_options_xfs
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf
--cluster=ceph --name=osd. --lookup osd_fs_mkfs_options_xfs
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf
--cluster=ceph --name=osd. --lookup osd_mount_options_xfs
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] zap: Zapping partition table on /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
--zap-all -- /dev/sdb
[n10-075-094][WARNIN] Caution: invalid backup GPT header, but valid main
header; regenerating
[n10-075-094][WARNIN] backup header from main header.
[n10-075-094][WARNIN]
[n10-075-094][WARNIN] Warning! Main and backup partition tables differ! Use
the 'c' and 'e' options
[n10-075-094][WARNIN] on the recovery & transformation menu to examine the
two tables.
[n10-075-094][WARNIN]
[n10-075-094][WARNIN] Warning! One or more CRCs don't match. You should
repair the disk!
[n10-075-094][WARNIN]
[n10-075-094][DEBUG ] ******************************
**********************************************
[n10-075-094][DEBUG ] Caution: Found protective or hybrid MBR and corrupt
GPT. Using GPT, but disk
[n10-075-094][DEBUG ] verification and recovery are STRONGLY recommended.
[n10-075-094][DEBUG ] ******************************
**********************************************
[n10-075-094][DEBUG ] GPT data structures destroyed! You may now partition
the disk using fdisk or
[n10-075-094][DEBUG ] other utilities.
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
--clear --mbrtogpt -- /dev/sdb
[n10-075-094][DEBUG ] Creating new GPT entries.
[n10-075-094][DEBUG ] The operation has completed successfully.
[n10-075-094][WARNIN] update_partition: Calling partprobe on zapped device
/dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
settle --timeout=600
[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/sdb
/sbin/partprobe /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
settle --timeout=600
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] ptype_tobe_for_name: name = journal
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] create_partition: Creating journal partition num 2
size 40960 on /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
--new=2:0:+40960M --change-name=2:ceph journal
--partition-guid=2:b7f01f38-f0d5-45ba-a913-ac7242820aed
--typecode=2:45b0969e-9b03-4f30-b4c6-b4b80ceff106 --mbrtogpt -- /dev/sdb
[n10-075-094][DEBUG ] Setting name!
[n10-075-094][DEBUG ] partNum is 1
[n10-075-094][DEBUG ] REALLY setting name!
[n10-075-094][DEBUG ] The operation has completed successfully.
[n10-075-094][WARNIN] update_partition: Calling partprobe on created device
/dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
settle --timeout=600
[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/sdb
/sbin/partprobe /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
settle --timeout=600
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb2 uuid path is
/sys/dev/block/8:18/dm/uuid
[n10-075-094][WARNIN] prepare_device: Journal is GPT partition
/dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed
[n10-075-094][WARNIN] prepare_device: Journal is GPT partition
/dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] set_data_partition: Creating osd partition on /dev/sdb
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] ptype_tobe_for_name: name = data
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] create_partition: Creating data partition num 1 size
0 on /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
--largest-new=1 --change-name=1:ceph data
--partition-guid=1:6e984e11-1b4b-4741-9080-131f13a73daa
--typecode=1:89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be --mbrtogpt -- /dev/sdb
[n10-075-094][DEBUG ] Setting name!
[n10-075-094][DEBUG ] partNum is 0
[n10-075-094][DEBUG ] REALLY setting name!
[n10-075-094][DEBUG ] The operation has completed successfully.
[n10-075-094][WARNIN] update_partition: Calling partprobe on created device
/dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
settle --timeout=600
[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/sdb
/sbin/partprobe /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
settle --timeout=600
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid path is
/sys/dev/block/8:17/dm/uuid
[n10-075-094][WARNIN] populate_data_path_device: Creating xfs fs on
/dev/sdb1
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/mkfs -t
xfs -f -i size=2048 -- /dev/sdb1
[n10-075-094][DEBUG ] meta-data=/dev/sdb1              isize=2048
agcount=4, agsize=55984277 blks
[n10-075-094][DEBUG ]          =                       sectsz=4096  attr=2,
projid32bit=1
[n10-075-094][DEBUG ]          =                       crc=0        finobt=0
[n10-075-094][DEBUG ] data     =                       bsize=4096
blocks=223937105, imaxpct=25
[n10-075-094][DEBUG ]          =                       sunit=0
 swidth=0 blks
[n10-075-094][DEBUG ] naming   =version 2              bsize=4096
ascii-ci=0 ftype=0
[n10-075-094][DEBUG ] log      =internal log           bsize=4096
blocks=109344, version=2
[n10-075-094][DEBUG ]          =                       sectsz=4096  sunit=1
blks, lazy-count=1
[n10-075-094][DEBUG ] realtime =none                   extsz=4096
blocks=0, rtextents=0
[n10-075-094][WARNIN] mount: Mounting /dev/sdb1 on
/var/lib/ceph/tmp/mnt.N8D5Kd with options rw,noexec,noatime,attr2,
inode64,logbufs=8,logbsize=256k,noquota
[n10-075-094][WARNIN] command_check_call: Running command: /bin/mount -t
xfs -o rw,noexec,noatime,attr2,inode64,logbufs=8,logbsize=256k,noquota --
/dev/sdb1 /var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] populate_data_path: Preparing osd data dir
/var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
/var/lib/ceph/tmp/mnt.N8D5Kd/ceph_fsid.11531.tmp
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
/var/lib/ceph/tmp/mnt.N8D5Kd/fsid.11531.tmp
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
/var/lib/ceph/tmp/mnt.N8D5Kd/magic.11531.tmp
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
/var/lib/ceph/tmp/mnt.N8D5Kd/journal_uuid.11531.tmp
[n10-075-094][WARNIN] adjust_symlink: Creating symlink
/var/lib/ceph/tmp/mnt.N8D5Kd/journal -> /dev/disk/by-partuuid/
b7f01f38-f0d5-45ba-a913-ac7242820aed
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph
/var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] unmount: Unmounting /var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] command_check_call: Running command: /bin/umount --
/var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk
--typecode=1:4fbd7e29-9d25-41b8-afd0-062c0ceff05d -- /dev/sdb
[n10-075-094][DEBUG ] Warning: The kernel is still using the old partition
table.
[n10-075-094][DEBUG ] The new table will be used at the next reboot.
[n10-075-094][DEBUG ] The operation has completed successfully.
[n10-075-094][WARNIN] update_partition: Calling partprobe on prepared
device /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
settle --timeout=600
[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/sdb
/sbin/partprobe /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
settle --timeout=600
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm
trigger --action=add --sysname-match sdb1
[n10-075-094][INFO  ] Running command: systemctl enable ceph.target
[n10-075-094][INFO  ] checking OSD status...
[n10-075-094][DEBUG ] find the location of an executable
[n10-075-094][INFO  ] Running command: /usr/bin/ceph --cluster=ceph osd
stat --format=json
[ceph_deploy.osd][DEBUG ] Host n10-075-094 is now ready for osd use.

--f403045f7db01a5d9f055e04aefd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"word-wrap:break-word" dir=3D"auto">Hi, List,=
<div><br></div><div>My machine has 12 ssd=C2=A0</div><div>There are some er=
rors for ceph-deploy.</div><div>It failed randomly<br><div><br></div><div><=
div>root@n10-075-012:~# <b>ceph-deploy osd create --zap-disk n10-075-094:sd=
b:sdb</b></div><div>[ceph_deploy.conf][DEBUG ] found configuration file at:=
 /root/.cephdeploy.conf</div><div>[ceph_deploy.cli][INFO =C2=A0] Invoked (1=
.5.39): /usr/bin/ceph-deploy osd create --zap-disk n10-075-094:sdb:sdb</div=
><div>[ceph_deploy.cli][INFO =C2=A0] ceph-deploy options:</div><div>[ceph_d=
eploy.cli][INFO =C2=A0] =C2=A0username =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: None</div><div>[ceph_deploy.cli]=
[INFO =C2=A0] =C2=A0block_db =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: None</div><div>[ceph_deploy.cli][INFO =C2=
=A0] =C2=A0disk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: [(&#39;n10-075-094&#39;, &#39;/dev/sdb&#39=
;, &#39;/dev/sdb&#39;)]</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0dmcr=
ypt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 : False</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0verbose =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=
 False</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0bluestore =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : None</div><di=
v>[ceph_deploy.cli][INFO =C2=A0] =C2=A0block_wal =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : None</div><div>[ceph_deploy=
.cli][INFO =C2=A0] =C2=A0overwrite_conf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0: False</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0=
subcommand =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0: create</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0dmcrypt_key_d=
ir =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : /etc/ceph/dmcrypt-key=
s</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0quiet =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : False</di=
v><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0cd_conf =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : &lt;ceph_deploy.c=
onf.cephdeploy.<wbr>Conf object at 0x7f566b82a110&gt;</div><div>[ceph_deplo=
y.cli][INFO =C2=A0] =C2=A0cluster =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : ceph</div><div>[ceph_deploy.cli][INFO=
 =C2=A0] =C2=A0fs_type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 : xfs</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=
=A0filestore =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 : None</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0func =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0: &lt;function osd at 0x7f566ae9a938&gt;</div><div>[ceph_deploy.c=
li][INFO =C2=A0] =C2=A0ceph_conf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 : None</div><div>[ceph_deploy.cli][INFO =C2=A0]=
 =C2=A0default_release =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : F=
alse</div><div>[ceph_deploy.cli][INFO =C2=A0] =C2=A0zap_disk =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: True</div><=
div>[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks n10-075-094:/dev=
/sdb:/dev/sdb</div><div>[n10-075-094][DEBUG ] connected to host: n10-075-09=
4</div><div>[n10-075-094][DEBUG ] detect platform information from remote h=
ost</div><div>[n10-075-094][DEBUG ] detect machine type</div><div>[n10-075-=
094][DEBUG ] find the location of an executable</div><div>[ceph_deploy.osd]=
[INFO =C2=A0] Distro info: debian 8.9 jessie</div><div>[ceph_deploy.osd][DE=
BUG ] Deploying osd to n10-075-094</div><div>[n10-075-094][DEBUG ] write cl=
uster configuration to /etc/ceph/{cluster}.conf</div><div>[ceph_deploy.osd]=
[DEBUG ] Preparing host n10-075-094 disk /dev/sdb journal /dev/sdb activate=
 True</div><div>[n10-075-094][DEBUG ] find the location of an executable</d=
iv><div>[n10-075-094][INFO =C2=A0] Running command: /usr/sbin/ceph-disk -v =
prepare --zap-disk --cluster ceph --fs-type xfs -- /dev/sdb /dev/sdb</div><=
div>[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd --clu=
ster=3Dceph --show-config-value=3Dfsid</div><div>[n10-075-094][WARNIN] comm=
and: Running command: /usr/bin/ceph-osd --check-allows-journal -i 0 --log-f=
ile $run_dir/$cluster-osd-check.<wbr>log --cluster ceph --setuser ceph --se=
tgroup ceph</div><div>[n10-075-094][WARNIN] command: Running command: /usr/=
bin/ceph-osd --check-wants-journal -i 0 --log-file $run_dir/$cluster-osd-ch=
eck.<wbr>log --cluster ceph --setuser ceph --setgroup ceph</div><div>[n10-0=
75-094][WARNIN] command: Running command: /usr/bin/ceph-osd --check-needs-j=
ournal -i 0 --log-file $run_dir/$cluster-osd-check.<wbr>log --cluster ceph =
--setuser ceph --setgroup ceph</div><div>[n10-075-094][WARNIN] get_dm_uuid:=
 get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</div><div>[n=
10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd --cluster=
=3Dceph --show-config-value=3Dosd_<wbr>journal_size</div><div>[n10-075-094]=
[WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16=
/dm/uuid</div><div>[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb =
uuid path is /sys/dev/block/8:16/dm/uuid</div><div>[n10-075-094][WARNIN] ge=
t_dm_uuid: get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</d=
iv><div>[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid path =
is /sys/dev/block/8:17/dm/uuid</div><div>[n10-075-094][WARNIN] get_dm_uuid:=
 get_dm_uuid /dev/sdb2 uuid path is /sys/dev/block/8:18/dm/uuid</div><div>[=
n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf --cluster=
=3Dceph --name=3Dosd. --lookup osd_mkfs_options_xfs</div><div>[n10-075-094]=
[WARNIN] command: Running command: /usr/bin/ceph-conf --cluster=3Dceph --na=
me=3Dosd. --lookup osd_fs_mkfs_options_xfs</div><div>[n10-075-094][WARNIN] =
command: Running command: /usr/bin/ceph-conf --cluster=3Dceph --name=3Dosd.=
 --lookup osd_mount_options_xfs</div><div>[n10-075-094][WARNIN] get_dm_uuid=
: get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</div><div>[=
n10-075-094][WARNIN] zap: Zapping partition table on /dev/sdb</div><div>[n1=
0-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk --zap-=
all -- /dev/sdb</div><div>[n10-075-094][WARNIN] Caution: invalid backup GPT=
 header, but valid main header; regenerating</div><div>[n10-075-094][WARNIN=
] backup header from main header.</div><div>[n10-075-094][WARNIN]</div><div=
>[n10-075-094][WARNIN] Warning! Main and backup partition tables differ! Us=
e the &#39;c&#39; and &#39;e&#39; options</div><div>[n10-075-094][WARNIN] o=
n the recovery &amp; transformation menu to examine the two tables.</div><d=
iv>[n10-075-094][WARNIN]</div><div>[n10-075-094][WARNIN] Warning! One or mo=
re CRCs don&#39;t match. You should repair the disk!</div><div>[n10-075-094=
][WARNIN]</div><div>[n10-075-094][DEBUG ] ******************************<wb=
r>******************************<wbr>****************</div><div>[n10-075-09=
4][DEBUG ] Caution: Found protective or hybrid MBR and corrupt GPT. Using G=
PT, but disk</div><div>[n10-075-094][DEBUG ] verification and recovery are =
STRONGLY recommended.</div><div>[n10-075-094][DEBUG ] *********************=
*********<wbr>******************************<wbr>****************</div><div=
>[n10-075-094][DEBUG ] GPT data structures destroyed! You may now partition=
 the disk using fdisk or</div><div>[n10-075-094][DEBUG ] other utilities.</=
div><div>[n10-075-094][WARNIN] command_check_call: Running command: /sbin/s=
gdisk --clear --mbrtogpt -- /dev/sdb</div><div>[n10-075-094][DEBUG ] Creati=
ng new GPT entries.</div><div>[n10-075-094][DEBUG ] The operation has compl=
eted successfully.</div><div>[n10-075-094][WARNIN] update_partition: Callin=
g partprobe on zapped device /dev/sdb</div><div>[n10-075-094][WARNIN] comma=
nd_check_call: Running command: /sbin/udevadm settle --timeout=3D600</div><=
div>[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s /dev/=
sdb /sbin/partprobe /dev/sdb</div><div>[n10-075-094][WARNIN] command_check_=
call: Running command: /sbin/udevadm settle --timeout=3D600</div><div>[n10-=
075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is /sys/dev/bl=
ock/8:16/dm/uuid</div><div>[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /=
dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</div><div>[n10-075-094][WA=
RNIN] ptype_tobe_for_name: name =3D journal</div><div>[n10-075-094][WARNIN]=
 get_dm_uuid: get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid=
</div><div>[n10-075-094][WARNIN] create_partition: Creating journal partiti=
on num 2 size 40960 on /dev/sdb</div><div>[n10-075-094][WARNIN] command_che=
ck_call: Running command: /sbin/sgdisk --new=3D2:0:+40960M --change-name=3D=
2:ceph journal --partition-guid=3D2:b7f01f38-<wbr>f0d5-45ba-a913-ac7242820a=
ed --typecode=3D2:45b0969e-9b03-<wbr>4f30-b4c6-b4b80ceff106 --mbrtogpt -- /=
dev/sdb</div><div>[n10-075-094][DEBUG ] Setting name!</div><div>[n10-075-09=
4][DEBUG ] partNum is 1</div><div>[n10-075-094][DEBUG ] REALLY setting name=
!</div><div>[n10-075-094][DEBUG ] The operation has completed successfully.=
</div><div>[n10-075-094][WARNIN] update_partition: Calling partprobe on cre=
ated device /dev/sdb</div><div>[n10-075-094][WARNIN] command_check_call: Ru=
nning command: /sbin/udevadm settle --timeout=3D600</div><div>[n10-075-094]=
[WARNIN] command: Running command: /usr/bin/flock -s /dev/sdb /sbin/partpro=
be /dev/sdb</div><div>[n10-075-094][WARNIN] command_check_call: Running com=
mand: /sbin/udevadm settle --timeout=3D600</div><div>[n10-075-094][WARNIN] =
get_dm_uuid: get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid<=
/div><div>[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path=
 is /sys/dev/block/8:16/dm/uuid</div><div>[n10-075-094][WARNIN] get_dm_uuid=
: get_dm_uuid /dev/sdb2 uuid path is /sys/dev/block/8:18/dm/uuid</div><div>=
[n10-075-094][WARNIN] prepare_device: Journal is GPT partition /dev/disk/by=
-partuuid/<wbr>b7f01f38-f0d5-45ba-a913-<wbr>ac7242820aed</div><div>[n10-075=
-094][WARNIN] prepare_device: Journal is GPT partition /dev/disk/by-partuui=
d/<wbr>b7f01f38-f0d5-45ba-a913-<wbr>ac7242820aed</div><div>[n10-075-094][WA=
RNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm=
/uuid</div><div>[n10-075-094][WARNIN] set_data_partition: Creating osd part=
ition on /dev/sdb</div><div>[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid =
/dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</div><div>[n10-075-094][W=
ARNIN] ptype_tobe_for_name: name =3D data</div><div>[n10-075-094][WARNIN] g=
et_dm_uuid: get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</=
div><div>[n10-075-094][WARNIN] create_partition: Creating data partition nu=
m 1 size 0 on /dev/sdb</div><div>[n10-075-094][WARNIN] command_check_call: =
Running command: /sbin/sgdisk --largest-new=3D1 --change-name=3D1:ceph data=
 --partition-guid=3D1:6e984e11-<wbr>1b4b-4741-9080-131f13a73daa --typecode=
=3D1:89c57f98-2fe5-<wbr>4dc0-89c1-f3ad0ceff2be --mbrtogpt -- /dev/sdb</div>=
<div>[n10-075-094][DEBUG ] Setting name!</div><div>[n10-075-094][DEBUG ] pa=
rtNum is 0</div><div>[n10-075-094][DEBUG ] REALLY setting name!</div><div>[=
n10-075-094][DEBUG ] The operation has completed successfully.</div><div>[n=
10-075-094][WARNIN] update_partition: Calling partprobe on created device /=
dev/sdb</div><div>[n10-075-094][WARNIN] command_check_call: Running command=
: /sbin/udevadm settle --timeout=3D600</div><div>[n10-075-094][WARNIN] comm=
and: Running command: /usr/bin/flock -s /dev/sdb /sbin/partprobe /dev/sdb</=
div><div>[n10-075-094][WARNIN] command_check_call: Running command: /sbin/u=
devadm settle --timeout=3D600</div><div>[n10-075-094][WARNIN] get_dm_uuid: =
get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</div><div>[n1=
0-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is /sys/dev/=
block/8:16/dm/uuid</div><div>[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid=
 /dev/sdb1 uuid path is /sys/dev/block/8:17/dm/uuid</div><div>[n10-075-094]=
[WARNIN] populate_data_path_device: Creating xfs fs on /dev/sdb1</div><div>=
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/mkfs -t xf=
s -f -i size=3D2048 -- /dev/sdb1</div><div>[n10-075-094][DEBUG ] meta-data=
=3D/dev/sdb1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isize=3D2048 =
=C2=A0 agcount=3D4, agsize=3D55984277 blks</div><div>[n10-075-094][DEBUG ] =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sectsz=3D4096 =C2=A0attr=3D2, pro=
jid32bit=3D1</div><div>[n10-075-094][DEBUG ] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 crc=3D0 =C2=A0 =C2=A0 =C2=A0 =C2=A0finobt=3D0</div><div>[n10-=
075-094][DEBUG ] data =C2=A0 =C2=A0 =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bsize=3D4096 =C2=A0 blocks=3D2239=
37105, imaxpct=3D25</div><div>[n10-075-094][DEBUG ] =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sunit=3D0 =C2=A0 =C2=A0 =C2=A0swidth=3D0 blks</div><di=
v>[n10-075-094][DEBUG ] naming =C2=A0 =3Dversion 2 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bsize=3D4096 =C2=A0 ascii-ci=3D0 ftype=3D0</div><di=
v>[n10-075-094][DEBUG ] log =C2=A0 =C2=A0 =C2=A0=3Dinternal log =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bsize=3D4096 =C2=A0 blocks=3D109344, version=3D2</=
div><div>[n10-075-094][DEBUG ] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sect=
sz=3D4096 =C2=A0sunit=3D1 blks, lazy-count=3D1</div><div>[n10-075-094][DEBU=
G ] realtime =3Dnone =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 extsz=3D4096 =C2=A0 blocks=3D0, rtextents=3D0</div><div>[n10-075=
-094][WARNIN] mount: Mounting /dev/sdb1 on /var/lib/ceph/tmp/mnt.N8D5Kd wit=
h options rw,noexec,noatime,attr2,<wbr>inode64,logbufs=3D8,logbsize=3D<wbr>=
256k,noquota</div><div>[n10-075-094][WARNIN] command_check_call: Running co=
mmand: /bin/mount -t xfs -o rw,noexec,noatime,attr2,<wbr>inode64,logbufs=3D=
8,logbsize=3D<wbr>256k,noquota -- /dev/sdb1 /var/lib/ceph/tmp/mnt.N8D5Kd</d=
iv><div>[n10-075-094][WARNIN] populate_data_path: Preparing osd data dir /v=
ar/lib/ceph/tmp/mnt.N8D5Kd</div><div>[n10-075-094][WARNIN] command: Running=
 command: /bin/chown -R ceph:ceph /var/lib/ceph/tmp/mnt.N8D5Kd/<wbr>ceph_fs=
id.11531.tmp</div><div>[n10-075-094][WARNIN] command: Running command: /bin=
/chown -R ceph:ceph /var/lib/ceph/tmp/mnt.N8D5Kd/<wbr>fsid.11531.tmp</div><=
div>[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph=
 /var/lib/ceph/tmp/mnt.N8D5Kd/<wbr>magic.11531.tmp</div><div>[n10-075-094][=
WARNIN] command: Running command: /bin/chown -R ceph:ceph /var/lib/ceph/tmp=
/mnt.N8D5Kd/<wbr>journal_uuid.11531.tmp</div><div>[n10-075-094][WARNIN] adj=
ust_symlink: Creating symlink /var/lib/ceph/tmp/mnt.N8D5Kd/<wbr>journal -&g=
t; /dev/disk/by-partuuid/<wbr>b7f01f38-f0d5-45ba-a913-<wbr>ac7242820aed</di=
v><div>[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:c=
eph /var/lib/ceph/tmp/mnt.N8D5Kd</div><div>[n10-075-094][WARNIN] unmount: U=
nmounting /var/lib/ceph/tmp/mnt.N8D5Kd</div><div>[n10-075-094][WARNIN] comm=
and_check_call: Running command: /bin/umount -- /var/lib/ceph/tmp/mnt.N8D5K=
d</div><div>[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid pa=
th is /sys/dev/block/8:16/dm/uuid</div><div>[n10-075-094][WARNIN] command_c=
heck_call: Running command: /sbin/sgdisk --typecode=3D1:4fbd7e29-9d25-<wbr>=
41b8-afd0-062c0ceff05d -- /dev/sdb</div><div>[n10-075-094][DEBUG ] Warning:=
 The kernel is still using the old partition table.</div><div>[n10-075-094]=
[DEBUG ] The new table will be used at the next reboot.</div><div>[n10-075-=
094][DEBUG ] The operation has completed successfully.</div><div>[n10-075-0=
94][WARNIN] update_partition: Calling partprobe on prepared device /dev/sdb=
</div><div>[n10-075-094][WARNIN] command_check_call: Running command: /sbin=
/udevadm settle --timeout=3D600</div><div>[n10-075-094][WARNIN] command: Ru=
nning command: /usr/bin/flock -s /dev/sdb /sbin/partprobe /dev/sdb</div><di=
v>[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600</div><div>[n10-075-094][WARNIN] command_check_call: =
Running command: /sbin/udevadm trigger --action=3Dadd --sysname-match sdb1<=
/div><div>[n10-075-094][INFO =C2=A0] Running command: systemctl enable ceph=
.target</div><div>[n10-075-094][INFO =C2=A0] checking OSD status...</div><d=
iv>[n10-075-094][DEBUG ] find the location of an executable</div><div>[n10-=
075-094][INFO =C2=A0] Running command: /usr/bin/ceph --cluster=3Dceph osd s=
tat --format=3Djson</div><div>[ceph_deploy.osd][DEBUG ] Host n10-075-094 is=
 now ready for osd use.</div></div></div></div></div>

--f403045f7db01a5d9f055e04aefd--

--===============2688090836212700711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2688090836212700711==--
