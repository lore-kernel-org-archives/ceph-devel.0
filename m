From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Increase in performance by increasing OSD's ?
Date: Wed, 21 Mar 2012 10:50:15 -0700
Message-ID: <E2991B22EA9D489A9C9D02461B1DDC76@dreamhost.com>
References: <loom.20120321T161007-745@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57780 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab2CURuR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 13:50:17 -0400
Received: by yhmm54 with SMTP id m54so1167296yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 10:50:17 -0700 (PDT)
In-Reply-To: <loom.20120321T161007-745@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday, March 21, 2012 at 8:11 AM, madhusudhana wrote:
> Hi all,
> 
> Will increase in the number of OSD will increase performance in ceph
> cluster? I mean to say, if ceph cluster is giving ~70MB/s with 3 OSD,
> will increasing OSD number to 5, increase the performance to ~100MB/s ?

It should, assuming similar OSD hardware.
> I have re-created my entire ceph cluster with CentOS 6.2 and kernel 
> 3.2.11 and ceph 0.43. When i ran some tests, the results are far
> better than my first cluster results. But, they are not yet near to
> a normal linux machine or a entry level NetApp storage box. I have tested 
> with cp, rsync, rm and dd commands. The performance what I am getting from
> ceph are not satisfactory (test with my actual work load is even 
> worse). For instance, rsync of 10G directory took 84 mins to complete 
> in Linux machine (in NetApp it was 89mins). But, the same rsync took like 
> 10hrs to copy 10G of data.

1GB/hour is certainly not good! Does the rsync cover folders with very large numbers of files in them (tens of thousands)? These are currently slow on the MDS, although we can give you some features to enable that should remove that as a factor. (As with the rest of the filesystem, they're not production ready, but we'll probably turn them on by default as soon as we get the time to run more large-scale tests with them.)
If you aren't using very large folders, then either your MDS is CPU constrained, your OSDs aren't fast enough, or something horrible is happening.
How much CPU does the ceph-mds process use up while running the rsync?
What client are you doing the rsync from? (Kernel or ceph-fuse?)
What are the results of "rados -p data bench write 60"?
How much memory are your daemons using?
-Greg

