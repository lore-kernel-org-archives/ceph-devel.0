From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph: simplify ceph_osdc_alloc_request()
Date: Wed, 14 Nov 2012 10:21:56 -0600
Message-ID: <50A3C524.8070303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:53478 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161112Ab2KNQWD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:22:03 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so384912iay.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:22:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

These two patches just move a couple of things that
ceph_osdc_alloc_request() does out and into the caller.
It simplifies the function slightly, and makes it possible
for some callers to not have to supply irrelevant arguments.

					-Alex

[PATCH 1/2] libceph: don't set flags in ceph_osdc_alloc_request()
[PATCH 2/2] libceph: don't set pages or bio in ceph_osdc_alloc_request()
