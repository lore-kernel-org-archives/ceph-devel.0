Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E183EE1C4
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322727; cv=none; b=SaNBXKHTbczqflSlUfWSXhRQkm1R3svoXkeEfBHKy4eqz3WATsEpg0m+nV8CHtih3ahq10PuKkmibr9/yl3V3mzQKfhxJXET/PVALFGW/El1yp5xRvm+sIbrMi949kb0KrX19VQB7zZ4GKaEtb9FiWvm+XH3+u2lpRceIiYoCso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322727; c=relaxed/simple;
	bh=rECAuaCU+sisvFAxlz4wBECy3Fjxf/Y512+AyaTPnw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TipVNdVRGAg1UHuGRUL2y2ZHc5ZT9Cu96Q08Z3Oplj3v3K7J5t6XR2r3JagLU8VevvgHVHRLTbwGl22v5LSXKJ98gHaEA2m3S9Kkpun9Rkl79ZgLhThl4AIulsh5aAn/7LFCJx5rH/X+9Es3PpIdgj1arQOv3AaXUwAdV68HJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dcWDSv41; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dcWDSv41"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47362928f65so2608926f8f.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322697; x=1783927497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXE4QLrQi2i/4sxK4k31CjHlNpeUbWys3Ip47/zk/0g=;
        b=dcWDSv41FEqbc5AM437IG2Nnrpns/ouNT+MCc2q7ttOuF+5VXSI/xBkDgr4284Ziy9
         z+ngj9PC1AXq9tiortj7EXdzpGMF8m87NlRqhyl7pmkMMFP/+cVBTdO1cKEwF5K31/co
         Yrx9FuCMWLPHOXPhrCWhzeVlPW6JGb7RnwmWgUji/TQl7s914yXmCUM+dYO61K9iPFi4
         Mo2uvfaVkd4cmZeMb64LP40XOtV2Q/QIceErWwdY/bdqFi21BtqqR7Km1f8MM6Szc52v
         6FGqJghyw3CB67h5FWAu5TUUZSbx8dIG26LPs+yOxo8XJKs7AEkBBIxOHKSFoa3gL4rN
         +z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322697; x=1783927497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sXE4QLrQi2i/4sxK4k31CjHlNpeUbWys3Ip47/zk/0g=;
        b=e8aZEpJ/611U4N19e9tgznPD+m/u1mqxYOnUaYgiGggM3/Xm4bBKEkEeK5uLkZBVGv
         6AYfG0QqYFOglMh9M6PWN0q0LiXvMMjGoLF4Omhd6jfOKx67QBxBAbB7Mb/B1VKvEQcU
         RQRZ9Fqn+dMxbjVMg4rJvGnBsYlpjgaDzr1FiHEdy3JQNaKIkaM/d3GmBqdgUodKOXsF
         aaQqH9Z+6+OjdTugarrllGJOhwRNhuimLH8L/dAjgGGRacSKpa/faFjR1wF5km6w3CDp
         oYtTGK41bQ7Z67ukQ9MQOe4gduPM/woKB0KWBM3Rx4SFfGQX3IJ6p7jEy+Xl0QuPE+E1
         3kEw==
X-Forwarded-Encrypted: i=1; AHgh+RroW7P3Y27VZWEJPzy57Avc4Pwr0L8LNapobTZINrN8QNkiZv2RcizKJyi7JQoVBRunI1eL+KArob9P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz493kfqRQpgfMBS3UK5RyeqcclKcHKL2C77Dtm/RA2XyOXimhG
	suOfD02+R8pXxG5sVvQz2ao3kGZACSAJUuS1ynjKxF+6QFbR+gyZ4hBy4XcxbTmGsj8=
X-Gm-Gg: AfdE7ck5IU1IC2t/jHqbrY+G/mX87Enq3mtveiPz0/xBe6Owwu7O9DNToYWmAuOdf9a
	N3om0w2eKE+UvniaSm/uoHpljZXhxK+AJCBFwnRfYSYUJsQHVKSge8JRhOxDohG5uYj7YlHn34P
	ptrPtX7f8SnoyajJl4qqzCrWRYCN/RMkXY2qoSoZM7Gk/uu3OL+Vm59uDhwBiPFl4yiF9VLoaKT
	GexCpdrVzRljOH8Yn5fz9tOcDgQz6XNBh14KmQ/89jdfKPk2N890SMQ4KVLNlDtlhjxdlB52iYh
	cDd/7RSmcH6PT0qXIHIZrlRVGDk8vxJjRspf0KRaj5W4WIU716muq+J/vJPz+sMTdOnW6pfFv9/
	2ujGBZ+MXQAkNfpQ/81Ywsub5K32jjnDQgkVdg9iotMhMfQzvWmV5+6tKknnvrMEZ+nk9uyFtq5
	dptZCtNl3fTLajeBH0XIetvKn8OYq2jWoOz6Pomy/9HjIf4GK/M9h2zqMFb2GL1DaIs5a9AVwEy
	m0Jklzmi4JV63vs
X-Received: by 2002:a5d:5903:0:b0:475:d10d:b582 with SMTP id ffacd0b85a97d-47aadb1646fmr8650070f8f.39.1783322696990;
        Mon, 06 Jul 2026 00:24:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:24:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 01/18] fs/ceph/super: remove unused field `i_cap_migration_resv`
Date: Mon,  6 Jul 2026 09:24:32 +0200
Message-ID: <20260706072450.3920010-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706072450.3920010-1-max.kellermann@ionos.com>
References: <20260706072450.3920010-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field was added 17 years ago by commit de57606c23afd ("ceph:
client types") but it was never used.

This reduces the size of `struct ceph_inode_info` by 8 bytes.

Fixes: de57606c23afd ("ceph: client types")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1d6aab060780..3cbd320b49a8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -450,7 +450,6 @@ struct ceph_inode_info {
 	wait_queue_head_t i_cap_wq;      /* threads waiting on a capability */
 	unsigned long i_hold_caps_max; /* jiffies */
 	struct list_head i_cap_delay_list;  /* for delayed cap release to mds */
-	struct ceph_cap_reservation i_cap_migration_resv;
 	struct list_head i_cap_snaps;   /* snapped state pending flush to mds */
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
-- 
2.47.3

