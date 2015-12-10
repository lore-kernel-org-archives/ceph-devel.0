From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] Blocked requests after "osd in"
Date: Wed, 9 Dec 2015 22:38:58 -0700
Message-ID: <CAANLjFqUoGTFSYrdwCwRw0apfXJN61SeS7FiXb0A_Bxtu4PJJg@mail.gmail.com>
References: <5667FC6E.5080600@flyingcircus.io>
	<B0751415-538E-471E-B310-76812C3C374C@schermer.cz>
	<56683B9E.8070201@flyingcircus.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35372 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbLJFjA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Dec 2015 00:39:00 -0500
Received: by vkha189 with SMTP id a189so75107409vkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 09 Dec 2015 21:38:59 -0800 (PST)
In-Reply-To: <56683B9E.8070201@flyingcircus.io>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Kauhaus <kc@flyingcircus.io>
Cc: Jan Schermer <jan@schermer.cz>, Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I noticed this a while back and did some tracing. As soon as the PGs
are read in by the OSD (very limited amount of housekeeping done), the
OSD is set to the "in" state so that peering with other OSDs can
happen and the recovery process can begin. The problem is that when
the OSD is "in", the clients also see that and start sending requests
to the OSDs before it has had a chance to actually get its bearings
and is able to even service the requests. After discussion with some
of the developers, there is no easy way around this other than let the
PGs recover to other OSDs and then bring in the OSDs after recovery (a
ton of data movement).

I've suggested some options on how to work around this issue, but they
all require a large amount of rework. Since I'm very interested in
reducing this problem, I'm willing to try and submit a fix after I'm
done with the new OP queue I'm working on. I don't know the best
course of action at the moment, but I hope I can get some input for
when I do try and tackle the problem next year.

1. Add a new state that allows OSDs to peer without client requests
coming in. (up -> in -> active) I'm not sure if other OSDs are seen as
clients, I don't think so. I'm not sure if there would have to be some
trickery to make the booting OSDs not be primary until all the PGs are
read and ready for I/O (not necessary recovered yet).
2. When a request comes in for a PG that is not ready, send the client
a redirect message to use the primary in a previous map. I have a
feeling this could be very messy and not very safe.
3. Proxy the OP on behalf of the client until the PGs are ready. The
"other" OSD would have to understand that it is OK to do that
write/read OP even though it is not the primary, this can be difficult
to do safely.

