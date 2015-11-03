From: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Subject: RE: ordered writeback for rbd client cache
Date: Tue, 3 Nov 2015 19:17:01 +0000
Message-ID: <3649A15A2562B54294DE14BCE5AC79120B8B81F7@FMSMSX119.amr.corp.intel.com>
References: <alpine.DEB.2.00.1511021150250.3903@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57612 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291AbbKCTRD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Nov 2015 14:17:03 -0500
In-Reply-To: <alpine.DEB.2.00.1511021150250.3903@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Gohad, Tushar" <tushar.gohad@intel.com>, "Chagam, Anjaneya" <anjaneya.chagam@intel.com>
Cc: "jdurgin@redhat.com" <jdurgin@redhat.com>

Thanks!  We're meeting now to discuss.  Will reply with a high level breakdown and datapath flow, and maybe some questions.  

-----Original Message-----
From: Sage Weil [mailto:sage@redhat.com] 
Sent: Monday, November 2, 2015 12:54 PM
To: ceph-devel@vger.kernel.org
Cc: Blinick, Stephen L; jdurgin@redhat.com
Subject: ordered writeback for rbd client cache

Just found this:

	https://www.usenix.org/conference/fast13/technical-sessions/presentation/koller

which should be helpful in constructing a persistent client-side writeback cache for RBD that preserves consistency.

sage
