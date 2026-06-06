Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9AE30C140
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jun 2026 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772453; cv=none; b=js84jx+dpPG0/M8qXcs1XkGWDj2n8dMERKGtJmo7Mciw21tICllJdRPvY0Qwyhi8cHxjC/KtCX3W/26pN3Gw11MqGe+arOR02SSCH76W6rT0/LMP08drC7Bomz9Xf7DA/lxDmn578fxNM8uiHToHNQZTcVn4Q0XaK3E0CCOil/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772453; c=relaxed/simple;
	bh=G/p1NhEroBtnSctFQHymP/5qrkJPeSykOHnFiiTppw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zen4XI2DIhBSq/tZaLeFweAa/U2Ikwz8QgzRW+A6fJMMdz/r0WpBiLg0KPTLLHqawQ8QKMDL3endBE2FJ9n9TWAf+f6SlTu7lcgLHvHQlcNf4Hg6/0/AHJGehdic15mfS3ZjW1ER7FutCuNB9vw1os6oHXkKMZm+5JA8ltn/1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc942fNb; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc942fNb"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51778077b28so34479821cf.1
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2026 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780772451; x=1781377251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaXCfO1Mwv1k6w0bpsL9U/18c9DbefbI9xxe01qkWag=;
        b=dc942fNbfiwz5uya30TH7a0o+tvcE7h1eHvwTOCoqH0X2h4BUEI7pTt3iYFeGC6xVK
         tmJHLXEXQ/8QTaunP0KI27I0A7WW43EoLgWMBCbKAbWwBrwBm2aPwv9tfDuVsbB1xXQq
         ukG/lB+S2sCCTiD/HCWUeaV7E/EBUqzjdPtmpffH2uwRrtLQFLBdUNJikE70+g4jhhTm
         YezlLO82GRahax3uGKXiVxPAloaurYLm1Qk9nKb8OEGIIvEwJPCF43jtmTNpZDg6K4/r
         TIMSzPAXvfDme9Jv0xBa6dHTUsAFDENtInRx/uIR6Sd+NNGPlu8NhEyjAZv1TNGpb3G1
         jvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780772451; x=1781377251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LaXCfO1Mwv1k6w0bpsL9U/18c9DbefbI9xxe01qkWag=;
        b=qVW4QZ6u28nrRB9/dDgkAH0H0M1UlQP61OZy99o43nVFfW4tr6VC7dFDyrm/TJVYG/
         5rwsic59EopVdE+HRGH217kMxgY9MIPzo1OkU1drVIi3YoQlu2FWJow3SuY1T9+5jIkm
         D4cqRFNxX+NiFpi6jEx6tl2wWnlBcccnIFAg9bAu5NVaX/IYgWDS2eLhzGgF28bhxdsA
         STgVywyes+NT+DwabjVeHXcEwzpUxwbDZnhY3a6HMwKBTt+2hGzV4/BPps8Wnyr//Nkm
         rJGoDlYBoJO9KIXKb1egN1x8ZfXtKCjweadmJHzlL6NFXyQ+XYYtXbyxUdRqoHyiZt3I
         w6BQ==
X-Gm-Message-State: AOJu0YycQYi5q9xpt/64C4DRvbuYRyeMR5F+wrUUUwXikbdGbnMakhYg
	DKUVdHTIzkL13e1vAoc9nsvHJPO2wBjneSPGFnR0a2AC3vbky5F2bDA4Z6zvzsQYuck=
