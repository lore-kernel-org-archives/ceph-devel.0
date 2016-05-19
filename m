From: Sage Weil <sage@newdream.net>
Subject: Re: No Ceph Recovery : Is it a bug ?
Date: Thu, 19 May 2016 03:47:14 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605190343450.980@cpach.fuggernut.com>
References: <CAPg135a2YdLrMspcGdLbkx-fWvh30VJ3J4Y=hKSMAxDzosd+KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43924 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbcESHq6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 03:46:58 -0400
In-Reply-To: <CAPg135a2YdLrMspcGdLbkx-fWvh30VJ3J4Y=hKSMAxDzosd+KQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaurav Bafna <bafnag@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 19 May 2016, Gaurav Bafna wrote:
> Hi Cephers ,
> 
> In our production cluster at Reliance Jio, when as osd goes corrupt
> and crashes, Cluster remains unhealthy even after 4 hours.
> 
>     cluster fac04d85-db48-4564-b821-deebda046261
>      health HEALTH_WARN
>             658 pgs degraded
>             658 pgs stuck degraded
>             688 pgs stuck unclean
>             658 pgs stuck undersized
>             658 pgs undersized
              ^^^ this...

>             recovery 3064/1981308 objects degraded (0.155%)
>             recovery 124/1981308 objects misplaced (0.006%)
>      monmap e11: 11 mons at
> {dssmon2=10.140.208.224:6789/0,dssmon3=10.140.208.225:6789/0,dssmon31=10.135.38.141:6789/0,dssmon32=10.135.38.142:6789/0,dssmon33=10.135.38.143:6789/0,dssmon34=10.135.38.144:6789/0,dssmon35=10.135.38.145:6789/0,dssmon4=10.140.208.226:6789/0,dssmon5=10.140.208.227:6789/0,dssmon6=10.140.208.228:6789/0,dssmonleader1=10.140.208.223:6789/0}
>             election epoch 792, quorum 0,1,2,3,4,5,6,7,8,9,10
> dssmon31,dssmon32,dssmon33,dssmon34,dssmon35,dssmonleader1,dssmon2,dssmon3,dssmon4,dssmon5,dssmon6
>      osdmap e8778: 2774 osds: 2746 up, 2746 in; 30 remapped pgs
                               doesn't match this ^^

which makes it look like a problem with OSDs reporting PG state to the 
mon.  The fact that an OSD restarts supports that theory.

What version is this?  A bunch of the osd -> mon pg reporting code was 
recently rewritten (between infernalis and jewel), so the new code is 
hopefully more robust.  (OTOH, it is also new, so we may have missed 
something.)

Nice big cluster!

sage
