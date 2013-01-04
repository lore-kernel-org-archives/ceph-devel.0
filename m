From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/6] libceph: parameter cleanup
Date: Fri, 04 Jan 2013 08:31:30 -0600
Message-ID: <50E6E7C2.2020604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:60070 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab3ADObc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:31:32 -0500
Received: by mail-ia0-f176.google.com with SMTP id y26so13700497iab.35
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:31:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series mostly cleans up parameters used by functions
in libceph, in the osd client code.

					-Alex

[PATCH REPOST 1/6] libceph: pass length to ceph_osdc_build_request()
[PATCH REPOST 2/6] libceph: pass length to ceph_calc_file_object_mapping()
[PATCH REPOST 3/6] libceph: drop snapid in ceph_calc_raw_layout()
[PATCH REPOST 4/6] libceph: drop osdc from ceph_calc_raw_layout()
[PATCH REPOST 5/6] libceph: don't set flags in ceph_osdc_alloc_request()
[PATCH REPOST 6/6] libceph: don't set pages or bio in
ceph_osdc_alloc_request()
