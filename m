From: michaelc@cs.wisc.edu
Subject: [PATCH 00/10] ceph/rbd: initial support for lio ha
Date: Tue, 28 Apr 2015 15:50:15 -0500
Message-ID: <1430254225-7359-1-git-send-email-michaelc@cs.wisc.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sabe.cs.wisc.edu ([128.105.6.20]:54028 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965792AbbD1Uui (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 16:50:38 -0400
Received: from rh2.redhat.com (c-24-245-27-162.hsd1.mn.comcast.net [24.245.27.162])
	(authenticated bits=0)
	by sabe.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id t3SKoWWB016959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 15:50:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The following patches made over v4.0 of the upstream linux kernel add
functionality needed to support HA LIO using RBD for the backing store.
More info can be found here
https://wiki.ceph.com/Planning/Blueprints/Hammer/Clustered_SCSI_target_using_RBD

These patches just add the ceph/rbd code. I was hoping to also post
the lio stuff today, but am hitting some bugs, and Doug might need some
of this to implement notify2/watch2 support.

I will try to post at least the TMF handling code that uses these functions
in a couple days.

