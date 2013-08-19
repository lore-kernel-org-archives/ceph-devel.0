From: Sage Weil <sage@inktank.com>
Subject: RE: v0.61.8 Cuttlefish released
Date: Mon, 19 Aug 2013 15:18:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308191518150.11018@cobra.newdream.net>
References: <alpine.DEB.2.00.1308191251390.11136@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B6649FD75@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51681 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab3HSWS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 18:18:58 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B6649FD75@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 19 Aug 2013, James Harper wrote:
> > 
> > We've made another point release for Cuttlefish. This release contains a
> > number of fixes that are generally not individually critical, but do trip
> > up users from time to time, are non-intrusive, and have held up under
> > testing.
> > 
> > Notable changes include:
> > 
> >  * librados: fix async aio completion wakeup
> >  * librados: fix aio completion locking
> >  * librados: fix rare deadlock during shutdown
> 
> Could any of these be causing the segfaults I'm seeing in tapdisk rbd? 
> Are these fixes in dumpling?

They are also in the dumpling branch and 0.67.1.  They might explain it... 
not a slam dunk though.

sage
