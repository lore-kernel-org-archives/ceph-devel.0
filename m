From: Wido den Hollander <wido@widodh.nl>
Subject: Commit 13a98a972cef3560ddaa2462f8cab50a2d820cfb breaks compilation
Date: Wed, 22 Sep 2010 12:44:28 +0200
Message-ID: <1285152268.2392.32.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:59255 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0IVKoa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 06:44:30 -0400
Received: from [192.168.6.32] (cable-191-148.zeelandnet.nl [82.176.191.148])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id F402E1AC388
	for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 12:44:28 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

In commit 13a98a972cef3560ddaa2462f8cab50a2d820cfb the flock type was
moved to "flock.h", but flock.h wasn't added to the repository, thus
breaking compilation.

Reverting to c33685764a3f0c63fab5e75fe287059b7f6d97fd gives you Ceph
packages again :-)

Wido

