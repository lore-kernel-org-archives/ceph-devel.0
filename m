From: Sage Weil <sage@newdream.net>
Subject: Re: An Evaluation of Object Name Hashing
Date: Tue, 12 Jan 2016 08:38:33 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601120831470.27580@cpach.fuggernut.com>
References: <87a8obhr88.fsf@uni-mainz.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44707 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934425AbcALNia (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jan 2016 08:38:30 -0500
In-Reply-To: <87a8obhr88.fsf@uni-mainz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <lauhoff@uni-mainz.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Marcel,

This is great!

On Tue, 12 Jan 2016, Marcel Lauhoff wrote:
> 
> Hi,
> 
> I wrote a Master's Thesis about Ceph and cold storage last year. One of
> the things I looked at was modifications to object placement.
> 
> Among others, what would happen to balance (e.g objects / OSD) when
> all objects of a file end up on the same OSD. I also ran tests with a
> different hash algorithm (Linux dcache).
> 
> I wrote an article on my website with the analysis, changes to the
> source and how I ran the tests:
> 
>   http://irq0.org/articles/ceph/object_name_hashing

The interesting thing to me is the error bars for linux prefix (the 
right-most set of bars on the last graph).  They range is significantly 
wider than rjenkins + prefix (ranging from 2.1TiB to 4.0TiB (vs 2.3-3.7ish 
for the others).  The reason we switched away from the linux dcache hash 
(it was the original choice) is because it is very weak.  I suspect that 
even if you look at the average + standard deviation it hides some of the 
badness; looking at 99th or 99.9th percentile, or simply a plot of the osd 
utilization distribution, will show that there are more low- and high- 
utilization outliers.

The other thing to keep in mind is that beyond a certain size locality 
doesn't buy you that much... the disk seek overhead is no longer 
significant once you've read several megabytes of data.  At the same 
time, concentrating all data in a file (or rbd image) on a single device 
means that a large, busy, hot file can focus a lot of traffic on a single 
OSD.

What might be more useful is the ability to take the data for several 
smaller files that are thought to be related (e.g., in the same directory, 
created at the same time) and try to store them together.  In that case, 
since we know the file are small, the impact on balance would not be 
significant.  On the other hand, what we currently do with (very) small 
files in CephFS is just inline the data in the inode anyway so we already 
get that locality (and more)--the main limitation there being that the max 
inline size is quite small (a KB or two, IIRC).

sage
