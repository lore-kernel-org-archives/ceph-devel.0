Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD850C388F7
	for <ceph-devel@archiver.kernel.org>; Tue, 10 Nov 2020 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898162076E
	for <ceph-devel@archiver.kernel.org>; Tue, 10 Nov 2020 13:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgKJNwM (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:52:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:24248 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730418AbgKJNwM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:52:12 -0500
IronPort-SDR: dZW5uAPZvKrpeQPmwXnWlEZs24HqaWRKnRgSSxG6dfQ1jK8azM9TyY0tO4lCURhQF7yzq4tvnF
 3AJvRpHDlqUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149822078"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="149822078"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 05:52:11 -0800
IronPort-SDR: 3wOwfK7UDcQ6xIqmb5PVJJTbONaDqDggbEdjetJrz0f7uHS04e3Y1DdD8Mo5kwvLAMmzW0FITF
 FRncIzbDGT0Q==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="308045158"
Received: from nstpc.sh.intel.com (HELO nstpc) ([10.239.158.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 05:52:09 -0800
Date:   Tue, 10 Nov 2020 21:52:01 +0800
From:   changcheng.liu@intel.com
To:     jlayton@kernel.org, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org
Subject: [PATCH] libceph: remove unused defined macro for port
Message-ID: <20201110135201.GA90549@nstpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

1. monitor's default port is defined by CEPH_MON_PORT
2. CEPH_PORT_START & CEPH_PORT_LAST are not needed.

Signed-off-by: Changcheng Liu <changcheng.liu@aliyun.com>

diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
index 1c1887206ffa..feff5a2dc33e 100644
--- a/include/linux/ceph/msgr.h
+++ b/include/linux/ceph/msgr.h
@@ -7,15 +7,6 @@
 
 #define CEPH_MON_PORT    6789  /* default monitor port */
 
-/*
- * client-side processes will try to bind to ports in this
- * range, simply for the benefit of tools like nmap or wireshark
- * that would like to identify the protocol.
- */
-#define CEPH_PORT_FIRST  6789
-#define CEPH_PORT_START  6800  /* non-monitors start here */
-#define CEPH_PORT_LAST   6900
-
 /*
  * tcp connection banner.  include a protocol version. and adjust
  * whenever the wire protocol changes.  try to keep this string length
-- 
2.25.1

