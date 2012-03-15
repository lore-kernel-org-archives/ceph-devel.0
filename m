From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Wed, 14 Mar 2012 21:24:15 -0700
Message-ID: <A0D9F03B-8FA9-4731-9BCF-3207166ECC23@cs.ucsc.edu>
References: <4F516A20.8060901@cs.ucsc.edu> <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net> <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:52336 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab2COEYQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Mar 2012 00:24:16 -0400
In-Reply-To: <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


On Mar 7, 2012, at 10:02 AM, Noah Watkins wrote:

> As for producing an upstream patch, I think the two biggest concerns are:
> 
> 1. Reporting hostname/racks rather than IPs for object location.
> 2. Address (or at least document) the time synchronization issue.

Regarding (1), my last comment in this ticket (http://tracker.newdream.net/issues/1666) seems to indicate that a stat occurs on a client and the mtime in the cached inode is returned, but the client is expecting the mtime in the updated inode in the OSD.

Is there an easy way to invalidate the the inodes in a client to at least verify the problem?

Thanks,
- Noah

