From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] libceph: use cursor for incoming data
Date: Tue, 12 Mar 2013 20:04:18 -0500
Message-ID: <513FD092.2030106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:32768 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBEW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:04:22 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so530695oag.5
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:04:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series changes the incoming data path for the messenger
to use the new data item cursors.

					-Alex

[PATCH 1/4] libceph: use cursor for bio reads
[PATCH 2/4] libceph: kill ceph message bio_iter, bio_seg
[PATCH 3/4] libceph: use cursor for inbound data pages
[PATCH 4/4] libceph: get rid of read helpers
