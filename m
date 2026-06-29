Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A08428473
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753286; cv=none; b=s45rZ04i3rOL0oFp756o90GVfvZZvYsZtBkeFOtW8njI7fmXOGBhy2GQkX2eD4Yaj/hdyNJVmFVSpmJQkHJqs/1BmopYDVnKsfc8YKMp7zmGgOZk1P5rCSlTiDyO1VExSVk8At3EPpj0MCLitDZZgPG7Sx9sRGvr6D8rjjSpOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753286; c=relaxed/simple;
	bh=RYX4k7mEvTZcWvAcRFU1w6p56PcAZ/5Qzzn0lCjvQ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/QYSKR31UDuC5xI27dPc8k4gHyTa6Kiy9OqSvFYazE0zItr55KtwlYDDtG1Sc5zj4/h+KVmJK+RvtPZ8IfC7oQK4lyXuf5gikIZkSNK2EjXzWv1ArDq7hCFnfgy5sKCJBqmOJKyXjNLYxxYomeg6R0BGexbE3l00Pawhl/6h3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI8c1tYr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI8c1tYr"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f18d92172aso3480556d6.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782753284; x=1783358084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2vDoBVoHJnWHiWlB4yOirQABqM3qP6B9+UR1w6RX/Y=;
        b=XI8c1tYr5V1jTSWA9M5+G0OWRBDD+8noNeWN/1C/JZWz6TQFDBSGSIucwowbIZOJQn
         US+bnzgNbuUS5XD5h67lpgCZ4lSKBpcDjuy6a3gWPgaNgrKIG+MtyNYqqOBGZkRQUi05
         mbt/KbGnPK62G6SEBN64aD9snz0R8x6Hmg6xueqTl9CSFrL6pdPcTKvbQyxdlZGQHEEy
         OIjasJAbyCxHCbhnrTr3DS7oTJxhiotnHKzD31qD4F/ls3KV6a5fZHUqkyPTup+9l7ta
         4vo5t6ZNv9GdwBB46V/Xk5ZioyuE3fQMQi0HHqaCRuiKoLMq6WZgotAvYUGxFtZJ+lgr
         UQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782753284; x=1783358084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2vDoBVoHJnWHiWlB4yOirQABqM3qP6B9+UR1w6RX/Y=;
        b=JuukzD8z2wlLsa7RzR1f19B6uRxWbW1fnHA3nTqJqqjbwAFF/mOh6DmsVHlc43EJoo
         4mPUGuiIAwYpiM5kh+/f6/q6hYr9CMSv+xSDExyWInqU9GXz1GvbSV7t1xByfoomPZYa
         1f29GQyUB0U9PyyOeusfU8XsvEYpc5f+47Mk7eW0HrIddPXEI8atWSb9I3EUmig+kUk0
         gfKOkeGrouCIAbbAfqrVgDUT0HCW7y6ydQxVS3A/V4R//wiThrKYgMxy6xFOcVXgXsYF
         MrVXgpEk0S/9pM7MGrnvkqcrQeWDwuky2El/SjXQYmBKxRnFE5WJp9bjSmK2PrsrogGa
         xoIg==
X-Forwarded-Encrypted: i=1; AHgh+RpZTIKPAcVe+LkvmQbK5/jQX14fEu/N3gqI9Crx8S+yVoIDVNTEBv2bQNFVQlq/WM+ja/kOzWEQqYP2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9asg0i/57MHPc6errfUVjFIKUEVTv9Oir0gOWbKzYTI44aEtt
	ZIN3KQE/+xu6YtUeEDzIW1wQu7v1WpmYqTKPJJliyU7mUNc3bIoTbtGD
X-Gm-Gg: AfdE7clvIgKiT1Sbmb7lSSb5Vc4oLt2Jt+0WNzFOAqctoM2wrUY6kjTp/DWdBYh+Cji
	V7IT3ZMIzlmHZf1wcUTLr5UG8jN4/mY+iV89xRRNstnRdtSSiv4Jbl4KK7vRwybwlGpw9BA5WNH
	XEj/tlQkTdXgSk5wLEpjyTlrxCzRCfBMpHWG/9HtTa78qk+U278fW/+xfufvAU53LAsoW2t3bP1
	w+2feMLbeVd4fMbnLVNWUDXUZui0R4cU7wCFctuAEjUautGVldzqn4tVlt/S7m1kJisJA4G61Dl
	9RR7y+APnSHhDtZQ6oTUTU9GqOE1Shie28gvdezkc+QZ/2Z5uTlDyNb5sDeMXqSfVgHpJMXrQ5S
	zQ5ZablNQyLyg+ILf5QL+js1AwRPkLAInEv3LjLJnxoN6T7hyfj0aSCaakxOHCyApzuqMoAajKK
	mCAvzrljFKv1DDCL+lpA12pTHTWl+YPpz/Na7LN/c5Zg==
X-Received: by 2002:a05:6214:3f90:b0:8f0:2653:4a9b with SMTP id 6a1803df08f44-8f1bbcd3629mr2478966d6.39.1782753283906;
        Mon, 29 Jun 2026 10:14:43 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a6f8d6a8sm2873216d6.35.2026.06.29.10.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:14:43 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Sage Weil <sage@inktank.com>,
	Alex Elder <elder@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] libceph: refresh CephX authorizer buffer after update
Date: Mon, 29 Jun 2026 13:14:22 -0400
Message-ID: <20260629171422.4163904-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_x_create_authorizer() caches au->buf->vec.iov_base and
au->buf->vec.iov_len in struct ceph_auth_handshake.  These
cached values are then used by the messenger connect code when
sending the authorizer.

ceph_x_update_authorizer() can rebuild the authorizer when a newer
service ticket is available.  If the rebuilt authorizer no longer
fits in the existing buffer, ceph_x_build_authorizer() drops its
reference to au->buf and allocates a new one.  If this is the final
reference, ceph_buffer_put() frees the old ceph_buffer and its
vec.iov_base, but auth->authorizer_buf still points at that freed
memory.

A subsequent msgr1 reconnect can therefore queue the stale pointer
and trigger a KASAN slab-use-after-free in _copy_from_iter() while
tcp_sendmsg() copies the authorizer.

Refresh auth->authorizer_buf and auth->authorizer_buf_len after a
successful authorizer rebuild so the messenger sends the current
buffer.

Fixes: 0bed9b5c523d ("libceph: add update_authorizer auth method")
Closes: https://lore.kernel.org/all/E378850E-106C-427B-A241-970EB2D054D7@gmail.com/
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 net/ceph/auth_x.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 9e64e82d0b63..50a79e8aa656 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -849,9 +849,16 @@ static int ceph_x_update_authorizer(
 
 	au = (struct ceph_x_authorizer *)auth->authorizer;
 	if (au->secret_id < th->secret_id) {
+		int ret;
+
 		dout("ceph_x_update_authorizer service %u secret %llu < %llu\n",
 		     au->service, au->secret_id, th->secret_id);
-		return ceph_x_build_authorizer(ac, th, au);
+		ret = ceph_x_build_authorizer(ac, th, au);
+		if (ret)
+			return ret;
+
+		auth->authorizer_buf = au->buf->vec.iov_base;
+		auth->authorizer_buf_len = au->buf->vec.iov_len;
 	}
 	return 0;
 }
-- 
2.43.0

