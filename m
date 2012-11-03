From: Sage Weil <sage@inktank.com>
Subject: Re: include/ and -I
Date: Sat, 3 Nov 2012 12:01:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1211031200530.25450@cobra.newdream.net>
References: <509437D1.9080105@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35566 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2KCTB2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 15:01:28 -0400
In-Reply-To: <509437D1.9080105@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 2 Nov 2012, Dan Mick wrote:
> I was somewhat surprised to note that we don't build with -I include, so that
> files that userland programs would find with relative-to-/usr/include paths
> have to be modified for building in the tree.
> 
> Was this conscious, or does anyone else think it would be smoother to
> -I include/ so that outside-the-tree and inside-the-tree #includes are more
> similar?

This was not deliberate.  However, we should be careful that our include/ 
files don't mask ones in /usr/include (e.g., types.h).

sage> 
