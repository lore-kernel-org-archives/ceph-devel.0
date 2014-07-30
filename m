From: Aanchal Agrawal <Aanchal.Agrawal@sandisk.com>
Subject: Non existing monitor
Date: Wed, 30 Jul 2014 10:07:20 +0000
Message-ID: <7F4FDDF05D5B3241ABA5EB82D169E31E04B2F97D@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:16889
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751887AbaG3KH0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 06:07:26 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>

Hi,

We found a case(bug?) in ceph mon code, where in, an attempt to start a non-existing monitor is throwing up a levelDB error saying "failed to create new leveldb store", instead we thought an appropriate message say "No Monitor present with that id" would do, by checking for the monitor existence way ahead.

It seems that 'mon_exists()' checks for the existence of the mon data directory(via 'mon_data_exists()') and also for the non-empty nature of that directory(via 'mon_data_empty()'). The fix seemed pretty simple, as to flag the appropriate message if 'mon_data_exists()' were to set 'exists' to 'false', in case mkfs is not set.

The other behavior that we are seeking clarity, again in case of mkfs not being set is, if 'mon_data_exists()' sets 'exists' to 'true' and 'mon_data_empty()' sets 'exists' to 'false' (meaning the mon data directory is present, but it is empty), then the current code seems to be going ahead in an attempt to open the 'store.db', and when open fails, it tries to create a new 'store.db' (though mkfs is not set) and eventually gives up throwing "unable to read magic from mon data".

The questions we had around this were:

1) Though in case of mkfs not being set, what is the reason for creating a new levelDB store in case an attempt to open the 'store.db' is a failure, as levelDB anyways seem to be throwing 'magic' error going forward. Are there any use cases for this scenario?
2) And also, is it valid to flag "No Monitor present" in case the mon data directory is existing, but with no data('store.db') in it, in case mkfs is not set?

Thanks,
Aanchal

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

