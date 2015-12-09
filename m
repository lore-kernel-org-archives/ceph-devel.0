From: Wido den Hollander <wido@42on.com>
Subject: Quering since when a PG is inactive
Date: Wed, 9 Dec 2015 08:54:31 +0100
Message-ID: <5667DE37.4080502@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:35529 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbbLIHyf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 02:54:35 -0500
Received: from [10.174.63.61] (unknown [62.140.137.50])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 5542A3FF81
	for <ceph-devel@vger.kernel.org>; Wed,  9 Dec 2015 08:54:33 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm working on a patch in PGMonitor.cc that sets the state to HEALTH_ERR
if >= X PGs are stuck non-active.

This works for me now, but I would like to add a timer that a PG has to
be inactive for more than Y seconds.

The PGMap contains "last_active" and "last_clean", but these timestamps
are never updated. So I can't query for last_active =< (now() - 300) for
example.

On a idle test cluster I have a PG for example:

"last_active": "2015-12-09 02:32:31.540712",

It's currently 08:53:56 here, so I can't check against last_active.

What would a good way be to see for how long a PG has been inactive?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
