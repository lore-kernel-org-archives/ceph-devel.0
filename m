From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Memory usage of ceph-mds
Date: Thu, 20 Sep 2012 10:32:42 -0700
Message-ID: <CANLRBozptcDe9rQAT8fDvE_x-a61Gu4ZnEyxFstGdL-BR894hw@mail.gmail.com>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com>
	<alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net>
	<CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com>
	<CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
	<CAPYLRziJNqjZnD4J8ufhMZ+GYs3Wn67Qk_=GJKsb45e_D8Qjgw@mail.gmail.com>
	<CANLRBoyfwajKToDqWgnfMWK9b8AAGX3WsRW9Ymr-96GsqTJ1ag@mail.gmail.com>
	<alpine.DEB.2.00.1209191432240.7537@cobra.newdream.net>
	<CANLRBowbQbqc-MnyJiqNS1f0SkT10zmMgkRu4ANTEUrebcP+Ng@mail.gmail.com>
	<CANLRBowA_=fM-n-8T=N_fZ_cA9Xd_iGX7Wu8Z80dK=zjx1UWRQ@mail.gmail.com>
	<alpine.DEB.2.00.1209191628480.29722@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52379 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab2ITRcn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Sep 2012 13:32:43 -0400
Received: by vcbfo13 with SMTP id fo13so2891963vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 20 Sep 2012 10:32:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209191628480.29722@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Sep 19, 2012 at 4:30 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 19 Sep 2012, Tren Blackburn wrote:
>> On Wed, Sep 19, 2012 at 2:45 PM, Tren Blackburn <tren@eotnetworks.com> wrote:
>> > On Wed, Sep 19, 2012 at 2:33 PM, Sage Weil <sage@inktank.com> wrote:
>> >> On Wed, 19 Sep 2012, Tren Blackburn wrote:
>> >>> On Wed, Sep 19, 2012 at 2:12 PM, Gregory Farnum <greg@inktank.com> wrote:
>> >>> > On Wed, Sep 19, 2012 at 2:05 PM, Tren Blackburn <tren@eotnetworks.com> wrote:
>> >>> >
>> >>> >> Greg: It's difficult to tell you that. I'm rsyncing 2 volumes from our
>> >>> >> filers. Each base directory on each filer mount has approximate 213
>> >>> >> directories, and then each directory under that has approximately
>> >>> >> anywhere from 3000 - 5000 directories (very loose approximation here,
>> >>> >> 850,000 directories per filer mount), and then each of those
>> >>> >> directories contains files.
>> >>> >
>> >>> > Ah, directories are larger ? Sage, do you think they're enough bigger
>> >>> > to make up that much extra memory usage?
>> >>> >
>> >>> >
>> >>> >> We have many many files here. We're doing this to see how CephFS
>> >>> >> handles lots of files. We are coming from MooseFS which its master
>> >>> >> metalogger process eats lots of ram, so we're hoping that Ceph is a
>> >>> >> bit lighter on us.
>> >>> >>
>> >>> >> Sage: The memory the MDS is using is only a cache? There should be no
>> >>> >> problem restarting the MDS server while activity is going on? I should
>> >>> >> probably change the limit for the non-active MDS servers first, and
>> >>> >> then the active one and hope it fails over cleanly?
>> >>> > Yep, that should work fine, with the obvious caveat that your
>> >>> > filesystem will become inaccessible if the MDS is down long enough for
>> >>> > clients to exceed their timeouts (no metadata loss though, if all
>> >>> > clients remain active until the MDS comes back up).
>> >>>
>> >>> I have 3 MDS's (active/standby setup). Shouldn't the MDS fail over to
>> >>> the other node when I restart the process? I'm not sure what the best
>> >>> method for just restarting the MDS is, and can it be done without
>> >>> forcing a fail over?
>> >>
>> >> Any running standby ceph-mds daemon will take over when the first one is
>> >> shut down.  Just stop the daemons on the other nodes too if for some
>> >> reason you care which machine the daemon runs on (Ceph certainly
>> >> doesn't!).
>> >>
>> >> You can restart with
>> >>
>> >>         /etc/init.d/ceph restart mds
>> >
>> > This does not work on gentoo. However "/usr/lib64/ceph/ceph_init.sh -c
>> > /etc/ceph/ceph.conf restart mds" works fine. I have restarted the
>> > MDS's, saving the active one for last. I restarted it, and now my
>> > cluster seems locked.
>> >
>> > sap ceph # ceph -s
>> >    health HEALTH_OK
>> >    monmap e1: 3 mons at
>> > {0=10.87.1.87:6789/0,1=10.87.1.88:6789/0,2=10.87.1.104:6789/0},
>> > election epoch 38, quorum 0,1,2 0,1,2
>> >    osdmap e25: 192 osds: 192 up, 192 in
>> >     pgmap v10025: 73728 pgs: 73728 active+clean; 48355 MB data, 148 GB
>> > used, 280 TB / 286 TB avail
>> >    mdsmap e17: 1/1/1 up {0=0=up:clientreplay}, 2 up:standby
>> >
>> > What is clientreplay? All IO to ceph has frozen. The mds.0.log shows:
>> >
>> > 2012-09-19 14:39:16.315311 7f9d9ad33700  1 mds.0.3 reconnect_done
>> > 2012-09-19 14:39:17.077926 7f9d9ad33700  1 mds.0.3 handle_mds_map i am
>> > now mds.0.3
>> > 2012-09-19 14:39:17.077931 7f9d9ad33700  1 mds.0.3 handle_mds_map
>> > state change up:reconnect --> up:rejoin
>> > 2012-09-19 14:39:17.077935 7f9d9ad33700  1 mds.0.3 rejoin_joint_start
>> > 2012-09-19 14:39:17.354120 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.91:6833/29579
>> > 2012-09-19 14:39:17.371475 7f9d9ad33700  1 mds.0.3 rejoin_done
>> > 2012-09-19 14:39:17.736378 7f9d9ad33700  1 mds.0.3 handle_mds_map i am
>> > now mds.0.3
>> > 2012-09-19 14:39:17.736383 7f9d9ad33700  1 mds.0.3 handle_mds_map
>> > state change up:rejoin --> up:clientreplay
>> > 2012-09-19 14:39:17.736385 7f9d9ad33700  1 mds.0.3 recovery_done --
>> > successful recovery!
>> > 2012-09-19 14:39:17.748784 7f9d9ad33700  1 mds.0.3 clientreplay_start
>> > 2012-09-19 14:39:17.761751 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.104:6831/11000
>> > 2012-09-19 14:39:17.763888 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.95:6818/18116
>> > 2012-09-19 14:39:17.775943 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.98:6812/7539
>> > 2012-09-19 14:39:17.786640 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.104:6819/10452
>> > 2012-09-19 14:39:17.801893 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.98:6821/7893
>> > 2012-09-19 14:39:17.827436 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.93:6827/3894
>> > 2012-09-19 14:39:17.837971 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.89:6809/28294
>> > 2012-09-19 14:39:17.839187 7f9d9ad33700  0 mds.0.3 ms_handle_connect
>> > on 10.87.1.99:6833/23283
>> >
>> > How long does this "clientreplay"stage take? It doesn't seem like the
>> > process is actually doing anything.
>> >
>> Woo! Love responding to my own posts. This was pretty exciting. I
>> ended up restarting the mon/mds services on the node that was the
>> active mds. The mds restarted, and came out of the "clientreplay"
>> state, but the mon crashed on restart. I was able to start just the
>> mon process and now my cluster is happy.
>>
>> Here is the log of the mon crash I received while restarting it.
>>
>> http://pastebin.com/fGriuEDQ
>
> Right after v0.51 (for v0.52) we merged a huge pile of messenger fixes
> that address that crash.  Phew!
>
> I'm not quite sure why you were stuck in clientreplay.  There is a known
> issue where this phase can take a long time because there is a journal
> event generated for every replayed request, so in certain cases it's just
> slow.  It sounds like it may have actually been stuck, though; we'll need
> to see if it can be reproduced.

Hi Sage;

I've been running into circumstances where the mds does not fail over
smoothly and gets stuck in "replay". I ended up resolving this by
stopping all IO to the cluster (which was fairly easy as the cluster
was IO locked due to the mds not being active), and unmounting the
ceph-fuse file system.

The cluster has gone back to a HEALTH_OK state, but the mds keeps
bouncing around, and all the OSD's seem stuck in a strange state. A
ceph -w shows:

ocr35-ire ceph # ceph -w
   health HEALTH_OK
   monmap e1: 3 mons at
{0=10.87.1.87:6789/0,1=10.87.1.88:6789/0,2=10.87.1.104:6789/0},
election epoch 240, quorum 0,1,2 0,1,2
   osdmap e485: 192 osds: 192 up, 192 in
    pgmap v62894: 73728 pgs: 73728 active+clean; 403 GB data, 1266 GB
used, 279 TB / 286 TB avail
   mdsmap e120: 1/1/1 up {0=2=up:replay}, 2 up:standby

2012-09-20 10:29:04.460089 mon.0 [INF] osd.127 10.87.1.99:6821/22799
failed (by osd.99 10.87.1.97:6809/28052)
2012-09-20 10:29:04.462365 mon.0 [INF] osd.126 10.87.1.99:6818/22672
failed (by osd.99 10.87.1.97:6809/28052)
2012-09-20 10:29:04.562200 mon.0 [INF] osd.77 10.87.1.95:6815/17994
failed (by osd.126 10.87.1.99:6818/22672)
2012-09-20 10:29:04.636452 mon.0 [INF] osd.77 10.87.1.95:6815/17994
failed (by osd.66 10.87.1.94:6818/2950)
2012-09-20 10:29:04.692759 mon.0 [INF] osd.122 10.87.1.99:6806/22175
failed (by osd.31 10.87.1.91:6821/29085)
2012-09-20 10:29:04.695048 mon.0 [INF] osd.123 10.87.1.99:6809/22296
failed (by osd.31 10.87.1.91:6821/29085)
2012-09-20 10:29:04.697321 mon.0 [INF] osd.94 10.87.1.96:6830/12903
failed (by osd.35 10.87.1.91:6833/29579)
2012-09-20 10:29:04.706610 mon.0 [INF] osd.53 10.87.1.93:6815/3248
failed (by osd.29 10.87.1.91:6815/28822)
2012-09-20 10:29:04.708906 mon.0 [INF] osd.110 10.87.1.98:6806/7307
failed (by osd.29 10.87.1.91:6815/28822)
2012-09-20 10:29:04.804913 mon.0 [INF] osd.57 10.87.1.93:6827/3894
failed (by osd.72 10.87.1.95:6800/17386)
2012-09-20 10:29:04.807192 mon.0 [INF] osd.58 10.87.1.93:6830/4102
failed (by osd.72 10.87.1.95:6800/17386)
2012-09-20 10:29:05.037468 mon.0 [INF] osd.10 10.87.1.89:6830/29109
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.039754 mon.0 [INF] osd.28 10.87.1.91:6812/28720
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.042032 mon.0 [INF] osd.41 10.87.1.92:6815/9069
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.044304 mon.0 [INF] osd.42 10.87.1.92:6818/9190
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.046579 mon.0 [INF] osd.61 10.87.1.94:6803/2359
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.048864 mon.0 [INF] osd.37 10.87.1.92:6803/8520
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.051139 mon.0 [INF] osd.31 10.87.1.91:6821/29085
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.053414 mon.0 [INF] osd.65 10.87.1.94:6815/2832
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.055688 mon.0 [INF] osd.68 10.87.1.94:6824/3182
failed (by osd.49 10.87.1.93:6803/2763)
2012-09-20 10:29:05.057963 mon.0 [INF] osd.71 10.87.1.94:6833/3676
failed (by osd.49 10.87.1.93:6803/2763)
...

The osd failed lines go on forever. If I look into the OSD logs I get:

2012-09-20 10:25:44.586339 7f8c42062700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.98:6819/7774 pipe(0x911d680 sd=68 pgs=2565 cs=65 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:44.629757 7f8c2f235700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.97:6813/28173 pipe(0x49bc900 sd=77 pgs=2640 cs=11 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:44.696361 7f8c4a0e2700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.96:6813/12199 pipe(0x40b0fc0 sd=127 pgs=2132 cs=11 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:44.731195 7f8c1fc40700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.90:6821/29986 pipe(0x3c2f200 sd=400 pgs=14 cs=1 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:44.737039 7f8c52465700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.100:6849/16139 pipe(0x76126c0 sd=52 pgs=373 cs=3 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:44.866336 7f8c281c5700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.90:6837/30369 pipe(0x4839440 sd=471 pgs=138 cs=1 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:44.936354 7f8c42c6e700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.94:6810/2594 pipe(0x3014fc0 sd=95 pgs=2116 cs=7 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:44.956375 7f8c32b6e700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.95:6822/18248 pipe(0x26e5200 sd=58 pgs=2748 cs=3 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:44.976385 7f8c52c6d700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.89:6819/28643 pipe(0x8970000 sd=53 pgs=2564 cs=55 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:45.166333 7f8c5599a700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.89:6834/29225 pipe(0x8970b40 sd=245 pgs=2189 cs=15 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:45.206362 7f8c44a8c700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.104:6850/32022 pipe(0x31f6480 sd=153 pgs=498 cs=3 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:45.226353 7f8c4df20700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.98:6825/8009 pipe(0x94a0000 sd=83 pgs=2427 cs=25 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:45.276371 7f8c2e629700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.103:6867/24849 pipe(0x269d440 sd=376 pgs=158 cs=1 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:45.281180 7f8c53677700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.90:6804/29534 pipe(0x7612240 sd=436 pgs=8 cs=1 l=0).fault with
nothing to send, going to standby
2012-09-20 10:25:45.296351 7f8c2a8ec700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.95:6828/18496 pipe(0x65f4480 sd=448 pgs=2206 cs=9 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:45.426345 7f8c2d71a700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.104:6868/321 pipe(0x40b0d80 sd=155 pgs=541 cs=3 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:45.446350 7f8c1e92d700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.97:6804/27813 pipe(0x2618fc0 sd=34 pgs=2265 cs=9 l=0).fault
with nothing to send, going to standby
2012-09-20 10:25:58.934930 7f8c4b7f9700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.94:6831/3545 pipe(0x31ecfc0 sd=98 pgs=1611 cs=5 l=0).fault
with nothing to send, going to standby
2012-09-20 10:26:00.276354 7f8c3f133700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.90:6831/30219 pipe(0x477e6c0 sd=111 pgs=13 cs=1 l=0).fault
with nothing to send, going to standby
2012-09-20 10:27:35.336359 7f8c50849700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.101:6813/21432 pipe(0x68ca240 sd=401 pgs=3629 cs=19 l=0).fault
with nothing to send, going to standby
2012-09-20 10:27:35.346333 7f8c24d91700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.90:6809/29632 pipe(0x3c2e480 sd=396 pgs=2 cs=1 l=0).fault with
nothing to send, going to standby
2012-09-20 10:27:35.486393 7f8c4ca0b700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.91:6819/28960 pipe(0x4838b40 sd=169 pgs=3047 cs=3 l=0).fault
with nothing to send, going to standby
2012-09-20 10:27:35.580193 7f8c4a2e4700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.91:6828/29331 pipe(0x8503680 sd=112 pgs=2573 cs=7 l=0).fault
with nothing to send, going to standby
2012-09-20 10:27:35.980046 7f8c40a4c700  0 -- 10.87.1.93:6816/3248 >>
10.87.1.91:6834/29579 pipe(0x2f56fc0 sd=124 pgs=2508 cs=59 l=0).fault
with nothing to send, going to standby

I'm going to try shutting down the ceph cluster and starting it back
up to see if that fixes the issues. If someone can point me in the
right direction that would be appreciated.

Thanks in advance!

t.
