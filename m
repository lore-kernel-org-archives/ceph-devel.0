From: Tomy Cheru <Tomy.Cheru@sandisk.com>
Subject: Where does the data go ??
Date: Wed, 23 Sep 2015 01:58:21 +0000
Message-ID: <EBFBEFF470372547BAACF06D39FF53A54F58B8B8@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0094.outbound.protection.outlook.com ([65.55.169.94]:43653
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752217AbbIWB6Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 21:58:25 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Noticed while benchmarking newstore with rocksdb backend that, the data is missing in "dev/osd0/fragments"

>64k sized objects produces content in above mentioned dir, however missing with <=64k  sized objects

Corresponding drive/s shows activity, .sst files are in "dev/osd0/db" dir

Is it expected behavior ??

Where does the data go ??

Tomy


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

