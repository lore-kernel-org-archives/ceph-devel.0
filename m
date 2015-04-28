From: mchristi@redhat.com
Subject: [PATCH 00/10] ceph/rbd: initial support for lio ha
Date: Tue, 28 Apr 2015 17:05:37 -0500
Message-ID: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51126 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030444AbbD1WFt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:49 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5nSm024533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:49 -0400
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbL013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sorry for possibly duplicate emails. I think git-send-email got a
error in the middle of sending the patchset, so it looks like it
did not make it the first time.

The following patches made over v4.0 of the upstream linux kernel add
functionality needed to support HA LIO using RBD for the backing store.
More info can be found here
https://wiki.ceph.com/Planning/Blueprints/Hammer/Clustered_SCSI_target_using_RBD

These patches just add the ceph/rbd code. I was hoping to also post
the lio stuff today, but am hitting some bugs, and Doug might need some
of this to implement notify2/watch2 support.

I will try to post at least the TMF handling code that uses these functions
in a couple days.


