From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph: always init trail for osd requests
Date: Wed, 14 Nov 2012 10:08:23 -0600
Message-ID: <50A3C1F7.6070107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54595 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422730Ab2KNQI0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:08:26 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so833303iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:08:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series makes the ceph_osd_request->r_trail be a
structure that's always initialized rather than a pointer.
The result works equivalent to before but it makes things
simpler.

					-Alex

[PATCH 1/2] libceph: always allow trail in osd request
[PATCH 2/2] libceph: kill op_needs_trail()
