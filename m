From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Best practice with 0.48.2 to take a node into maintenance
Date: Mon, 3 Dec 2012 20:05:32 +0100
Message-ID: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:50400 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2LCTFe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 14:05:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi *,

well, even if 0.48.2 is really stable and reliable, it is not everytime the case with linux kernel. We have a couple of nodes, where an update would make life better.
So, as our OSD-nodes have to care for VM's too, it's not the problem to let them drain so migrate all of them to other nodes.
Just reboot? Perhaps not, cause all OSD's will begin to remap/backfill, they are instructed to do so. Well, declare them as "osd lost"?
Dangerous. Is there another way I miss in doing node-maintenance? Will we have to wait for bobtail for far less hassle with all remapping and resources?

Thnx for comments,

Oliver.

