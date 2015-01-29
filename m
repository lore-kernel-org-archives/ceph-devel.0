From: Sage Weil <sweil@redhat.com>
Subject: wip-crush-linear
Date: Thu, 29 Jan 2015 14:17:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501291412270.13726@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940AbbA2WRO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jan 2015 17:17:14 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yujie He <yujie.he@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yujie,

I've rebased your congruential crush series on top of the other recent 
CRUSH changes (mainly straw2 buckets) and made a few small changes and 
cleanups.  Can you please take a look and see if I may have 
missed anything?  It would also be helpful if you could verify that the 
final version of raw_pg_to_pps

	https://github.com/ceph/ceph/commit/e42baff8e823cf088c50605433bef8334fe06785#diff-0bd9f9613a09a1111a9851762e70fcd4R1034

and the final linear bucket implementation and seed argument meet 
your needs.  If so, it would be nice to merge this in alongside the straw2 
changes so that there is a single feature bit to cover them both.

After thinking about the linear bucket some more I'm not sure it is worth 
plugging any additional parameters in.

If you have any unit tests you can contribute that exercise the new code 
that would be very helpful.  For example, a unit test that exercises the 
seed selection code, or a generic test that constructs maps 
with all bucket types and feeds in a bunch of inputs would be 
great.

Thanks!
sage
