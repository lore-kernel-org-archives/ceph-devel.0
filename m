From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: A bug in rolling back to a degraded object
Date: Mon, 1 Jun 2015 12:51:25 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489EBE1F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60816 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbbFAMvi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2015 08:51:38 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage and all,

Another bug discovered during the proxy write teuthology testing is when rolling back to a degraded object. This doesn't seem specific to proxy write. I see a scenario like below from the log file:

- A rollback op comes in, and is enqueued.
- Several other ops on the same object come in, and are enqueued.
- The rollback op dispatches, and finds the object which it rollbacks to is degraded, then this op is pushbacked into a list to wait for the degraded object to recover.
- The later ops are handled and responded back to client.
- The degraded object recovers. The rollback op is enqueued again and finally responded to client.

This breaks the op order. A fix for this is to maintain a map to track the <source, destination> pair. And when an op on the source dispatches, if such a pair exists, queue the op in the destination's degraded waiting list. A drawback of this approach is that some entries in the ' waiting_for_degraded_object' list of the destination object may not be actually accessing the destination, but the source. Does this make sense?
