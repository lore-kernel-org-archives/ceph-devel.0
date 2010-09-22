From: Sage Weil <sage@newdream.net>
Subject: Re: some questions about ceph deployment
Date: Wed, 22 Sep 2010 09:17:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009220911290.6962@cobra.newdream.net>
References: <000d01cb4c37$71fadf90$55f09eb0$@com>
 <Pine.LNX.4.64.1009171322440.29822@cobra.newdream.net>
 <AANLkTikLgvHVRnHC+ept0NZv7uGVpAL52hDdFH2wiN9L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1175787854-1285172244=:6962"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44271 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab0IVQPf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 12:15:35 -0400
In-Reply-To: <AANLkTikLgvHVRnHC+ept0NZv7uGVpAL52hDdFH2wiN9L@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cang lin <fwdflywl@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1175787854-1285172244=:6962
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 22 Sep 2010, cang lin wrote:
> We not only mount ceph onto a client in the same subnet but also mount it
> onto remote client through internet.in the first week everything worked
> fine,it is about 100G write operation and 10 times read operation per
> day.The file was almost read only and the size is form a dozens  of MB to=
 a
> few GB,not a very heavy load.but in the second week the client in the sam=
e
> subnet with ceph cluster can=FF=FFt be accessed and ceph can=FF=FFt be un=
mounted from
> it,the remote client can still access and unmount ceph.
>=20
> Use 'ceph =FF=FFs' and 'ceph osd dump -0' on ceph01 can find out that the=
 3 of 4
> osd were down(osd0,osd02,osd04). Use 'df =FF=FFh' command can find out
> /dev/sde1(for osd0), /dev/sdd1(for osd2), /dev/sdc1(for osd4) still in th=
eir
> mount point.
>=20
> Use following command to restart osd:
>=20
> # /etc/init.d/ceph start osd0
>=20
> [/etc/ceph/fetch_config /tmp/fetched.ceph.conf.4967]
>=20
> =3D=3D=3D osd.0 =3D=3D=3D
>=20
> Starting Ceph osd0 on ceph01...
>=20
>  ** WARNING: Ceph is still under heavy development, and is only suitable =
for
> **
>=20
>  **          testing and review.  Do not trust it with important data.
> **
>=20
> starting osd0 at 0.0.0.0:6800/4864 osd_data /mnt/ceph/osd0/data
> /mnt/ceph/osd0/data/journal
>=20
> =FF=FF
>=20
> 3 osd started and ran normally,but the local ceph client was down.Dose it
> have anything to do with the osd restart?The local client can remount cep=
h
> after reboot and work normally. The remote client can remount ceph and wo=
rk
> normally too,but a few days later it can=FF=FFt access or unmount ceph.
>=20
>=20
>=20
> #umount /mnt/ceph
>=20
> umount: /mnt/ceph: device is busy.
>=20
>         (In some cases useful info about processes that use
>=20
>          the device is found by lsof(8) or fuser(1))
>=20
>=20
> There was no response for lsof or fuser command.the only thing could do i=
s
> kill the process and reboot the system.We use ceph v0.21.2 for the cluste=
r
> and client and use Ubuntu 10.04 LTS(server),kernel version is
> 2.6.32-21-generic-pae=FF=FF
>=20
>  What confuse me is why the client can=FF=FFt access ceph?Even if the osd=
 was
> down shouldn=FF=FFt affect the client.what is the reason for the client c=
an=FF=FFt
> access or unmount ceph?

It could be a number of things.  The output from=20

 cat /sys/kernel/debug/ceph/*/mdsc
 cat /sys/kernel/debug/ceph/*/osdc

will tell you if it's waiting for a server request to respond.  Also, if=20
you know the hung pid, you can

 cat /proc/$pid/stack

and see where it is blocked.  Also,

 dmesg | tail

may have some relevant console messages.


> >          When I follow the instruction of
> > http://ceph.newdream.net/wiki/Monitor_cluster_expansion to expand a
> > monitor to ceph02, the following error occurred:
> > >
> > > root@ceph02:~#  /etc/init.d/ceph start mon1
> > > [/etc/ceph/fetch_config/tmp/fetched.ceph.conf.14210] ceph.conf 100%  =
2565
> >  2.5KB/s  00:00
> > > =3D=3D=3D mon.1 =3D=3D=3D
> > > Starting Ceph mon1 on ceph02...
> > >  ** WARNING: Ceph is still under heavy development, and is only suita=
ble
> > for **
> > >  ** testing and review.  Do not trust it with important data.  **
> > > terminate called after throwing an instance of 'std::logic_error'
> > >   what():  basic_string::_S_construct NULL not valid
> > > Aborted (core dumped)
> > > failed: ' /usr/bin/cmon -i 1 -c /tmp/fetched.ceph.conf.14210 '
> >
> > I haven't seen that crash, but it looks like a std::string constructor =
is
> > being passed a NULL pointer.  Do you have a core dump (to get a
> > backtrace)?  Which version are you running (`cmon -v`)?
> >
>=20
> The cmon version is v0.21.1 when the crash happen and been updated to
> v0.21.2.
>=20
> The following backtrace is from v0.21.2:

Thanks, we'll see if we can reproduce and fix this one!

> [...]
> Thanks,I will wait for v0.22 and try to add mds then,but I want to is my
> config for mds is right.
>=20
>=20
>=20
> I set 2 mds in ceph.conf
>=20
> [mds]
>=20
> keyring =3D /etc/ceph/keyring.$name
>=20
> debug ms =3D 1
>=20
> [mds.ceph01]
>=20
> host =3D ceph01
>=20
> [mds.ceph02]
>=20
>       host =3D ceph02

Looks right.


> The result for 'ceph =FF=FFs':
>=20
> 10.09.01_17:56:19.337895   mds e17: 1/1/1 up {0=3Dup:active}, 1 up:standb=
y
>=20
> But now the result for 'ceph =FF=FFs' is:
>=20
> 10.09.19_17:01:50.398809   mds e27: 1/1/1 up {0=3Dup:active}

It looks like the second 'standby' cmds went away.  Is the daemon still=20
running?


> > > Q4.
> > > How to set the journal path to a device or patition?
> >
> >        osd journal =3D /dev/sdc1  ; or whatever
> >
>=20
> How to know which journal is for certain osd?
>=20
> Can the following config does that?
>=20
>=20
>=20
> [osd]
>=20
>         sudo =3D true
>=20
>         osd data =3D /mnt/ceph/osd$id/data
>=20
> [osd0]
>=20
>         host =3D ceph01
>=20
>         osd journal =3D /dev/sdc1
>=20
>=20
> If I make a partition for journal in a 500GB hdd,what is the proper size =
for
> the partition?

1 GB should be sufficient.

sage
--557981400-1175787854-1285172244=:6962--
