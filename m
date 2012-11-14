From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: disavow any support for multiple osd ops
Date: Wed, 14 Nov 2012 10:33:20 -0600
Message-ID: <50A3C7D0.2050809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46318 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671Ab2KNQdX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:33:23 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so880506iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:33:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The rbd code is rife with places where it seems that an
osd request could support multiple osd ops.  But the
reality is that there are spots in rbd as well as libceph
and the messenger that make such support impossible without
some (upcoming, planned) additional work.

This series starts by getting rid of the notion that
anything but a single op will be passed for an osd
operation.  The first two patches just make it clear
that we never actually do send more than one op from
rbd anyway, the last two make the code reflect that,
simplifying things in the process.

					-Alex

[PATCH 1/4] rbd: pass num_op with ops array
[PATCH 2/4] libceph: pass num_op with ops
[PATCH 3/4] rbd: there is really only one op
[PATCH 4/4] rbd: assume single op in a request
