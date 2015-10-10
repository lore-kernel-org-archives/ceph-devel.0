From: Sage Weil <sage@newdream.net>
Subject: Re: How to reduce the influenct on the IO when an osd is marked
 out?
Date: Sat, 10 Oct 2015 06:39:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510100634450.29929@cobra.newdream.net>
References: <56188B95.7060006@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55944 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbJJNjM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Oct 2015 09:39:12 -0400
In-Reply-To: <56188B95.7060006@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wangsongbo <songbo1227@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, sjust@redhat.com

[dropping ceph-users]

On Sat, 10 Oct 2015, wangsongbo wrote:
> Hi all,
> when an osd is marked out, relative IO will be blocked, in which case,
> application built on ceph will fail.According to test result, the larger a
> data is,the longer it will take to elapse.
> How to reduce the impact of this process on the IO?

When you mark an osd out the mon is doing prime_pg_temp, which 
preemptively remaps the PG to the same OSDs.  This should make peering 
fast... except that the OSDs still have to do a cycle of up_thru updates.

Sam, I think we can do the following to avoid this:

 - in build prior, we can infer that that interval for last_epoch_start is 
also a rw interval (because clearly it finished peering).

 - if the acting set and primary do not change, we can skip the up_thru 
update (because we will already infer rw from above).

I think the only caveat is that we can only skip the up_thru update 
once the entire cluster has a feature bit indicating they understand 
that last_epoch_started implies rw.

Anyway, this would mean that there's no subsequent mon interaction after 
the mark out (and probably lots of other common scenarios)...

What do you think?
sage
