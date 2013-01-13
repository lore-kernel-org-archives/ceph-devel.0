From: =?iso-8859-1?Q?Harald_R=F6=DFler?= <Harald.Roessler@btd.de>
Subject: rbd kernel driver on the osd server
Date: Sun, 13 Jan 2013 17:08:40 +0100
Message-ID: <20130113160840.GF27442@hro-mlt-02.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from odm-dns-01.odmedia.net ([87.238.139.200]:32984 "EHLO
	odm-dns-01.odmedia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094Ab3AMQSY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Jan 2013 11:18:24 -0500
Received: from odm-mucoffice-03.odmedia.net (odm-mucoffice-02.odmedia.net [87.238.138.120])
	by odm-dns-01.odmedia.net (Postfix) with ESMTP id 5233B7FA5
	for <ceph-devel@vger.kernel.org>; Sun, 13 Jan 2013 17:08:43 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

couple of month ago I read about a limitation to run an RBD kernel driver on the osd server. Is this limitation still valid? The reason in Ubuntu and Debian there is no support for the RBD devices in QEMU. At the moment, in our setup  the KVM's are running on the OSD servers.

Best Regards
Harald Roessler
