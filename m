From: Sage Weil <sage@inktank.com>
Subject: Re: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 16:30:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209191628480.29722@cobra.newdream.net>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com> <alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net> <CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com> <CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
 <CAPYLRziJNqjZnD4J8ufhMZ+GYs3Wn67Qk_=GJKsb45e_D8Qjgw@mail.gmail.com> <CANLRBoyfwajKToDqWgnfMWK9b8AAGX3WsRW9Ymr-96GsqTJ1ag@mail.gmail.com> <alpine.DEB.2.00.1209191432240.7537@cobra.newdream.net> <CANLRBowbQbqc-MnyJiqNS1f0SkT10zmMgkRu4ANTEUrebcP+Ng@mail.gmail.com>
 <CANLRBowA_=fM-n-8T=N_fZ_cA9Xd_iGX7Wu8Z80dK=zjx1UWRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41728 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab2ISXad (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 19:30:33 -0400
In-Reply-To: <CANLRBowA_=fM-n-8T=N_fZ_cA9Xd_iGX7Wu8Z80dK=zjx1UWRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Wed, 19 Sep 2012, Tren Blackburn wrote:
> On Wed, Sep 19, 2012 at 2:45 PM, Tren Blackburn <tren@eotnetworks.com> wrote:
> > On Wed, Sep 19, 2012 at 2:33 PM, Sage Weil <sage@inktank.com> wrote:
> >> On Wed, 19 Sep 2012, Tren Blackburn wrote:
> >>> On Wed, Sep 19, 2012 at 2:12 PM, Gregory Farnum <greg@inktank.com> wrote:
> >>> > On Wed, Sep 19, 2012 at 2:05 PM, Tren Blackburn <tren@eotnetworks.com> wrote:
> >>> >
> >>> >> Greg: It's difficult to tell you that. I'm rsyncing 2 volumes from our
> >>> >> filers. Each base directory on each filer mount has approximate 213
> >>> >> directories, and then each directory under that has approximately
> >>> >> anywhere from 3000 - 5000 directories (very loose approximation here,
> >>> >> 850,000 directories per filer mount), and then each of those
> >>> >> directories contains files.
> >>> >
> >>> > Ah, directories are larger ? Sage, do you think they're enough bigger
> >>> > to make up that much extra memory usage?
> >>> >
> >>> >
> >>> >> We have many many files here. We're doing this to see how CephFS
> >>> >> handles lots of files. We are coming from MooseFS which its master
> >>> >> metalogger process eats lots of ram, so we're hoping that Ceph is a
> >>> >> bit lighter on us.
> >>> >>
> >>> >> Sage: The memory the MDS is using is only a cache? There should be no
> >>> >> problem restarting the MDS server while activity is going on? I should
> >>> >> probably change the limit for the non-active MDS servers first, and
> >>> >> then the active one and hope it fails over cleanly?
> >>> > Yep, that should work fine, with the obvious caveat that your
> >>> > filesystem will become inaccessible if the MDS is down long enough for
> >>> > clients to exceed their timeouts (no metadata loss though, if all
> >>> > clients remain active until the MDS comes back up).
> >>>
> >>> I have 3 MDS's (active/standby setup). Shouldn't the MDS fail over to
> >>> the other node when I restart the process? I'm not sure what the best
> >>> method for just restarting the MDS is, and can it be done without
> >>> forcing a fail over?
> >>
> >> Any running standby ceph-mds daemon will take over when the first one is
> >> shut down.  Just stop the daemons on the other nodes too if for some
> >> reason you care which machine the daemon runs on (Ceph certainly
> >> doesn't!).
> >>
> >> You can restart with
> >>
> >>         /etc/init.d/ceph restart mds
> >
> > This does not work on gentoo. However "/usr/lib64/ceph/ceph_init.sh -c
> > /etc/ceph/ceph.conf restart mds" works fine. I have restarted the
> > MDS's, saving the active one for last. I restarted it, and now my
> > cluster seems locked.
> >
> > sap ceph # ceph -s
> >    health HEALTH_OK
> >    monmap e1: 3 mons at
> > {0=10.87.1.87:6789/0,1=10.87.1.88:6789/0,2=10.87.1.104:6789/0},
> > election epoch 38, quorum 0,1,2 0,1,2
> >    osdmap e25: 192 osds: 192 up, 192 in
> >     pgmap v10025: 73728 pgs: 73728 active+clean; 48355 MB data, 148 GB
> > used, 280 TB / 286 TB avail
> >    mdsmap e17: 1/1/1 up {0=0=up:clientreplay}, 2 up:standby
> >
> > What is clientreplay? All IO to ceph has frozen. The mds.0.log shows:
> >
> > 2012-09-19 14:39:16.315311 7f9d9ad33700  1 mds.0.3 reconnect_done
> > 2012-09-19 14:39:17.077926 7f9d9ad33700  1 mds.0.3 handle_mds_map i am
> > now mds.0.3
> > 2012-09-19 14:39:17.077931 7f9d9ad33700  1 mds.0.3 handle_mds_map
> > state change up:reconnect --> up:rejoin
> > 2012-09-19 14:39:17.077935 7f9d9ad33700  1 mds.0.3 rejoin_joint_start
> > 2012-09-19 14:39:17.354120 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.91:6833/29579
> > 2012-09-19 14:39:17.371475 7f9d9ad33700  1 mds.0.3 rejoin_done
> > 2012-09-19 14:39:17.736378 7f9d9ad33700  1 mds.0.3 handle_mds_map i am
> > now mds.0.3
> > 2012-09-19 14:39:17.736383 7f9d9ad33700  1 mds.0.3 handle_mds_map
> > state change up:rejoin --> up:clientreplay
> > 2012-09-19 14:39:17.736385 7f9d9ad33700  1 mds.0.3 recovery_done --
> > successful recovery!
> > 2012-09-19 14:39:17.748784 7f9d9ad33700  1 mds.0.3 clientreplay_start
> > 2012-09-19 14:39:17.761751 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.104:6831/11000
> > 2012-09-19 14:39:17.763888 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.95:6818/18116
> > 2012-09-19 14:39:17.775943 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.98:6812/7539
> > 2012-09-19 14:39:17.786640 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.104:6819/10452
> > 2012-09-19 14:39:17.801893 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.98:6821/7893
> > 2012-09-19 14:39:17.827436 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.93:6827/3894
> > 2012-09-19 14:39:17.837971 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.89:6809/28294
> > 2012-09-19 14:39:17.839187 7f9d9ad33700  0 mds.0.3 ms_handle_connect
> > on 10.87.1.99:6833/23283
> >
> > How long does this "clientreplay"stage take? It doesn't seem like the
> > process is actually doing anything.
> >
> Woo! Love responding to my own posts. This was pretty exciting. I
> ended up restarting the mon/mds services on the node that was the
> active mds. The mds restarted, and came out of the "clientreplay"
> state, but the mon crashed on restart. I was able to start just the
> mon process and now my cluster is happy.
> 
> Here is the log of the mon crash I received while restarting it.
> 
> http://pastebin.com/fGriuEDQ

Right after v0.51 (for v0.52) we merged a huge pile of messenger fixes 
that address that crash.  Phew!

I'm not quite sure why you were stuck in clientreplay.  There is a known 
issue where this phase can take a long time because there is a journal 
event generated for every replayed request, so in certain cases it's just 
slow.  It sounds like it may have actually been stuck, though; we'll need 
to see if it can be reproduced.

sage
