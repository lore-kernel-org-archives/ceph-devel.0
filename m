From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Compiling for FreeBSD
Date: Sun, 29 Nov 2015 18:44:57 +0100
Message-ID: <565B3999.3050302@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:29291 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbbK2Rp2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 29 Nov 2015 12:45:28 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 2309A153416
	for <ceph-devel@vger.kernel.org>; Sun, 29 Nov 2015 18:45:26 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:953f:f3db:1564:452f] (unknown [IPv6:2001:4cb8:3:1:953f:f3db:1564:452f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id D5D2B153418
	for <ceph-devel@vger.kernel.org>; Sun, 29 Nov 2015 18:44:57 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Not unlike many others running FreeBSD I'd like to see if I/we can get
Ceph to build and run on FreeBSD. If not all components than at least
certain components.

With compilation I do get quite some way, even with the CLANG compiler.
But I run into obvious part where Linux goes a different direction from
what is available on FreeBSD.

If I google one of the reports I ran into, I get at:
http://lists.ceph.com/pipermail/ceph-commit-ceph.com/2013-November/005812.html

Which sort of suggests that some of the code for FreeBSD has again been
purged from the tree...

Is that to remove FreeBSD completely from the tree?
Or just because that code did not work?

Thanx,
--WjW

