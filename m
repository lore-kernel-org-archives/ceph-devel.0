From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: inconsistent chunk
Date: Fri, 17 Jun 2011 09:27:10 -0700
Message-ID: <E58F9FF9-B13F-45D7-86D3-5C1940A919C7@dreamhost.com>
References: <4DFAE436.9060606@ufm.su>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33249 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab1FQQ11 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2011 12:27:27 -0400
In-Reply-To: <4DFAE436.9060606@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org, samuel.just@dreamhost.com

On Jun 16, 2011, at 10:20 PM, Fyodor Ustinov wrote:

> Hi!
> 
> I have inconsistent chunk:
> 
> 2011-06-17 08:11:33.844030    pg v26069: 2376 pgs: 2375 active+clean, 1 active+clean+inconsistent; 285 GB data, 572 GB used, 24180 GB / 25494 GB avail
> 
> Questions:
> 1. What does this mean?
This isn't actually an inconsistent chunk. It's an inconsistent "placement group", which is a logical grouping of RADOS objects which are moved between OSDs and share the same RADOS metadata. It being labeled inconsistent means that the background scrub has identified a difference in the PG's contents. Right now, I think that means a difference in the file contents, or in one of their sizes or modification times.

> 2. How to learn what kind of file is damaged?
That's not readily-available data, I'm afraid. There may be a way to find out which objects caused it to get flagged inconsistent (which would tell you the inode of the damaged files), Sam would be able to tell you more about this...

> 3. Delete damaged file should fix it?
You're unlikely to be able to delete things that are marked inconsistent, since the system wants to resolve the inconsistency before it does anything else with them.

> 4. Can I recover the data without backup?
Possibly. If the inconsistency is just that one of the OSDs is storing the object and another OSD says the object shouldn't exist, that can be recovered from by working out which one is correct.

Have you manually adjusted the contents of any OSDs? Can you think of anything you've done that might have triggered this?