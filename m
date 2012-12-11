From: Sage Weil <sage@inktank.com>
Subject: Re: Debian packaging question
Date: Mon, 10 Dec 2012 21:34:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212102133040.17288@cobra.newdream.net>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43626 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab2LKFen (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 00:34:43 -0500
In-Reply-To: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, James Page <james.page@ubuntu.com>

On Mon, 10 Dec 2012, Gary Lowell wrote:
> Hi -
> 
> I'm looking for advice on debian multiple architecture repositories.  
> To date we have been building ceph debian packages on two different 
> machines for the i386 and amd64 platforms, rsyncing the results to a 
> common directory on the build host, then putting the results together 
> using the reprepro command to push out to ceph.com.  As all the packages 
> are architecture=linux-any, the arch is embedded in the file names and 
> we don't have any collisions.
> 
> The new libcephfs-java, which is architecture=all, ends up being built 
> twice with the same resulting file name, but different checksums 
> depending on where it was built. Not unexpectedly, reprepro complains 
> about this.

Can we just ignore the second attempt that fails?  Or only try to add the 
arch=all .dsc once?

sage
