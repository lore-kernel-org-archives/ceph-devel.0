From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Available space shrinks to zero after upgrading cluster
Date: Mon, 9 Jan 2012 15:40:10 -0800
Message-ID: <CACLRD_1L+3gQJ6hW8WXSSC7NFoP9c79eudTfMuVofgWWkh_OkQ@mail.gmail.com>
References: <2223940.SkCGeMiCNa@pc10>
	<2860646.9ynkoJcyEE@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61070 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab2AIXkN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2012 18:40:13 -0500
Received: by werm1 with SMTP id m1so3070086wer.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2012 15:40:11 -0800 (PST)
In-Reply-To: <2860646.9ynkoJcyEE@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

After restarting the OSDs, does the available space make sense?
-Sam

On Mon, Jan 9, 2012 at 3:28 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Am Montag, 9. Januar 2012, 12:23:53 schrieb Guido Winkelmann:
>> Hi,
>>
>> I just upgraded my cluster to the current git version (from 0.39, us=
ing
>> https://github.com/NewDreamNetwork/ceph.git), and now ceph -s report=
s the
>> total available space in the the cluster as 0 and all of the clients=
 using
>> the cluster are blocking:
>>
>> # ceph -s
>> 2012-01-09 12:12:39.433576 =C2=A0 =C2=A0pg v313084: 396 pgs: 396 act=
ive+clean; 79166
>> MB data, 0 KB used, 0 KB / 0 KB avail
>> 2012-01-09 12:12:39.434269 =C2=A0 mds e11: 1/1/1 up {0=3Dalpha=3Dup:=
replay}
>> 2012-01-09 12:12:39.434289 =C2=A0 osd e293: 6 osds: 6 up, 6 in
>> 2012-01-09 12:12:39.434338 =C2=A0 log 2012-01-09 12:12:26.600575 mon=
=2E0
>> 10.3.1.33:6789/0 6 : [INF] osd.1 10.3.1.33:6804/22161 boot
>> 2012-01-09 12:12:39.434389 =C2=A0 mon e5: 3 mons at
>> {ceph1=3D10.3.1.33:6789/0,ceph2=3D10.3.1.34:6789/0,ceph3=3D10.3.1.35=
:6789/0}
>>
>> I have a cluster with three machines, each with two OSDs and one mon=
=2E
>> Additionally, the first one also has a single mds.
>>
>> I did the upgrade by cloning the latest git sources onto each machin=
e, doing
>> the usual ./autgen.sh, ./configure, make && make install and then
>> restarting ceph on one machine after the other using /etc/init.d/cep=
h
>> restart, starting with the last one.
>>
>> So... what's happening here and how do I get my cluster working agai=
n?
>
> Oh, hey, it just changed to this:
>
> # ceph -s
> 2012-01-09 12:28:07.745570 =C2=A0 =C2=A0pg v313092: 396 pgs: 232 acti=
ve+clean, 106
> active+clean+degraded, 13 active+clean+replay+degraded, 45
> down+degraded+peering; 79166 MB data, 33829 MB used, 825 GB / 876 GB =
avail;
> 8792/42838 degraded (20.524%)
> 2012-01-09 12:28:07.746310 =C2=A0 mds e11: 1/1/1 up {0=3Dalpha=3Dup:r=
eplay}
> 2012-01-09 12:28:07.746330 =C2=A0 osd e296: 6 osds: 1 up, 6 in
> 2012-01-09 12:28:07.746379 =C2=A0 log 2012-01-09 12:27:24.965150 mon.=
0
> 10.3.1.33:6789/0 7 : [INF] osd.4 10.3.1.35:6806/3705 boot
> 2012-01-09 12:28:07.746422 =C2=A0 mon e1: 1 mons at {ceph1=3D10.3.1.3=
3:6789/0}
> 2012-01-09 12:28:07.746431 =C2=A0 mon e2: 2 mons at
> {ceph1=3D10.3.1.33:6789/0,ceph2=3D10.3.1.34:6789/0}
> 2012-01-09 12:28:07.746440 =C2=A0 mon e3: 1 mons at {ceph1=3D10.3.1.3=
3:6789/0}
> 2012-01-09 12:28:07.746446 =C2=A0 mon e4: 2 mons at
> {ceph1=3D10.3.1.33:6789/0,ceph2=3D10.3.1.34:6789/0}
> 2012-01-09 12:28:07.746453 =C2=A0 mon e5: 3 mons at
> {ceph1=3D10.3.1.33:6789/0,ceph2=3D10.3.1.34:6789/0,ceph3=3D10.3.1.35:=
6789/0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
