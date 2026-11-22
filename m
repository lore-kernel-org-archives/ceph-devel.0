Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371390;
	b=tRLQDxB8Bk5h0SE5+jvVwcZboxsy/agHdN35bcIR3r2cb/2kZyYCRoEncu6Py76QOAa8
	 h9NDy8Tjhep4UJKTmxRPOk9lB1pAkWBv3H8PBp+EB7xAl7uwB8gXZrCrJRBLyCZCfw88X
	 GPoPHL0P2tj+V3Ygvd5pw/Ub1u/Wa54f43wyndm1/9cz2/e8z+dEsob7NvwrAOmVpdqRr
	 P6dm3J5ygLkOWXiDzCsLPCelaGTKGaPlv2kwEWy37J5QQw3dfIvjuB0iHgdzqt+EOYaEg
	 NLAkf1htHjU3Q6iU0a471Fxb4v8bJ6kya3hp9WoEVkGTOr6gSGTSH2vZGjbECwj/X3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371390;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GC86Rl5d7G64rmKwKqSKNiErJx76bLmpSfAVjHTh11g=;
	b=m4mFiqY2blBth0U426yvFEEjA9hjkN5hiuCamAFINfuqqBjPr6w96Pj7jVVNPwAEanUQ
	 kXO22DtRnXMcWjPv9jy1FLdHvsVRrTAktdCf64qrtmxLvU3H4jXHJK2vUgXcpGyt2DrGp
	 Xz/RFBXO8P9WbQ8K94Z5Mm4RT7PD94zpQ4c7RlIdmH1qRHQ1prIS36FfkxaPK2lSBG3uz
	 7QjwD5DzVrwrzkJUHvREfdCvCllx6+pxouHkZwN7kUtu3wZkj7VFtigPIYLL6Hd7AuL1p
	 9soKXBSTEwF/Wgwfddo8F1ZZQpfxGZ7/L7HxLi3blDJxuftHUzjr7RTBH0YJfoXyCng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="i/kCXSSn";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rCxngTgI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E73606A32A
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 18:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E73606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i/kCXSSn;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rCxngTgI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795371388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GC86Rl5d7G64rmKwKqSKNiErJx76bLmpSfAVjHTh11g=;
	b=i/kCXSSnhy4AVySUQ8LxGhowx96vsJjlYXKs7alDhWVqfcKXL3+cdmBSAH1sAU/WTF8T6j
	XVJH9ZfifMkBhulLIBC4nY1bE1KOqBCfWWNRRu3cAFfamT+FHYsTBFVYTvdOqDdrvJNq6L
	Jq8Cw3sWDKtZPBMKDzxXOPSoFxOdH3I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-c-7fymhqNW6E82zClygVbw-1; Sun, 22 Nov 2026 18:16:26 +0000
X-MC-Unique: c-7fymhqNW6E82zClygVbw-1
X-Mimecast-MFC-AGG-ID: c-7fymhqNW6E82zClygVbw_1795371386
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b57668479aso2940139a12.0
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795371385; x=1795976185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GC86Rl5d7G64rmKwKqSKNiErJx76bLmpSfAVjHTh11g=;
        b=rCxngTgIyvjrvdeIyP27cmqJSxpMzxGriNTQdQ3Y+VnfGCo1B+/zfE4gLaY/xoIfqq
         qsYoWhNo3BRI2LGN6nvXJkh6y0iTy88u4zv7rHNQvmCxRQN2GXgNZKVgG0W/Qd/0u45B
         4sNWSjGdkw553JMqylmkeNevkGpyNjkc8aZS6OVoA44JIjf5xWk/lgilvWAmlj6CNfV0
         w5VPwe1R5RenIPKC/2xriQo0Jdz5q6tivUWD8gSaUykZDrzXV3frCYQX3jPZJoW29nWL
         0bVJ0hmoHusBqzfPwNB/VGtTOuRn8hGLNBnzsHeGWa/cs05P3JMrN7s8z/XcLiSB1duG
         xaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795371385; x=1795976185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GC86Rl5d7G64rmKwKqSKNiErJx76bLmpSfAVjHTh11g=;
        b=f+vgMJ+Aw03gBpkB1/xADZ0HEcKKOuZZ84LyFistE8CtD7/vk40H+Oyka09b5BQKQp
         yKrvebvNzcVp6BSCin9gl+NO1TEiXQ5prjSfGdbpKKVylmmB1+G1FndfX6optyj5kleQ
         5Wb3dxsMKJduddkMAKF2wE7QZdL2EIUdaDoM9QSw38CQFjwKChEykOo01X100245PNXp
         fhgr8hwxW+T0O68UMWitpMNS3wThnxgbLhGBxDjXMnPPx/HbMiCdQpF+MuIQ4kA7gop5
         LFSlf0V85WsyMu1IVfgTFungHg2yGDuH+Ewh8x8r3CFW6u0T7YnJUdwf43urS32ItM5x
         ZT9A==
