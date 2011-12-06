From: <Eric_YH_Chen@wistron.com>
Subject: rbd device would disappear after re-boot
Date: Tue, 6 Dec 2011 17:31:52 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D943112@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw5.wistron.com ([220.128.89.25]:50043 "EHLO
	TWNHUMSW5.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932901Ab1LFJby convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 04:31:54 -0500
Received: from twnhufe1.whq.wistron (unverified [10.37.31.101]) by TWNHUMSW5.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta120d823e4c0a8167320e4@TWNHUMSW5.wistron.com> for <ceph-devel@vger.kernel.org>;
 Tue, 6 Dec 2011 17:32:50 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wistron.com

Dear All:

   Another question about the rbd device. All rbd device would disappear
after server re-boot.

   Do you have any plan to implement a feature that server would re-map
all the device during initialization?

   If not, do you have any suggestion (about technical part) if we want
to implement this feature? 

   Furthermore, we would like to send a pull request after we finish it,
any policy should we take-care?

   Thanks a lot!
