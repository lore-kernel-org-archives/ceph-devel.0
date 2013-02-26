From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: maintanance on osd host
Date: Tue, 26 Feb 2013 15:56:25 +0100
Message-ID: <512CCD19.7010509@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:52655 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab3BZO4a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 09:56:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi list,

how can i do a short maintanance like a kernel upgrade on an osd host?
Right now ceph starts to backfill immediatly if i say:
ceph osd out 41
...

Without ceph osd out command all clients hang for the time ceph does not
know that the host was rebootet.

I tried
ceph osd set nodown and ceph osd set noout
but this doesn't result in any difference

Stefan
