From: Marcus Sorensen <shadowsor@gmail.com>
Subject: [PATCH] Fix compile error when using nss libs:
Date: Fri, 22 Jul 2011 13:13:12 -0600
Message-ID: <CALFpzo4Nc3y1zps9tct5BMjHa2kYSEQyPpK=66XSRtLK7WqzBA@mail.gmail.com>
References: <1311356967-1797-1-git-send-email-shadowsor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37100 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab1GVTNN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 15:13:13 -0400
Received: by wyg8 with SMTP id 8so1693542wyg.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jul 2011 12:13:12 -0700 (PDT)
In-Reply-To: <1311356967-1797-1-git-send-email-shadowsor@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

auth/Crypto.cc:218: error: expected primary-expression before =91}=92 t=
oken
auth/Crypto.cc:218: error: expected =91;=92 before =91}=92 token

Perhaps something more is missing here but this gets things going...
apparently not used much?
---
=A0src/auth/Crypto.cc | =A0 =A01 +
=A01 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/auth/Crypto.cc b/src/auth/Crypto.cc
index 7251d09..ad256bb 100644
--- a/src/auth/Crypto.cc
+++ b/src/auth/Crypto.cc
@@ -215,6 +215,7 @@ static void nss_aes_operation(CK_ATTRIBUTE_TYPE
op, const bufferptr& secret,
=A0err_slot:
=A0 PK11_FreeSlot(slot);
=A0err:
+ =A0;
=A0}

=A0#else
--
1.7.4.1
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
