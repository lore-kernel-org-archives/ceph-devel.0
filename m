Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE43955FA
	for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939121; cv=none; b=alaxfJauI/fo2YWa5Z3Jpeqy2dgdsnuHYvcVlDBZYAEmTtXBcYvwVcdw6aneUbS1cQyCVgBw/grQ/GOibi8PcRvveLxzYt8HZwrigkVmbOl95NAFDHJu5HlhqfwOZaFwc/z0jJsNYtqFBWcgabgQFyBgEhqYIlFkBUPd2f/uT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939121; c=relaxed/simple;
	bh=htZYsknmaKglxEdP11yJuMBy0iYQlKpuXbCq7oMS5fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzSAglT3KpTAsDEOQCVkVz38P9oLzloymtGX2TKOJKE4Jl/rMbP4MQ4Xk1uVMJfjQiawZqcjML0eWM/pfFq+Z0Ih9cr4Kwbj/XhIXiKbsP9rtKXK5H2VFkxYwXAYfgozYNHQogA37xcIsgSqA4Hvu7shp0xWqp6sxD6dny4yqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e06FYy4/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e06FYy4/"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482e5733a5aso831783f8f.0
        for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2026 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787939113; x=1788543913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldhPBd6gTP49jgwzRdZBbN0z+sgukl9cHOVoHnp8Uvo=;
        b=e06FYy4/Zwtrh3EYhn7yN77Fh5F/8wpSLc/5/0XIrUBOWiRQmmh3D9PaXMyHvpwWHo
         ILKODPj6DSsYFolMMn3rK06fAVQgXdxX1lQ+Uiu586GmdBQaOEf94IvqHNeWafBdHFPG
         Vo6s8TXEV4gUIHS1QLl4Ejx2fwU/ixu46hKsPLsmF3LFhMa39XmdMHfH9LxFsmA1hkut
         y9GOUVjDE2uQI5XgcYm+nd1Q3Mgy+gbHgFgHSeBDBQEovn122rDTuP2GjkUlywRF2znx
         XrqsNYws1WrUbaJtSj3tUE/bX7bAVUxBWiqvI+PZx0s+t1xC5rUVSrZ++jSDJrmPUc9C
         xDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939113; x=1788543913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ldhPBd6gTP49jgwzRdZBbN0z+sgukl9cHOVoHnp8Uvo=;
        b=YkjOtRHkBMyYCcFmzABM4rZDgx+es60wqQV3B8onMY4rirU2FOB8CtnYzQQ/5F7y9h
         cGRVi6lDArdcPanf5CukaKLM+baoXinf/0D/+F6SbHcC6QY+GW4pHE6ODmbqNdNuuiJg
         XOu4t2m0wkr7Dz5yKCwFGwWd3GkdzfxI35F2RPrAqjS0RV8AyF+Y0ybRHoB7suagXB+V
         NKwNCPA+LcGRQDAuhFHyhIIOEGE3hHPoHuk3kQ5J08P2MjaeJO2uLAJJEeJ+P4EiV2td
         xBJtsgEp6ymFxRdiqv6zC5dK6R/+r/weiM56NsBYcpHlDvuCfBrRPDp82obMEQAUd+RL
         5U1A==
X-Forwarded-Encrypted: i=1; AHgh+RpriaPU8lu9VTBxZG7iOqCZSuhlLPq8eHtmAMQUeL+TWUGfYvuujRIKhe1QCqptuXeCepDgJI4z7l8F@vger.kernel.org
X-Gm-Message-State: AFuF++nWmPa69OvN0/yK9BQg+HFNYYxSBbFyvR9mIRW4HVRGk/LWFZS5
	WFSllpVDj06D5zdusgXt9SfMiqZKxUJpscYhbf+uDCk/6afaYL2JCJEdz1iyByuHC4g=
X-Gm-Gg: AR+sD13H5hW/bYBkA90kIcmiVi6jpzotjOCZyjykYDZ8GWf/GQxpwqjAnRgo2m9l3qd
	6ZAPIsnTcdWA6hS6vVWEU15d5e2VulnoikdpdBNYfdTW5xkRfmyqU37WDCuclBOZNOPty7154dg
	JNqAG63+X+H9OgMqVyvfNUjjskXr2dpTNo4ipjzd8qyJ/qwFe6XDN6O6vyr0nIVhOeV+oSLUM93
	ri7OVgcuwl24646kSBjXuc7NqdaEilQa0yNUG7KST9o0e2FoQpmrKq4C5/uMYFUgr1w+LVI4DDw
	ENgbHkE8oFdDvGf03pIv8+dA/Fb8NmgETAGMbpvo3uJfhrFmMuupJOQ5qQuAlTyGMb3SfmYCrVN
	LBI13JAsuSf95v5lgmqUb5mVwcP+XDdLLfw5Ku5GTCaoAUHch7S2f6wNl2n0r6I/OfhgSD+6SnP
	IagmY56/8ZC2pUWiKnaWjLuYikjX4t2v81obH3HePVjEtFKiw/QMn4zuEwRMrxclq3T3yunIhiI
	J+GB+dIcz40Hmmk6vIAYlz5S7dBHD+qL4V1vktB/dAvQjblhYD3NmROu5zpGXIkviG9W1IIDYA=
X-Received: by 2002:a05:6000:18a6:b0:482:ea08:8c97 with SMTP id ffacd0b85a97d-482f79cb828mr11667503f8f.2.1787939113387;
        Fri, 28 Aug 2026 10:45:13 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2794dsm5480678f8f.25.2026.08.28.10.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 10:45:13 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 1/3] ceph/mds_client: pin sessions while checking a new MDS map
Date: Fri, 28 Aug 2026 19:45:02 +0200
Message-ID: <20260828174504.1247038-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828174504.1247038-1-max.kellermann@ionos.com>
References: <20260828174504.1247038-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_new_map() drops `mdsc->mutex` while it locks a session, prepares
a reconnect, or cleans up caps.  A concurrent teardown can unregister
and release a session, invalidating check_new_map()'s local variable
`s`.

Fix this by taking a temporary session reference using
__ceph_lookup_mds_session() instead of accessing the `sessions[]`
array directly.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3c692ad02c85..160f23e2edd3 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5798,9 +5798,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	}
 
 	for (i = 0; i < oldmap->possible_max_rank && i < mdsc->max_sessions; i++) {
-		if (!mdsc->sessions[i])
+		s = __ceph_lookup_mds_session(mdsc, i);
+		if (!s)
 			continue;
-		s = mdsc->sessions[i];
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
@@ -5813,7 +5813,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 
 		if (i >= newmap->possible_max_rank) {
 			/* force close session for stopped mds */
-			ceph_get_mds_session(s);
 			__unregister_session(mdsc, s);
 			__wake_requests(mdsc, &s->s_waiting);
 			mutex_unlock(&mdsc->mutex);
@@ -5841,6 +5840,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			mutex_unlock(&s->s_mutex);
 			s->s_state = CEPH_MDS_SESSION_RESTARTING;
 		} else if (oldstate == newstate) {
+			ceph_put_mds_session(s);
 			continue;  /* nothing new with this mds */
 		}
 
@@ -5878,6 +5878,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			mutex_unlock(&s->s_mutex);
 			wake_up_session_caps(s, RECONNECT);
 		}
+		ceph_put_mds_session(s);
 	}
 
 	/*
-- 
2.47.3

