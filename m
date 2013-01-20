From: Sage Weil <sage@inktank.com>
Subject: Re: questions on networks and hardware
Date: Sun, 20 Jan 2013 11:05:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301201103230.29915@cobra.newdream.net>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net> <50FC2682.3020601@widodh.nl> <50FC3CA8.4070608@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40938 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab3ATTF3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 14:05:29 -0500
In-Reply-To: <50FC3CA8.4070608@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org

On Sun, 20 Jan 2013, Jeff Mitchell wrote:
> Wido den Hollander wrote:
> > No, not really. 1Gbit should be more then enough for your monitors. 3
> > monitors should also be good. No need to go for 5 or 7.
> 
> I have 5 monitors, across 16 different OSD-hosting machines...is that going to
> *harm* anything?

The updates will be marginally more expensive, but I don't think it will 
cause any problems--not until you have 10 or more mons, I'd say.

The only thing to watch out for is the ceph-mon interfering with the 
ceph-osds.  If you have an old kernel without syncfs(2) (<2.6.39 or 
thereabouts), or if you are sharing the mon disk with an osd, there can be 
a negative interaction.

sage

> (I have had issues in my cluster when doing upgrades where my monitor count
> fell to 3, so it felt like having the extra was nice, at that point.)

5 will give you protection from 2 ceph-mon failues, which is nice.

sage
