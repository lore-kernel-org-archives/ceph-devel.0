Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1653C062A
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596555; cv=none; b=tz5+13KM8REJeSrlHLuOj7mayNo7hTfnzxheY76WUUesPCBmLi7fBwbOPepHlnpa6WgohPgewZ4aoAoI9TeG+WKh8vd3w9xCH3TSXVr51eCdGVWXyqdWRkU1NJuY+gyQ2awvcevum+2kDvpwgDCEAgo1mWx8Tzvyk33YWZWL38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596555; c=relaxed/simple;
	bh=PO3iejuBlnRzIOMTIRC7gUF+lvmQGa01DfODjyBXwno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXGXW24pe3isKpPVbvKp4U3MsVFcFX8q431C91b8Qd9hLKUY2h53DGX0Jts8LQSIz5bDFO00Syjozuqik8pBk0ro87mtvJN+tZAub1pBT74w3nHxykDlaK1LMosLgNN6B5H+7MhyHMJLOWBmxEvlOkqcjcVtrzP7NG5pv364uDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3mCZt/d; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3mCZt/d"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5177ad0cc67so8309371cf.0
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596552; x=1781201352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc3UhhffxGWia37/F9UtpFEHW30fe749qB/+Usg5z+c=;
        b=a3mCZt/dZCd+Vf9j43EAWOSb6Qjxt1sMcE6Vv6KeNx+kuIEx0tprIB1UiEUpIobOpg
         CgpefpuCvHxY8AHXAZJqXBJxFG74WtzTLypzfS8LZJ7SmoEnMJ1M8BlgfG/rvTnNzqlQ
         VmSU/O3+7YEvwpLdmOa+ZngYEmeZ827dy/wpRpHP5WdRr4Tan8KPYRkiQcD+WMtAhiBL
         o94cRNT3FxLwXZWZrocxsqYgxiDFbV1FenHP+apqSC6ZbeWesazgFvmZ+TWjuzXuv3zv
         V65lTLN8yjI6l3YKrnebw1Q4dq8wC4sHxDqbi7+NIWpOdYLQKPdiA60BWz58wogK/hzb
         FSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596552; x=1781201352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qc3UhhffxGWia37/F9UtpFEHW30fe749qB/+Usg5z+c=;
        b=EseJnrugWdlCjuZjme/+TalLXgB3zJnslKnuSHdtCMUUGq2v8dSWpCLl5wS3ndNZej
         8T4st8iW+L9e9VwwbW9sFxzJcM5p9ilFbIdRKaeliJa34Gra9H8IpMkmh38BwfJLdPy5
         EblUbQNZV2Cxay95vPi1uoOZ04brThqN7y6k2mpj5s0AiGnWwvhhg1M38CqsoAL5S8X6
         dzwGP2KTGHDjJ2vh+sXRLVdlaodyFKH+UwWRKIN6FPBv3a+jKbB6BjK+YhYt98Giv/g7
         L2HhsPEG16H/YVGGiSpU6lojWrhmxo6wn/KMQlk7ykWzBcvp26axmdL5gK+1+ao23I9F
         577A==
X-Gm-Message-State: AOJu0Yx5VERI2ezFdIHsy0RMaBwId61utPI4Hj3TI0iHo7WwUB0uPQJa
	OSXCiXV4+p22KZQLusEcDo/xRnpuHN1p7XiHf6TdpZ7gdBmzomURFyKcM2Klkj6w25Q=
X-Gm-Gg: Acq92OGh5VzV2h/TAH7DBUe63LPoivADpmQzZz4/dCLTGPVFSbV04DCe0kE8REBem5D
	+Yc5gg+dolvOnXs+5MbQ4upUk1Tt9ZfOU85cu+x381HNVql/gj3GC7Tisc9LKsNdm+X70LKntQx
	tJjYWDzTb/RMw51fvyrVYV/3Nvq0lXfqYyyUfq/NW2titqSZn1km+rDpQu8FYetTJWqBtJ6g9Zg
	HqE61FCYgwoZLtJ7WmRHqp79rbyTyI2X7FC+g5HzCQiG3BzhGv5N++8XdoDK+tzbCDqdUXmvWuh
	lE+QY/r6MVG45/5xPwdSlA14/0kswUTaUWd1BMddqdpg4fiae9BIoeVISrkaNl1BUmQsFZdXy3G
	6FfwMq2OnHoK8WOHKDzw9U8NM3BRJiz25yZCAghTHAzAWQYeB8wNDjRdVcEtlxnDFXIVkJFIgNh
	FAE9FRxFwYq4i8JrAtK3Y7zKVMw2mofoRcUO376/BvBTh1MHg1FXzBI5OlFP6FmaVmd19CtVPKf
	rES5zBRqRLo/eMtOzOh61SlWY1ZZA4=
X-Received: by 2002:ac8:6f13:0:b0:50f:c109:b78 with SMTP id d75a77b69052e-517787c0e39mr124706901cf.60.1780596551903;
        Thu, 04 Jun 2026 11:09:11 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dbd2c9sm59020961cf.23.2026.06.04.11.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:09:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ceph: bound MDSCapAuth path and fs_name decode in handle_session()
Date: Thu,  4 Jun 2026 14:08:58 -0400
Message-ID: <54eb585e03930ade4d11d9a103eff5f737d65251.1780596023.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
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
---
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

