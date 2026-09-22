Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A3539792
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075722; cv=none; b=ZsEQgwHUxSg1UFP1q+zVUk5H0Ug1kTCz0gH1glKH8tWNcsyq6Avou1/4Gr1SwS57FpU3jG68EZu3oD6dsyi9cpvkAUHIZo4fq0/QGOhOGtjjKrLAyiwJDCXBJDdxsRqpXmRqnr+6MlfhYQf3KEqxpfFuj2zF6EvbS4fjyrGEs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075722; c=relaxed/simple;
	bh=hLVQ1ftq7EVejCnHot1sW/PcbtMmvC6zm8K/x3ZhQa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kce1zV/yCeqMtwjYP2y7TOX6UKrCSuDl68kUu+iQ2rrmTfwrswXOfR2PBnlycold6nH49kVKLlLodnhEzypTSKUEntevsHtFLs7eppFac8qZiG9yVstNgei5fM3lnEBm54JyufWmV3Evb6/zBiizcLulUC0lJHldjIjFU1XPDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbT0OX8d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8/EEUzt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbT0OX8d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8/EEUzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=CbT0OX8dFRwEfyRrsaXaLfB20hw4QS93OXXeGLAcX3OvqKMmO0WEcD5QZxasY9KMfMNHdh
	Rj5jTNY2Njwsyy3OEhOEviV2HhMkbe2ZxTGBQ9PDdhzN6dILV9UnfMBNr/rlRAOjxwO5bQ
	Pzz/zQas/pGA59/+VlPlW6dSqUoFyYs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-DF3Ox4V4NU6BgMJlpZlG_Q-1; Tue, 22 Sep 2026 07:15:18 -0400
X-MC-Unique: DF3Ox4V4NU6BgMJlpZlG_Q-1
X-Mimecast-MFC-AGG-ID: DF3Ox4V4NU6BgMJlpZlG_Q_1790075718
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530f968ccb3so61520871cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075718; x=1790680518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=Z8/EEUztmOaOyOkmZV1ojWRR7aRX2WvJdWN5ZsQuBlCQlZLfPR8xCCQmTMtGpSA/D9
         HOWemCbRG6yPlEOPYima5yEnIiZcVOTw2ur83Q3rBl7qJTKFpCH3VHrxMh3etDmi6qiN
         UcxVzJ0scCC/Zk8NXWQpNDGsK801V2aVczHQLEJ4rM6nwjE2WeXyjgK7YfCzatT9cghc
         O+IVZr/nHJIOaG6Aw/0TZX47DcuFl6kbtYSXtw2oslTIIOZdEH50F/UYDxaZMocuD6e5
         b7ZFp1sRgCzFeDA5XuqOObwZKCVmYttFBo2k/fumUyJRlMidxZCAcSTTkzBL1f0/aXxs
         t4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075718; x=1790680518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=1TWdTKCviELg5Yf+mCWqTq3RpyZIvcMAH384s+RHn9UmjPrrOOpNsdrBGGXiVP7rzL
         mG6UqHvADIV6l0F3zLHhuSUI0XLyQpDI743UTAPiEEJPNW7auZl2zJwHKLDyAuSgFQ5R
         As8X9CV/PV0TDlUdCSKyDEbYYwdHPXjYxo0D/x4iE+42seHsCNht3tYMsKrhs8GB11Fy
         TXYdn1nMVj+u+ktxSYyX4tz5f2Z8bJoG6gBbvv++xki7DHARYLHj0+BWZHxTmatk4wnu
         jqPnvNrV1gQyglIkYjtL75HVodX0de/Oz++1nsRdcy+6bl/dGoBVaVcoSXFosxhWh1b8
         8Gcw==
X-Forwarded-Encrypted: i=1; AKwUvBym0jwHNf/Ot5Cj4WKJzC51B7JvRZDIfKtwJt3TV7ujwvRST12CXtWyXkm3v0rwEpPzX02O73/d9NLj@vger.kernel.org
X-Gm-Message-State: AFuF++nvXpaLpoTyZ5DVeB8izoFWKuUbyBGkrPKbBPjoCgRh4mwr2w1n
	oxaQG0o+KQyOfAp7XXWzE3XVsdwa+dpO86IhsPRkf/jV03qQOCvAB35mJ9oAH+NEf5hpQpHQfR5
	zbgDnbBU+PIXyjXyv48ulBITymEbTu08AdgtcEHEiKhyyYMD2wUrsRWsqD6M/AGY=
X-Gm-Gg: AYBFou184j0pl9qJPmY0XyW96mO0HpZfDR0pnZF1W8+ZL82YX60ag4EA65jl+9OBzN7
	2p9zsc/LaVAScNd3MGpyFCy29Pxtyy8oSyZGK7PcrjOGOnG44qxknFkYD5Dn0hYQ/g2q+CxRRW+
	Zge7etNEr22nya8lsSNcxQNAwQAM922OknsSiY++rfVzDYgV8C9BLEB5YfpaoKzeazmOWWo+MZa
	rAfUiHuLNjNmr3pAkxdlfl9Oy+HMQ6hRltrLn0Fnh9PzlPGOirH6nNR6QTjLahQ+KWOUnPfJhwR
	/94rGPNiL4cAxWi6xipjwuC6Iyx+K107/Wv7LNgW92ky78W1nJHiScxCst8Yez+xoEm2iKsbcG2
	+2ivdpUMT4heVMLqA5HkvaBY5zNKVYg6Eyyc+NxCLcTZAY2rzr8mH5wUFrNVnk9qw7QCn601CHc
	7tIH/CwUOxY51R/A==
X-Received: by 2002:a05:622a:598f:b0:52f:a0b3:bcb9 with SMTP id d75a77b69052e-532dd3cca40mr32808251cf.10.1790075717780;
        Tue, 22 Sep 2026 04:15:17 -0700 (PDT)
X-Received: by 2002:a05:622a:598f:b0:52f:a0b3:bcb9 with SMTP id d75a77b69052e-532dd3cca40mr32807681cf.10.1790075717136;
        Tue, 22 Sep 2026 04:15:17 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18db10esm10346891cf.14.2026.09.22.04.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:16 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: libceph: only set read_from_replica on read requests
Date: Tue, 22 Sep 2026 11:15:14 +0000
Message-Id: <20260922111514.767318-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903-b4-read-from-replica-v1-1-76d1ad8d7c2e@clyso.com>
References: <20260903-b4-read-from-replica-v1-1-76d1ad8d7c2e@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

