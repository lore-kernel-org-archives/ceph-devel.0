From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: update ceph_fs.h and related code
Date: Sat, 16 Feb 2013 11:05:24 -0600
Message-ID: <511FBC54.9060408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:56618 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab3BPRF1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:05:27 -0500
Received: by mail-qe0-f52.google.com with SMTP id 6so1870969qeb.39
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 09:05:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series updates "include/linux/ceph/ceph_fs.h" to nearly match
its user space counterpart in "src/include/ceph_fs.h".

There are still a few things that should be reconciled by updating
that user space code; that work is covered by:
    http://tracker.ceph.com/issues/4168

					-Alex

[PATCH 1/2] libceph: update ceph_fs.h
[PATCH 2/2] libceph: update ceph_mds_state_name() and ceph_mds_op_name()
