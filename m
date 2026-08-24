Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51D340A6F
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590038; cv=none; b=XF5gSZKPngc64P5UQEvnF+v3tnxheD92fvVGoWMh+T2/2/bBCYdWX2Xtp7lYXnxfuT/b+9CEe+ggZ0II05e638WAstbyx4WfRGI0g/IwQF7F1p5n8NVWBH8Xp2IYHOmxGaF691SEkUgFpFW/ttkO+586sfPZgpodORz/Hqy0do8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590038; c=relaxed/simple;
	bh=7Eq4H0wXoehn29ByqTM1IIhuFt1x/zpEaGrgoOhjmr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSUjnvCaK4M0xES+EU37/y4GxoOZ197jMJ6FUW2bfoaXIrl+5MWktjLcCJ5pgi06uesyd7kcvPo/3IBkA4XmARg240qtZSXdjjgAVO5+wfhw/Uww15nZ1f5v0uN2tTCdZRzGkMCDQ6bGAVMg/tW6xjWEdzVUKH34b7G/nIW1Mo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hYW/U47M; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hYW/U47M"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a41191c9a9so7384145a12.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787590034; x=1788194834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vO5J9Tkq/BMJEuFay0EK1J+ldjBV3PGyGhM7DZqzQJk=;
        b=hYW/U47MZ2bB/sKuhjws8Yo7b8deYavWr5WZxbl5T7zBVXLJfZ3mKRLK1TL5csNgzh
         xln469FsDbJvRm9cHKtC2AYE2E/4rfn3bptbhdTtTgmetXwh2+iBgWIPusUme7KihDb6
         D+nxO5+ZYWTDft6VhbYVnvyQRrGUShjWWOQ9KwpPU46PD2o1rG09UzM7KZ3apenyE9+D
         C36TvxkrNKTFoUsbFUKuYmb/ew2x0NqWYDgPnQCuscXC4FbPqlg9Gpv3d53JU7+rZPfY
         MW6k6YAFJSQezeg+KS3obtjCeZkpuKHgvF/OW2IS4iR01nuEUQMcPpxlyMeOPPwgWqSj
         vm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787590034; x=1788194834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vO5J9Tkq/BMJEuFay0EK1J+ldjBV3PGyGhM7DZqzQJk=;
        b=h7U6/GeMlCnmdMoR71//mrPcLlUzGwVx7+Eq3Re92cEWhRg0e/TZFWb5BzETUTpU91
         MddDhCM0QubCMJcMQ9Xfhk2+zSCKwvrQPnSQnc4Pa0E6j+dih9YOkw7sZaBEB8P3Syyz
         bOOWoZNYl1XlYqE0pNqj3b55UVQuuASQhnOPrIRixLH9By+PMN59NU6CfMReRyL8CVGN
         I5OlEmzFBmiDtfwNEW9g2N4LmWVzHoniBn9mPxzK3yuCxAO2CQsPS0ZzdSf2roqmkKo4
         orVcQokCDRUAwwjVvjVEj5bTUGSjDDaRpHfefttsv6wSr3tYLViZ8GsTzpMgz5pDso1x
         idQA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1Z74SHFrBIm2WqHP6k9UFl2aai0f32tlO3tzny8zs7HXEOmg6tX+VZ4oZDiujpu1kISxrt3IAIMUP@vger.kernel.org
X-Gm-Message-State: AFuF++n5RSYmDV3f5vBdGTXZLfn0vmOGnT6IQG656ZdTFqgPYOfxmQ6s
	qhtOBN3lwGI6m6JJjITi8XnQN647l3DXVa1RZiZm0gIguwwwbMMWIQbhBHfTnBoefVg=
