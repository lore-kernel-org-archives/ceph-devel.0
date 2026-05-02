Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B923D7F0
	for <ceph-devel@vger.kernel.org>; Sat,  2 May 2026 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699375; cv=none; b=UgsA47K8KFWbEgRYxA5Wtjz784zRn92zG4XZuHGhz7h9B7oxWl/6IJ/Sdi/HNY3394pW+vkVdTkrUxjCHqUK5492GrhJw9e+KZqWx3oppe+5znch31in/izIebUe9aaYoSQ46Iro/CEvQEbHokEHQ2z/PFs5filqsdaJwqyl+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699375; c=relaxed/simple;
	bh=klkuNC9n1JBOD9ygDaA6GEg4ImuFQZg/JhDtWlAuQQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZmSoAqSufHO3NmzFTlZF+vOUB2V6PmeI1mcK3uG67QDT+Og9WlVGGY6YH8z0OJXXb5jQLpjvQeJzKtAeJOIXTLTDkvISN64nQjR140947dXjSPkjmeLgY8Vx1pEVg7yGC/LGCKQn3LB4flbB9ZugUwLGn2YbFd/7EutvZpt8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAIrqOep; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAIrqOep"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2c7427ad9so2460279e87.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 May 2026 22:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699372; x=1778304172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfdJ9DeevY/kQSFjrfpUduVPMDhOYMJs3EHm3Wf83iM=;
        b=SAIrqOepEhdcgyx0LuHuw2RrX40oG9FoaKT/5rBAWC9e139yQkaDUZee0X4EpUahJI
         gHVrOYSijsa+OEFnsE0+7n1Dw/d6uCq2DOyMAhws39aT/P/Am+KlroobDLdZ/dEz+zsV
         7FBL27KTtNUuHG9jjrVad5PjeQryHaBxSxqQhMkD5Jh0ee7gt5mJhACrCqXPYk/Hwpgg
         k/59sZy7wZc4ynBnyK56L7ZrxOGE4O9lgQqleArA/jPeRq1WcnjSuZlRZE8elxsNacXR
         vTaKVjO3f8LWv5CsTZqlwgjKBsKl+7qBTmTLGOvkGxdW3Gdn9xmqvPLWg2xwWGvhacKI
         0/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699372; x=1778304172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfdJ9DeevY/kQSFjrfpUduVPMDhOYMJs3EHm3Wf83iM=;
        b=lRPv78thL4vwD+51OUs13cW8in1/OSYDiBqToYyqPOCVjfiCJzsW9sAsci4GA57lRN
         JqYCpeBB5sk1NBznEMCP8eV+CSKKk/2QNUX4tO6uNnor25EptlJ4h2W8ZHhauZqCmK/j
         UBl7iLV09o7x3/vZUUKC2R+VJb/X6aaG4hfCnrCncnZo9sGFBRxrdLl1UaaQgToQunTa
         eX1zKLoDTWnNCqBouRHlDqkUInEp81TluhHVMI9YhO1maz9TBN6jJ33TokMq4pmjbCiH
         0AlnfuFNjAiv6Wqc0TAtPyoXiNzJyqeXhTqNpnRIRUvuhZ2g4kDPBKniFChHhYpWOgDs
         0XzQ==
X-Gm-Message-State: AOJu0YxVURM/+D+JVQ4QnQY32XJG6fJyI7Z0roTFuwpnn+5dhn/dRHd1
	jW6D3teu57rx4ctlPfEeTjK9hNrnDUW1UdTDyUEiykKOf5FKxZeFsl6N
X-Gm-Gg: AeBDievRiNMCMl/c+5f/n1EicYM52iZbBIYlHxudIBfa0sTSQGbMH3hpnPW5QtTpkzi
	t11Ncgb4wt+UrExJ72e50eVt52jM3Sek5Odae18ax5NvhVU+U/KWw6GSeeal2VjDM5qk5OA0faa
	h+JctFkaZp4M0LmjDvx+mCamsZg4AZG+m/wCjFSKsOKpINJhdR/7RyKFjNFs9VXwaDn87fd1njR
	5GzwUPYjSqGnQm9ttqMHGMr6rqbw/u/4xU72M3Nl/5yOpFMBMtT4QAVLcV0w/2mc8lUdMCCp/Vz
	HFwwYPlUM3xOVNAKahpe+nAyqpZzh9pcRv7vQ/+sozTGmDnk5FVPNrZXlI8UXyLoimc3R3ayOdI
	AlAFCUEdAWIiBJ4TFUv6aCdXY5VTQVYZMORg5HzjaMP9/FJnblQb2c8XIDbmbAt94mUspTZwfTT
	t1hskS2hnWnmZd3We3W2YVpSLmS/pWNn1pAYMwcihiHBiOJ50CZ2iG6aZD5aOrQtQo8Rq3CU8Oi
	YDgE6iRX3pTfgtcVW7wE41Yq2wnVAd3ul4/8dMLidyoibDvw2lgRUCx1xShFz2lGg==
