From: Sage Weil <sage@newdream.net>
Subject: Re: some questions about ceph deployment
Date: Fri, 17 Sep 2010 13:30:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009171322440.29822@cobra.newdream.net>
References: <000d01cb4c37$71fadf90$55f09eb0$@com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1939056155-1284755456=:29822"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57556 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab0IQU3S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Sep 2010 16:29:18 -0400
In-Reply-To: <000d01cb4c37$71fadf90$55f09eb0$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: FWDF <fwdflywl@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1939056155-1284755456=:29822
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Sorry, I just realized this one slipped through the cracks!

On Sat, 4 Sep 2010, FWDF wrote:

> =FF=FF=FF=FFWe use 3 servers to build a test system of ceph, configured a=
s below:
> =FF=FF=FF=FF
> =FF=FF=FF=FFHost                          IP     =20
> =FF=FF=FF=FFclient01            192.168.1.10  =20
> =FF=FF=FF=FFceph01              192.168.2.50
> =FF=FF=FF=FFceph02              192.168.2.51  =20
> =FF=FF=FF=FF
> =FF=FF=FF=FFThe OS is unbuntu 10.04 LTS and the version of ceph is v0.21.=
1
> =FF=FF=FF=FF
> =FF=FF=FF=FFceph.conf:
> =FF=FF=FF=FF[global]
> =FF=FF=FF=FF        auth supported =3D cephx
> =FF=FF=FF=FF        pid file =3D /var/run/ceph/$name.pid
> =FF=FF=FF=FF        debug ms =3D 0
> =FF=FF=FF=FF        keyring =3D /etc/ceph/keyring.bin
> =FF=FF=FF=FF [mon]
> =FF=FF=FF=FF        mon data =3D /mnt/ceph/data/mon$id
> =FF=FF=FF=FF        debug ms =3D 1
> =FF=FF=FF=FF[mon0]
> =FF=FF=FF=FF        host =3D ceph01
> =FF=FF=FF=FF        mon addr =3D 192.168.2.50:6789
> =FF=FF=FF=FF [mds]
> =FF=FF=FF=FF        keyring =3D /etc/ceph/keyring.$name
> debug ms =3D 1
> =FF=FF=FF=FF[mds.ceph01]
> =FF=FF=FF=FF        host =3D ceph01
> =FF=FF=FF=FF[mds.ceph02]
> =FF=FF=FF=FF        host =3D ceph02
> =FF=FF=FF=FF[osd]
> =FF=FF=FF=FF        sudo =3D true
> =FF=FF=FF=FF        osd data =3D /mnt/ceph/osd$id/data
> =FF=FF=FF=FF        keyring =3D /etc/ceph/keyring.$name
> =FF=FF=FF=FF        osd journal =3D /mnt/ceph/osd$id/data/journal
> =FF=FF=FF=FF        osd journal size =3D 100
> =FF=FF=FF=FF[osd0]
> =FF=FF=FF=FF        host =3D ceph01
> =FF=FF=FF=FF[osd1]
> =FF=FF=FF=FF        host =3D ceph01
> =FF=FF=FF=FF[osd2]
> =FF=FF=FF=FF        host =3D ceph01
> =FF=FF=FF=FF[osd3]
> =FF=FF=FF=FF        host =3D ceph01
> =FF=FF=FF=FF[osd10]
> =FF=FF=FF=FF        host =3D ceph02
> =FF=FF=FF=FF
> =FF=FF=FF=FFThere are 4 HDDs in the ceph01 and every HDD has a OSD named =
as osd0, osd1, osd2,osd3; there is 1 HDD in the ceph02 named as osd10. All =
these HDDs are made as btrfs and mounted on the mount point as listed below=
:
> =FF=FF=FF=FF
> =FF=FF=FF=FFceph01
> =FF=FF=FF=FF         /dev/sdc1         /mnt/ceph/osd0/data               =
btrfs
> =FF=FF=FF=FF         /dev/sdd1         /mnt/ceph/osd1/data               =
btrfs
> =FF=FF=FF=FF         /dev/sde1         /mnt/ceph/osd2/data               =
btrfs
> =FF=FF=FF=FF         /dev/sdf1          /mnt/ceph/osd3/data              =
 btrfs
> =FF=FF=FF=FF
> =FF=FF=FF=FFceph02
> =FF=FF=FF=FF         /dev/sdb1         /mnt.ceph/osd10/data             b=
trfs
> =FF=FF=FF=FF
> =FF=FF=FF=FFMake ceph FileSystem:
> =FF=FF=FF=FFroot@ceph01:~#  mkcephfs  -c /etc/cepf/ceph.conf -a -k /etc/c=
eph/keyring.bin
> =FF=FF=FF=FF
> =FF=FF=FF=FFStartup ceph:
> =FF=FF=FF=FFroot@ceph01:~#  /etc/init.d/ceph =FF=FFa  start
>=20
>          Then
> =FF=FF=FF=FFroot@ceph01:~#  ceph -w
> =FF=FF=FF=FF10.09.01_17:56:19.337895   mds e17: 1/1/1 up {0=3Dup:active},=
 1 up:standby
