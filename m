From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: update rados.h and related code
Date: Sat, 16 Feb 2013 10:56:22 -0600
Message-ID: <511FBA36.4020407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:59592 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab3BPQ4Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:56:24 -0500
Received: by mail-qa0-f54.google.com with SMTP id hg5so734078qab.20
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:56:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The ceph kernel and user space code bases have a few header files
in common, but because they're maintained separately they sometimes
diverge.

This series updates "include/linux/ceph/rados.h" to nearly match
its user space counterpart in "src/include/rados.h".

There are still a few things that should be reconciled by updating
that user space code; that work is covered by:
    http://tracker.ceph.com/issues/4167

					-Alex

[PATCH 1/3] libceph: update rados.h
[PATCH 2/3] libceph: add ceph_osd_state_name()
[PATCH 3/3] libceph: update ceph_osd_op_name()
