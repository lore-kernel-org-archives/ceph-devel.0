From: Sage Weil <sage@inktank.com>
Subject: Re: Cache, Backup and S3backer
Date: Sat, 13 Oct 2012 20:46:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210132041030.3424@cobra.newdream.net>
References: <loom.20121013T051644-437@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38238 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab2JNDqL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Oct 2012 23:46:11 -0400
In-Reply-To: <loom.20121013T051644-437@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Auada <rauada@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 13 Oct 2012, Ricardo Auada wrote:
> Hi, I?m just starting to look at CEPH and some questions crossed my mind. I
> wonder if someone can help me with them:
> 
> 1- Does Ceph use any kind of cache to improve speed access to data in OSD?s ?

The ceph file system and RBD both have caches.  The low-level librados 
does not, and radosgw (RESTful S3/Swift access) caches only certain 
metadata, but not object data.  Caches can be easily layered on top of 
these.

> 2- Because Ceph is usually used for big amounts of data, how can we backup /
> snapshot this data ? How fast can we recover this big backup ? Or we wouldn?t
> need a backup at all, due to the redundance features ? Here I mean only disaster
> recover backup.

This is a big question for any large storage system.  The goal is that for 
most applications, there would be no backup, since Ceph is masking 
individual component failure.  Ultimately this is a question for you, 
based on the data you are storing and your level of trust.

> 3- I see Ceph has an S3 API. Also, we are studying some S3 filesystems and
> S3backer seems to be a very nice one. What would be the differences in using one
> or the other ?

If the goal is a file system, I would use RBD or the ceph fs directly, not 
layer it on top of radosgw; you'll get a cleaner, simpler stack and better 
performance.

sage
