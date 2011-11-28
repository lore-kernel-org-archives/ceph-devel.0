From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: need help in a recovering ceph
Date: Mon, 28 Nov 2011 09:41:25 -0800
Message-ID: <CAF3hT9Cpbm1B7-fVw=AAia0F_7_Cuct1DtJDM_fAAtyY3yh2WQ@mail.gmail.com>
References: <4ED10636.6070705@biodatomics.com>
	<4ED36701.3060107@widodh.nl>
	<4ED37271.8030504@biodatomics.com>
	<CAF3hT9CS9EMnuUjTJF3S9L7U21xaOiin8eaezha2QToNBgATKA@mail.gmail.com>
	<4ED3BCBE.6000906@biodatomics.com>
	<CAF3hT9CFYe9AeUH5GBCcaUsfdP9itoL9ByVmbPZwe3ETuAT1nQ@mail.gmail.com>
	<4ED3C64B.5060601@biodatomics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45576 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab1K1Rl0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 12:41:26 -0500
Received: by iage36 with SMTP id e36so9234696iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 09:41:26 -0800 (PST)
In-Reply-To: <4ED3C64B.5060601@biodatomics.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: max@biodatomics.com
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 28, 2011 at 9:35 AM, Maxim Mikheev <mikhmv@biodatomics.com>=
 wrote:
> Hi Greg,
>
> it does not work:
>
> root@s2-8core:~# rados -p data bench 10 write
> Maintaining 16 concurrent writes of 4194304 bytes for at least 10 sec=
onds.
> =A0sec Cur ops =A0 started =A0finished =A0avg MB/s =A0cur MB/s =A0las=
t lat =A0 avg lat
> =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> 2011-11-28 12:27:25.190205 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x23032e0 tid 1
> 2011-11-28 12:27:25.190384 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x2303e10 tid 2
> 2011-11-28 12:27:25.190407 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x2300b50 tid 3
> 2011-11-28 12:27:25.190460 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x2300f70 tid 4
> 2011-11-28 12:27:25.190483 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x23019e0 tid 5
> 2011-11-28 12:27:25.190504 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x2301e00 tid 6
> 2011-11-28 12:27:25.190527 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x2304270 tid 7
> 2011-11-28 12:27:25.190547 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x2304690 tid 8
> 2011-11-28 12:27:25.190570 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x2304ab0 tid 9
> 2011-11-28 12:27:25.190592 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x2304ed0 tid 10
> 2011-11-28 12:27:25.190617 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x23052f0 tid 11
> 2011-11-28 12:27:25.190764 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x7fe488000cf0 tid 12
> 2011-11-28 12:27:25.190796 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x7fe480000ba0 tid 13
> 2011-11-28 12:27:25.190827 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x7fe480000fc0 tid 14
> 2011-11-28 12:27:25.190855 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x7fe4800013e0 tid 15
> 2011-11-28 12:27:25.190881 7fe493dbc740 client.7871.objecter =A0FULL,=
 paused
> modify 0x7fe480001800 tid 16
> =A0 =A01 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A02 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A03 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A04 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A05 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A06 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A07 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A08 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A09 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 10 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 11 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 12 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 13 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 14 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 15 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 16 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 17 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 18 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 19 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> min lat: 9999 max lat: 0 avg lat: 0
> =A0sec Cur ops =A0 started =A0finished =A0avg MB/s =A0cur MB/s =A0las=
t lat =A0 avg lat
> =A0 20 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 21 =A0 =A0 =A016 =A0 =A0 =A0 =A016 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =
=A0 0
Yes, this is expected, but it should have gotten the OSDs to get a new
"OSD map" so they should be transferring data based on the new weights
now. Check your network traffic. :)

> root@s1-2core:~# ceph mon injectargs --mon_osd_full_ratio 96
> 2011-11-28 12:29:39.067860 mon <- [mon,injectargs]
> 2011-11-28 12:29:39.068438 mon.0 -> 'unknown command injectargs' (-22=
)
> root@s1-2core:~# ceph mon injectargs "mon osd full ratio =3D 96"
> 2011-11-28 12:29:53.431669 mon <- [mon,injectargs,mon osd full ratio =
=3D 96]
> 2011-11-28 12:29:53.432076 mon.0 -> 'unknown command injectargs' (-22=
)
Oh, I forgot the syntax changed on these:
ceph injectargs --mon_osd_full_ratio 96
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
