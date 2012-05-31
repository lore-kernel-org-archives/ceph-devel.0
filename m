From: Sage Weil <sage@inktank.com>
Subject: Re: "rbd rm image" slow with big images ?
Date: Thu, 31 May 2012 11:19:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205311118150.28422@cobra.newdream.net>
References: <b4c574f6-49bf-4d36-b8f2-526bcccb4c71@mailpro> <4FC7B528.30609@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53142 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758300Ab2EaSUL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 14:20:11 -0400
In-Reply-To: <4FC7B528.30609@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On Thu, 31 May 2012, Wido den Hollander wrote:
> Hi,
> > Is it the normal behaviour ? Maybe some xfs tuning could help ?
> 
> It's in the nature of RBD.

Yes.

That said, the current implementation is also stupid: it's doing a single 
io at a time.  #2256 (next sprint) will parallelize this to make it go 
much faster (probably an order of magnitude?).

sage
