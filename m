Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC78476CD9
	for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133508; cv=none; b=aOuxlqTvToMQir3+ozs9KCYJiKwG9nF3TUrXDWaY6AaAmjpvzxd+MueFzP40tq7XWxLe00eg9Jsilkn/W+mgItuqYvTh9BERf3qjMtvZVP/iwUOGQiWkABrNYFzHhy6PRfpTfMj+scfSdGC23hR+M3LjscgccLfhaMYmi87sfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133508; c=relaxed/simple;
	bh=xixb/irvDDTZ+1ALQQuckecjdupSCXFYvqi0iIQ8Dd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIFPiPicixmbaIdVbBFc8hLrkaedimflCnInWGhRyvBF0aYDDHjb1tEaaZuXvoHDMYL+9ldJUhyJguqP0aipyyTgZoMnD/HiUN6Vf1TpIO6iP6HKYUn3OU5ve5ZoAFZx2+bt9SZSQ9TuIqzPJRBOZnjypK9ARgpaENjuEf1uDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEheYlPI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEheYlPI"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39675172593so924155a91.2
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789133506; x=1789738306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Z9QHqYcT1YWEzjyHufxn1J/JMrSvKtS/IwWIhbmHWM=;
        b=rEheYlPIrxfemkmgL1yOkERCMoGNYVUhBVmlMVyv3JHWzdHiXi0e/2Nte+wYDtC3ZK
         A9VgU782n/3ToERFmznfLmp3hNX9tq5QrXYLnNsb4NE7worrc+5h8KE+k9uHaIBp2c6n
         /sMlxx+NRM2ZLUuHB3Bizw9syCavQe9KCpqr71BW0zn16svbFp+ljiwF1oNru3jkygjZ
         d/c04uJ8hzHfI6I71SdTavvvy5aohcfQx/+BEd05mGXdqAVmo5WucTCskT+hASkka72W
         ji22emXk+G61W+6Mx3v/3Q6FmmCnk5Zurqr/ukQ1S7UQuZ9LxglTHq3DS+PBuPsqtDL0
         DNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133506; x=1789738306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Z9QHqYcT1YWEzjyHufxn1J/JMrSvKtS/IwWIhbmHWM=;
        b=ag49RZL2SNOKgyh59A2jZEHvZdCUfVtL1IB8VKVSwd37kih5jMepWf4eHFVXlqritZ
         7C8JxbwzurJZ+sFnX1Qu1w9IzO11Hi6ePuZOgzfi4bAUJhB0FhecXwFgkzhrpdaedjwx
         3UqeALNKny9B5WyWa+k5EiigeG0yt1Cwrnuq2yU8Ju59yyUcQ670bdRVIPHXAd4qfLIg
         R33vdkKdEtpQP00+ZT1jv7rVXd2i9zQfHo8ngVyjne0LqTwS3BHd6t8rukJdBsBl3GIy
         vxF08dLjAnrsbW29O4Fv69PW19cP8sv+dgsPK3ZfpYIep77jdwgzpC3zp9XJuqvI0qFR
         kIVw==
X-Forwarded-Encrypted: i=1; AKwUvBx5T4GJJvBW+fopnqjenHe6ChAEHy6ndFrfImwoPCQHFLmpkMPa3/LF4qHFqWOVHRiwK+k2onbv9PS3@vger.kernel.org
X-Gm-Message-State: AFuF++mHm6AR+xUE7tKm024Cug3tt5pzQ2GEUh+urDO9tLy1GkAUpZTS
	RBx2WrlB7wD2FAsC3KOAEi0n1CdVN4lAo5wSJTj0IUzuGfv7KmjUorGW
X-Gm-Gg: AYBFou2OVrCnSKbbJPyVI6Il8qnDsGYp+HMLBToqLS2S7cR6lSZqhR3j8CeYWBBFZz9
	cWXAMlUhGRKLu9hzmHoNrpUDN9TNKy0uhYNyQH1yfIVidENHorj28PTyluFUIITvEcO1ZiC7agw
	VSYKWPvG+f8Fh93HcLCSuRXbivgGZnSXI/MgUalAJTofFRYSHIwsNShX2EvnKF1TDyHJOwn9zJA
	81D3zUienulY9iCnKa3CAy0lcMztKx5J1hxg4LZzEH7W2aGPdCnAdEHLt7Tjlh9wNTG4iGuFTny
	pueHJU6Go7txoltXnvLQnY9fzi+OGRUJWJ7+k7sghG65Y91es0LYb9v+s/GGRYW4Um3oXH15L1T
	3F5arLivpStRzaSVGqNQSWMN3soT9WpU9TuZSJ55WdyGNTn2UzOrWPLN5Rho46tZymQ80XXxW4w
	ahzAOqCKXBGD0LD53eq0Y/Zvzeub5qgiNZmelzC8s3gcBSuOeSOKnu6AlKwA3DVQlTCMfej8F3W
	uUHiQkt0MNCoxUbRonC1D+LnNd6em6kb9Y=
X-Received: by 2002:a17:90b:1c8b:b0:398:9c00:29ee with SMTP id 98e67ed59e1d1-39d9c38fa48mr6908147a91.22.1789133506138;
        Fri, 11 Sep 2026 06:31:46 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.135.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc5c7bsm11349015ad.51.2026.09.11.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:31:45 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com
Subject: [PATCH 2/2] ceph: don't keep a mon_addr= that failed to parse
Date: Fri, 11 Sep 2026 19:01:10 +0530
Message-ID: <20260911133110.2218-3-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260911133110.2218-1-yogeshgaur.83@gmail.com>
References: <20260911133110.2218-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_parse_mon_addr() stores the string in fsopt->mon_addr before handing
it to ceph_parse_mon_ips(), and then returns that function's error. So
after a mon_addr= that does not parse, fsconfig() reports the failure but
the mount context keeps the rejected string.

That matters because ceph_get_tree() uses fsopt->mon_addr as the "monitor
addresses were supplied" test:

	if (fsopt->new_dev_syntax && !fsopt->mon_addr)
		return invalfc(fc, "No monitor address");

Userspace is free to ignore the error from fsconfig(FSCONFIG_SET_STRING)
and go straight to FSCONFIG_CMD_CREATE. The check then passes on a value
that was rejected, and the mount continues with ceph_options::num_mon
still 0 - which is how syzbot reached the BUG_ON() in pick_new_mon()
fixed by the previous patch.

Parse first and commit only on success. A failed mon_addr= now leaves any
previously accepted value in place instead of replacing it with one that
does not parse.

Reported-by: syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1dbed5969931c19d3eb5
Fixes: 7b19b4db5add ("ceph: new device mount syntax")
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
 fs/ceph/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 72935f665f11..9e0aee8f33ff 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -394,13 +394,18 @@ static int ceph_parse_mon_addr(struct fs_parameter *param,
 {
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
 	struct ceph_mount_options *fsopt = pctx->opts;
+	int ret;
+
+	ret = ceph_parse_mon_ips(param->string, strlen(param->string),
+				 pctx->copts, fc->log.log, '/');
+	if (ret)
+		return ret;
 
 	kfree(fsopt->mon_addr);
 	fsopt->mon_addr = param->string;
 	param->string = NULL;
 
-	return ceph_parse_mon_ips(fsopt->mon_addr, strlen(fsopt->mon_addr),
-				  pctx->copts, fc->log.log, '/');
+	return 0;
 }
 
 static int ceph_parse_mount_param(struct fs_context *fc,
-- 
2.55.0.windows.5

