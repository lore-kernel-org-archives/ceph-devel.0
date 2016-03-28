From: Loic Dachary <loic@dachary.org>
Subject: make check on jewel aarch64 / arm64 / ARMv8
Date: Mon, 28 Mar 2016 14:04:08 +0200
Message-ID: <56F91DB8.8010208@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40224 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbcC1MEO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2016 08:04:14 -0400
Received: from mfilter19-d.gandi.net (mfilter19-d.gandi.net [217.70.178.147])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id 8D112C5A46
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2016 14:04:11 +0200 (CEST)
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter19-d.gandi.net (mfilter19-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id HwdhEOvucLKc for <ceph-devel@vger.kernel.org>;
	Mon, 28 Mar 2016 14:04:09 +0200 (CEST)
Received: from [192.168.0.11] (85-169-70-103.rev.numericable.fr [85.169.70.103])
	(Authenticated sender: loic@dachary.org)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2675CC5A54
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2016 14:04:08 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

It was a pleasant surprise to see make check run successfully on the je=
wel branch compiled on arm64 with only two minor glitches.

Makefile-env.am: set a default for CEPH_BUILD_VIRTUALENV (part 2) https=
://github.com/ceph/ceph/pull/8320
src/test/cephtool-test-mon.sh Hooked allocator frame not found hides er=
ror (arm64) http://tracker.ceph.com/issues/15289

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
