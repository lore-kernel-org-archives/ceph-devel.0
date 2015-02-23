From: Sage Weil <sweil@redhat.com>
Subject: Re: Recovery question
Date: Mon, 23 Feb 2015 13:02:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502231258440.23553@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282B72DE@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbbBWVC6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Feb 2015 16:02:58 -0500
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282B72DE@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 23 Feb 2015, Somnath Roy wrote:
> Hi,
> Can anyone help me understand what will happen in the following scenarios ?
> 
> 1. Current PG map : 3.5 -> OSD[1,2,3]
> 
> 2. 1 is down and new map : 3.5 -> OSD[2,3,4]

More likely it's:

 1: 3.5 -> [1,2,3]
 2: 3.5 -> [2,3]   (osd.1 is down)
 3: 3.5 -> [2,3,4] (osd.1 is marked out)

> 3. Need to for backfill recovery for 4 and it started

If log recovery will work, we'll do that and it's nice and quick.  If 
backfill is needed, we will do

 4: 3.5 -> [2,3]  (up=[2,3,4]) (pg_temp record added to map to log-recoverable OSDs)

> 4. Meanwhile OSD 1 came up , it was down for short amount of time

 5: 3.5 -> [1,2,3] (osd.1 is back up and in)

> 5. Will pg 3.5 mapping change considering OSD 1 recovery could be log 
> based ?

It will change immediately when osd.1 is back up, regardless of what data 
is where.  If it's log recoverable, then no mapping changes will be 
needed.  If it's not, then

 6: 3.5 -> [2,3,4]  (up=[1,2,3]) (add pg_temp mapping while we backfill osd.1)
 7: 3.5 -> [1,2,3]  (pg_temp entry removed when backfill completes)

> 6. Also, if OSD 4 recovery could be log based, will there be any change 
> in pg map if OSD 1 is up during the recovery ?

See above

Hope that helps!
sage