> =FF=FF=FF=FF10.09.01_17:56:19.347184   osd e27: 5 osds: 5 up, 5 in
> =FF=FF=FF=FF10.09.01_17:56:19.349447     log =FF=FF=20
> =FF=FF=FF=FF10.09.01_17:56:19.373773   mon e1: 1 mons at 192.168.2.50:678=
9/0
> =FF=FF=FF=FF
> =FF=FF=FF=FFThe ceph file system is mounted to client01(192.168.1.10), ce=
ph01(192.168.2.50), ceph02=FF=FF192.168.2.51=FF=FFat /data/ceph. It works f=
ine at the beginning, I can use ls and the write and read of file is ok. Af=
ter some files are wrote , I find I can=FF=FFt use ls =FF=FFl /data/ceph un=
til I umount ceph from ceph02, but one day later the same problem occurred =
again, then I umount ceph from ceph01 the system and everything is ok.
>=20
> =FF=FF=FF=FFQ1:
>          Can the ceph filesystem be mounted to a member of ceph cluster?

Technically, yes, but you should be very careful doing so.  The problem is=
=20
that when the kernel is low on memory it will force the client to write=20
out dirty data so that it can reclaim those pages.  If the writeout=20
depends on then waking up some user process (cosd daemon), doing a bunch=20
of random work, and writing the data to disk (dirtying yet more memory),=20
you can deadlock the system.
=20
>          When I follow the instruction of http://ceph.newdream.net/wiki/M=
onitor_cluster_expansion to expand a monitor to ceph02, the following error=
 occurred:
> =FF=FF=FF=FF
> =FF=FF=FF=FFroot@ceph02:~#  /etc/init.d/ceph start mon1
> =FF=FF=FF=FF[/etc/ceph/fetch_config/tmp/fetched.ceph.conf.14210] ceph.con=
f 100%  2565  2.5KB/s  00:00=20
> =FF=FF=FF=FF=3D=3D=3D mon.1 =3D=3D=3D
> =FF=FF=FF=FFStarting Ceph mon1 on ceph02...
> =FF=FF=FF=FF ** WARNING: Ceph is still under heavy development, and is on=
ly suitable for **
> =FF=FF=FF=FF ** testing and review.  Do not trust it with important data.=
  **
> =FF=FF=FF=FFterminate called after throwing an instance of 'std::logic_er=
ror'
> =FF=FF=FF=FF  what():  basic_string::_S_construct NULL not valid
> =FF=FF=FF=FFAborted (core dumped)
> =FF=FF=FF=FFfailed: ' /usr/bin/cmon -i 1 -c /tmp/fetched.ceph.conf.14210 =
'

I haven't seen that crash, but it looks like a std::string constructor is=
=20
being passed a NULL pointer.  Do you have a core dump (to get a=20
backtrace)?  Which version are you running (`cmon -v`)?

> =FF=FF=FF=FFQ2:
> =FF=FF=FF=FFHow to expand a monitor to a running ceph system?

The process in that wiki article can expand the monitor cluster while it=20
is online.  Note that the monitor identication changed slightly between=20
v0.21 and the current unstable branch (will be v0.22), and the=20
instructions still need to be updated for that.

> =FF=FF=FF=FFQ3
> =FF=FF=FF=FF    Is it possible to add mds when the ceph system is running=
? how?

Yes.  Add the new mds to ceph.conf, start the daemon.  You should see it=20
as up:standby in the 'ceph -s' or 'ceph mds dump -o -' output.  Then

 ceph mds setmaxmds 2

change the size of the 'active' cluster to 2. =20

Please keep in mind the clustered MDS still has some bugs; we expect v0.22=
=20
to be stable.

> =FF=FF=FF=FF
> =FF=FF=FF=FFI fdisked a HDD into two partition, one for journal, other on=
e for data like this:
> =FF=FF=FF=FF/dev/sdc1=FF=FF180GB=FF=FFas data
> =FF=FF=FF=FF/dev/sdc2=FF=FF10GB=FF=FFas journal
> =FF=FF=FF=FF
> =FF=FF=FF=FF/dev/sdc1 made as btrfs, mount to /mnt/osd0/data
> =FF=FF=FF=FF/dev/sdc2 made as btrfs, mount to /mnt/osd0/journal
> =FF=FF=FF=FF
> =FF=FF=FF=FFceph.conf:
> =FF=FF=FF=FF=FF=FF
> =FF=FF=FF=FF[osd]
> =FF=FF=FF=FF        osd data =3D /mnt/ceph/osd$id/data
> =FF=FF=FF=FF        osd journal =3D /mnt/ceph/osd$id/journal
> =FF=FF=FF=FF        ; osd journal size =3D 100
> =FF=FF=FF=FF=FF=FF
> =FF=FF=FF=FFWhen I use mkcephfs command, I can't build osd until I edited=
 ceph.conf like this:
> =FF=FF=FF=FF
> =FF=FF=FF=FF[osd]
> =FF=FF=FF=FF        osd data =3D /mnt/ceph/osd$id/data
> =FF=FF=FF=FF        osd journal =3D /mnt/ceph/osd$id/data/journal
> =FF=FF=FF=FF        osd journal size =3D 100

If the journal is a file, the system won't create it for you unless you=20
specify a size.  If it already exists (e.g., you created it via 'dd', or=20
it's a block device) the journal size isn't needed.

> =FF=FF=FF=FFQ4.
> =FF=FF=FF=FF  How to set the journal path to a device or patition?

=09osd journal =3D /dev/sdc1  ; or whatever

Hope this helps!  Sorry for the slow response.  Let us know if you have=20
further questions!

sage


> =FF=FF=FF=FFThanks for all help and reply , sorry for my lame English.
> =FF=FF=FF=FF
> =FF=FF=FF=FFLin
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1939056155-1284755456=:29822--
