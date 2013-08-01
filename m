From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: still recovery issues with cuttlefish
Date: Thu, 01 Aug 2013 10:22:25 +0200
Message-ID: <51FA1AC1.8040207@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:46429 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3HAIWf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 04:22:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

i still have recovery issues with cuttlefish. After the OSD comes back
it seem to hang for around 2-4 minutes and then recovery seems to start
(pgs in recovery_wait start to decrement). This is with ceph 0.61.7. I
get a lot of slow request messages an hanging VMs.

What i noticed today is that if i leave the OSD off as long as ceph
starts to backfill - the recovery and "re" backfilling wents absolutely
smooth without any issues and no slow request messages at all.

Does anybody have an idea why?

Greets,
Stefan