X-Gm-Gg: Acq92OE5UWkJFpFyI13PFDZ33EqzlqhwMF2QzI9dtXoI7Rg0NsSaoO0wPGidoLXQaSw
	SldTjoRls8KYWP81lVuKI0f9dZNOozG9YVPPKVkESpLPOtWAbVSIPFx9EuhT7cn81rwHYR9f7Ux
	VUuHPeB6GUVQg0MQyi5Ojj8EtXoHb16Gl9LUC+0Xp4iquj1+83CXSevLurzXd26cswdnLg0kVwQ
	Yiup1uDfaKbctNYENRLeePhaAN6cB6iW24V4Nc9GwiAok3UNqPTo6r0iblvp/k4K4NniBYKVrXk
	NXPCRLpPEnDnGSIUOX4MbJcWWnLZW7MKy6DkCDynw9KmL02ezxtia15eflY/abJyoHqU60XlwFD
	O0366q2H90G5D6hO7luEhy4q+4GWONPNjkVjLFaDyhB7o7ZgFU1voH6nHcx5fGgwJ/DsWQJxAzP
	D9WCUktj2T4bu5ZV6NYOFZF7vO4SW2dzFUQg7FZHAetSG1BdsjIEE6UiQrHAoqY8JfyJafFNnlG
	xzHbZk8vPJkV/JkofGkK94G4F9uZEU=
X-Received: by 2002:a05:622a:411:b0:517:6351:b401 with SMTP id d75a77b69052e-51795c0763fmr137402321cf.44.1780772447684;
        Sat, 06 Jun 2026 12:00:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5179dd9d908sm40084581cf.15.2026.06.06.12.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:00:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ceph: bound MDSCapAuth path and fs_name decode in handle_session()
Date: Sat,  6 Jun 2026 15:00:23 -0400
Message-ID: <e98390a93a237d89de33982707c4af15cf6a3923.1780766417.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780766417.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com> <cover.1780766417.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

handle_session() decodes the MDSCapAuth records carried by a
CEPH_SESSION_OPEN message (msg_version >= 6). For each record the
match.path and match.fs_name byte strings are read by first decoding a
32-bit length and then copying that many bytes with the bare
ceph_decode_copy(). Unlike the surrounding fields, which all use the
_safe decode variants, these two copies are not preceded by a
ceph_decode_need() bounds check, and the enclosing MDSCapAuth and
MDSCapMatch struct_len fields are skipped rather than enforced as an
upper bound. A length larger than the bytes remaining in the message
front makes ceph_decode_copy() read past the end of the front buffer.

The message front is a dedicated allocation (ceph_msg_new2() ->
kvmalloc), so the over-read runs off that object. A malicious or
compromised MDS can trigger this with the first post-connect message on
mount, with no client-side user interaction; under KASAN it is reported
as a slab-out-of-bounds read in handle_session().

Impact: a malicious MDS can force the kernel client to read up to 4 GiB
past the message front allocation during session setup, crashing the
client (out-of-bounds read).

Switch both copies to ceph_decode_copy_safe(), which performs the
ceph_decode_need() bounds check before the copy and branches to the
existing bad label, matching the rest of the decoder and the error path
that frees the partially decoded cap_auths array.

Fixes: 1d17de9534cb ("ceph: save cap_auths in MDS client when session is opened")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
v2:
- Add Reviewed-by from Viacheslav Dubeyko.

 fs/ceph/mds_client.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ed17e0023705e..4f36ac73305dc 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4318,7 +4318,9 @@ static void handle_session(struct ceph_mds_session *session,
 					pr_err_client(cl, "No memory for path\n");
 					goto fail;
 				}
-				ceph_decode_copy(&p, cap_auths[i].match.path, _len);
+				ceph_decode_copy_safe(&p, end,
+						      cap_auths[i].match.path,
+						      _len, bad);
 
 				/* Remove the tailing '/' */
 				while (_len && cap_auths[i].match.path[_len - 1] == '/') {
@@ -4335,7 +4337,9 @@ static void handle_session(struct ceph_mds_session *session,
 					pr_err_client(cl, "No memory for fs_name\n");
 					goto fail;
 				}
-				ceph_decode_copy(&p, cap_auths[i].match.fs_name, _len);
+				ceph_decode_copy_safe(&p, end,
+						      cap_auths[i].match.fs_name,
+						      _len, bad);
 			}
 
 			ceph_decode_8_safe(&p, end, cap_auths[i].match.root_squash, bad);
-- 
2.53.0
