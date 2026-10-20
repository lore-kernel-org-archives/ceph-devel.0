Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528034;
	b=nZQ4n12oZS/Ev5FGqwkgYTkD4vjARtzQ5sSBr3LuOxkbucl6rob+np1kbNQMbBWkLqsS
	 ZIE29XaHJnrz5WT1MbeTjoMk3VgSloL2joJGregY6YEhRzvnYDVDWu4JeNQdgF3aSomQv
	 fvUseHMDK/jckL9Wc9LcThzA5CXFJrGlqQ7ESSZ3U8BRNY2J35IH2ryr35hdrxhdYbiCU
	 lVDwNcsI0LEGGKCx7BljpIkE9YeEgvoR9sihV7KTXL9lsQVu5SbuOHZPu+MICPqsk77VR
	 VQ1rHAbl2ODKH08uoJDR4HHiAxFs7aDTEI+alcO7S9t+h1Z1Lpd0ONV6KNf7qchFdaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528034;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
	b=Ymm6MoqDDkdkeAp2s3dIFOkYypNXOjMMkiOQib89wNCpz9jWS5mBydyx/mFAunoq/mqE
	 d4A+Sqq3wGTTitYv3/vpAdqxpaAxuMG6b3pdGJ5/EOaN5218vI6eb213tV1Vb/VThIHSm
	 7y2paGp43ywLCX6hy93HOVkhO86T5KW87J5v1jC7gZctFr4KwAhVp4Vg/Wd2ZOdWSPS6t
	 qgtrgZXL1LsW7EAXvKD4ubwrrJD2ep7hbtECEbBworojQl5ef0Bp2cZ3zjWuReelwBWXW
	 qF3af1CZ4hG6GKrtjLsCw8j4/mUmPNK9TDWfNCPAfknLE9PW1zQuiUtenCf3se2BPPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VKslPPuq;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="PL/TEgYt";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB6606A329
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 20:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DAB6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VKslPPuq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PL/TEgYt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792528032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
	b=VKslPPuqNKjgn8iUKsg1cNg88lRnVDJAaTpzp1z4lhX401ofDN5zcOFBIc/NUxByZ/WMxe
	qTy+db8Zen6AVgjcdt+aKPTsuYzFTzAagrNTfAnwsejWgrDqg8H9o9D5X44jShQtWHduCg
	X3WCcpWOTfKo+D5gCJJt53bzY2Tn8vc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-Zd8tPQIbPsucb-tKItEw7w-1; Tue, 20 Oct 2026 20:27:05 +0000
X-MC-Unique: Zd8tPQIbPsucb-tKItEw7w-1
X-Mimecast-MFC-AGG-ID: Zd8tPQIbPsucb-tKItEw7w_1792528024
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91b529a8610so1811966d6.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792528024; x=1793132824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
        b=PL/TEgYtsmpwVYabHp5Gzx43TyRxZDYQcCFL6E3+JWQ28BKDj+fcpOM2mbzp3c9iYI
         4A7nmVWVPyaFXCCjN64EhkEDJUPY8Y3+8UYX2oi0T138zJ+oJKTJ60oa+7G4gq+/gFv2
         w7t311vSmLUwyicxUw69U5Mdofu/zeGa7Zodynn7HZHSwn7hFGI5mrhBHMBpi3cfrU9P
         OiNSIJ6EZwO3COTcmZPWIeX9MYf0UE/Z5B4l7kCH2PNe20g5E3Wfixy51wt6VaP0eVSK
         Orka+uKEqSQHbDlPRJ8LDHc+gprL50vyYloeRSphPxAMwez3YXxzqJgqaoL/g6OydAxT
         rl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528024; x=1793132824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
        b=sHJlKfnGhJ+WvCZH855F/nXTEBoh3EhXsWjUaXtnxgPyQPCCb4fwL/HmF0g4kDdDLJ
         aPTOTpv7vJaqrcYhcGz2sXQYjfcUWMF+gGVmd7iW/mfn2MvqwIWt0BSZZQ6mYCZ1EBVQ
         COlWn1xDgLK0y7s+xXpa3CKU7NA27TmvEqTnN3I8p2P9iCU6gfXJdVpTVzlAqK/seJgg
         vCXzGIaISdRKILelvL4VMyBiOLC/lTMpPTHaTyks7FRKqRY7fvj7lqdDLzREOyMkQEVd
         2Dq+WeYXST5949aSeU7J22eGkV3f64D67/uHPJE1VSBuKr39gDJKL+d+TIIY3M0punc0
         iHuQ==
X-Gm-Message-State: AFq9FYLs8HrmZah7udVr8HPLXkbkAxMiXGGU8dyBEafJYd7IZmt0DMPc
	L5kBkJFME+61u9XRcs3cBIiGildIDpQkdLuAcV+H8fUQrq71JuSF9fv0W+JqbgxYav8+nFSIJ/3
	AAo9H0WXofke5dOU0pkr2HMacxgYqMkeSEEJLiSRS6btdlAtE81AD3JrIOSMqbj4MeJMlD5dOYt
	lz3gM7WQvqLQCbn134oKIBQcP4fJiH67/MUXzmHxtawLGRQ8EJqA==
X-Gm-Gg: AYBFou08HHx1PiTnHmbtY41M8OwOIBluQiXBbfy27eJRfjDh6gUDY92WImd2esDLaUw
	pDklIl1KghDDCQkCAPjLcYh7VOZ/56mYqSmUzE0ZdI+pbBUQBG7NT93ozZXflZibnACpZ+ZMDvZ
	1QfVuho6h/MDKEpKgt8/my51zvl5uYd/SgUxtcHPNh3C1shgoKKxaEwakyiGLZD8e3xF7AzcE/k
	qluTpAk2lKPODNwr8BQbLdkah7ZPSsAEgcMtFybClq/oFsb/G+ChUZFBxWb+WRc3hLoZOxZrZNR
	npmo4v8KutV6FA656HmixYdwLE/THocD3vNMGSmtq2M6lGIoah+mX/uuKJ1o/+nWfOmmN8kq9ku
	fuZ0WuvRQgpjAZWJyjKUiY/tY2KPGJeivU+HXpy3sLfDMhnhAVRi3/tvS9Snvx2kIBJx+vOkqGV
	+avGliwxamtBvbrW86CBZcgKTCseNtY2nL9ptVpRUB+tKJ6yP6DYmtPNzmDxywdEogT0SkOTAbK
	oI=
X-Received: by 2002:a05:6214:8414:b0:91c:305:a955 with SMTP id 6a1803df08f44-91c0305a95bmr51463666d6.31.1792528024283;
        Tue, 20 Oct 2026 13:27:04 -0700 (PDT)
X-Received: by 2002:a05:6214:8414:b0:91c:305:a955 with SMTP id 6a1803df08f44-91c0305a95bmr51463206d6.31.1792528023567;
        Tue, 20 Oct 2026 13:27:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm7461436d6.3.2026.10.20.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:27:03 -0700 (PDT)
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
Subject: [PATCH v5 3/5] ceph: add subvolume quarantine wire definitions
Date: Tue, 20 Oct 2026 20:26:48 +0000
Message-Id: <774d53d774a44724c2ab8876a28cf51247bcd0c3.1792527529.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792527529.git.amarkuze@redhat.com>
References: <cover.1792527529.git.amarkuze@redhat.com>
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

