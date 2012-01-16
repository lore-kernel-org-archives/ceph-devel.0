From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Slow ceph io. High iops. Compared to hadoop.
Date: Mon, 16 Jan 2012 15:02:40 +0400
Message-ID: <CAADCt4LUwy2NdYvH=T4qgSxNnfBZsFYy6mPAxGp8b02_h1hObw@mail.gmail.com>
References: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d043d66fd70208c04b6a32848
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34042 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab2APLDD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2012 06:03:03 -0500
Received: by wgbgn7 with SMTP id gn7so1254711wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2012 03:03:01 -0800 (PST)
In-Reply-To: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--f46d043d66fd70208c04b6a32848
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

And here is perfcounters, a few seconds after ceph starts
write data (disk util goes up in dstat)

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
> Performance differs in 2-3 times. After some tests i see strange thing.
> hadoop uses disk very close to iozone: small amount and iops and high
> throughtput (same as iozone).
> ceph uses very inefficient: huge amount of iops, up to 3 times less
> throughtput (i think because of high amount of iops).
>
> hadoop dstat output:
> sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total-
> util:util:util:util|usr sys idl wai hiq siq| read =C2=A0writ| read =C2=A0=
writ
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 5 =C2=A083 =C2=A011 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 529M| =C2=A0 0 =C2=A0 247
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 0 =C2=A083 =C2=A016 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 542M| =C2=A0 0 =C2=A0 168
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 0 =C2=A081 =C2=A018 =C2=A0 0 =C2=
=A0 0| =C2=A028k =C2=A0518M|6.00 =C2=A0 149
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 4 =C2=A077 =C2=A017 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 533M| =C2=A0 0 =C2=A0 243
> =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 3 =C2=A083 =C2=A013 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 523M| =C2=A0 0 =C2=A0 264
>
> ceph dstat output:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total-
> util:util:util:util|usr sys idl wai hiq siq| read =C2=A0writ| read =C2=A0=
writ
> 68.0:70.0:79.0:76.0| =C2=A01 =C2=A0 2 =C2=A093 =C2=A0 4 =C2=A0 0 =C2=A0 0=
| =C2=A0 0 =C2=A0 195M| =C2=A0 0 =C2=A01723
> 86.0:85.0:93.0:91.0| =C2=A01 =C2=A0 2 =C2=A091 =C2=A0 5 =C2=A0 0 =C2=A0 0=
| =C2=A0 0 =C2=A0 226M| =C2=A0 0 =C2=A01816
> 85.0:85.0:85.0:84.0| =C2=A01 =C2=A0 3 =C2=A092 =C2=A0 4 =C2=A0 0 =C2=A0 0=
| =C2=A0 0 =C2=A0 235M| =C2=A0 0 =C2=A02316
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

--f46d043d66fd70208c04b6a32848
Content-Type: text/x-log; charset=US-ASCII; name="perfcounters.log"
Content-Disposition: attachment; filename="perfcounters.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxhdx4yi1

