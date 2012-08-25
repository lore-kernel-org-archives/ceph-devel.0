From: jx z <seaepigone@gmail.com>
Subject: ceph bug
Date: Sat, 25 Aug 2012 08:01:33 +0800
Message-ID: <CALJAiJWABHQCVQMVnpmNfL-+nezTVmchuBKFDPZgzrzMn-UJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59118 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850Ab2HYABe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 20:01:34 -0400
Received: by vbbff1 with SMTP id ff1so2710092vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 17:01:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hello!
When I use the CEPH, ceph-mds crashes at line 2125 in
mds/Server.cc,because the mdr->dn[0] is empty, so modify it to:
  reply_request(mdr, 0, ref,
  (req->get_op() == CEPH_MDS_OP_LOOKUP && !mdr->dn[0].empty()) ?
mdr->dn[0].back() : 0);
Is this right?

thanks


name:zhangjianxin