X-Received: by 2002:a05:6512:3d15:b0:5a8:5276:962a with SMTP id 2adb3069b0e04-5a862ec0f83mr437710e87.9.1777699372154;
        Fri, 01 May 2026 22:22:52 -0700 (PDT)
Received: from localhost.localdomain (bba-92-98-184-214.alshamil.net.ae. [92.98.184.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c233192sm1002087e87.36.2026.05.01.22.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:22:51 -0700 (PDT)
From: Dhiraj Mishra <mishra.dhiraj95@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>,
	security@kernel.org,
	Dhiraj Mishra <mishra.dhiraj95@gmail.com>
Subject: [PATCH v3] libceph: reject monitor replies with oversized data segment
Date: Sat,  2 May 2026 09:22:42 +0400
Message-ID: <20260502052242.33396-1-mishra.dhiraj95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501193722.25194-1-mishra.dhiraj95@gmail.com>
References: <20260501193722.25194-1-mishra.dhiraj95@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Monitor messages can be allocated from preallocated reply messages or
with ceph_msg_new(), both of which may provide only front-buffer storage
and no data items.  The messenger receive path copies the wire header
into the selected ceph_msg and later uses hdr.data_len to decide whether
to initialize a data cursor.

If a malicious or compromised monitor advertises a non-zero data segment
for one of these front-only replies, the receive path can call
ceph_msg_data_cursor_init() with length greater than msg->data_length and
hit its BUG_ON() checks, crashing the client kernel.

I verified the issue against v7.1-rc1-123-ge75a43c7cec4.  The msgr2
trigger path is present since commit cd1a677cad99 ("libceph, ceph:
implement msgr2.1 protocol (crc and secure modes)"), which is contained
in v5.11-rc1 and later.  The monitor allocator pattern is older, but I
have not tested older msgr1-only kernels.

A concrete trigger is a monitor connection over msgr2 after
CEPH_CON_S_OPEN where a FRAME_TAG_MESSAGE contains a monitor reply type
handled by mon_alloc_msg(), a valid front_len for that message type and
data_len = 1.  CEPH_MSG_MON_MAP is one such example: the message is
allocated with ceph_msg_new(), leaving msg->data_length and
msg->num_data_items as zero.

Reject monitor replies whose wire data segment is larger than the data
backing allocated for the selected ceph_msg, mirroring the existing OSD
reply hardening.

Fixes: cd1a677cad99 ("libceph, ceph: implement msgr2.1 protocol (crc and secure modes)")
Signed-off-by: Dhiraj Mishra <mishra.dhiraj95@gmail.com>
---
v3:
  - Remove the impossible !req->reply check for generic requests.
  - Use pr_warn_ratelimited() for malicious-monitor log spam resistance.
  - Avoid adding __func__ to the new mon_client warnings.
  - Add a blank line between the front_len and data_len checks.

v2:
  - Resend as an inline plain-text patch.
  - Add full email address to the From and Signed-off-by identities.
  - Add ceph-devel and LKML to the recipient list when sending.

 net/ceph/mon_client.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d2cdc8ee3155..9f1c7ca42f36 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -712,6 +712,7 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 	struct ceph_mon_client *monc = con->private;
 	struct ceph_mon_generic_request *req;
 	u64 tid = le64_to_cpu(hdr->tid);
+	u32 data_len = le32_to_cpu(hdr->data_len);
 	struct ceph_msg *m;
 
 	mutex_lock(&monc->mutex);
@@ -720,6 +721,11 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 		dout("get_generic_reply %lld dne\n", tid);
 		*skip = 1;
 		m = NULL;
+	} else if (data_len > req->reply->data_length) {
+		pr_warn_ratelimited("mon generic reply tid %llu data %u > preallocated %zu, skipping\n",
+				    tid, data_len, req->reply->data_length);
+		*skip = 1;
+		m = NULL;
 	} else {
 		dout("get_generic_reply %lld got %p\n", tid, req->reply);
 		*skip = 0;
@@ -1499,6 +1505,7 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 	struct ceph_mon_client *monc = con->private;
 	int type = le16_to_cpu(hdr->type);
 	int front_len = le32_to_cpu(hdr->front_len);
+	u32 data_len = le32_to_cpu(hdr->data_len);
 	struct ceph_msg *m = NULL;
 
 	*skip = 0;
@@ -1545,5 +1552,15 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
 	}
 
+	if (m && data_len > m->data_length) {
+		pr_warn_ratelimited("mon message data %u > prealloc %zu (%u#%llu), skipping\n",
+				    data_len, m->data_length,
+				    (unsigned int)con->peer_name.type,
+				    le64_to_cpu(con->peer_name.num));
+		ceph_msg_put(m);
+		m = NULL;
+		*skip = 1;
+	}
+
 	return m;
 }