eyAiZmlsZXN0b3JlIiA6IHsgImFwcGx5X2xhdGVuY3kiIDogeyAiYXZnY291bnQiIDogMzc1MiwK
ICAgICAgICAgICJzdW0iIDogMTA3LjAwNzAwMDAwMDAwMDAxCiAgICAgICAgfSwKICAgICAgImJ5
dGVzIiA6IDEwODQwMjY0MDUsCiAgICAgICJjb21taXRjeWNsZSIgOiAxMCwKICAgICAgImNvbW1p
dGN5Y2xlX2ludGVydmFsIiA6IHsgImF2Z2NvdW50IiA6IDEwLAogICAgICAgICAgInN1bSIgOiA1
Ny45MDI1MDAwMDAwMDAwMDMKICAgICAgICB9LAogICAgICAiY29tbWl0Y3ljbGVfbGF0ZW5jeSIg
OiB7ICJhdmdjb3VudCIgOiAxMCwKICAgICAgICAgICJzdW0iIDogNy44OTIwMQogICAgICAgIH0s
CiAgICAgICJjb21taXR0aW5nIiA6IDAsCiAgICAgICJqb3VybmFsX2J5dGVzIiA6IDk3NDk1NjAy
OSwKICAgICAgImpvdXJuYWxfZnVsbCIgOiAwLAogICAgICAiam91cm5hbF9sYXRlbmN5IiA6IHsg
ImF2Z2NvdW50IiA6IDM3MzksCiAgICAgICAgICAic3VtIiA6IDEzNjEuMTE5OTk5OTk5OTk5OQog
ICAgICAgIH0sCiAgICAgICJqb3VybmFsX29wcyIgOiAzNzM5LAogICAgICAiam91cm5hbF9xdWV1
ZV9ieXRlcyIgOiAxMDkwNzAzNzYsCiAgICAgICJqb3VybmFsX3F1ZXVlX21heF9ieXRlcyIgOiAx
MDQ4NTc2MDAsCiAgICAgICJqb3VybmFsX3F1ZXVlX21heF9vcHMiIDogNTAwLAogICAgICAiam91
cm5hbF9xdWV1ZV9vcHMiIDogMTMsCiAgICAgICJvcF9xdWV1ZV9ieXRlcyIgOiAyNjc0Mjk3NCwK
ICAgICAgIm9wX3F1ZXVlX21heF9ieXRlcyIgOiAxMDQ4NTc2MDAsCiAgICAgICJvcF9xdWV1ZV9t
YXhfb3BzIiA6IDUwMCwKICAgICAgIm9wX3F1ZXVlX29wcyIgOiAzLAogICAgICAib3BzIiA6IDM3
NTIKICAgIH0sCiAgIm9zZCIgOiB7ICJidWZmZXJfYnl0ZXMiIDogMCwKICAgICAgImhlYXJ0YmVh
dF9mcm9tX3BlZXJzIiA6IDQsCiAgICAgICJoZWFydGJlYXRfdG9fcGVlcnMiIDogNCwKICAgICAg
ImxvYWRhdmciIDogMC40MTk5OTk5OTk5OTk5OTk5OCwKICAgICAgIm1hcF9tZXNzYWdlX2Vwb2No
X2R1cHMiIDogMTAsCiAgICAgICJtYXBfbWVzc2FnZV9lcG9jaHMiIDogMTQsCiAgICAgICJtYXBf
bWVzc2FnZXMiIDogMTEsCiAgICAgICJudW1wZyIgOiA2MjUsCiAgICAgICJudW1wZ19wcmltYXJ5
IiA6IDIwOSwKICAgICAgIm51bXBnX3JlcGxpY2EiIDogNDE2LAogICAgICAibnVtcGdfc3RyYXki
IDogMCwKICAgICAgIm9wIiA6IDEzNywKICAgICAgIm9wX2luX2J5dGVzIiA6IDE2MDk5NzMxNiwK
ICAgICAgIm9wX2xhdGVuY3kiIDogeyAiYXZnY291bnQiIDogMTM3LAogICAgICAgICAgInN1bSIg
OiAxOTAuOTg2OTk5OTk5OTk5OTkKICAgICAgICB9LAogICAgICAib3Bfb3V0X2J5dGVzIiA6IDI2
ODcxLAogICAgICAib3BfciIgOiA5LAogICAgICAib3Bfcl9sYXRlbmN5IiA6IHsgImF2Z2NvdW50
IiA6IDksCiAgICAgICAgICAic3VtIiA6IDMuMDI0MzMKICAgICAgICB9LAogICAgICAib3Bfcl9v
dXRfYnl0ZXMiIDogMjY4NzEsCiAgICAgICJvcF9ydyIgOiAwLAogICAgICAib3BfcndfaW5fYnl0
ZXMiIDogMCwKICAgICAgIm9wX3J3X2xhdGVuY3kiIDogeyAiYXZnY291bnQiIDogMCwKICAgICAg
ICAgICJzdW0iIDogMAogICAgICAgIH0sCiAgICAgICJvcF9yd19vdXRfYnl0ZXMiIDogMCwKICAg
ICAgIm9wX3J3X3JsYXQiIDogeyAiYXZnY291bnQiIDogMCwKICAgICAgICAgICJzdW0iIDogMAog
ICAgICAgIH0sCiAgICAgICJvcF93IiA6IDEyOCwKICAgICAgIm9wX3dfaW5fYnl0ZXMiIDogMTYw
OTk3MzE2LAogICAgICAib3Bfd19sYXRlbmN5IiA6IHsgImF2Z2NvdW50IiA6IDEyOCwKICAgICAg
ICAgICJzdW0iIDogMTg3Ljk2Mjk5OTk5OTk5OTk5CiAgICAgICAgfSwKICAgICAgIm9wX3dfcmxh
dCIgOiB7ICJhdmdjb3VudCIgOiAxMjgsCiAgICAgICAgICAic3VtIiA6IDc1LjAxMjIwMDAwMDAw
MDAwNwogICAgICAgIH0sCiAgICAgICJvcF93aXAiIDogNSwKICAgICAgIm9wcSIgOiA3LAogICAg
ICAicHVsbCIgOiAwLAogICAgICAicHVzaCIgOiAwLAogICAgICAicHVzaF9vdXRfYnl0ZXMiIDog
MCwKICAgICAgInJlY292ZXJ5X29wcyIgOiAwLAogICAgICAic3Vib3AiIDogMzM0LAogICAgICAi
c3Vib3BfaW5fYnl0ZXMiIDogNzM1NjExMTQ1LAogICAgICAic3Vib3BfbGF0ZW5jeSIgOiB7ICJh
dmdjb3VudCIgOiAzMzQsCiAgICAgICAgICAic3VtIiA6IDIzOC45ODU5OTk5OTk5OTk5OQogICAg
ICAgIH0sCiAgICAgICJzdWJvcF9wdWxsIiA6IDAsCiAgICAgICJzdWJvcF9wdWxsX2xhdGVuY3ki
IDogeyAiYXZnY291bnQiIDogMCwKICAgICAgICAgICJzdW0iIDogMAogICAgICAgIH0sCiAgICAg
ICJzdWJvcF9wdXNoIiA6IDAsCiAgICAgICJzdWJvcF9wdXNoX2luX2J5dGVzIiA6IDAsCiAgICAg
ICJzdWJvcF9wdXNoX2xhdGVuY3kiIDogeyAiYXZnY291bnQiIDogMCwKICAgICAgICAgICJzdW0i
IDogMAogICAgICAgIH0sCiAgICAgICJzdWJvcF93IiA6IDAsCiAgICAgICJzdWJvcF93X2luX2J5
dGVzIiA6IDczNTYxMTE0NSwKICAgICAgInN1Ym9wX3dfbGF0ZW5jeSIgOiB7ICJhdmdjb3VudCIg
OiAzMzQsCiAgICAgICAgICAic3VtIiA6IDIzOC45ODU5OTk5OTk5OTk5OQogICAgICAgIH0KICAg
IH0KfQo=
--f46d043d66fd70208c04b6a32848--
