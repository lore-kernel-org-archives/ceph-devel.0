From: =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>
Subject: [PATCH] Avoid holding the zero page on slab init failure
Date: Thu, 25 Jun 2015 03:27:55 +0200
Message-ID: <1435195676-2873-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 28-113-190-109.dsl.ovh.fr ([109.190.113.28]:32944 "EHLO ariel"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753201AbbFYB14 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Jun 2015 21:27:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, elder@ieee.org, =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>

Spotted by visual inspection.

Applies on libceph: Remove spurious kunmap() of the zero page.

Beno=C3=AEt Canet (1):
  libceph: Avoid holding the zero page on ceph_msgr_slab_init errors

 net/ceph/messenger.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