X-Forwarded-Encrypted: i=1; AL+hErHI+YkGgO8ShX3HBrSvv+0nLNvv62CVcfz4C3gBAF/Law3Zk34BlVCG8EmIn3SidGB02Ht2Y5hAV5q4@vger.kernel.org
X-Gm-Message-State: APuU4Z8TTNno5WHGLUXOQHsHGP21Mx5+KIt4v30YOZmvK8B7/TnRrKGI
	uZdJc2ykM2fX3WKORVejHHInNorbJQQ+r9BM0xaOEjsOzF01wUR2B2N5/muJ02cM2O627mNlG/A
	JGJ8HuiXHk7ayaIaJEdH9tCqJZDCg06Lg5Ydcev8kHEMG6RWq43jn2oOg8KBTVag=
X-Gm-Gg: AZFdTZd0JIEzpktvppseGNM+Q3tkC6ub7tf4UPEutL/5vhlPiRR2CqxAdzG+PbUQ7/M
	rucWPv1/y/lShCvmpsVdxr9h74l3Y0a/ljRmuPF/zvB6Je1il3WOb3GUw4EoqwWiWkwBQOvFoGN
	u6NPtTkI0jRIqrTTqHW9k7qw66ZNT9Caszv8uDPp5JSx2aWeaXtH3QQs64GrdXagWaHxlPkE4T7
	rtS8Cj+wtYzuHAQ7opt8hIjqyBbY3AMkI8HvF9C4XNET5sxNIrvnuB0VRNBP+KrHXUMkPholOEz
	5GeG0u4LJgvQRS9hSX0myy7136Y09cP9If68CCtSiUxWe95Aca3TZyF6358bEJde38GulX/f13S
	E47Xe1GZzPIoMPPs2m6Uq1IEIsEnYtvEF6f/e47mJ66vyEjj7D6Ioey7d+fk+YL/JuAknHDwv/U
	zF5txqhFtWQItjPSgEUA+0g7QzrwpnSXlh+0dGQNizt55+3K7ZMoYwDQMxElQby+jeF4up+YFUP
	aOc1KS6flHqiGNxYRG1xrlFQ10n5WbXI5DUwFJtpLWLE4CZj8KW
X-Received: by 2002:a05:6402:1e8e:b0:6ba:5993:cec5 with SMTP id 4fb4d7f45d1cf-6ba5993f458mr4312651a12.35.1795371385687;
        Sun, 22 Nov 2026 10:16:25 -0800 (PST)
X-Received: by 2002:a05:6402:1e8e:b0:6ba:5993:cec5 with SMTP id 4fb4d7f45d1cf-6ba5993f458mr4312645a12.35.1795371385314;
        Sun, 22 Nov 2026 10:16:25 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370faeeasm4410449a12.22.2026.11.22.10.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:16:24 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Kaho Jiang <kj2864@nyu.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Xiubo Li <xiubli@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+408fcc361565713f@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ceph: Use unsigned types for snapshot split counts
Date: Sun, 22 Nov 2026 18:16:22 +0000
Message-Id: <20261122181622.1294305-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113030257.1061200-2-kj2864@nyu.edu>
References: <20261113030257.1061200-2-kj2864@nyu.edu>
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

Hi Kaho,

The new array-length checks return through ceph_handle_snap()'s bad
label, which drops the message without fencing I/O. If the MDS sends a
malformed snapshot update, the client can miss it and continue writing
with an out-of-date snapshot context, risking snapshot contents.

Please fence I/O on these failures and use the same blocklisting and
session-close handling as for a corrupt snap trace.

Thanks,
Alex

