From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Slow ceph io. High iops. Compared to hadoop.
Date: Mon, 16 Jan 2012 15:23:27 +0400
Message-ID: <CAADCt4KQUnN9Mmc+LEmMs_ryYp1Jveega7XHt9mJdjJ6-AHg1w@mail.gmail.com>
References: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58880 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab2APLXt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2012 06:23:49 -0500
Received: by wgbdq11 with SMTP id dq11so550629wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2012 03:23:48 -0800 (PST)
In-Reply-To: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ops. It is really a buffer problem.
It can be checked with easy with ceph osd tell 4 bench

bench: wrote 1024 MB in blocks of 15625 KB in 17.115538 sec at 61264 KB=
/sec
bench: wrote 1024 MB in blocks of 122 MB in 12.281531 sec at 85378 KB/s=
ec
bench: wrote 1024 MB in blocks of 244 MB in 13.529501 sec at 77502 KB/s=
ec
bench: wrote 3814 MB in blocks of 488 MB in 30.909198 sec at 123 MB/sec

and in last case dstat show 'iozone-like iops'

 100: 100: 100: 100|  0   0  94   6   0   0|   0   538M|   0   238
 100: 100: 100: 100|  0   0  96   3   0   0|   0   525M|   0   133
 100: 100: 100: 100|  0   2  95   3   0   0|   0   497M|   0   128
18.0:39.0:30.0:27.0|  0   3  96   2   0   0|   0   144M|   0  40.0
75.0:74.0:72.0:67.0|  0   3  95   2   0   0|   0   103M|   0  2698
 100: 100: 100: 100|  0  13  83   4   0   0|   0   484M|   0   125
 100: 100: 100: 100|  0   0 100   0   0   0|   0   486M|   0   124
 100: 100: 100: 100|  0   3  88   9   0   0|   0   476M|   0   123

Now question arises: how ceph can be tuned to gain such
performance in normal operations, not in bench?

2012/1/16 Andrey Stepachev <octo47@gmail.com>:
> Hi all.
>
> Last week I've investigate the status for hadoop on ceph.
> I create some patches to remove some bugs and crashes.
> Looks like it works. Even hbase works on top.
>
> For reference all sources and patches are here
>
> https://github.com/octo47/hadoop-common/tree/branch-1.0-ceph
> https://github.com/octo47/ceph/tree/v0.40-hadoop
>
> After YCSB and TestDSFIO work without crashes i start investigate
> performance.
>
> I have 5node cluster with 4 sata disks. btrfs. 24core on each.
> raid. iozone shows up to 520MB/s.
>
> Performance differs in 2-3 times. After some tests i see strange thin=
g.
> hadoop uses disk very close to iozone: small amount and iops and high
> throughtput (same as iozone).
> ceph uses very inefficient: huge amount of iops, up to 3 times less
> throughtput (i think because of high amount of iops).
>
> hadoop dstat output:
> sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total-
> util:util:util:util|usr sys idl wai hiq siq| read =C2=A0writ| read =C2=
=A0writ
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 5 =C2=A083 =C2=A011 =C2=A0 0=
 =C2=A0 0| =C2=A0 0 =C2=A0 529M| =C2=A0 0 =C2=A0 247
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 0 =C2=A083 =C2=A016 =C2=A0 0=
 =C2=A0 0| =C2=A0 0 =C2=A0 542M| =C2=A0 0 =C2=A0 168
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 0 =C2=A081 =C2=A018 =C2=A0 0=
 =C2=A0 0| =C2=A028k =C2=A0518M|6.00 =C2=A0 149
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 4 =C2=A077 =C2=A017 =C2=A0 0=
 =C2=A0 0| =C2=A0 0 =C2=A0 533M| =C2=A0 0 =C2=A0 243
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 3 =C2=A083 =C2=A013 =C2=A0 0=
 =C2=A0 0| =C2=A0 0 =C2=A0 523M| =C2=A0 0 =C2=A0 264
>
> ceph dstat output:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total-
> util:util:util:util|usr sys idl wai hiq siq| read =C2=A0writ| read =C2=
=A0writ
> 68.0:70.0:79.0:76.0| =C2=A01 =C2=A0 2 =C2=A093 =C2=A0 4 =C2=A0 0 =C2=A0=
 0| =C2=A0 0 =C2=A0 195M| =C2=A0 0 =C2=A01723
> 86.0:85.0:93.0:91.0| =C2=A01 =C2=A0 2 =C2=A091 =C2=A0 5 =C2=A0 0 =C2=A0=
 0| =C2=A0 0 =C2=A0 226M| =C2=A0 0 =C2=A01816
> 85.0:85.0:85.0:84.0| =C2=A01 =C2=A0 3 =C2=A092 =C2=A0 4 =C2=A0 0 =C2=A0=
 0| =C2=A0 0 =C2=A0 235M| =C2=A0 0 =C2=A02316
>
>
> So, my question is: can someone point me:
> a) can it be because of inefficient buffer size on osd part
> (i tried to increase CephOutputStream buffer to 256kb, not helps)
> b) what other problems can be and what options can i tune
> to find out what is going on.
>
> PS: i can't use iozone on kernel mounted fs. something
> hang in kernel, only reboot helps.
> in /var/log/messages i see attached kern.log.
>
>
>
> --
> Andrey.



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
