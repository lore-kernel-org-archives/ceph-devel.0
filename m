From: Wei Jin <wjin.cn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ceph-deploy failed to deploy osd randomly
Date: Wed, 15 Nov 2017 20:24:34 +0800
Message-ID: <AC28A0DB-A570-44F4-85E0-00835B91B1E9@gmail.com>
References: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/mixed; boundary="===============1471343182066664520=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <A80E9066-6266-49E2-9BD7-137E8136D6B9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============1471343182066664520==
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_C7138CC4-5FEA-4A22-A45D-39968DB5FB30"


--Apple-Mail=_C7138CC4-5FEA-4A22-A45D-39968DB5FB30
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi, List,

My machine has 12 SSDs disk, and I use ceph-deploy to deploy them. But =
for some machine/disks=EF=BC=8Cit failed to start osd.
I tried many times, some success but others failed. But there is no =
error info.
Following is ceph-deploy log for one disk:


root@n10-075-012:~# ceph-deploy osd create --zap-disk =
n10-075-094:sdb:sdb
[ceph_deploy.conf][DEBUG ] found configuration file at: =
/root/.cephdeploy.conf
[ceph_deploy.cli][INFO  ] Invoked (1.5.39): /usr/bin/ceph-deploy osd =
create --zap-disk n10-075-094:sdb:sdb
[ceph_deploy.cli][INFO  ] ceph-deploy options:
[ceph_deploy.cli][INFO  ]  username                      : None
[ceph_deploy.cli][INFO  ]  block_db                      : None
[ceph_deploy.cli][INFO  ]  disk                          : =
[('n10-075-094', '/dev/sdb', '/dev/sdb')]
[ceph_deploy.cli][INFO  ]  dmcrypt                       : False
[ceph_deploy.cli][INFO  ]  verbose                       : False
[ceph_deploy.cli][INFO  ]  bluestore                     : None
[ceph_deploy.cli][INFO  ]  block_wal                     : None
[ceph_deploy.cli][INFO  ]  overwrite_conf                : False
[ceph_deploy.cli][INFO  ]  subcommand                    : create
[ceph_deploy.cli][INFO  ]  dmcrypt_key_dir               : =
/etc/ceph/dmcrypt-keys
[ceph_deploy.cli][INFO  ]  quiet                         : False
[ceph_deploy.cli][INFO  ]  cd_conf                       : =
<ceph_deploy.conf.cephdeploy.Conf object at 0x7f566b82a110>
[ceph_deploy.cli][INFO  ]  cluster                       : ceph
[ceph_deploy.cli][INFO  ]  fs_type                       : xfs
[ceph_deploy.cli][INFO  ]  filestore                     : None
[ceph_deploy.cli][INFO  ]  func                          : <function osd =
at 0x7f566ae9a938>
[ceph_deploy.cli][INFO  ]  ceph_conf                     : None
[ceph_deploy.cli][INFO  ]  default_release               : False
[ceph_deploy.cli][INFO  ]  zap_disk                      : True
[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks =
n10-075-094:/dev/sdb:/dev/sdb
[n10-075-094][DEBUG ] connected to host: n10-075-094
[n10-075-094][DEBUG ] detect platform information from remote host
[n10-075-094][DEBUG ] detect machine type
[n10-075-094][DEBUG ] find the location of an executable
[ceph_deploy.osd][INFO  ] Distro info: debian 8.9 jessie
[ceph_deploy.osd][DEBUG ] Deploying osd to n10-075-094
[n10-075-094][DEBUG ] write cluster configuration to =
/etc/ceph/{cluster}.conf
[ceph_deploy.osd][DEBUG ] Preparing host n10-075-094 disk /dev/sdb =
journal /dev/sdb activate True
[n10-075-094][DEBUG ] find the location of an executable
[n10-075-094][INFO  ] Running command: /usr/sbin/ceph-disk -v prepare =
--zap-disk --cluster ceph --fs-type xfs -- /dev/sdb /dev/sdb
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd =
--cluster=3Dceph --show-config-value=3Dfsid
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd =
--check-allows-journal -i 0 --log-file $run_dir/$cluster-osd-check.log =
--cluster ceph --setuser ceph --setgroup ceph
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd =
--check-wants-journal -i 0 --log-file $run_dir/$cluster-osd-check.log =
--cluster ceph --setuser ceph --setgroup ceph
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd =
--check-needs-journal -i 0 --log-file $run_dir/$cluster-osd-check.log =
--cluster ceph --setuser ceph --setgroup ceph
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-osd =
--cluster=3Dceph --show-config-value=3Dosd_journal_size
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid path is =
/sys/dev/block/8:17/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb2 uuid path is =
/sys/dev/block/8:18/dm/uuid
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf =
--cluster=3Dceph --name=3Dosd. --lookup osd_mkfs_options_xfs
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf =
--cluster=3Dceph --name=3Dosd. --lookup osd_fs_mkfs_options_xfs
[n10-075-094][WARNIN] command: Running command: /usr/bin/ceph-conf =
--cluster=3Dceph --name=3Dosd. --lookup osd_mount_options_xfs
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] zap: Zapping partition table on /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk =
--zap-all -- /dev/sdb
[n10-075-094][WARNIN] Caution: invalid backup GPT header, but valid main =
header; regenerating
[n10-075-094][WARNIN] backup header from main header.
[n10-075-094][WARNIN]
[n10-075-094][WARNIN] Warning! Main and backup partition tables differ! =
Use the 'c' and 'e' options
[n10-075-094][WARNIN] on the recovery & transformation menu to examine =
the two tables.
[n10-075-094][WARNIN]
[n10-075-094][WARNIN] Warning! One or more CRCs don't match. You should =
repair the disk!
[n10-075-094][WARNIN]
[n10-075-094][DEBUG ] =
**************************************************************************=
**
[n10-075-094][DEBUG ] Caution: Found protective or hybrid MBR and =
corrupt GPT. Using GPT, but disk
[n10-075-094][DEBUG ] verification and recovery are STRONGLY =
recommended.
[n10-075-094][DEBUG ] =
**************************************************************************=
**
[n10-075-094][DEBUG ] GPT data structures destroyed! You may now =
partition the disk using fdisk or
[n10-075-094][DEBUG ] other utilities.
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk =
--clear --mbrtogpt -- /dev/sdb
[n10-075-094][DEBUG ] Creating new GPT entries.
[n10-075-094][DEBUG ] The operation has completed successfully.
[n10-075-094][WARNIN] update_partition: Calling partprobe on zapped =
device /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600
[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s =
/dev/sdb /sbin/partprobe /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] ptype_tobe_for_name: name =3D journal
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] create_partition: Creating journal partition num 2 =
size 40960 on /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk =
--new=3D2:0:+40960M --change-name=3D2:ceph journal =
--partition-guid=3D2:b7f01f38-f0d5-45ba-a913-ac7242820aed =
--typecode=3D2:45b0969e-9b03-4f30-b4c6-b4b80ceff106 --mbrtogpt -- =
/dev/sdb
[n10-075-094][DEBUG ] Setting name!
[n10-075-094][DEBUG ] partNum is 1
[n10-075-094][DEBUG ] REALLY setting name!
[n10-075-094][DEBUG ] The operation has completed successfully.
[n10-075-094][WARNIN] update_partition: Calling partprobe on created =
device /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600
[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s =
/dev/sdb /sbin/partprobe /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb2 uuid path is =
/sys/dev/block/8:18/dm/uuid
[n10-075-094][WARNIN] prepare_device: Journal is GPT partition =
/dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed
[n10-075-094][WARNIN] prepare_device: Journal is GPT partition =
/dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] set_data_partition: Creating osd partition on =
/dev/sdb
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] ptype_tobe_for_name: name =3D data
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] create_partition: Creating data partition num 1 =
size 0 on /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk =
--largest-new=3D1 --change-name=3D1:ceph data =
--partition-guid=3D1:6e984e11-1b4b-4741-9080-131f13a73daa =
--typecode=3D1:89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be --mbrtogpt -- =
/dev/sdb
[n10-075-094][DEBUG ] Setting name!
[n10-075-094][DEBUG ] partNum is 0
[n10-075-094][DEBUG ] REALLY setting name!
[n10-075-094][DEBUG ] The operation has completed successfully.
[n10-075-094][WARNIN] update_partition: Calling partprobe on created =
device /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600
[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s =
/dev/sdb /sbin/partprobe /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid path is =
/sys/dev/block/8:17/dm/uuid
[n10-075-094][WARNIN] populate_data_path_device: Creating xfs fs on =
/dev/sdb1
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/mkfs -t =
xfs -f -i size=3D2048 -- /dev/sdb1
[n10-075-094][DEBUG ] meta-data=3D/dev/sdb1              isize=3D2048   =
agcount=3D4, agsize=3D55984277 blks
[n10-075-094][DEBUG ]          =3D                       sectsz=3D4096  =
attr=3D2, projid32bit=3D1
[n10-075-094][DEBUG ]          =3D                       crc=3D0        =
finobt=3D0
[n10-075-094][DEBUG ] data     =3D                       bsize=3D4096   =
blocks=3D223937105, imaxpct=3D25
[n10-075-094][DEBUG ]          =3D                       sunit=3D0      =
swidth=3D0 blks
[n10-075-094][DEBUG ] naming   =3Dversion 2              bsize=3D4096   =
ascii-ci=3D0 ftype=3D0
[n10-075-094][DEBUG ] log      =3Dinternal log           bsize=3D4096   =
blocks=3D109344, version=3D2
[n10-075-094][DEBUG ]          =3D                       sectsz=3D4096  =
sunit=3D1 blks, lazy-count=3D1
[n10-075-094][DEBUG ] realtime =3Dnone                   extsz=3D4096   =
blocks=3D0, rtextents=3D0
[n10-075-094][WARNIN] mount: Mounting /dev/sdb1 on =
/var/lib/ceph/tmp/mnt.N8D5Kd with options =
rw,noexec,noatime,attr2,inode64,logbufs=3D8,logbsize=3D256k,noquota
[n10-075-094][WARNIN] command_check_call: Running command: /bin/mount -t =
xfs -o rw,noexec,noatime,attr2,inode64,logbufs=3D8,logbsize=3D256k,noquota=
 -- /dev/sdb1 /var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] populate_data_path: Preparing osd data dir =
