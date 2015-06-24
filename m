From: =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>
Subject: [PATCH] remove unbalanced kunmap
Date: Wed, 24 Jun 2015 23:18:38 +0200
Message-ID: <1435180719-12000-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 28-113-190-109.dsl.ovh.fr ([109.190.113.28]:60119 "EHLO ariel"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751247AbbFXV0p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Jun 2015 17:26:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>

Spotted via visual inspection of the code.

Beno=C3=AEt Canet (1):
  libceph: Remove spurious kunmap() of the zero page

 net/ceph/messenger.c | 1 -
 1 file changed, 1 deletion(-)

--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
