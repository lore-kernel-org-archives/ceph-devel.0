From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: need help in a recovering ceph
Date: Mon, 28 Nov 2011 09:23:50 -0800
Message-ID: <CAF3hT9CFYe9AeUH5GBCcaUsfdP9itoL9ByVmbPZwe3ETuAT1nQ@mail.gmail.com>
References: <4ED10636.6070705@biodatomics.com>
	<4ED36701.3060107@widodh.nl>
	<4ED37271.8030504@biodatomics.com>
	<CAF3hT9CS9EMnuUjTJF3S9L7U21xaOiin8eaezha2QToNBgATKA@mail.gmail.com>
	<4ED3BCBE.6000906@biodatomics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38621 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab1K1RXv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 12:23:51 -0500
Received: by ggnr5 with SMTP id r5so5443095ggn.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 09:23:50 -0800 (PST)
In-Reply-To: <4ED3BCBE.6000906@biodatomics.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: max@biodatomics.com
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 28, 2011 at 8:54 AM, Maxim Mikheev <mikhmv@biodatomics.com>=
 wrote:
> I understand you Greg. I hope you have a good Thanksgiving.
>
> I did:
> root@s2-8core:~# ceph osd reweight-by-utilization
> 2011-11-28 11:38:40.201428 mon <- [osd,reweight-by-utilization]
> 2011-11-28 11:38:40.209388 mon.0 -> 'SUCCESSFUL reweight-by-utilizati=
on:
> average_util: 0.386560, overload_util: 0.463872. overloaded osds: 2
> [1.000000 -> 0.406347], ' (0)
>
> How can I initiate transfer data for balancing?
>
> root@s2-8core:~# ceph -w
> 2011-11-28 11:40:19.634094=A0=A0=A0 pg v385135: 594 pgs: 594 active+c=
lean; 254 GB
> data, 522 GB used, 673 GB / 1351 GB avail
> 2011-11-28 11:40:19.635551=A0=A0 mds e182: 1/1/1 up {0=3Da=3Dup:activ=
e}
> 2011-11-28 11:40:19.635592=A0=A0 osd e465: 3 osds: 3 up, 3 in full
> 2011-11-28 11:40:19.635665=A0=A0 log 2011-11-28 09:22:55.618408 osd.2
> 192.168.2.12:6800/1097 476 : [INF] 1.1f scrub ok
> 2011-11-28 11:40:19.635759=A0=A0 mon e1: 1 mons at {a=3D192.168.2.11:=
6789/0}
>
> Monitor didn't show any transfer activity after changing weights.

Hmmm. It looks like we need to rework the OSDs so they subscribe to
map updates when full. Try running "rados -p data bench 10 write". It
will fail, but let it go for a few seconds and it should cause all the
OSDs to update their maps and begin shuffling data.

> And another question:
> How can I change mon_osd_full_ratio?
> I tried this:
> root@s2-8core:~# ceph mon injectargs 'mon_osd_full_ratio =3D 96'
> 2011-11-28 11:53:11.070059 mon <- [mon,injectargs,mon_osd_full_ratio =
=3D 96]
> 2011-11-28 11:53:11.070383 mon.0 -> 'unknown command injectargs' (-22=
)
either:
ceph mon injectargs --mon_osd_full_ratio 96
or
ceph mon injectargs "mon osd full ratio =3D 96"
should work.
:)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