Right now I'm leaning to option #1. When the new OSD boots, keep the
previous primary running and the PG is in degraded mode until the new
OSD has done all of it's housekeeping and can service the IO
effectively, then make a change to the CRUSH map to swap the primaries
where needed. Any input and ideas from the devs would be helpful.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWaQ/tCRDmVDuy+mK58QAAt78QAIipf97avpZv+FLF0SUT
=469vaUwTDI8fTpOmca1v4/nJ90pxM0RksYpg7Q+tg7+JlyQ6gns2QoKwUAf5F
EgVPg6pUQXmzkKcVvUgt51NDR4d80E+xIXHSmJKT4iU3BPI5ezNHYoVlAOhm
LXdDrYTaEPy/EfQxj5Prole0mLsCB129ydgPG7ud1qaNjzxLikyihLvA72Bd
AZhOhvjXTXGzWR1Uw2oPStYuw2i0JrFHp9//bipa6hqHd1XJSb3afe6VW9vJ
9E3AqGXMrdZG5Nk7kjaH7MfZbsxl39KimgAcHPDBz1XK2ZrSrtNZ1nTo09+u
Bb8DIB66kAT/4OIXQ1NvwTNn8INi9u14IFPzS2Z1Ewidg7jMAPkS0XxIPjhF
6G01GornpfN+emhOsQRz5sw6WPC8dlLGP9JfEP8+rPkLcNqBP82aCJ68AllZ
TWelhgAJoW/LdyyCaFD87wmQ1lqQxbujcDsLaDzBLQ/vDqmw9mNTubCIKfR2
WKRft9CyDR5r/Ous16RVsy+PFhmw/e/ovrWBFLx4t/KrbQVYUCfgDZrNSLtb
4aNRUtel7PN3AXUtFM8O7gS+CaYv5fP+CotQer8HuSnL4eFGIe9yg2jHSGVy
fmDFEirT3DlxFEDWja8uNFGdJ8rMYjTqOMdyOCS3SLtizTmC/+SF00kk0m9A
sB8x
=3Di9F/
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Dec 9, 2015 at 7:33 AM, Christian Kauhaus <kc@flyingcircus.io> =
wrote:
> Am 09.12.2015 um 11:21 schrieb Jan Schermer:
>> Are you seeing "peering" PGs when the blocked requests are happening=
? That's what we see regularly when starting OSDs.
>
> Mostly "peering" and "activating".
>
>> I'm not sure this can be solved completely (and whether there are ma=
jor improvements in newer Ceph versions), but it can be sped up by
>> 1) making sure you have free (and not dirtied or fragmented) memory =
on the node where you are starting the OSD
>>       - that means dropping caches before starting the OSD if you ha=
ve lots of "free" RAM that is used for VFS cache
>> 2) starting the OSDs one by one instead of booting several of them
>> 3) if you pin the OSDs to CPUs/cores, do that after the OSD is in - =
I found it to be best to pin the OSD to a cgroup limited to one NUMA no=
de and then limit it to a subset of cores after it has run a bit. OSD t=
ends to use hundreds of % of CPU when booting
>> 4) you could possibly prewarm cache for the OSD in /var/lib/ceph/osd=
=2E..
>
> Thank you for your advice. The use case is not so much after rebootin=
g a
> server, but more when we take OSDs in/out for maintenance. During boo=
t, we
> already start them one after another with 10s pause between each pair=
=2E
>
> I've done a bit of tracing. I've kept a small cluster running with 2 =
"in" OSDs
> out of 3 and put the third one "in" at 15:06:22. From ceph.log:
>
> | 2015-12-09 15:06:22.827030 mon.0 172.20.4.6:6789/0 54964 : cluster =
[INF]
> osdmap e264345: 3 osds: 3 up, 3 in
> | 2015-12-09 15:06:22.828693 mon.0 172.20.4.6:6789/0 54965 : cluster =
[INF]
> pgmap v39871295: 1800 pgs: 1800 active+clean; 439 GB data, 906 GB use=
d, 4515
> GB / 5421 GB avail; 6406 B/s rd, 889 kB/s wr, 67 op/s
> | [...]
> | 2015-12-09 15:06:29.163793 mon.0 172.20.4.6:6789/0 54972 : cluster =
[INF]
> pgmap v39871299: 1800 pgs: 1800 active+clean; 439 GB data, 906 GB use=
d, 7700
> GB / 8607 GB avail
>
> After a few seconds, backfills start as expected:
>
> | 2015-12-09 15:06:24.853507 osd.3 172.20.4.40:6800/5072 778 : cluste=
r [INF]
> 410.c9 restarting backfill on osd.2 from (0'0,0'0] MAX to 264336'5024=
26
> | [...]
> | 2015-12-09 15:06:29.874092 osd.3 172.20.4.40:6800/5072 1308 : clust=
er [INF]
> 410.d1 restarting backfill on osd.2 from (0'0,0'0] MAX to 264344'1202=
983
> | 2015-12-09 15:06:32.584907 mon.0 172.20.4.6:6789/0 54973 : cluster =
[INF]
> pgmap v39871300: 1800 pgs: 3 active+remapped+wait_backfill, 191
> active+remapped, 1169 active+clean, 437 activating+remapped; 439 GB d=
ata, 906
> GB used, 7700 GB / 8607 GB avail; 1725 kB/s rd, 2486 kB/s wr, 605 op/=
s;
> 23058/278796 objects misplaced (8.271%); 56612 kB/s, 14 objects/s rec=
overing
> | 2015-12-09 15:06:24.851307 osd.0 172.20.4.51:6800/4919 2662 : clust=
er [INF]
> 410.c8 restarting backfill on osd.2 from (0'0,0'0] MAX to 264344'1017=
219
> | 2015-12-09 15:06:38.555243 mon.0 172.20.4.6:6789/0 54976 : cluster =
[INF]
> pgmap v39871303: 1800 pgs: 22 active+remapped+wait_backfill, 520
> active+remapped, 638 active+clean, 620 activating+remapped; 439 GB da=
ta, 906
> GB used, 7700 GB / 8607
> | GB avail; 45289 B/s wr, 4 op/s; 64014/313904 objects misplaced (20.=
393%)
> | 2015-12-09 15:06:38.133376 osd.3 172.20.4.40:6800/5072 1309 : clust=
er [WRN]
> 9 slow requests, 9 included below; oldest blocked for > 15.306541 sec=
s
> | 2015-12-09 15:06:38.133385 osd.3 172.20.4.40:6800/5072 1310 : clust=
er [WRN]
> slow request 15.305213 seconds old, received at 2015-12-09 15:06:22.8=
28061:
> osd_op(client.15205073.0:35726 rbd_header.13998a74b0dc51 [watch recon=
nect
> cookie 139897352489152 gen 37] 410.937870ca ondisk+write+known_if_red=
irected
> e264345) currently reached_pg
>
> It seems that PGs in "activating" state are causing blocked requests.
>
> After a half minute or so, slow requests disappear and backfill proce=
eds normally:
>
> | 2015-12-09 15:06:54.139948 osd.3 172.20.4.40:6800/5072 1396 : clust=
er [WRN]
> 42 slow requests, 9 included below; oldest blocked for > 31.188267 se=
cs
> | 2015-12-09 15:06:54.139957 osd.3 172.20.4.40:6800/5072 1397 : clust=
er [WRN]
> slow request 15.566440 seconds old, received at 2015-12-09 15:06:38.5=
73403:
> osd_op(client.15165527.0:5878994 rbd_data.129a42ae8944a.0000000000000=
f2b
> [set-alloc-hint object_size 4194304 write_size 4194304,write 1728512~=
4096]
> 410.de3ce70d snapc 3fd2=3D[3fd2] ack+ondisk+write+known_if_redirected=
 e264348)
