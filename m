Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458B3B19AC
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543230; cv=none; b=egoIkRGOtsgaqeXPo3Bx4pr3vmZQ/1eI/bPJ/WrHxcFG+xtJl4q0gdbDpalcFpKMVuUMIfEB0IeMm1y8BBJ8uNPc3ObX5trzjgGx30fiy6S78ZXrLCZUzFRESjhK/Cb+sXq/IzWJJDdTCr7dH+Z3PMmL8t41ZHgz7MdKBmlxK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543230; c=relaxed/simple;
	bh=kaPZErsK3KYzi0e3RLe7W7LF9YGVqnv7yq+SFX4ufLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+xEAinARHM7duLKi7fAKBptdZ/Y4bGQgi0fTPRCuoQuB8DV/3QxHA5bbZ9uC7WJoYFxZlIU4X9nyUFfP+CPblvmYR+Na66WncpjhvjhmEWIAzVG5N362Xqojbo6g2QDn0y1LneEPW6rodIad933MH/u0txtNroAhYW4uIxTmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JrAdci/E; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JrAdci/E"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47df440fcd5so415642f8f.3
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jul 2026 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783543227; x=1784148027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7x8+X06pvsKgsbhNKOh2cLRprWp7S1kFPDrLN1+nS8=;
        b=JrAdci/ES0cT4TfTF/9BpXKgP/Urg2tUmHIUOgVnukKHeASg8G15TfzYdIg+kUAFTl
         AAIe2PmSVdTIby8UCeWXoAo6XZv46qVPTEHH7yBKBYotYHNg2vi92acaKn7WTzLBsptv
         sD/RkIyHObi6OE+/8SVqiaudy2meETgTc6Tfb/2/O2KKmbWP+Ag/jwy86K1v4YheupxO
         Dh7hOZHVAOGS1d5WFe0pyrVEOW9s5izUMIUn/znVuVmiSlGwP2mfepvUXLyBCT2UkVIS
         7V12oJX/l6E/73g7isRwcS3HpVW5UBeDbuJF83twPMuLFo8ltKn96Tcpd6RL/twwQkb+
         NoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783543227; x=1784148027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7x8+X06pvsKgsbhNKOh2cLRprWp7S1kFPDrLN1+nS8=;
        b=Vp5gEzQFXVpbpIu4CVIsBgl3DV5EiW3extjs51cEGqV9sakPBjWzrmKu1DPQrc6FdT
         y0qfm9tLVDtN66hoooGxO+uJbxiPfGj30+MC5KljhUcaS6c6zI5TXD4U9PdJSe/zUtNb
         WdnC1ATYWc/647Y4axY2vxubakhoeHpm6wMu8ZfyrIi7nDJ2mg2rFAUea50/oNErNT7d
         Pud5xrgta6eUqsZJA8sEx02LB8PhlbAPDfdM20Gc/vqlCYXv4TK/b2WM3nsdIJmpMZyS
         973tmNtkkxI0/nEbR75kOtp9pkmaw525wzHsdnxland0i5UrFJ6jLO94sqBXECmBd0Fo
         nfWQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTDgPw1OR9ShULPH75audLUUroHJRVCoa2iMszHi30TgO2EolaOpfCtETdlLORemuwMvrqbHaQwneD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8S42zq5yqs0kr/budBGf82/LUFYSdWnFyDHOs0O0l94JWqjkT
	CpKyvjiNyqLE7lCCqn/D5D9x0h2afkLf31Tokpi02GktIDwPZy5Xr4J8rWMaJt0LsfdB7MWo4N+
	SwndAg7M=
X-Gm-Gg: AfdE7ckjqY1VkG8GZZ4yx7S6z+iRztEsV5IRKJtWOEAvtulvnjYMd4rde5cfLeFvWU4
	9u69QQcJesWbz2o6Xd4+QfU4SR9hfJvh7mTKbQDYtBOJ1gNBEsixomCS7NLM1zohkYB5KEbBOQq
	aryL8f7nWJWWOhI+msBMb4nKw//ASWPZVvv+B08EdUaSWcE5u1GpYkX++k0oAJ1JmUbFy/ojUIl
	N2tfwXVYO9lkuMXYLHpEJoA0tLnDN4tGwc+gqGrpV/TRvJZsm7jNGlL5s4EE8coHXhWqeS91sIf
	zFVssGksZE6g1tgFUA8nDAoWPFlj2RhccPiOZbBF/ucy2MhgNzc+iCEjczBrVIeHavSBRxhEgP0
	3NJS05jccT4s7416F7TBI0/+rbxN+02JPWpK7uRCXbkVpY8yixhUAQiADlgXT52QoxcHy9El6pi
	tGi8Yyd4VQsMp4cVMLueApIAdbb5xMLIlUXk4C13b8PxJ8mo8M6pZejjiW7NTzEiS/MSmEPZNDu
	C0GpXcGY83ZdxLV
X-Received: by 2002:a05:6000:2f86:b0:475:f100:360d with SMTP id ffacd0b85a97d-47df0824681mr4713745f8f.60.1783543227502;
        Wed, 08 Jul 2026 13:40:27 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9b4d850dsm46784459f8f.0.2026.07.08.13.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 13:40:27 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/mds_client: drop mdsc->mutex before decoding the MDS reply
Date: Wed,  8 Jul 2026 22:40:22 +0200
Message-ID: <20260708204022.263578-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_reply() held `mdsc->mutex` across parse_reply_info(),
i.e. across the full decode of the reply message.  For large replies
(a big readdir allocates and parses many dir_entries), this can take a
while and blocks ceph_mdsc_submit_request() calls meanwhile.

The decode does not need `mdsc->mutex`: parse_reply_info() mostly
fills the request's `r_reply_info`.  Create replies may also add
delegated inode numbers to the session xarray, but that xarray is
protected by its own lock and is not serialized by `mdsc->mutex`
today.  By the time we reach parse_reply_info(), all
`mdsc->mutex`-protected state has already been updated under the lock
(the request has either been unregistered (safe reply) or added to the
session's unsafe list (unsafe reply)) and the request is pinned by the
reference taken in lookup_get_request().

Drop `mdsc->mutex` before calling parse_reply_info() so reply decoding
no longer blocks request submission.  This only widens the existing
unlocked window that already covers the heavier ceph_fill_trace() /
ceph_readdir_prepopulate() processing, so no new races are introduced.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 853bf698b356..bb8570d31208 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4089,13 +4089,19 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		list_add_tail(&req->r_unsafe_item, &req->r_session->s_unsafe);
 	}
 
+	/*
+	 * Now that all mutex-protected state has been updated above
+	 * (the request has been unregistered or added to the
+	 * session's unsafe list), we can unlock it.
+	 */
+	mutex_unlock(&mdsc->mutex);
+
 	doutc(cl, "tid %lld result %d\n", tid, result);
 	if (test_bit(CEPHFS_FEATURE_REPLY_ENCODING, &session->s_features))
 		err = parse_reply_info(session, msg, req, (u64)-1);
 	else
 		err = parse_reply_info(session, msg, req,
 				       session->s_con.peer_features);
-	mutex_unlock(&mdsc->mutex);
 
 	/* Must find target inode outside of mutexes to avoid deadlocks */
 	rinfo = &req->r_reply_info;
-- 
2.47.3

