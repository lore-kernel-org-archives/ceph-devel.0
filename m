From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Reduce bandwidth for remapping/backfill/recover?
Date: Sat, 3 Nov 2012 16:37:37 +0100
Message-ID: <EDED730E-CCE5-4A07-AF1E-2D90E0686218@filoo.de>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:54186 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab2KCPhm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 11:37:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi *

anybody out there, who can help with an idea for reducing bandwidth when incorporating 2 new nodes into a cluster?
I know of "osd recovery max active = X" ( 5 default), but with 4 OSD's per node, there is enough possibility to saturate our backnet ( 1Gig at the moment).
Any other way to not disturb users too much?

Thxn in@vance,

Oliver.


