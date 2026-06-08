Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DB2571DD
	for <ceph-devel@vger.kernel.org>; Mon,  8 Jun 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929270; cv=none; b=RyuREtyLJbs8Fzv2g4TSh/wYeD+mtohkbdpAlIziWV704QvHFQB0qr4A8Mgonp8qlr3zYnrREraMhb7DqQ4G3CAk4lFOkIA31odu6UEeDQdoJLLuYGyVcIl+79mkeoxmbuyGKO6piFTEjqv01DXiCIq3z9M4yor0+k1rRJz3me0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929270; c=relaxed/simple;
	bh=2DiM6PFrPZzoOX3Txr45CahtPR9yAKKQFjvEf1Rg/0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EWikDhB7iZ/ZGdG2l+OqWlUfOnO+PAipU/ZwSc9b97Co1WPeTMc86ZaKjEvDDEtQ3LqKPtVu+Xm0doSpmmq2F4JVLHS31HEq045qXGOf5F7HAKBWbZYWfrro8F/mDuwVJDKxbqrw6VGpxGw9Zfk0yLYLAgOFQZVROxxHAW3MRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=l/HTe1ie; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="l/HTe1ie"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6ec655c80so2343160a34.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jun 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780929268; x=1781534068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/M/vbl7ihKt4hB2QPk1iXol4u8SiMgbyxK1Z7CwC08=;
        b=l/HTe1ie4YJiYPZOuEE26ccKoBxrF8bdcepOCEQo4CE1xjTujvlVGJUf+BzxJ9XoDl
         YHGQLFzgOvkitqdfccA1jDm5ypp6ahRXT7yOXavHPPLp6CrN0HaM03vA9ezuLc8wMTv7
         9lqfHgbl7qpupJhLfuCHpQRAlaeqt9zCOfsxo79n3hcNvGA+28PDuY3DY790IZ6Qjgok
         Uz5zeZXPCFGBYxMylz0eQkkwW8ds/7gwX0V3iSrvzmyWXPUW8eGvl97sSzootlyQ1AQE
         9gAiODy8ptUUEU4tb1XENh6IHWCWAXEqPx8KiD8/d3zOxyfUz5Q/q1M6cGL/webkFbJ1
         HD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929268; x=1781534068;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/M/vbl7ihKt4hB2QPk1iXol4u8SiMgbyxK1Z7CwC08=;
        b=Cs4uaQOsRAJFRhmwdP0IK4IiEFra6ZO0Ibb+yjeMTptB4W9jVBbs3XZ757BnMa0675
         sq7w0Qd0S76ChZn+ZyPWpJPOvIFTqCS4ye7Zjzp9rgqw0tHzBxY3GsWa+cdiSC0B/Hry
         mwWRKhlaV2Y1365WdZgFnqKbAlkx2n0rZiB0zF0nPrLsbU+FxYodTWkSgwOy873iVdph
         fzM7mOrsH+cUSbOk6A7YWQ5CxhX8QHshLMjSNUNw7RW3qgoQG+L+bzBVj8NNZi/RINCt
         mNuVjW845bPraZzGs79J+yDr8hy9c2545La7ZGebEaqDYoXW/bc7QLv1FPUwMdD++Mct
         R9GQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Jr5PtsKJ8khUnb+ERGKw9S1fo+lhiRWTyiR/0Tf9mn/CTIspsZa2UcNmA06qwcC7hhejnNa/Nx76O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73l3zWpTrNgI/igdbw33Si7d7Cqug7zkh/5BeJMxFZWWu3XYp
	xDLhMp4P7xa8wZ3v4JsXb5y2+8ZHh+Z6W+4/woLAku+aAROgvEsvyzO/CXpU19WGMOs=
X-Gm-Gg: Acq92OForBDHcZ0B40CRbZNzwhdMXRBlX17ralq9xOMNu7bVUCmu4A1MteV2PYs4yvD
	EBd4OJo0OhaNTlhXZF+tt4JSu1Ooms3qb/YwOyjuxyriMlB3ajkZjl0YBzRwIV3d1D+fLYjZj1G
	C2YsrPBgb5PzeK+0Mosm6oUkmggukQxo4wiOC0nPdjkFnTojZh3pHFpSvvBmrbgjEa/rsSL7TDB
	FGZepMeZC57TbG8VE3erYrmvL6/0/Yrj0j1I3c3yUiNhQ9mOQ3xF/4L3qV4LKAlfQ+qFKlHGZ/F
	ssLGRgD8/0iumYC4hFdw5AwqTHctHyrpBZ9TdufXVgZBgH8f2wFvXhf1QzHVSaz/90ktYFNVVh8
	d2g8WIH+9Z5gKDjQsgnPKlLumUU3Ujrr6mIJd2/dg7oAZV2NK1q400tTc17HfOvtiftQfnIX2+n
	h57plY3qh60tYXf5OP9SfSHOYPCQtUMLe/NtIJFDZ5Q0UMH+VLkWvlsAkwInmPqkCwGvLK7UKIl
	6e8X5dHiEnyWRA=
X-Received: by 2002:a05:6820:4b8a:b0:69d:521d:a4fc with SMTP id 006d021491bc7-69e68b1b38dmr7672050eaf.8.1780929267965;
        Mon, 08 Jun 2026 07:34:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm9622409eaf.9.2026.06.08.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:34:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
 Arnd Bergmann <arnd@kernel.org>, ceph-devel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 david.laight.linux@gmail.com
Cc: Ilya Dryomov <idryomov@gmail.com>
In-Reply-To: <20260606202744.5113-5-david.laight.linux@gmail.com>
References: <20260606202744.5113-5-david.laight.linux@gmail.com>
Subject: Re: [PATCH next] drivers/block/rbd: Use strscpy() to copy strings
 into arrays
Message-Id: <178092926613.1038952.2298978254798273245.b4-ty@b4>
Date: Mon, 08 Jun 2026 08:34:26 -0600
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 06 Jun 2026 21:27:44 +0100, david.laight.linux@gmail.com wrote:
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.

Applied, thanks!

[1/1] drivers/block/rbd: Use strscpy() to copy strings into arrays
      commit: 5ef1b0194b382fafe5023b5b014e4db3b948ee15

Best regards,
-- 
Jens Axboe



