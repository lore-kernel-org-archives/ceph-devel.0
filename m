From: Wido den Hollander <wido@42on.com>
Subject: CodingStyle on existing code
Date: Tue, 1 Dec 2015 14:10:15 +0100
Message-ID: <565D9C37.3060903@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57278 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236AbbLANKR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Dec 2015 08:10:17 -0500
Received: from [IPv6:2001:980:7936:0:294c:6cb6:dae6:650e] (unknown [IPv6:2001:980:7936:0:294c:6cb6:dae6:650e])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 7B2E8761C6
	for <ceph-devel@vger.kernel.org>; Tue,  1 Dec 2015 14:10:15 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

While working on mon/PGMonitor.cc I see that there is a lot of
inconsistency on the code.

A lot of whitespaces, indentation which is not correct, well, a lot of
things.

Is this something we want to fix? With some scripts we can probably do
this easily, but it might cause merge hell with people working on features.

Wido
