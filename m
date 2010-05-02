From: Sage Weil <sage@newdream.net>
Subject: Re: mkcephfs 0.20 failure on debian: FAILED assert(r == 0)
Date: Sun, 2 May 2010 15:05:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005021501240.32001@cobra.newdream.net>
References: <hrhh53$gf3$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56136 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab0EBWDV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 May 2010 18:03:21 -0400
In-Reply-To: <hrhh53$gf3$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

On Sat, 1 May 2010, Thomas Mueller wrote:

> Hi
> 
> I wanted to do some testing. but i failed on mkcephfs.  see mkcephfs 
> output below. 
> 
> this is on debian lenny, i follow the howto in the wiki http://
> ceph.newdream.net/wiki/Debian and 
> http://ceph.newdream.net/wiki/Installing_on_Debian
> 
> 0.19 worked with the wiki-howto.

It sounds like the osd journal file exists, but is 0 bytes.  You can 
include

	osd journal size = 100    ; measured in MB

to your ceph.conf and it will be resized during mkfs (iff it is 0 bytes).  
Or use 'dd'.  Or (better yet) point it at a raw block device.

I'm fixing up the error handling to return an error instead of asserting.

> .. and what happend to the ceph-kclient-source package? 

Well, I'm not sure if we should keep building that package.  The kernel 
client versioning is somewhat divorced from the server side now that the 
client is in the mainline kernel (and releases are dictated by kernel 
releases).  But I take it people use that package?  I suppose as long as 
there is some 'stable' release that coincides with the final kernel 
release (e.g., v0.20.1 for v2.6.34 in a few weeks, in this case).

sage
