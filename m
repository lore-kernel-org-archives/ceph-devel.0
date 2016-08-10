From: Wido den Hollander <wido@42on.com>
Subject: OSD crash after Upgrade to Jewel
Date: Wed, 10 Aug 2016 19:52:08 +0200 (CEST)
Message-ID: <1722398688.2333.1470851528137@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:34004 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933044AbcHJSKz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 14:10:55 -0400
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 4BFF876140
	for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 19:52:08 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm seeing this crash on multiple OSDs while upgrading to Jewel:

     0> 2016-08-10 19:41:40.686944 7f20d37f1700 -1 common/buffer.cc: In function 'void ceph::buffer::ptr::copy_in(unsigned int, unsigned int, const char*, bool)' thread 7f20d37f1700 time 2016-08-10 19:41:40.682052
common/buffer.cc: 977: FAILED assert(o+l <= _len)

It started to happen when the OSDs came under load due to a node failing (hardware) which brought a lot of PGs in a unclean state.

I already filed a tracker issue for it: http://tracker.ceph.com/issues/16982

All machines are running Ubuntu 14.04 with the 4.4 kernel.

Wondering if somebody has seen this before. This cluster is very down at the moment..


Wido
