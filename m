Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C83AD512
	for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323842; cv=none; b=O58UnfrZBR6XS22KvnsdE5IAWOKmzkA2XsMSAUDiksK1rsI6egwUUBFmkmDuKlGaHYUN3lwVM8BdJM6PbK5D457TTylVmfEXNRQzpR3B+1TJWC9OJBnHUY3CkK8uhUI1xTo6bQy/nvJ8TdduY+DiuCcKPZ+ghlYhV0T+0rl7r60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323842; c=relaxed/simple;
	bh=qOimUxJ53KcSLGVbxV1DywR5xcf/0MPygEdvcHcIyII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=htiZjZ97QAmjB4yrJg3X1o9Ayr3FieKQRkD8XSbP47lmaGEBLqKjLknxXoUb2G96GlXtLDjfwKZBd5zZeVYrL2PZu/oS6M5WQJKPpkk1nkjeeSeFBeaFc44Fk4fz3P07Qlw1Gr+d0FO+FdOEUMymfmNOoyf+GLgL8svjEP4j5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=yhiLnibX; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="yhiLnibX"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43c2fbe2117so3538726fac.0
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2026 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780323839; x=1780928639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ21QY8dl+1eznQFP7IkNssuFzjReRTu6OvtZmgp4rE=;
        b=yhiLnibX1nSPbld0HFESsD/xtJuNE/5u16VlO55NOcfbegeBpRTDsEwJhzGHgoEmmf
         t0pki+IlIgrRCC8RCqtZcLlm7S5sqFoPStwno8oTLR4uvKE4DWnPqGQnclKf5tOrhoZz
         8NuTShHTiKSRK4+a+emXdNozrzymKRnqwlIPQLKIvy9SX4JMJHlMZ7hFIFAHAx5SNzj8
         je2PK/+2yKQ34BXUujCu880uGBMrHaG0cqojSlJnvF44kLwneKSCvdxkTT2P2VFzaf42
         kYcHK19KrEP85OZzL703GLMQ49k/PIU7eI/h3jRRpfy0nTqo8w3IuSUgrA+bh/CrmV9+
         WGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323839; x=1780928639;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZ21QY8dl+1eznQFP7IkNssuFzjReRTu6OvtZmgp4rE=;
        b=BH6xtwVkbwP7U0mXqcwlR62ElAzdjrYcicfm2fBi0xgsZLp26jL+b3HzlObZN61hRW
         bwMO3ygycdvAJl0jqo1BxKTUj5u9n3JRoptWkHQOiHXE2yKp8nvJPROxncufuyC0sSDi
         /s60nAzY8PDLxKTki+ted2+6YNIK4zP9K1XpkF9/sZ+fcREZYChfaEJajd1sl2Pw4td3
         m+YP7wmfA/Cv6yl1ZX4C8mH705Cz2S8as7ef6UyDlqfVz2QRZ6j6ZJ9Fi83ZPEu9ojkO
         XFrecoXaWaP27k6V9hX83Qqo9dHqxD6vE6vXvmdAZneFlz1T924CDzi2Ziy2wcfpNfOV
         bPhg==
X-Forwarded-Encrypted: i=1; AFNElJ8gVZ+n7teO2lvwHZuB8zAWm1EM/0LsNgSA3QB7xz/xxnmhEJAq21z2whZsAyNu3w4YGWqULyMc4UYf@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZKYGF27O59N18u2agS28pvfYeUhNnDFjMYrw3gHka1sZfPcS
	PGLwYU4cnp3+ICpWKlIF16vXIKfi5REjwuNx9lhlRRG0UNaGA7NMxtRc2NSmOIdrByg=
X-Gm-Gg: Acq92OFQGApDPtdgKexSJpo842CTQ+S/ubTC6fevH+uOXVh9bY9clsNUwSsewq2uwGU
	w1ZaEgUfdNm+DuWeBfvaWyQwzl9D0koz8auMQYj3sOOzwu47qxca6NVyeQWDGaBXAMI9uzn+XHL
	Iewz8fONOiv8kmyTfgMT/nw0/1fyyrS6IWnd4Bq+vFLyjW0aI4XgLjUO/X1FhVghx4LRi0/umU7
	PWyIN85yjD9JaDmV8kNwWGLdi0o4xS8Gkc7Jd3FHw8c8u4BTeZ2dnwgrqJm0k3F9bGMn6wqyV+F
	QAaz9DKlAJzfoUof0TNlk/1wxBXr0eGu9KC2ggU3+ERVnLqeu2Bf0JSiRj1pJt2/eAXcWE3RHRC
	AgGLdBFi4M0/1Rni7ICn8524chflswNIAHqSKOwPuT4Tw57ToStbcWuvxeYUfk7q47IPgy2WsZr
	ipwEn/JGwiwkP8WZw4wfxxYMlCrjDh+bQOO5WeSrjjOUt+ZgGPS3/kGPVpzLKLklczErY0CXslY
	c1Qbu9PqK6/Zg==
X-Received: by 2002:a05:6870:9a93:b0:435:9a81:f35f with SMTP id 586e51a60fabf-43ca421d3c5mr6646133fac.21.1780323839410;
        Mon, 01 Jun 2026 07:23:59 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93ae5342sm7818948fac.7.2026.06.01.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:23:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@linux.dev>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20260530011255.52916-1-rosenp@gmail.com>
References: <20260530011255.52916-1-rosenp@gmail.com>
Subject: Re: [PATCH] rbd: check snap_count against RBD_MAX_SNAP_COUNT
Message-Id: <178032383731.395085.5307833564708936991.b4-ty@b4>
Date: Mon, 01 Jun 2026 08:23:57 -0600
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 29 May 2026 18:12:55 -0700, Rosen Penev wrote:
> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
> (~2^61 on 64-bit), which clang flags as always false with
> -Wtautological-constant-out-of-range-compare.
> 
> The proper check here should be that snap_count does not go over
> RBD_MAX_SNAP_COUNT.
> 
> [...]

Applied, thanks!

[1/1] rbd: check snap_count against RBD_MAX_SNAP_COUNT
      commit: 2e1b3f4c51ace14f67201bd2a92ca6312a3c3724

Best regards,
-- 
Jens Axboe



