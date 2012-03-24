From: Sage Weil <sage@newdream.net>
Subject: Re: periodically delays when one of mons dies
Date: Fri, 23 Mar 2012 17:31:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203231729120.6414@cobra.newdream.net>
References: <CAHULbC=doKVD1Y72qO9kpbi4YoQ6EginOLsbGC_cGrLRPcyV_Q@mail.gmail.com>
 <CAHULbCnLxNd4j9f3Nfa7-hr0DJ8A_b_sge+1haunDqbPbS1siA@mail.gmail.com>
 <63F3EB16E0CC4D6E9AC1F738A38838F0@dreamhost.com>
 <CAHULbCk90QZ7J0gc+_8V7LW9i5Amz2jxSo6QPJKx3Pp90Q4SBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36431 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2CXAb2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Mar 2012 20:31:28 -0400
In-Reply-To: <CAHULbCk90QZ7J0gc+_8V7LW9i5Amz2jxSo6QPJKx3Pp90Q4SBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: Greg Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Fri, 23 Mar 2012, ruslan usifov wrote:
> Sorry for my bad English.
> 
> I mean that, if throw pacemaker we organize fault tolerant monitor
> (monitor that will work all time - even in fail case), we prevent

The other key thing to keep in mind is that this is completely unnecessary 
with Ceph.  Just run 3 (or 5, or 7, or whatever) monitors, and individual 
ceph-mon failures won't affect the availability.  Ceph clients are smart 
enough to find a non-failed monitor, and the cluster manages consistency 
and so forth on it's own.

The whole point is to _avoid_ kludgey proxy/failover solutions like 
this...

sage
