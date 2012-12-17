From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: use RB_EMPTY_NODE() in the osd client
Date: Mon, 17 Dec 2012 12:31:29 -0600
Message-ID: <50CF6501.5070707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49877 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab2LQSb1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 13:31:27 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so9803601ieb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 10:31:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The first one of these is an update based on a previous post.
The other two are new, but basically address the same issue
in two other spots in the osd client code.

					-Alex

[PATCH 1/3] libceph: init osd->o_node in create_osd()
[PATCH 2/3] libceph: init event->node in ceph_osdc_create_event()
[PATCH 3/3] libceph: don't use rb_init_node() in