/var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph =
/var/lib/ceph/tmp/mnt.N8D5Kd/ceph_fsid.11531.tmp
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph =
/var/lib/ceph/tmp/mnt.N8D5Kd/fsid.11531.tmp
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph =
/var/lib/ceph/tmp/mnt.N8D5Kd/magic.11531.tmp
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph =
/var/lib/ceph/tmp/mnt.N8D5Kd/journal_uuid.11531.tmp
[n10-075-094][WARNIN] adjust_symlink: Creating symlink =
/var/lib/ceph/tmp/mnt.N8D5Kd/journal -> =
/dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed
[n10-075-094][WARNIN] command: Running command: /bin/chown -R ceph:ceph =
/var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] unmount: Unmounting /var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] command_check_call: Running command: /bin/umount =
-- /var/lib/ceph/tmp/mnt.N8D5Kd
[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/sgdisk =
--typecode=3D1:4fbd7e29-9d25-41b8-afd0-062c0ceff05d -- /dev/sdb
[n10-075-094][DEBUG ] Warning: The kernel is still using the old =
partition table.
[n10-075-094][DEBUG ] The new table will be used at the next reboot.
[n10-075-094][DEBUG ] The operation has completed successfully.
[n10-075-094][WARNIN] update_partition: Calling partprobe on prepared =
device /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600
[n10-075-094][WARNIN] command: Running command: /usr/bin/flock -s =
/dev/sdb /sbin/partprobe /dev/sdb
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
settle --timeout=3D600
[n10-075-094][WARNIN] command_check_call: Running command: /sbin/udevadm =
trigger --action=3Dadd --sysname-match sdb1
[n10-075-094][INFO  ] Running command: systemctl enable ceph.target
[n10-075-094][INFO  ] checking OSD status...
[n10-075-094][DEBUG ] find the location of an executable
[n10-075-094][INFO  ] Running command: /usr/bin/ceph --cluster=3Dceph =
osd stat --format=3Djson
[ceph_deploy.osd][DEBUG ] Host n10-075-094 is now ready for osd use.=

--Apple-Mail=_C7138CC4-5FEA-4A22-A45D-39968DB5FB30
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D"">Hi, List,<div =
class=3D""><br class=3D""></div><div class=3D"">My machine has 12 SSDs =
disk, and I use ceph-deploy to deploy them. But for some =
machine/disks=EF=BC=8Cit failed to start osd.</div><div class=3D"">I =
tried many times, some success but others failed. But there is no error =
info.</div><div class=3D"">Following is ceph-deploy log for one =
disk:</div><div class=3D""><br class=3D""></div><div class=3D""><br =
class=3D""></div><div class=3D""><div class=3D""><div =
class=3D"">root@n10-075-012:~# <b class=3D"">ceph-deploy osd create =
--zap-disk n10-075-094:sdb:sdb</b></div><div =
class=3D"">[ceph_deploy.conf][DEBUG ] found configuration file at: =
/root/.cephdeploy.conf</div><div class=3D"">[ceph_deploy.cli][INFO =
&nbsp;] Invoked (1.5.39): /usr/bin/ceph-deploy osd create --zap-disk =
n10-075-094:sdb:sdb</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] =
ceph-deploy options:</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] =
&nbsp;username &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;: None</div><div class=3D"">[ceph_deploy.cli][INFO =
&nbsp;] &nbsp;block_db &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;: None</div><div =
class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;disk &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;: [('n10-075-094', '/dev/sdb', '/dev/sdb')]</div><div =
class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;dmcrypt &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : =
False</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;verbose =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; : False</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] =
&nbsp;bluestore &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; : None</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] =
&nbsp;block_wal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; : None</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] =
&nbsp;overwrite_conf &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;: False</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] =
&nbsp;subcommand &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;: create</div><div class=3D"">[ceph_deploy.cli][INFO =
&nbsp;] &nbsp;dmcrypt_key_dir &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; : /etc/ceph/dmcrypt-keys</div><div =
class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;quiet &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : =
False</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;cd_conf =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; : &lt;ceph_deploy.conf.cephdeploy.Conf object at =
0x7f566b82a110&gt;</div><div class=3D"">[ceph_deploy.cli][INFO &nbsp;] =
&nbsp;cluster &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; : ceph</div><div class=3D"">[ceph_deploy.cli][INFO =
&nbsp;] &nbsp;fs_type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; : xfs</div><div =
class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;filestore &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : None</div><div =
class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;func &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;: &lt;function osd at 0x7f566ae9a938&gt;</div><div =
class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;ceph_conf &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : None</div><div =
class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;default_release &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : False</div><div =
class=3D"">[ceph_deploy.cli][INFO &nbsp;] &nbsp;zap_disk &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: =
True</div><div class=3D"">[ceph_deploy.osd][DEBUG ] Preparing cluster =
ceph disks n10-075-094:/dev/sdb:/dev/sdb</div><div =
class=3D"">[n10-075-094][DEBUG ] connected to host: =
n10-075-094</div><div class=3D"">[n10-075-094][DEBUG ] detect platform =
information from remote host</div><div class=3D"">[n10-075-094][DEBUG ] =
detect machine type</div><div class=3D"">[n10-075-094][DEBUG ] find the =
location of an executable</div><div class=3D"">[ceph_deploy.osd][INFO =
&nbsp;] Distro info: debian 8.9 jessie</div><div =
class=3D"">[ceph_deploy.osd][DEBUG ] Deploying osd to =
n10-075-094</div><div class=3D"">[n10-075-094][DEBUG ] write cluster =
configuration to /etc/ceph/{cluster}.conf</div><div =
class=3D"">[ceph_deploy.osd][DEBUG ] Preparing host n10-075-094 disk =
/dev/sdb journal /dev/sdb activate True</div><div =
class=3D"">[n10-075-094][DEBUG ] find the location of an =
executable</div><div class=3D"">[n10-075-094][INFO &nbsp;] Running =
command: /usr/sbin/ceph-disk -v prepare --zap-disk --cluster ceph =
--fs-type xfs -- /dev/sdb /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/ceph-osd --cluster=3Dceph --show-config-value=3Dfsid</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/ceph-osd --check-allows-journal -i 0 --log-file =
$run_dir/$cluster-osd-check.log --cluster ceph --setuser ceph --setgroup =
ceph</div><div class=3D"">[n10-075-094][WARNIN] command: Running =
command: /usr/bin/ceph-osd --check-wants-journal -i 0 --log-file =
$run_dir/$cluster-osd-check.log --cluster ceph --setuser ceph --setgroup =
ceph</div><div class=3D"">[n10-075-094][WARNIN] command: Running =
command: /usr/bin/ceph-osd --check-needs-journal -i 0 --log-file =
$run_dir/$cluster-osd-check.log --cluster ceph --setuser ceph --setgroup =
ceph</div><div class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid =
/dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/ceph-osd --cluster=3Dceph =
--show-config-value=3Dosd_journal_size</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid =
path is /sys/dev/block/8:17/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb2 uuid =
path is /sys/dev/block/8:18/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/ceph-conf --cluster=3Dceph --name=3Dosd. --lookup =
osd_mkfs_options_xfs</div><div class=3D"">[n10-075-094][WARNIN] command: =
Running command: /usr/bin/ceph-conf --cluster=3Dceph --name=3Dosd. =
--lookup osd_fs_mkfs_options_xfs</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/ceph-conf --cluster=3Dceph --name=3Dosd. --lookup =
osd_mount_options_xfs</div><div class=3D"">[n10-075-094][WARNIN] =
get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid</div><div class=3D"">[n10-075-094][WARNIN] =
zap: Zapping partition table on /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/sgdisk --zap-all -- /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] Caution: invalid backup GPT header, but =
valid main header; regenerating</div><div class=3D"">[n10-075-094][WARNIN]=
 backup header from main header.</div><div =
