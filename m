From: Wido den Hollander <wido@42on.com>
Subject: Delayed start of OSDs with systemd to prevent slowdowns
Date: Wed, 10 Aug 2016 10:37:40 +0200 (CEST)
Message-ID: <97824899.2313.1470818261025@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:33269 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcHJSBA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 14:01:00 -0400
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 2E4C576134
	for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 10:37:41 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Currently with the systemd design a booting system will start all OSDs at the same time. This means that a cluster suddenly gets a bunch of CRUSH updates (if update on start is enabled), booting OSDs and PGs which go into peering state.

My systemd-foo isn't that good, but I was wondering if there is a way to modify ceph-osd.target in such a way that it doesn't start all the OSDs in parallel?

I would like 1 or maybe 2 OSDs to start at the same time with a delay of 120 seconds in between. This way the boot will take longer, but the impact on the cluster will be less.

Any ideas on how we might achieve this with systemd?

Wido