> currently waiting for subops from 0,2
> | 2015-12-09 15:06:54.139977 osd.3 172.20.4.40:6800/5072 1401 : clust=
er [WRN]
> slow request 15.356852 seconds old, received at 2015-12-09 15:06:38.7=
82990:
> osd_op(client.15165527.0:5878997 rbd_data.129a42ae8944a.0000000000000=
f2b
> [set-alloc-hint object_size 4194304 write_size 4194304,write 1880064~=
4096]
> 410.de3ce70d snapc 3fd2=3D[3fd2] ack+ondisk+write+known_if_redirected=
 e264348)
> currently waiting for subops from 0,2
> | [...]
> | 2015-12-09 15:07:00.072403 mon.0 172.20.4.6:6789/0 54989 : cluster =
[INF]
> osdmap e264351: 3 osds: 3 up, 3 in
> | 2015-12-09 15:07:00.074536 mon.0 172.20.4.6:6789/0 54990 : cluster =
[INF]
> pgmap v39871313: 1800 pgs: 277 active+remapped+wait_backfill, 881
> active+remapped, 4 active+remapped+backfilling, 638 active+clean; 439=
 GB data,
> 906 GB used, 7700 GB / 8607 GB avail; 347 kB/s rd, 2551 kB/s wr, 261 =
op/s;
> 162079/313904 objects misplaced (51.633%); 218 MB/s, 54 objects/s rec=
overing
>
> I've used Brendan Greggs opensnoop utility to see what is going on on=
 the
> filesystem level (see attached log). AFAICS the OSB reads lots of dir=
ectories.
> The underlying filesystem is XFS, so this should be sufficiently fast=
=2E During
> the time I see slow requests, the OSD continuously opens omap/*.ldb a=
nd
> omap/*.log files (starting at timestamp 95927.111837 in opensnoop log=
 which
> equivalents 15:06:37 in wall clock time).
>
> Any idea how to reduce the blockage at least?
>
>> It's unclear to me whether MONs influence this somehow (the peering =
stage) but I have observed their CPU usage and IO also spikes when OSDs=
 are started, so make sure they are not under load.
>
> I don't think this is an issue here. Our MONs don't use more than 5% =
CPU
> during the operation and don't cause significant amounts of disk I/O.
>
> Regards
>
> Christian
>
> --
> Dipl-Inf. Christian Kauhaus <>< =C2=B7 kc@flyingcircus.io =C2=B7 +49 =
345 219401-0
> Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
> Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
> HR Stendal 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
