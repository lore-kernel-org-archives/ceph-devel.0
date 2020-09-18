Return-Path: <SRS0=Ugkn=C3=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B99C43465
	for <ceph-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3315C23447
	for <ceph-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600395867;
	bh=sTH9H5cLkDDkeT7+8BSnxFuTL3G71zT6DoZ7bdCP3GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bdP4dG82JLAjuQFoXULcIVaYa2AyZk3zJ/gW2OAiyLhDyIjZjPF6hqQiojR1bIT4+
	 wf9VtUF13KiDOSIS0E+9Gh3ZDRCgzhysTx98s6cxhHlMxcFRqjWZhX8fIVW2KLVJpY
	 oQXYp6Z6li8nHDFRMkqAkU3Cqj41BG8btK/y3ZQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgIRCYU (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729427AbgIRCQk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:16:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E3E23998;
        Fri, 18 Sep 2020 02:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395395;
        bh=sTH9H5cLkDDkeT7+8BSnxFuTL3G71zT6DoZ7bdCP3GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MY+MXFmquFUUauSDK0NSc3NyaF+BXMtzh25wT0CT9rRMoV8xYdlNHnuLtN43cNQeq
         JpOGfwe2YT4ngOtxT9KtOdcW2g52STPAp2viIDgG5tJfo8dFntswtQS5AVb8UuPyG9
         6xz3UJLkUJCfjAk10HPTzVpt1fJ10sDqRGAxlDsk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 84/90] ceph: fix potential race in ceph_check_caps
Date:   Thu, 17 Sep 2020 22:14:49 -0400
Message-Id: <20200918021455.2067301-84-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021455.2067301-1-sashal@kernel.org>
References: <20200918021455.2067301-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit dc3da0461cc4b76f2d0c5b12247fcb3b520edbbf ]

Nothing ensures that session will still be valid by the time we
dereference the pointer. Take and put a reference.

In principle, we should always be able to get a reference here, but
throw a warning if that's ever not the case.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index e11aacb35d6b5..cbd92dd89de16 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1807,12 +1807,24 @@ ack:
 			if (mutex_trylock(&session->s_mutex) == 0) {
 				dout("inverting session/ino locks on %p\n",
 				     session);
+				session = ceph_get_mds_session(session);
 				spin_unlock(&ci->i_ceph_lock);
 				if (took_snap_rwsem) {
 					up_read(&mdsc->snap_rwsem);
 					took_snap_rwsem = 0;
 				}
-				mutex_lock(&session->s_mutex);
+				if (session) {
+					mutex_lock(&session->s_mutex);
+					ceph_put_mds_session(session);
+				} else {
+					/*
+					 * Because we take the reference while
+					 * holding the i_ceph_lock, it should
+					 * never be NULL. Throw a warning if it
+					 * ever is.
+					 */
+					WARN_ON_ONCE(true);
+				}
 				goto retry;
 			}
 		}
-- 
2.25.1

