From: Sage Weil <sage@newdream.net>
Subject: Re: Slow ceph io. High iops. Compared to hadoop.
Date: Tue, 17 Jan 2012 08:44:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201170843220.15646@cobra.newdream.net>
References: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
 <CAADCt4KQUnN9Mmc+LEmMs_ryYp1Jveega7XHt9mJdjJ6-AHg1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1261393288-1326818640=:15646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45146 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab2AQQoE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2012 11:44:04 -0500
In-Reply-To: <CAADCt4KQUnN9Mmc+LEmMs_ryYp1Jveega7XHt9mJdjJ6-AHg1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1261393288-1326818640=:15646
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 16 Jan 2012, Andrey Stepachev wrote:
> Ops. It is really a buffer problem.
> It can be checked with easy with ceph osd tell 4 bench
>=20
> bench: wrote 1024 MB in blocks of 15625 KB in 17.115538 sec at 61264 KB/s=
ec
> bench: wrote 1024 MB in blocks of 122 MB in 12.281531 sec at 85378 KB/sec
> bench: wrote 1024 MB in blocks of 244 MB in 13.529501 sec at 77502 KB/sec
> bench: wrote 3814 MB in blocks of 488 MB in 30.909198 sec at 123 MB/sec
>=20
> and in last case dstat show 'iozone-like iops'
>=20
>  100: 100: 100: 100|  0   0  94   6   0   0|   0   538M|   0   238
>  100: 100: 100: 100|  0   0  96   3   0   0|   0   525M|   0   133
>  100: 100: 100: 100|  0   2  95   3   0   0|   0   497M|   0   128
> 18.0:39.0:30.0:27.0|  0   3  96   2   0   0|   0   144M|   0  40.0
> 75.0:74.0:72.0:67.0|  0   3  95   2   0   0|   0   103M|   0  2698
>  100: 100: 100: 100|  0  13  83   4   0   0|   0   484M|   0   125
>  100: 100: 100: 100|  0   0 100   0   0   0|   0   486M|   0   124
>  100: 100: 100: 100|  0   3  88   9   0   0|   0   476M|   0   123
>=20
> Now question arises: how ceph can be tuned to gain such
> performance in normal operations, not in bench?

This may be related to how your OSD journaling is configured.  I'm=20
guessing it's set to a file inside the btrfs volume holding the data?

sage

>=20
> 2012/1/16 Andrey Stepachev <octo47@gmail.com>:
> > Hi all.
> >
> > Last week I've investigate the status for hadoop on ceph.
> > I create some patches to remove some bugs and crashes.
> > Looks like it works. Even hbase works on top.
> >
> > For reference all sources and patches are here
> >
> > https://github.com/octo47/hadoop-common/tree/branch-1.0-ceph
> > https://github.com/octo47/ceph/tree/v0.40-hadoop
> >
> > After YCSB and TestDSFIO work without crashes i start investigate
> > performance.
> >
> > I have 5node cluster with 4 sata disks. btrfs. 24core on each.
> > raid. iozone shows up to 520MB/s.
> >
> > Performance differs in 2-3 times. After some tests i see strange thing.
> > hadoop uses disk very close to iozone: small amount and iops and high
> > throughtput (same as iozone).
> > ceph uses very inefficient: huge amount of iops, up to 3 times less
> > throughtput (i think because of high amount of iops).
> >
> > hadoop dstat output:
> > sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total-
> > util:util:util:util|usr sys idl wai hiq siq| read =A0writ| read =A0writ
> > =A0100: 100: 100: 100| =A01 =A0 5 =A083 =A011 =A0 0 =A0 0| =A0 0 =A0 52=
9M| =A0 0 =A0 247
> > =A0100: 100: 100: 100| =A01 =A0 0 =A083 =A016 =A0 0 =A0 0| =A0 0 =A0 54=
2M| =A0 0 =A0 168
> > =A0100: 100: 100: 100| =A01 =A0 0 =A081 =A018 =A0 0 =A0 0| =A028k =A051=
8M|6.00 =A0 149
> > =A0100: 100: 100: 100| =A01 =A0 4 =A077 =A017 =A0 0 =A0 0| =A0 0 =A0 53=
3M| =A0 0 =A0 243
> > =A0100: 100: 100: 100| =A01 =A0 3 =A083 =A013 =A0 0 =A0 0| =A0 0 =A0 52=
3M| =A0 0 =A0 264
> >
> > ceph dstat output:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total-
> > util:util:util:util|usr sys idl wai hiq siq| read =A0writ| read =A0writ
> > 68.0:70.0:79.0:76.0| =A01 =A0 2 =A093 =A0 4 =A0 0 =A0 0| =A0 0 =A0 195M=
| =A0 0 =A01723
> > 86.0:85.0:93.0:91.0| =A01 =A0 2 =A091 =A0 5 =A0 0 =A0 0| =A0 0 =A0 226M=
| =A0 0 =A01816
> > 85.0:85.0:85.0:84.0| =A01 =A0 3 =A092 =A0 4 =A0 0 =A0 0| =A0 0 =A0 235M=
| =A0 0 =A02316
> >
> >
> > So, my question is: can someone point me:
> > a) can it be because of inefficient buffer size on osd part
> > (i tried to increase CephOutputStream buffer to 256kb, not helps)
> > b) what other problems can be and what options can i tune
> > to find out what is going on.
> >
> > PS: i can't use iozone on kernel mounted fs. something
> > hang in kernel, only reboot helps.
> > in /var/log/messages i see attached kern.log.
> >
> >
> >
> > --
> > Andrey.
>=20
>=20
>=20
> --=20
> Andrey.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1261393288-1326818640=:15646--
