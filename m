From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 16:37:23 +0000 (UTC)
Message-ID: <loom.20150226T172151-585@post.gmane.org>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53410 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779AbbBZQkF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 11:40:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YR1Tn-0000lV-38
	for ceph-devel@vger.kernel.org; Thu, 26 Feb 2015 17:40:03 +0100
Received: from 98.243.40.164-rev.hti.pl ([164.40.243.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 17:40:03 +0100
Received: from rzarzynski by 98.243.40.164-rev.hti.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 17:40:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sweil <at> redhat.com> writes:

> Have you seen any problems?  Any other feedback?  The hope is to (vastly) 
> simplify deployment.

What about the memory footprint? In some cases the civetweb frontend
performs an additional buffering to properly calculate the size of a content
and to attach the "Content-Length" HTTP header. Please take a look on
RGWMongoose::write_data() and RGWMongoose::complete_request() methods. The
problem might be best visible on HUGE container listing.

Regards,
Radoslaw Zarzynski

