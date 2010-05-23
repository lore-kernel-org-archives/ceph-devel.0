From: Sage Weil <sage@newdream.net>
Subject: Re: Quota support
Date: Sun, 23 May 2010 09:00:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005230855200.11676@cobra.newdream.net>
References: <201005231227.47393.michal.humpula@hudrydum.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52881 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab0EWP47 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 May 2010 11:56:59 -0400
In-Reply-To: <201005231227.47393.michal.humpula@hudrydum.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Humpula <michal.humpula@hudrydum.cz>
Cc: ceph-devel@vger.kernel.org

On Sun, 23 May 2010, Michal Humpula wrote:
> I was interesting if there is some plan for linux quota support (I've searched 
> the list and the code and found nothing). If it is, is there some experimental 
> code or at least some place with ideas how it should be implemented?

Hi Michal,

Kristal Pollack did a paper on distributed quotas that represents one 
possible approach for enforcement in the case where clients are untrusted:

	http://ceph.newdream.net/publications/quota-voucher-paper.pdf

There is also the recursive accounting in the the MDS that in theory could 
facilitate subtree quotas.  It already implements the accounting half of 
the problem, but the implementation of enforcement would be tricky.  See

	http://marc.info/?t=127264993600004&r=1&w=2

sage
