From: Sage Weil <sage@newdream.net>
Subject: Re: 10 times higher disk load with btrfs
Date: Mon, 5 Jan 2015 11:25:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501051124430.5967@cobra.newdream.net>
References: <54AAD9B5.5080207@profihost.ag> <54AAE3BF.9080908@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55567 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbbAETZ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 14:25:59 -0500
In-Reply-To: <54AAE3BF.9080908@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Mon, 5 Jan 2015, Stefan Priebe wrote:
> 
> Am 05.01.2015 um 19:36 schrieb Stefan Priebe:
> > Hi devs,
> > 
> > while btrfs is now declared as stable ;-) i wanted to retest btrfs on
> > our production cluster on 2 out of 54 osds. So if they crash it doesn't
> > hurt.
> > 
> > While if those OSDs run XFS have spikes of 20MB/s every 4-7s. The same
> > OSDs after formatting them with btrfs have spikes of 190MB/s every 4-7s.
> > 
> > Why does just another filesystem raises the disk load by a factor of 10?
> 
> OK this seems to happen cause ceph is creating every 5s a new subvolume /
> snap. Is this really expected / needed?

You can disable it with

 filestore btrfs snap = false

I'm curious how much this drops the load down; originally the 
snaps were no more expensive than a regular sync but perhaps this 
has changed...

sage
