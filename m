From: David Blundell <David.Blundell@100percentit.com>
Subject: Unable to restart Mon after reboot
Date: Sat, 23 Jun 2012 00:31:35 +0000
Message-ID: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.100percentit.com ([217.25.0.14]:56034 "EHLO
	smtp.100percentit.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756648Ab2FWAif convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 20:38:35 -0400
Received: from exchange1.ad.100it.net (unknown [87.254.25.14])
	by smtp.100percentit.com (Postfix) with ESMTP id 6D12CD8110
	for <ceph-devel@vger.kernel.org>; Sat, 23 Jun 2012 01:31:39 +0100 (BST)
Content-Language: en-US
Content-ID: <0C2F6B2370100F40AB1EB8BCB558168A@ad.100it.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I am testing Ceph 0.47.2 on btrfs with three servers running Fedora 17.  Following a reboot of the servers, one of the mon daemons crashes on startup with "FAILED assert(r>0)"

MDS and the OSD start and run fine as do the mon daemons on the other two servers.

The debug log is at http://pastebin.com/tXwvd44Z

I would really appreciate any comments - especially if I am missing something obvious.

David