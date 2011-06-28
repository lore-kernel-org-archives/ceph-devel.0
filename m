From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 0/3] Add BASH completion for various tools
Date: Tue, 28 Jun 2011 20:28:11 +0200
Message-ID: <1309285694-12399-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:33197 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1759734Ab1F1SdY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2011 14:33:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

BASH completion is very useful when working with the common Ceph tools on a regular basis.

It also makes it easier for new users to quickly find out some "hidden" commands the "ceph" tool has.

I made a start with the BASH completion for the most used tools, ceph, rados, radosgw_admin and rbd.

They are not complete yet, they'll have to take shape over time.

I've been playing with complementing pool names to the -p argument of the rados and rbd tool, but this causes "rados lspools" to be ran in the background.
I'm not sure yet what kind of performance impact this could have when you have a large amount of pools.

Let me know what you guys think of it.

Wido

