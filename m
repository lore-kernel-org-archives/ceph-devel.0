Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2C2C3757
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020743; cv=none; b=iHCl4batO4JooORsGPrpxgRWDQy511PpKaTkJvWRJHe7CQKvKpkt1t4rRSgTfY23ZAHaFByq1apEejGzlvBbF66n/TWBuaWPOiyraK8g9MSvTiPcREtyjHqIFZG6VTOBKFMpBEuieMK9wMz79XeKoKMcnFHleP9i6NedBqd+rCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020743; c=relaxed/simple;
	bh=E+t1gFtcHDiraPPrfsroY+Aj4GCqUrp3X08deU2GKIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i1/2B2qvLImDoEj1/IkbhLLXXHpb9ffmg9GJIX5qSulvQhQdY80Ik6EAGI2Wapp4+/4tpnsK9cd6xXRecvWb92K3FcAk0HbQXAIL8okx3sRMTX0R7iOD0xs211c0zAxQTpo/psACqBR11TgnwtweXPOFmOSu3szrnTyO6tN5LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QJpPa04w; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QJpPa04w"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-930f618435cso138718485a.3
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2026 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786020741; x=1786625541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=;
        b=QJpPa04wKEU93cVUT6IOHEoTbPdj1SLgqIogOrZevNcBUAQ4+egaELr2nW/8bkBY8P
         QEz/4gTs+dY30vIaqKCtk6FJeoTG7uYJ8Te8GJDPLJs+GsvvAGl+iWBa7WckxDks+nDw
         YUxNfptFq5UvWrSb2YWhxsPNYE7rIMrRe1ic5P7Fm9hcBNXrg6rnWjd9syuWKjTG3o0q
         QHkmWriyni3+mWGrQSrf1S5FcsaVVZvUKyzybfTu+gP38m2XkiJcarJBGX5y6FGm+YEw
         Qn98v+3MuEtBsSLGFM9qAQzZxolAsRE5FcgM9EzVu2zmcicsyDqMD0NYvor8/u8yxEZa
         R7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786020741; x=1786625541;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=;
        b=Nu42LY7ENFD1D5DMlNncabRsHKjRf2jeWhHNHyesCNqcUzM774lFPlCEBKHRPOjzmX
         KCaVgHPclTsAulE85PNcqRNG4Ep0t089WhL7q9DlvmDtrp04N7I8FKBnUS7qw9dQlgt1
         Usw6nCithPyAQfCHiHKUwa6IXchBnezEhd16zC/wWYcnG6Q24XDxwx/w4l8gSJTFFRTd
         T27H5hmtN6X7M6GhNqeA9YMprAkhs1RkELpAt+w9g3OimGI+sMLMPvhjeskFlvOnrnDT
         oAwjgxD50BDi2u/lp4c9Mujetp0uT2MF0J58z2vmxBevPxr4Jt0G2s25Em/jH7V8arus
         dOfg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6lQTaHH8BCrvPp35/4LXe1K+qr6OifzDsWHgXeOdm3hTagh10hrOogrTdQPUvxsTG2pQwmWBlWIok@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4O6P2o4d0y1OPEzZ2E+/wQ42S7kW9BYDp2FEbhKRfe3wdFOW
	IRxncU8hS4uUGB2T4dniisOkKccBf6M3cVdfllvJ0ALIhHb28zr+Jf2LMLvgHtczY2c=
X-Gm-Gg: AR+sD13ysGdwPvUwe68JmDFsFbq6+PO/o/F93cMlooMLBG62jh2Gp49ljfs7DRHpou4
	K4lVIzseSWuibkJtKaQ0bLTymw3h5S8Wmd4ngc5gT2ujaLSDXZlwb7qOPtvg4ScIOYyby5waZ4T
	AYk0qq4VuLs38HBROo+Qp0KhQfAhHSpujbkRTJBxdaF6nppC+MFWApb98PWxOReYnVj/CGBazSl
	uC+RF3qBHwzN05RmWy7uYDI9zlhzfb8pb5Xobnj551lbV60t6MQDWK4DJm88Fx4ZuQzb3FSnVWd
	LT/rrnXJJE55Bo4ezrhDOIHq0/xjgIG2GK3gtppECcQN2yrjePv+gD/QfjP7sso9OTsi2L90xdJ
	BB5iMV3FRwS/Ykvy+6rqskjM1TsYEgv+vRL74tiV3n9VMs90O+W6YN3Nxcu4debsIv+RaTFOvb2
	XHmb5deJRf06BPNebdp1XGOcKjYlAGPZZ2oCFqCwx6MgHEYoFau8WJSsdC9DKHKW1Dd9xFFWJq4
	izL8wtq0EZa/L7Pyp3wBk3yJ0FGiIv5Bq/HiuhIvY/MZO9A
X-Received: by 2002:a05:620a:2311:20b0:930:84d0:fd3b with SMTP id af79cd13be357-93648fafbc7mr1150209885a.7.1786020740525;
        Thu, 06 Aug 2026 05:52:20 -0700 (PDT)
Received: from [127.0.0.1] ([2605:59ca:42bb:f910:6d9f:8dfb:ae1:441b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9365ef833edsm123847685a.3.2026.08.06.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:52:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Hannes Reinecke <hare@kernel.org>, 
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ceph-devel@vger.kernel.org
In-Reply-To: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
References: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] block: rename bi_bvec_done
Message-Id: <178602073720.2137920.17721545855702977301.b4-ty@b4>
Date: Thu, 06 Aug 2026 06:52:17 -0600
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 06 Aug 2026 13:19:27 +0100, Pavel Begunkov wrote:
> struct bvec_iter::bi_bvec_done is used an offset in the current bvec,
> let's rename it accordingly for better clarity. I also plan to use it
> for non-bvec based iteration in the future like dma-buf, so drop the
> "bvec" part.

Applied, thanks!

[1/1] block: rename bi_bvec_done
      commit: b539aeacf8cc5e9d8e5d94625d2d9c697a167add

Best regards,
-- 
Jens Axboe



