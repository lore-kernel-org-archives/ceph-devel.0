Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108A36C582
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jun 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686608; cv=none; b=LQgCS8AVRaExd+05tCfGz/8BsmTcsSWMwc4bmagRaWHu5Q1+I0oU5iEpc8e95iHaDtIHrUEiHt1tRJRWNBnxvhA9UU9FOd97IZ9MD1zjJY1dh1IavAfiYdYSdfbwlHlDZzeUyQrD+tDnBkacMfz9d0n4iX52Q9mhDTAyLB56saY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686608; c=relaxed/simple;
	bh=TV5LTA3AQzF5RhhwzDW10XuFkTxlq4kM2tdQb1xIhXY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I3IRsfHD15HUgibm+Eb0kipqpkZFHjMlP9iZoEGInJvHVeWSPWCLpz/zQuA3AET0UqdZQ2QxIYHkaFcY5VvzF0oqEDolmuvwIcs79G87zyvcaGLpWJsefJ0xPX6PdND0t9c0Xd3dfieDWtPpRqcCAojBHiFytP9Bl1BwJhp5VQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=VsR7JOtf; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="VsR7JOtf"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6605c3453f2so2578582d50.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 Jun 2026 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780686606; x=1781291406; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TV5LTA3AQzF5RhhwzDW10XuFkTxlq4kM2tdQb1xIhXY=;
        b=VsR7JOtfpNneEDaZO3Fty4kY14DhnPtlc7pribfW1x2ElNz2ThiHCYSaPyp6gcVYEH
         U7OsDiXt1SAdR61qfK3hMRcGxZy8nBsMwwCAOXRVHBSSUEJnDnU6uy94tjJ+jNQuETiL
         7gUH/Go39pxbRv6OP6WPJa6bLzB0cjkqEaKVU4px2DX9s5hecNnKdyYkHGberFmccfkA
         F7+kMHCZBNxYN5/mDKYtu1ibVAW8sG2spYuWJXqgawuprFQ9TTCSYvKy4weOTCe81++l
         uSHL683kQnV+5MhUCx7OxQfUk7ViRqxu4T6UwuCXX/ub238B0aAwBS7n2XtKCzp4CijD
         lRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686606; x=1781291406;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TV5LTA3AQzF5RhhwzDW10XuFkTxlq4kM2tdQb1xIhXY=;
        b=Idc2/qPZd4Dqdu//pwB6dBpzRi6nbrFVuzOWsc1JVCBgYQumXliWxRV9DIELNnKaSw
         LmkkxQJpOdM/w4HZ/djHWbEtLo3e07EhvIBMnCJk6sOOSInoOqLez8ObDStmJES7q1nF
         BrpZquGJMii5ymZ7uG9gjqjpkNM9b+7ub4UlT/tP+S3zu5NSMHxPFHOGSeomzHqQAOos
         8//7zdQzBup2nRT+6QsaqJm3omqrBRP/J5SwGPnK2t4Evf6avavKwsWG6i91fcJZMb4t
         lKSUxyEPbH0fE7J0f4kntJOyCNZd3kvVo0LO61iXVEQ3XAANT9Wnj/nC03Y9ZQAa8IOG
         paYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zuQ4rtgeooLTdA/baDBM3XpDsfEbXPj/OESQX41n01zK1Kzjs56ukCInZ9a1bU5m6a6uwFhkNbBDk@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPk+F8UnQSWuf6dEe7clXUX82U4a4+szR6Qkdyels9Uapm8l4
	0i0CuwuPqMXxwenR4WnFWc4ZHqMDqvAx3M1XauCeDzj9SH3PGQhGH+UdoA88KA7Ieno=
X-Gm-Gg: Acq92OGuqIIeUFRDm+LUzp+0TsAI6SJW8ay/TCS5FP6cP4Cst88djxo5438b5Je+7jA
	Dr38zL98+p7OhY7C8KEP8Oxt/K0+/S0Q/NY0pEEwkjYOibor2CaAFjzoFAO8jxJIKCk2XZs8BvG
	YUDRAH1zSUuZoImSeuoo3VhzpxQgFiTQTCXY1N4w/D3eAC5qgk3sVjr6c4j6ruh7zborJZEHpJy
	DjB8hJccsgYOSw9OAsuaN+Fzxt3EpDzOcPwEv9JEpFRjL89SIBkDVtCrcSJk591AHGMzqS9LVAG
	6qeQ9TwqnRxWr59IJrAOdYD/caTdfENFmPFpmg8VTxQPzXhnp/vipqkI/UF1K5EDSj89FImn4mw
	TfH0rmhddkxi/qobECNVwmqOvF4nLbzudZ7IQME0n7A3s+DO5mH6gNAZlK32tCBkeeDZuPiIHGH
	bO0cyQkrkiSQ0klaf8y6Yqru56ts8cm2Fr/S/rV3Uk6mOf3z/erlMC9oDw6Wuuvr67CrGKQ4m8T
	3htAJo0ll0sFXV64eDe+/8af7KaBtISMvN5xqFpMumXPifygFL9zdGvRiTHPZ+wJbdRovd2walT
	Oyg=
X-Received: by 2002:a53:b886:0:b0:660:5b90:b43b with SMTP id 956f58d0204a3-66106f3bd82mr3848333d50.38.1780686606185;
        Fri, 05 Jun 2026 12:10:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:80ee:99ae:6c1:509d? ([2600:1700:6476:1430:80ee:99ae:6c1:509d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d62040c5sm6042721d50.12.2026.06.05.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:10:05 -0700 (PDT)
Message-ID: <a087d04f74271deaaae736374d2d240e39e77444.camel@dubeyko.com>
Subject: Re: [PATCH 4/4] ceph: cap delegated inode count in
 ceph_parse_deleg_inos()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 05 Jun 2026 12:10:03 -0700
In-Reply-To: <CAJJ9bXyPgNzRRPApmky9FSpAZwao0aG8bFM5gk+ukrBKdM+38Q@mail.gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
	 <8f25e9ac54cb3c408d061993a5a797186aa50506.1780596023.git.michael.bommarito@gmail.com>
	 <c3d563d16537d0bdb03f4d4b7c677de28ab33223.camel@dubeyko.com>
	 <CAJJ9bXyPgNzRRPApmky9FSpAZwao0aG8bFM5gk+ukrBKdM+38Q@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 17:41 -0400, Michael Bommarito wrote:
> On Thu, Jun 4, 2026 at 5:06=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
com>
> wrote:
> > Technically speaking, I am not completely convinced by this limit.
> > Also, this limit is for one single interval. But if attacker tries
> > multiple times, then we can still have memory pressure or run out
> > of
> > memory. I think we need to consider more robust solution. Could we
> > improve the fix?
>=20
> I looked at a per session limit but the lock management gets to be a
> bit more complicated.=C2=A0 If you think that's the right direction, I ca=
n
> implement v2 based on that.
>=20
> About the count, if we move to per session, then do you agree that
> the
> right number is based on some factor of mds_client_prealloc_inos?

I believe that it is right direction. Anyway, it's better than to
operate by assumption or hardcode the constant into the code.

Thanks,
Slava.

