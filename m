From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: chaning pg_num / pgp_num after adding more osds
Date: Tue, 06 Nov 2012 12:07:58 +0100
Message-ID: <5098EF8E.3060709@unilogicnetworks.net>
References: <5097C9DD.3030600@profihost.ag> <50984F82.3010706@inktank.com> <5098BCFF.6050004@profihost.ag> <alpine.DEB.2.00.1211060251380.12495@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out118.unilogicnetworks.net ([62.133.206.118]:59971 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751372Ab2KFLh0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 06:37:26 -0500
In-Reply-To: <alpine.DEB.2.00.1211060251380.12495@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/06/2012 11:59 AM, Sage Weil wrote:
>
>> When i have one pool with 800 pgs and i add 20 new OSDs how does a new pool
>> help? I mean the old pools will stay with 800 pgs.
> It make the distribution of existing data less coarse, but as the size of
> teh PGs for the new pool increases things will tend to level out.
>
> My suggestion is to overshoot the PG count a little bit (not too much!),
> maybe ~200 pgs per osd.  If things get too unbalanced after a significant
> expansion you can put new data is new pools, or make fine-grainted
> adjustments in the CRUSH map.
>
> I suspect that this will be sufficient for just about everyone until the
> splitting functionality is in place... hopefully in 1-2 dev releases after
> bobtail.
>
Maybe I missed something but do you mean about 100-200 PG's per pool per 
OSD or 100-200 PG's per OSD? Because when you create new pools, the PG's 
per OSD increases a lot.

Stefan
