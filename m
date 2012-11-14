From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: stop using ceph_calc_raw_layout()
Date: Wed, 14 Nov 2012 12:31:15 -0600
Message-ID: <50A3E373.4090006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46415 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423116Ab2KNSbS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 13:31:18 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so1019915iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 10:31:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series makes rbd no longer call ceph_calc_raw_layout(),
and in doing so, also stop calling ceph_calc_file_object_mapping()
for its requests.  Apparently the call to the former was for
the *other* side-effects it had (unrelated to the layout).

					-Alex

[PATCH 1/4] rbd: pull in ceph_calc_raw_layout()
[PATCH 2/4] rbd: open code rbd_calc_raw_layout()
[PATCH 3/4] rbd: don't bother calculating file mapping
[PATCH 4/4] rbd: use a common layout for each device
