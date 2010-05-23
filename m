From: Sage Weil <sage@newdream.net>
Subject: Re: Quota support
Date: Sun, 23 May 2010 09:14:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005230913420.11676@cobra.newdream.net>
References: <201005231227.47393.michal.humpula@hudrydum.cz>
 <Pine.LNX.4.64.1005230855200.11676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50322 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab0EWQKa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 May 2010 12:10:30 -0400
In-Reply-To: <Pine.LNX.4.64.1005230855200.11676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Humpula <michal.humpula@hudrydum.cz>
Cc: ceph-devel@vger.kernel.org


On Sun, 23 May 2010, Sage Weil wrote:

> On Sun, 23 May 2010, Michal Humpula wrote:
> > I was interesting if there is some plan for linux quota support (I've searched 
> > the list and the code and found nothing). If it is, is there some experimental 
> > code or at least some place with ideas how it should be implemented?
> 
> Hi Michal,
> 
> Kristal Pollack did a paper on distributed quotas that represents one 
> possible approach for enforcement in the case where clients are untrusted:
> 
> 	http://ceph.newdream.net/publications/quota-voucher-paper.pdf

Sorry,

	http://ceph.newdream.net/pubs/quota-voucher-paper.pdf

sage
