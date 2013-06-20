From: Sage Weil <sage@inktank.com>
Subject: Re: lost bugfix in sync_requester_abort?
Date: Thu, 20 Jun 2013 09:10:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306200908460.27572@cobra.newdream.net>
References: <51C31C34.5080108@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38825 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757935Ab3FTQKN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 12:10:13 -0400
In-Reply-To: <51C31C34.5080108@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 20 Jun 2013, Jim Schutt wrote:
> Hi Sage,
> 
> A week or so ago you had a patch in your wip-mon branch
> (now gone) called "mon: fix raw use of *_dout in sync_requester_abort()".
> It seems that patch got dropped.
> 
> AFAICS, without that patch, sync_requester_abort() has different
> behavior depending on the value of "debug mon".  In particular,
> I believe the sync leader/provider won't get reset if debug mon
> is less than 10.
> 
> Am I missing something, or was dropping that change unintended?

That was accidental.. not sure what happened.  I pushed it to next and 
will backport to cuttlefish.  Thanks!

sage

