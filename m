Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CC4E56D0
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534195; cv=none; b=RM0LtmBGvE3D9FVIK3dNFrRSWdBCNP+WxhWpSAH7Jjy5IP+qTHU8svm8W9smF3uemUhjW7mSi+1jobOgcN2FBmP9UkXhNuu06LAt5/AvI+KokJRjdkU7vTF47u3uIqXZgosYsC8gFYhwqJFnHXLfQHFNlKm4grAM1wdm/C3l2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534195; c=relaxed/simple;
	bh=rJMGxltpZAJR+jvcsSWb1sWqev/1OdfAjfWAfOaf5p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blwJgl+hlpCdfrkSBxDLM/S/5QQUrclpIJhumtKtR9+emVCddXQRgNGKGp9tkbh6cmIPN+frTrp8TvEiBHMnXnkvyM+bBq3uqkX/XBRCIWyuE0OfqyLGGj29vxTSOmAMEERm2J7wAaOGbeQyzo9MiTpukF6NYsvfwaX6p6pFFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NOPau+o7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NOPau+o7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c20e70a0962so140895466b.2
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788534191; x=1789138991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nzoyfcOHeKv+tpIRgc2EL6jwYs5rJEcNEzi5ToP2Q7A=;
        b=NOPau+o7lFVkyOQu82/0x2kbPX/Qjl1gUl2J4269yEES58mAR6CYHq3AinAEVjG1FN
         CNF/6oHiGApxRGEI8ifXSp/7t29VbxLHTwqSJOqxtOWkba5yUqVveRko4SvBqcJas6gY
         kW7npbpnfQUiX0mgOZyKcJLgEljcPv414UvlLNj3IqRg116kj1hCDIjSwex2KOT7F0/7
         eyndeizrwnR6PEhl9lEF4d7fRTEcJfgHKxDB/mlUQ7Pz78rx9Jy2xef9MhMl3hob2x9E
         esj8mFsH/YCyISw8CPjeGQdUsQ8IgoTHRY264QlGcXZms9dy/+2VPG1tPYoGT63ieHHP
         mdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534191; x=1789138991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nzoyfcOHeKv+tpIRgc2EL6jwYs5rJEcNEzi5ToP2Q7A=;
        b=kSX3HxpR6lOvixzO1bmCA5gHdRlVG/DHml5I6jJuUEXDQi9Ts9uFnHI6FsXVEtIxBA
         kolN5bzxDI6vU3CeukjJBMZ/squJ9UBaE2kjNwGvd76N/ogH1zam/EAMH4tjmOf0ZZ1U
         uIkgUQrVNbEpyVQQ2r8BktaBQ8qhl2foOarth1r/o6EbmhO10DEuKUTVIQxHndOmqOpd
         GgIm6R3xw05u0/QTzwL/ISa0q9JVWdlF5kLNmP0mqjcCxEzuf9HvR+xwaSEmK2B3YTxo
         3VejtCGcawCd4h4Nyq02Rx7OT11a8ZrRf0cXX9Ll9wLEoBoLdC7e5U0f/ugssZ4j92EX
         FJhA==
X-Forwarded-Encrypted: i=1; AKwUvByYyYv+rGYB3ckEBjSyFzEf8GIyqLrkj1nmWlhXvsqV7iy9BfFsQocFpMOsbu8PIpNw4/UbbaBA8Bjf@vger.kernel.org
X-Gm-Message-State: AFuF++mbluKYy3h7xS21CH6/1/9TQkJmcOuWBwQJ171QjWP9VM52IPAX
	Oxb6hphuLYiSFkl24y9CDdXAzeVZioAv+9dLaLMnPtDYFiLyJWZPiAF6J7fLC10AUZI=
X-Gm-Gg: AYBFou1Z4cE0H23lZR1wqedJE7vGyX1XjcZVSl13+a4hfOjsZdsWRXDo32bIJI/tbEE
	sdE7PvLK4XDXKNOPOMRRT+URN3TY4OqnVbmjmzDMcxAtk6V5ABKHYX2SE+DtYi7Gf2OV/XcQyHd
	avGnLrO6KehGmB7R4vaTX3EpoY6tOFPnlb2GNK0DGjgq2DEFk+xPhvTWKqwxSSy1p7KtaB5tX72
	BCngSuxwRiLjpVnsRp3U2cwscmHgY7DbNuwiLenJk4CYltk1K7iuGOYBkzGnYmCGkjt2JZprj6m
	ENRwCzD2DheEjO/ck7ZKcW5YyBs9ocx21OUWXBC/zpZ8kJWXm+0SIe9pglZkEkWUsxPLhMitw/Y
	DmX+2TW6EGEsS4l/UxNKpXhPEBsC5nvnSVP0O+XAI9aLJSWMAFoBO7s/jwyiAnlBjOMw+aYul9l
	081zDR6Tiau0KJkjJqCQE0u3VzGOangfTsmOq7JDrWOLLlZpo7mLZKbu21qRScm8nJmH8DqBSbE
	ZCZtzB7IkcYKDWSES0LUr/WYhesEarUwC9/kaSScwr2UsON7rep2gwotsZ5twmPuzpHsBkkm0kC
	Uw==
