From: Sage Weil <sage@inktank.com>
Subject: Re: osd dies / crahes directly after mkcephfs
Date: Fri, 15 Jun 2012 14:46:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206151445290.4551@cobra.newdream.net>
References: <4FDBA78C.4050401@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36379 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329Ab2FOVqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 17:46:38 -0400
In-Reply-To: <4FDBA78C.4050401@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 15 Jun 2012, Stefan Priebe wrote:
> Hi,
> 
> i've seen several osd crashes on one of my machines directly after creating
> the ceph fs.
> 
> Attached is the osd log. I also have a core dump file. Do you need it?

Also, are you mounting the ceph file system on the same node as the osd?  
This might be a sync(2)-induced deadlock.

Putting a ceph fs mount on the same node as an osd is dicey in low memory 
situations.  On older glibcs and kernels without syncfs(2) support, it can 
easily deadlock.

sage
