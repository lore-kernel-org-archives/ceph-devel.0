From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] libceph: tighten up some interfaces
Date: Wed, 14 Nov 2012 10:13:58 -0600
Message-ID: <50A3C346.1010400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51686 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701Ab2KNQOB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:14:01 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so844332iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:14:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

While investigating exactly how and why rbd uses ceph_calc_raw_layout()
I implemented some small changes to some functions to make it obvious
to the caller that certain functions won't cause side-effects, or that
certain functions do or don't need certain parameters.

					-Alex

[PATCH 1/4] libceph: pass length to ceph_osdc_build_request()
[PATCH 2/4] libceph: pass length to ceph_calc_file_object_mapping()
[PATCH 3/4] libceph: drop snapid in ceph_calc_raw_layout()
[PATCH 4/4] libceph: drop osdc from ceph_calc_raw_layout()
