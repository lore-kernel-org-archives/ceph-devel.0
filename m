From: Sage Weil <sage@newdream.net>
Subject: Re: mkmonfs error
Date: Tue, 11 May 2010 10:43:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005111043000.32173@cobra.newdream.net>
References: <AANLkTin_nfsvA5jqFQ5BhsuzI1IVLmU2ubk6YKPTFagX@mail.gmail.com>
 <Pine.LNX.4.64.1005110927040.32173@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42005 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab0EKRkp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 May 2010 13:40:45 -0400
In-Reply-To: <Pine.LNX.4.64.1005110927040.32173@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Chiang <paul_chiang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 11 May 2010, Sage Weil wrote:
> On Tue, 11 May 2010, Paul Chiang wrote:
> > I'm getting an error with mkmonfs while trying to expand the monitor
> > cluster as per the instructions on the wiki.
> 
> Yeah, this is indeed broken.  We should have a fix sometime today.

I've updated the wiki with a new, simpler, faster procedure (that 
actually works):

	http://ceph.newdream.net/wiki/Monitor_cluster_expansion

Let me know if you run into problems!
sage
