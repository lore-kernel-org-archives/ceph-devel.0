From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 0/4] fix ceph_get_caps() bugs
Date: Tue, 10 Mar 2020 19:34:17 +0800
Message-ID: <20200310113421.174873-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39662 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726211AbgCJLee (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:34:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

Yan, Zheng (4):
  ceph: cleanup return error of try_get_cap_refs()
  ceph: request new max size only when there is auth cap
  ceph: don't skip updating wanted caps when cap is stale
  ceph: wait for async creating inode before requesting new max size

 fs/ceph/caps.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

--=20
2.21.1
