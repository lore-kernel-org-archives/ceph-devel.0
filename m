From: Mark Nelson <mnelson@redhat.com>
Subject: Re: FW: Reg:.[CBT] Unable to do a CBT Clean Run.
Date: Fri, 5 Feb 2016 10:43:43 -0600
Message-ID: <56B4D13F.2000105@redhat.com>
References: <B22CD36FB1C8D94DB1871AFD0023B0E438D72067@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52104 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245AbcBEQnr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 11:43:47 -0500
In-Reply-To: <B22CD36FB1C8D94DB1871AFD0023B0E438D72067@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.com>, "ceph-devel-owner@vger.kernel.org" <ceph-devel-owner@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Gunna (Gunneswara) Marripudi-SSI" <g.marripudi@ssi.samsung.com>, Brent Compton <bcompton@redhat.com>, Kyle Bader <kbader@redhat.com>, Sage Weil <sage@newdream.net>

Hi Vish,

Thanks for the report!

I seem to remember seeing something very similar to this a while back=20
and it turned out to be an issue on the monitor where crushtool wasn't=20
in the path.

The way I had to solve it was to set the "crushtool" path via ceph.conf=
:

https://github.com/ceph/ceph/blob/master/src/common/config_opts.h#L29

Please let me know if that helps.

Thanks,
Mark

On 02/05/2016 10:26 AM, Vish (Vishwanath) Maram-SSI wrote:
> Hi,
>
> Sorry I am forwarding again as the mails are not going through the li=
st.
>
> Thanks,
>
> -Vish
>
> *From:*Vish (Vishwanath) Maram-SSI
> *Sent:* Thursday, February 04, 2016 3:45 PM
> *To:* 'ceph-devel-owner@vger.kernel.org'; 'ceph-devel@vger.kernel.org=
'
> *Cc:* 'Brent Compton'; 'Kyle Bader'
> *Subject:* Reg:.[CBT] Unable to do a CBT Clean Run.
>
> Hi All,
>
> We are trying to do a clean run with CBT and please find below all th=
e
> details:
>
> 1.OS =96 CentOS7.2
>
> 2.CBT =96 Commit ID =931203c2b9d25344d1e15b28236ea2f19aa3103e0b=94 fr=
om =93git log=94
>
> 3.CEPH Code =96 Hammer Version =96 0.94.5
>
> 4.Test.yaml =96 Please find below
>
> 5.Ceph.conf =96 Please find below
>
> *__*
>
> *_Issue:_*
>
> Command - ./cbt.py --archive=3D"Archive" --conf=3D./ceph.conf ./test.=
yaml >
> cmd_log.txt
>
> After the above command is executed we were able to check the Cluster=
 is
> being created on the Server and able to see the status/OSD Tree as we=
ll.
> All those show correct, but we didn=92t see any IO going on the disk
> (iostat =96t 5). So we started debugging the CBT code ceph.py under
> cluster directory. When we debugged and we observed that pool creatio=
n
> is not happening and we inserted break in ceph.py just before pool
> creation and executed the pool creation command on Server and get the
> below error:
>
> *Error EINVAL: error running crushmap through crushtool: (125) Operat=
ion
> canceled*
>
> And because of the above issue we weren=92t able to see any FIO run.
>
> Appreciate any inputs.
>
> Thanks,
>
> -Vish
>
> Test.yaml =96
>
>    1  cluster:
>
>    2   user: 'root'
>
>    3   head: "Server"
>
>    4   clients: ["client"]
>
>    5   osds: ["Server"]
>
>    6   mons:
>
>    7     Mon1:
>
>    8       a: "10.10.10.150:6789"
>
>    9   osds_per_node: 1
>
> 10   fs: 'xfs'
>
> 11   mkfs_opts: '-f -i size=3D2048 -n size=3D64k'
>
> 12   mount_opts: '-o inode64,noatime,logbsize=3D256k'
>
> 13   conf_file: '/usr/local/ceph-cbt/ceph.conf.1osd'
>
> 14   iterations: 1
>
> 15   use_existing: False
>
> 16 #  clusterid: "8eda02e2-04b7-4eed-a85a-8471ea51528c"
>
> 17   clusterid: "cbttest"
>
> 18   tmp_dir: "/tmp/cbt"
>
> 19   pool_profiles:
>
> 20     rbd:
>
> 21       pg_size: 256
>
> 22       pgp_size: 256
>
> 23       replication: 1
>
> 24 benchmarks:
>
> 25   librbdfio:
>
> 26     time: 300
>
> 27     vol_size: 16384
>
> 28     mode: [write]
>
> 29     op_size: [1048576]
>
> 30     concurrent_procs: [1]
>
> 31     iodepth: [64]
>
> 32     osd_ra: [4096]
>
> 33     cmd_path: '/usr/local/bin/fio'
>
> 34     pool_profile: 'rbd'
>
> Ceph.conf =96
>
> [global]
>
>          osd pool default size =3D 1
>
>          auth cluster required =3D none
>
>          auth service required =3D none
>
>          auth client required =3D none
>
>          keyring =3D /tmp/cbt/ceph/keyring
>
>          osd pg bits =3D 8
>
>          osd pgp bits =3D 8
>
>          log to syslog =3D false
>
>          log file =3D /tmp/cbt/ceph/log/$name.log
>
>          public network =3D 10.10.10.0/24
>
>          cluster network =3D 10.10.10.0/24
>
>          rbd cache =3D true
>
>          osd scrub load threshold =3D 0.01
>
>          osd scrub min interval =3D 137438953472
>
>          osd scrub max interval =3D 137438953472
>
>          osd deep scrub interval =3D 137438953472
>
>          osd max scrubs =3D 16
>
>          filestore merge threshold =3D 40
>
>          filestore split multiple =3D 8
>
>          osd op threads =3D 8
>
>          mon pg warn max object skew =3D 100000
>
>          mon pg warn min per osd =3D 0
>
>          mon pg warn max per osd =3D 32768
>
> [mon]
>
>          mon data =3D /tmp/cbt/ceph/mon.$id
>
> [mon.a]
>
>          host =3D Mon1
>
>          mon addr =3D 10.10.10.150:6789
>
> [osd.0]
>
>          host =3D Server
>
>          osd data =3D /tmp/cbt/mnt/osd-device-0-data
>
>          osd journal =3D /dev/disk/by-partlabel/osd-device-0-journal
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
