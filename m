From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 0/4] buffer alignment for erasure code SIMD
Date: Mon, 29 Sep 2014 14:34:28 +0200
Message-ID: <1411994072-18850-1-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:42034 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbaI2Mej (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 08:34:39 -0400
Received: from coburn.home.jannau.net (55d46691.access.ecotel.net [85.212.102.145])
	by soltyk.jannau.net (Postfix) with ESMTPSA id B193C3E1989
	for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 14:34:36 +0200 (CEST)
In-Reply-To: <1410796508-28711-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

reworked patchset to address the comments in https://github.com/ceph/ceph/pull/2558

variable alignment instead of the hardcoded 32-byte alignment
fixed copy and paste error in a comment
change buffer alignment for decoding too (much simpler than the encoding
changes)

I'll do a github pull request once the last make check run finishes
locally.

Also available from http://git.jannau.net/ceph.git/log/?h=buffer_align

regards

Janne