X-Received: by 2002:a17:906:f586:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c260c6a0e2emr465899466b.3.1788534189151;
        Fri, 04 Sep 2026 08:03:09 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c93sm122438866b.63.2026.09.04.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:03:08 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] ceph: fix use-after-free in check_new_map() after early session put
Date: Fri,  4 Sep 2026 17:03:02 +0200
Message-ID: <20260904150304.49104-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904150304.49104-1-max.kellermann@ionos.com>
References: <20260904150304.49104-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_new_map() drops mdsc->mutex while it locks a session, prepares a
reconnect, or kicks flushing caps.  A concurrent teardown can call
__unregister_session() in that window and drop the sessions[]
reference. When check_new_map() reacquires mdsc->mutex, its temporary
reference may therefore be the only reference keeping the local
variable `s` alive.

Commit ee611a750955 ("ceph: fix UAF in check_new_map() on session freed
during unlock") addressed this by taking a temporary reference around
each unlock window, but it drops that reference as soon as mdsc->mutex
is reacquired, while `s` is still in use:

  ceph_get_mds_session(s);
  mutex_unlock(&mdsc->mutex);
  mutex_lock(&s->s_mutex);
  mutex_lock(&mdsc->mutex);
  ceph_put_mds_session(s);    /* may drop the last reference */
  ceph_con_close(&s->s_con);  /* use-after-free */
  mutex_unlock(&s->s_mutex);  /* use-after-free */
  s->s_state = CEPH_MDS_SESSION_RESTARTING;

If the session was unregistered during the window, the sessions[]
reference is already gone, so this ceph_put_mds_session() frees it.

Additionally, the session could be freed while its s_mutex is locked,
which trips the WARN_ON(mutex_is_locked(&s->s_mutex)) in
ceph_put_mds_session() and then unlocks freed memory.

Fix this by holding a single reference for the whole loop iteration:
look the session up with __ceph_lookup_mds_session(), which returns it
with a reference held, and release that reference on every exit from
the loop body.  This subsumes the per-window get/put pairs, so remove
them.

Fixes: ee611a750955 ("ceph: fix UAF in check_new_map() on session freed during unlock")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note the stable maintainers: this is a fixup for ee611a750955, but the
bug has existed before; see
https://lore.kernel.org/ceph-devel/20260828174504.1247038-2-max.kellermann@ionos.com/
for a patch that applies to pre-7.2 kernel versions.
---
 fs/ceph/mds_client.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a091f77cedaf..d36a114747ae 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5860,9 +5860,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	}
 
 	for (i = 0; i < oldmap->possible_max_rank && i < mdsc->max_sessions; i++) {
-		if (!mdsc->sessions[i])
+		s = __ceph_lookup_mds_session(mdsc, i);
+		if (!s)
 			continue;
-		s = mdsc->sessions[i];
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
@@ -5875,7 +5875,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 
 		if (i >= newmap->possible_max_rank) {
 			/* force close session for stopped mds */
-			ceph_get_mds_session(s);
 			__unregister_session(mdsc, s);
 			__wake_requests(mdsc, &s->s_waiting);
 			mutex_unlock(&mdsc->mutex);
@@ -5896,15 +5895,14 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			   ceph_mdsmap_get_addr(newmap, i),
 			   sizeof(struct ceph_entity_addr))) {
 			/* just close it */
-			ceph_get_mds_session(s);
 			mutex_unlock(&mdsc->mutex);
 			mutex_lock(&s->s_mutex);
 			mutex_lock(&mdsc->mutex);
-			ceph_put_mds_session(s);
 			ceph_con_close(&s->s_con);
 			mutex_unlock(&s->s_mutex);
 			s->s_state = CEPH_MDS_SESSION_RESTARTING;
 		} else if (oldstate == newstate) {
+			ceph_put_mds_session(s);
 			continue;  /* nothing new with this mds */
 		}
 
@@ -5915,7 +5913,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		    newstate >= CEPH_MDS_STATE_RECONNECT) {
 			int rc;
 
-			ceph_get_mds_session(s);
 			mutex_unlock(&mdsc->mutex);
 			clear_bit(i, targets);
 			rc = send_mds_reconnect(mdsc, s);
@@ -5924,7 +5921,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 					       "mds%d reconnect failed: %d\n",
 					       i, rc);
 			mutex_lock(&mdsc->mutex);
-			ceph_put_mds_session(s);
 		}
 
 		/*
@@ -5937,15 +5933,14 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 				pr_info_client(cl, "mds%d recovery completed\n",
 					       s->s_mds);
 			kick_requests(mdsc, i);
-			ceph_get_mds_session(s);
 			mutex_unlock(&mdsc->mutex);
 			mutex_lock(&s->s_mutex);
 			mutex_lock(&mdsc->mutex);
-			ceph_put_mds_session(s);
 			ceph_kick_flushing_caps(mdsc, s);
 			mutex_unlock(&s->s_mutex);
 			wake_up_session_caps(s, RECONNECT);
 		}
+		ceph_put_mds_session(s);
 	}
 
 	/*
-- 
2.47.3

