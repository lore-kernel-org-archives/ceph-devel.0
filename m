From: Sage Weil <sweil@redhat.com>
Subject: aarch64 not using crc32?
Date: Thu, 24 Sep 2015 05:17:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509240514480.13834@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbbIXMR3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Sep 2015 08:17:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pankaj.Garg@caviumnetworks.com
Cc: ceph-devel@vger.kernel.org

Hi Pankaj,

In order to get the build going on the new trusty gitbuilder I had to make 
this change:

	https://github.com/ceph/ceph/commit/3123b2c5d3b72c9d43b10d8f296305d41b68b730

It was clearly a bug, but what worries me is that the fact that I hit it 
means the HWCAP_CRC32 is not present.  Is there a problem with the 
hardware feature detection or is that feature simply missing from the box 
we're using?

Thanks!
sage