class=3D"">[n10-075-094][WARNIN]</div><div =
class=3D"">[n10-075-094][WARNIN] Warning! Main and backup partition =
tables differ! Use the 'c' and 'e' options</div><div =
class=3D"">[n10-075-094][WARNIN] on the recovery &amp; transformation =
menu to examine the two tables.</div><div =
class=3D"">[n10-075-094][WARNIN]</div><div =
class=3D"">[n10-075-094][WARNIN] Warning! One or more CRCs don't match. =
You should repair the disk!</div><div =
class=3D"">[n10-075-094][WARNIN]</div><div class=3D"">[n10-075-094][DEBUG =
] =
**************************************************************************=
**</div><div class=3D"">[n10-075-094][DEBUG ] Caution: Found protective =
or hybrid MBR and corrupt GPT. Using GPT, but disk</div><div =
class=3D"">[n10-075-094][DEBUG ] verification and recovery are STRONGLY =
recommended.</div><div class=3D"">[n10-075-094][DEBUG ] =
**************************************************************************=
**</div><div class=3D"">[n10-075-094][DEBUG ] GPT data structures =
destroyed! You may now partition the disk using fdisk or</div><div =
class=3D"">[n10-075-094][DEBUG ] other utilities.</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/sgdisk --clear --mbrtogpt -- /dev/sdb</div><div =
class=3D"">[n10-075-094][DEBUG ] Creating new GPT entries.</div><div =
class=3D"">[n10-075-094][DEBUG ] The operation has completed =
successfully.</div><div class=3D"">[n10-075-094][WARNIN] =
update_partition: Calling partprobe on zapped device /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/udevadm settle --timeout=3D600</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/flock -s /dev/sdb /sbin/partprobe /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/udevadm settle --timeout=3D600</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] ptype_tobe_for_name: name =3D =
journal</div><div class=3D"">[n10-075-094][WARNIN] get_dm_uuid: =
get_dm_uuid /dev/sdb uuid path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] create_partition: Creating journal =
partition num 2 size 40960 on /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/sgdisk --new=3D2:0:+40960M --change-name=3D2:ceph journal =
--partition-guid=3D2:b7f01f38-f0d5-45ba-a913-ac7242820aed =
--typecode=3D2:45b0969e-9b03-4f30-b4c6-b4b80ceff106 --mbrtogpt -- =
/dev/sdb</div><div class=3D"">[n10-075-094][DEBUG ] Setting =
name!</div><div class=3D"">[n10-075-094][DEBUG ] partNum is 1</div><div =
class=3D"">[n10-075-094][DEBUG ] REALLY setting name!</div><div =
class=3D"">[n10-075-094][DEBUG ] The operation has completed =
successfully.</div><div class=3D"">[n10-075-094][WARNIN] =
update_partition: Calling partprobe on created device /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/udevadm settle --timeout=3D600</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/flock -s /dev/sdb /sbin/partprobe /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/udevadm settle --timeout=3D600</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb2 uuid =
path is /sys/dev/block/8:18/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] prepare_device: Journal is GPT =
partition =
/dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed</div><div =
class=3D"">[n10-075-094][WARNIN] prepare_device: Journal is GPT =
partition =
/dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] set_data_partition: Creating osd =
partition on /dev/sdb</div><div class=3D"">[n10-075-094][WARNIN] =
get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid</div><div class=3D"">[n10-075-094][WARNIN] =
ptype_tobe_for_name: name =3D data</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] create_partition: Creating data =
partition num 1 size 0 on /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/sgdisk --largest-new=3D1 --change-name=3D1:ceph data =
--partition-guid=3D1:6e984e11-1b4b-4741-9080-131f13a73daa =
--typecode=3D1:89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be --mbrtogpt -- =
/dev/sdb</div><div class=3D"">[n10-075-094][DEBUG ] Setting =
name!</div><div class=3D"">[n10-075-094][DEBUG ] partNum is 0</div><div =
class=3D"">[n10-075-094][DEBUG ] REALLY setting name!</div><div =
class=3D"">[n10-075-094][DEBUG ] The operation has completed =
successfully.</div><div class=3D"">[n10-075-094][WARNIN] =
update_partition: Calling partprobe on created device /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/udevadm settle --timeout=3D600</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/flock -s /dev/sdb /sbin/partprobe /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/udevadm settle --timeout=3D600</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb uuid =
path is /sys/dev/block/8:16/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] get_dm_uuid: get_dm_uuid /dev/sdb1 uuid =
path is /sys/dev/block/8:17/dm/uuid</div><div =
class=3D"">[n10-075-094][WARNIN] populate_data_path_device: Creating xfs =
fs on /dev/sdb1</div><div class=3D"">[n10-075-094][WARNIN] =
command_check_call: Running command: /sbin/mkfs -t xfs -f -i size=3D2048 =
-- /dev/sdb1</div><div class=3D"">[n10-075-094][DEBUG ] =
meta-data=3D/dev/sdb1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;isize=3D2048 &nbsp; agcount=3D4, agsize=3D55984277 blks</div><div =
class=3D"">[n10-075-094][DEBUG ] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; sectsz=3D4096 &nbsp;attr=3D2, projid32bit=3D1</div><div =
class=3D"">[n10-075-094][DEBUG ] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; crc=3D0 &nbsp; &nbsp; &nbsp; &nbsp;finobt=3D0</div><div =
class=3D"">[n10-075-094][DEBUG ] data &nbsp; &nbsp; =3D &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
bsize=3D4096 &nbsp; blocks=3D223937105, imaxpct=3D25</div><div =
class=3D"">[n10-075-094][DEBUG ] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; sunit=3D0 &nbsp; &nbsp; &nbsp;swidth=3D0 blks</div><div =
class=3D"">[n10-075-094][DEBUG ] naming &nbsp; =3Dversion 2 &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bsize=3D4096 &nbsp; ascii-ci=3D0 =
ftype=3D0</div><div class=3D"">[n10-075-094][DEBUG ] log &nbsp; &nbsp; =
&nbsp;=3Dinternal log &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bsize=3D4096 =
&nbsp; blocks=3D109344, version=3D2</div><div =
class=3D"">[n10-075-094][DEBUG ] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; sectsz=3D4096 &nbsp;sunit=3D1 blks, lazy-count=3D1</div><div =
class=3D"">[n10-075-094][DEBUG ] realtime =3Dnone &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; extsz=3D4096 &nbsp; blocks=3D0, =
rtextents=3D0</div><div class=3D"">[n10-075-094][WARNIN] mount: Mounting =
/dev/sdb1 on /var/lib/ceph/tmp/mnt.N8D5Kd with options =
rw,noexec,noatime,attr2,inode64,logbufs=3D8,logbsize=3D256k,noquota</div><=
div class=3D"">[n10-075-094][WARNIN] command_check_call: Running =
command: /bin/mount -t xfs -o =
rw,noexec,noatime,attr2,inode64,logbufs=3D8,logbsize=3D256k,noquota -- =
/dev/sdb1 /var/lib/ceph/tmp/mnt.N8D5Kd</div><div =
class=3D"">[n10-075-094][WARNIN] populate_data_path: Preparing osd data =
dir /var/lib/ceph/tmp/mnt.N8D5Kd</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: /bin/chown -R =
ceph:ceph /var/lib/ceph/tmp/mnt.N8D5Kd/ceph_fsid.11531.tmp</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: /bin/chown -R =
ceph:ceph /var/lib/ceph/tmp/mnt.N8D5Kd/fsid.11531.tmp</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: /bin/chown -R =
ceph:ceph /var/lib/ceph/tmp/mnt.N8D5Kd/magic.11531.tmp</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: /bin/chown -R =
ceph:ceph /var/lib/ceph/tmp/mnt.N8D5Kd/journal_uuid.11531.tmp</div><div =
class=3D"">[n10-075-094][WARNIN] adjust_symlink: Creating symlink =
/var/lib/ceph/tmp/mnt.N8D5Kd/journal -&gt; =
/dev/disk/by-partuuid/b7f01f38-f0d5-45ba-a913-ac7242820aed</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: /bin/chown -R =
ceph:ceph /var/lib/ceph/tmp/mnt.N8D5Kd</div><div =
class=3D"">[n10-075-094][WARNIN] unmount: Unmounting =
/var/lib/ceph/tmp/mnt.N8D5Kd</div><div class=3D"">[n10-075-094][WARNIN] =
command_check_call: Running command: /bin/umount -- =
/var/lib/ceph/tmp/mnt.N8D5Kd</div><div class=3D"">[n10-075-094][WARNIN] =
get_dm_uuid: get_dm_uuid /dev/sdb uuid path is =
/sys/dev/block/8:16/dm/uuid</div><div class=3D"">[n10-075-094][WARNIN] =
command_check_call: Running command: /sbin/sgdisk =
--typecode=3D1:4fbd7e29-9d25-41b8-afd0-062c0ceff05d -- =
/dev/sdb</div><div class=3D"">[n10-075-094][DEBUG ] Warning: The kernel =
is still using the old partition table.</div><div =
class=3D"">[n10-075-094][DEBUG ] The new table will be used at the next =
reboot.</div><div class=3D"">[n10-075-094][DEBUG ] The operation has =
completed successfully.</div><div class=3D"">[n10-075-094][WARNIN] =
update_partition: Calling partprobe on prepared device =
/dev/sdb</div><div class=3D"">[n10-075-094][WARNIN] command_check_call: =
Running command: /sbin/udevadm settle --timeout=3D600</div><div =
class=3D"">[n10-075-094][WARNIN] command: Running command: =
/usr/bin/flock -s /dev/sdb /sbin/partprobe /dev/sdb</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/udevadm settle --timeout=3D600</div><div =
class=3D"">[n10-075-094][WARNIN] command_check_call: Running command: =
/sbin/udevadm trigger --action=3Dadd --sysname-match sdb1</div><div =
class=3D"">[n10-075-094][INFO &nbsp;] Running command: systemctl enable =
ceph.target</div><div class=3D"">[n10-075-094][INFO &nbsp;] checking OSD =
status...</div><div class=3D"">[n10-075-094][DEBUG ] find the location =
of an executable</div><div class=3D"">[n10-075-094][INFO &nbsp;] Running =
command: /usr/bin/ceph --cluster=3Dceph osd stat --format=3Djson</div><div=
 class=3D"">[ceph_deploy.osd][DEBUG ] Host n10-075-094 is now ready for =
osd use.</div></div></div></body></html>=

--Apple-Mail=_C7138CC4-5FEA-4A22-A45D-39968DB5FB30--

--===============1471343182066664520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1471343182066664520==--
