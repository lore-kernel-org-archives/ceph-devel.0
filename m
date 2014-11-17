From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 0/12] ceph: read/modify inline data support
Date: Mon, 17 Nov 2014 15:56:54 +0800
Message-ID: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKQH53 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:57:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

Hi,

This patch series allows cephfs client kernel to read/modify inline data.
When modifying a inode with inline data, inline data are always converted
to normal object first. This patch series does not support storing new data
as inline.

Regards
Yan, Zheng