X-Gm-Gg: AR+sD12K3fUi6cfMIdMbhO2V+FfETkJL3qXJLU288Y9LPgs4shPYrA4XjSB50Z4U0O3
	wP08kAAsbULKfDaPEi6iLju+kslYt5La6/+NVIab1utO+XsFbkPaQjBvytlcqdyW1KoZfJyF9+X
	RBf35Xw43l3L2FbdzbSsJqDFSHG0v9dQ7aqIO9e2d1XyaOo8sEzwykCv7lNllLplpv5FYqRG3W+
	2G0fcL+7uIcFDwmcfC4pGXACqH4ZX9ihCHsw4KKSVGMGpi0D6WmmyFjucaVEFzi4FCH4MbSjSpo
	RN00PRMKWlK0hBhvgUgAvvEo7+wG33NhaYhARAg/jhxR29URve29GLeGgfiTgV5qWcaOn1LIzOe
	YyYMVDRMiAUS3eGZcrkHiDLyRcLEJxvTsbHO3+ptzXr0EwUQS5es2UueyLF8/6793F8XAvRf7ui
	kzr+jvF6YDpBbse8X4l9cA593dqWtwsuCIeKcajjifnZZ+xZ6DSqexM9+SO7WEA/7L57j7sk+6i
	9GK9U0nithfu/qCvCOfuxDktCunnw17Fmy0J2T+To1Ofm95ykNipgZYAZKeG32J
X-Received: by 2002:a17:907:fd18:b0:c24:d48a:e1e0 with SMTP id a640c23a62f3a-c24d48ae5c7mr623299266b.14.1787590032837;
        Mon, 24 Aug 2026 09:47:12 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm9209420a12.9.2026.08.24.09.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:47:12 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: lock mutex in ceph_mds_check_access()
Date: Mon, 24 Aug 2026 18:47:07 +0200
Message-ID: <20260824164707.225547-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MDS session OPEN handling replaces mdsc->s_cap_auths under
mdsc->mutex, freeing the previous array and its strings.

ceph_mds_check_access() traverses this array without holding the
mutex.  A concurrent session reopen can therefore free the array while
it is being inspected, resulting in a use-after-free like this:

  Unable to handle kernel paging request at virtual address 003aaad64b2c8bb9
  [...]
  Internal error: Oops: 0000000096000004 [#1]  SMP
  Modules linked in:
  CPU: 56 UID: 2953037534 PID: 1253231 Comm: php-cgi8.4 Not tainted 6.18.45-i2-ampere #1146 NONE
  [..]
  pc : ceph_mds_check_access+0xd4/0x550
  lr : ceph_mds_check_access+0xc8/0x550
  [...]
  Call trace:
   ceph_mds_check_access+0xd4/0x550 (P)
   ceph_atomic_open+0x138/0xbe8
   path_openat+0xa24/0xfa8
   do_filp_open+0x94/0x158
   do_sys_openat2+0x88/0xf8

Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 4 ++++
 fs/ceph/mds_client.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3c692ad02c85..0348e8b848ff 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6532,11 +6532,13 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 	doutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
 	      tpath, mask, caller_uid, caller_gid);
 
+	mutex_lock(&mdsc->mutex);
 	for (i = 0; i < mdsc->s_cap_auths_num; i++) {
 		struct ceph_mds_cap_auth *s = &mdsc->s_cap_auths[i];
 
 		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
 		if (err < 0) {
+			mutex_unlock(&mdsc->mutex);
 			put_cred(cred);
 			return err;
 		} else if (err > 0) {
@@ -6558,6 +6560,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 	doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
 	      rw_perms_s);
 	if (root_squash_perms && rw_perms_s == NULL) {
+		mutex_unlock(&mdsc->mutex);
 		doutc(cl, "access allowed\n");
 		return 0;
 	}
@@ -6572,6 +6575,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 		      !!(mask & MAY_READ), !!(mask & MAY_WRITE));
 	}
 	doutc(cl, "access denied\n");
+	mutex_unlock(&mdsc->mutex);
 	return -EACCES;
 }
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0ece4c9e3529..8774c7d7d18d 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -603,6 +603,7 @@ struct ceph_mds_client {
 	struct rw_semaphore     pool_perm_rwsem;
 	struct rb_root		pool_perm_tree;
 
+	/* protected by mutex */
 	u32			 s_cap_auths_num;
 	struct ceph_mds_cap_auth *s_cap_auths;
 
-- 
2.47.3

