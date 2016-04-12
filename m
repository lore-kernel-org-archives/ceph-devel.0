From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Tue, 12 Apr 2016 16:47:48 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604121639590.29593@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com> <4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz> <alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com>
 <8CF37229-17C6-4E49-A623-FB8933631F60@schermer.cz> <alpine.DEB.2.11.1604121525020.29593@cpach.fuggernut.com> <2CBEF339-052C-42D8-A6EA-5BA9C5B8DE9F@schermer.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38206 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964798AbcDLUrw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 16:47:52 -0400
In-Reply-To: <2CBEF339-052C-42D8-A6EA-5BA9C5B8DE9F@schermer.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Schermer <jan@schermer.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com

On Tue, 12 Apr 2016, Jan Schermer wrote:
> Still the answer to most of your points from me is "but who needs that?" 
> Who needs to have exactly the same data in two separate objects 
> (replicas)? Ceph needs it because "consistency"?, but the app (VM 
> filesystem) is fine with whatever version because the flush didn't 
> happen (if it did the contents would be the same).

If you want replicated VM store that isn't picky about consistency, 
try Sheepdog.  Or your mdraid over iSCSI proposal.

We care about these things because VMs are just one of many users of 
rados, and because even if we could get away with being sloppy in some (or 
even most) cases with VMs, we need the strong consistency to build other 
features people want, like RBD journaling for multi-site async 
replication.

Then there's the CephFS MDS, RGW, and a pile of out-of-tree users that 
chose rados for a reason.

And we want to make sense of an inconsistency when we find one on scrub.  
(Does it mean the disk is returning bad data, or we just crashed during a 
write a while back?)

...

Cheers-
sage

