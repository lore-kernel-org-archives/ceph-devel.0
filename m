Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500771;
	b=uDuhZuiDAeNSwrr6UlyNtp/myiREguFPC9rqTjLQLWhTLzguXhRhF5pPY7R8uX9x97xu
	 8q3/ded8uZdEjjb1H4J+SPgZqDo409xFh2ti0SdLd9si3cJtSHhabSMlAlWUWUrx1Zmma
	 wIWJrUuskp0FciRESVgDK8ZC6AH/Dhn4HnFA4FJwpBUp3yWYrL9llFHJex5ItALTYFyLK
	 JRCQPK3vjedzlbWH6nXReSt6Q2JrzmD33812HR1NL5U6Yq83ZVlzq+f4578G86J6BG6we
	 OzAkedE5yGmdtVoGeN8ppf2K5smHGY1ljeRH0Iii1yMSMWgR/A0XO2YT7lh4R3NfWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500771;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
	b=b2K1MkWYSvmeFQTPGKpFI4wgeNF8sN9jzvAoQvuCcDdhVfO3bhh4OUcXbeZNkLIC2qdT
	 vanjAxsKFFW+tQZGxYR9/MHfq6aW3KBowdkV9cXB9WRhsG48qjWJ7hRRZ/0JR/8U6S+VH
	 3JnNhoZXEfSCdt1efehChVU8hfaybiDc05Fv9jHrXv45sAFAGsei7UK6wvbYgqFl3OTVg
	 lyvOZ4qN+zyWfe1Z5P9wllH5QmGWheZzteM+rmK00Y6Bi1fRmvHOay1RzNV51m9xio8Hp
	 s3yfOqKMVXsuKPWM2ElIorWTlEnMSI02YGT9snxYESHF413z/8kkYOeItRJJ7kfzGRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fp9wry7g;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Sxz25ht1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DA606A32F
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 12:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 957DA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fp9wry7g;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Sxz25ht1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792500769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
	b=fp9wry7grFgyi5F9HL4+eNyp8C2ZBzYI0NA7yUDeGXzdO2pPpiuMQ+LmSHub6Szp01KkkO
	fmv9JMCgihWB7GiHQEdY+j6mcJfMFnggg3NQ1ymEPyD0Js/YRYEcAPXIsmHUiIkp5cZlx5
	jRIrKE70w+R98EamRXBLXI8QuSJZcMc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ubNP-e45OAKJe66rgqL4UQ-1; Tue, 20 Oct 2026 12:52:46 +0000
X-MC-Unique: ubNP-e45OAKJe66rgqL4UQ-1
X-Mimecast-MFC-AGG-ID: ubNP-e45OAKJe66rgqL4UQ_1792500765
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1c285faebso3395117a12.2
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792500765; x=1793105565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
        b=Sxz25ht1Di0z0S0fBCiVHyEB+3U8FDm7nOw6Dp2jL7y/hbR6XGpeZLHl4bYl0D43KI
         tAnRtDQYY3auDzClqzE28MPikFSPaYWUMQJENFSFBcmqt4Fhe+mx0Uolc2+nhLW6B81g
         fiTiHFeYs74ZT+tYm6/6pV9vJE6yKouKnm/NSZlkDlQhDL98LqrfbRc1GQ3kjcoBvbPh
         9hskZZD396IG0fWkb1cp9u+MCrQCWMPmQou0fj6lr5WcyTaWCWShgY3fZk60RxbPZULd
         OFdrcP1TBpDVJZNLjDFkgykxyQ1Cit41kDMdhVr9mvia6KqPTGUy+wFQygToifbBaTAt
         I/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500765; x=1793105565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
        b=DhX032XbWyGqY3s9oYToOfEFOLedQHICMjq3wLMQEjjhRvOkAI6mOHBrkydFaYc4OK
         RMUW80aXyiUyk6KFIRsxbuhYIIPgZb22YMWNFO7+WbIU7w1JjF6cqag79Tl5iCp2yAFO
         BnRew6/oWt9IMSqA3shV0EDvyZBA27av3y0Ygr/RkYFZqxShyy+zCZiuJymHhhNKt+cl
         2z9w0gAIy3wxkFg31/I/ms28+IXxvg7EExPqtzFsgOa8mpowsCrec4ttyKE5+SzfgSgr
         8TFZHvTxRzpUOt4riXkocGsgHsngwtpUuoZqAdQy2EMkwgTvp8wl4BsNK59YcaEE4TeH
         0ksw==
X-Gm-Message-State: AFq9FYLwnrOy7rOfu4UnRSmBkrD10Vc8vtsfqUyDD4AetZK68pMzUYZr
	GdLqGArgWCj1gINQKaT7wkUGRFgByD0wPd3J8hdyDk74l62S6iVhm3QGCg+lq9pWH8VOxHHrgu5
	3jgVWMk/ydg/FDTBPCYq+TM6BAgVfzLg1VnaYIZuaAWqdr0NLZ+O5Hn+i+jVYzczaukmUX1m4TY
	MXlJr4SfSb/7dUIoipbxWX41TtjAcXKeeDycoTP23euewEkVMIPw==
