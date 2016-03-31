From: "Yan, Zheng" <zyan@redhat.com>
Subject: [BUG] backport commit ebeec2ef4c in ubuntu-vivid.git break cephfs
Date: Thu, 31 Mar 2016 12:06:42 +0800
Message-ID: <90A03E70-2B8B-4C29-9655-A73D7D4523D5@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbcCaEGr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 00:06:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel-team@lists.ubuntu.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

ubuntu-vivid git tree includes commit ebeec2ef4c (ceph: fix message length computation), but does not contain backport for upstream commit 1f041a89b4 (ceph: fix request time stamp encoding). This breaks cephfs kernel driver completely. Please add the later commit to your git tree.

Regards
Yan, Zheng