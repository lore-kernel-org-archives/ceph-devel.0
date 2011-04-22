From: Sage Weil <sage@newdream.net>
Subject: Re: How to reduce active mds number
Date: Fri, 22 Apr 2011 08:46:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104220845110.15351@cobra.newdream.net>
References: <BANLkTikGYbYnWQfPPMFo3spsuzOq315m=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59641 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651Ab1DVPqR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2011 11:46:17 -0400
In-Reply-To: <BANLkTikGYbYnWQfPPMFo3spsuzOq315m=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: AnnyRen <annyren6@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 22 Apr 2011, AnnyRen wrote:
> Hi,
> 
> I'm testing MDS expasion,
> my original environment has 3 MON, 2 MDS (one active, one standby), 10
> OSD which are built on 15 physical machines.
> 
> the following is my step to test add/remove active MDS:
> 
> 
> Step1: check mds status
> 
> root@MON1:~# ceph mds dump -o -
> 4097:   192.168.200.184:6800/2095 '0' mds0.1 up:active seq 66
> 4107:   192.168.200.185:6800/1911 '1' mds-1.0 up:standby seq 2
> There are two mds, one is active, another is standby
> 
> Step2: ceph mds set_max_mds 2
> 
> Step3: ceph -s
> 2011-04-22 08:33:03.836554   mds e18: 2/2/2 up {0=up:active,1=up:active}
> 
> or
> root@MON1:~# ceph mds dump -o -
> max_mds 2
> in      0,1
> up      {0=4097,1=4107}
> failed
> stopped
> 4097:   192.168.200.184:6800/2095 '0' mds0.1 up:active seq 66
> 4107:   192.168.200.185:6800/1911 '1' mds1.1 up:active seq 25635
> 
> 
> Step4: I want to set one mds to standby, so I execute "ceph mds set_max_mds 1"
> 
> root@MON1:~# ceph mds set_max_mds 1
> 2011-04-22 08:35:29.964667 mon <- [mds,set_max_mds,1]
> 2011-04-22 08:35:30.133274 mon0 -> 'max_mds = 1' (0)
> 
> 
> Step5: Then I check mds status
> 
> root@MON1:~# ceph mds stat
> 2011-04-22 08:39:04.160139 mon <- [mds,stat]
> 2011-04-22 08:39:04.160823 mon0 -> 'e19: 2/2/1 up {0=up:active,1=up:active}' (0)
>                                                               ^^^^^^
> What does the 2/2/1 means ?
> 
> I found that the number of active MDS still remains two...
> Could you tell me how to reduce the active mds number from 2 to 1...?
> and what the 2/2/1 means ?

2 are "up", 2 are "in" (the cluster set includes 2), and 1 is the 
target/max.

You can do

$ ceph mds stop 1

to tell mds1 to export everything and shut down cleanly.

sage