X-Gm-Gg: AYBFou2uVX7JTWcZYQsRBIb/CooDk8bcIDncirp4fxbJbHr/1jwdRRyhKMtgUkalE04
	oPdUM8ktV0N11GzRlyQ2+lR1tyMOINbYCOfghGzBncLife6H3t1P7t1atMcUSrGwvEpZcoirYyM
	PlHXCUHnRw2xScJR2VICTGxj4ElcP7rypCyG/+jWyidOgDHctUBbH//WMBqrRwF1IXUACPkcI8e
	g+yNu1Z++w2QRl3W2tLDfpnLw228vvSP17eoI1c7FNywO653PVxkwLLKhIIHrIQmALHyi08HkJp
	BD3EU3A7Ayo1aC+mT/nGlf85ja92X82k3MV0k5BA4cBpPKwmTk0rgTOoNnOGdVHa2ITfhcbYaew
	3e8T5lYLfeNzvlxnUUNt5klZh8RjHrnje8ffGNJ2ONXa+mwbK+Va0xu5V383kpq/qmqSk8ohRBS
	Yhhjvid57EhENw4jhKCOCEgf+NtHtBFkOKR8buiT/3R7Lq9I+rZ8hfxJx3DTUhvLXNA6tiFzAcK
	XU=
X-Received: by 2002:a05:6402:1ed3:b0:6a9:9766:59ad with SMTP id 4fb4d7f45d1cf-6b3a81d9dadmr7485401a12.43.1792500765248;
        Tue, 20 Oct 2026 05:52:45 -0700 (PDT)
X-Received: by 2002:a05:6402:1ed3:b0:6a9:9766:59ad with SMTP id 4fb4d7f45d1cf-6b3a81d9dadmr7485370a12.43.1792500764752;
        Tue, 20 Oct 2026 05:52:44 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b3c74eb8a7sm2982781a12.2.2026.10.20.05.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:52:44 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] ceph: add subvolume quarantine wire definitions
Date: Tue, 20 Oct 2026 12:52:35 +0000
Message-Id: <774d53d774a44724c2ab8876a28cf51247bcd0c3.1792498351.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792498351.git.amarkuze@redhat.com>
References: <cover.1792498351.git.amarkuze@redhat.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MDS revokes a quarantined subvolume's caps to PIN and reports
-CEPH_EQUARANTINED in MClientCaps v14. This wire errno is 1000 and
must be translated to EACCES before returning it to applications.
When quarantine is lifted, MQuarantineDisable identifies the inode
whose local mark can be cleared.

Add the errno, message type and packed disable payload, and teach
ceph_msg_type_name() the message name. Advertise the session feature
only after the client can enforce quarantine on cached access.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/ceph_fs.h | 13 +++++++++++++
 net/ceph/ceph_common.c       |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index d70bbce1a1b2..5afccfa891cb 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -154,6 +154,7 @@ const char *ceph_con_mode_name(int mode);
 #define CEPH_MSG_CLIENT_SNAP            0x312
 #define CEPH_MSG_CLIENT_CAPRELEASE      0x313
 #define CEPH_MSG_CLIENT_QUOTA           0x314
+#define CEPH_MSG_CLIENT_QUARANTINE_DISABLE 0x315
 
 /* pool ops */
 #define CEPH_MSG_POOLOP_REPLY           48
@@ -921,4 +922,16 @@ struct ceph_mds_quota {
 	__le64 max_files;	/* quota max. files */
 } __attribute__ ((packed));
 
+/*
+ * Cap oserrno used by the MDS when a subvolume is quarantined.
+ * This is not a VFS errno; applications see -EACCES.
+ */
+#define CEPH_EQUARANTINED	1000
+
+/* MDS -> client: quarantine lifted for one inode (ino, oserrno). */
+struct ceph_mds_quarantine_disable {
+	__le64 ino;
+	__le32 oserrno;
+} __packed;
+
 #endif
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 67e88f30409d..cc3d21fd7d5b 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -83,6 +83,8 @@ const char *ceph_msg_type_name(int type)
 	case CEPH_MSG_CLIENT_CAPS: return "client_caps";
 	case CEPH_MSG_CLIENT_CAPRELEASE: return "client_cap_release";
 	case CEPH_MSG_CLIENT_QUOTA: return "client_quota";
+	case CEPH_MSG_CLIENT_QUARANTINE_DISABLE:
+		return "client_quarantine_disable";
 	case CEPH_MSG_CLIENT_SNAP: return "client_snap";
 	case CEPH_MSG_CLIENT_LEASE: return "client_lease";
 	case CEPH_MSG_POOLOP_REPLY: return "poolop_reply";

