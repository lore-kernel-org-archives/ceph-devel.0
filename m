Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CE3C465
	for <ceph-devel@vger.kernel.org>; Tue,  7 Apr 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525637; cv=pass; b=Lwxx4ydxk4fbxdA+eVNE/z8YBc3qU+559DhozFiGfaJsghJJa8PZACGec5oNs6fXn922498CCLBNSj/y+9CtwvCrWlsOijyk5+po64uo0na4z2PFFRiCVri6QTjG1hXxggdaOVFqiaaMhtFTUxWaGzWxOhsrw9YDXHZ71s/UxmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525637; c=relaxed/simple;
	bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qiy8ScyVWqcKtXhitKI1MEfhei9TbGTlX4kgaH7GetfS/oJTgRDaxswpnckPLwnej6MOPjHvkuedjPNPrehMwmeuyf/+nlOJr0QoFEyzU5iD2ja9chs4v4MGW8IRCQuuBpVJbrplmNwY+vUADFlDgNkq5qGl84tfoIbWAW9SHvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzSFHsS2; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzSFHsS2"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89cc71f4311so62221126d6.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Apr 2026 18:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775525634; cv=none;
        d=google.com; s=arc-20240605;
        b=RQejEvFpd1S6KVSvAN4N7lUFwIa7/lriC+Rfib2fFWFr8QzYNZEEstJzjdgLxsnrgS
         zq7yc0eWyppvYmt4YaxIB4ooBddvtquotEh2CJ8eFEHk6FKLZJtI9mtuZmo0TszkKG3p
         2OpsMoStc5VtIlnnBu1aRJ1aXvIs4BNgQ7VDgBUzhgUOSUAp2HAoZenb5ASzYS8cSJdK
         mvOrRIS6xWta46qGiBW7E/dYSJft9zeaaTFd64751CqgR5I2YBq8qkcDLZ8IGTSjjTkT
         Jin+dUW3HYIhCDSNBMfGNREkk9WRO34FOA/mGh9eNcmFWFcsBxSd9HoiYPRYpc7Sgi3+
         ODYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        fh=1EoUW7uaYGF56bBz6fzdcOe1FpfdBYDtWnSFVWXUYt4=;
        b=YL4Y7S/v2DvteN0oUp47uaToH72drMDJzQoEJfTzaGYWIXAhTABymv2XiKFryRsgxb
         iGvlcuy9qiNWA82bm2lRUKVcpp9KCQzwUN4HPIcVQNJ/VwqXZlNQzqiD5ijZPeAIcDfE
         AQ0pE802+AQt1YeR4a3P0NtD1fSgonjjAKY8Ggd33C07q0jnYx6jl62Jzt3L2sl1F8k4
         KTxe22C34FdjvISoNHhz7XJBxsWLHTyNyZGweSVix+6eJbersqMm4hrFFRJJgv7ZvnlM
         YGpbEcOssR6AdMXW5uIcvyHDhiEacukrBmvR1ReiN0tKJVQhOGYXeNb+QYXZxARa2rtN
         xldQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775525634; x=1776130434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=gzSFHsS2+LSeEfAyisIiX+v7cGWf53UuxRdlaOdcV+g/gWJY3b7CpLck+aVvS3y5p2
         NP7AnnxXF1/JBg2rEaikZztKBvrGJtbm8oCzR8BcUR9jybpb6iMZVY0pwx1/GoKjfcMa
         yjRNc4FCItEziHOJI8F45l96CuR/3F84lWQDLSPndT0mOzA0kcty+vnejz8cZIKqIWCO
         M30N7623h1KWMOFYPj7KJCpT+K8U3/PY0g0fB1P3WUk80qoyY6Z3Lzgzt4MVzTDkuSiA
         ugvGFaqFJAbjvexFq04TTrMslgppALp/o54V4kWX0UFe1+BKPQTCvRZqyikgtlMy/7lo
         8r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525634; x=1776130434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=pMABAmMfq4ujc3dwDXr0/V2EMb5xDVMAzTWC4DCcKe/+Z58+/eTkYbShw0KN09BsO7
         qtnOnkYnxjT8B2NxE1g283ZczCIvudrk9+G0/Ri8FaHTlw8iLegqnho1zFtSE1jKOVM0
         rr7M9AcGLdGHad2RNeYYMMtR9GSd5DxrtMojvvZEN8OfQ6ify5DeNvuVJndjt2PZXUzy
         GdEutXLRKqdbbyNTkKQji8w3HzrVWNtWrnPLREhEYZCBD1EJB+KMu1gAvQW3wWNVUHev
         BiugofzrLao/ES6V15RJv8bVW6A6SqARfZeyKyZcatdE0/JF4HObZ7XOI9+QDclV50mP
         Sl8g==
X-Forwarded-Encrypted: i=1; AJvYcCVPX5e8P2oQC8CeJ4rCwSaCM0wlXJU3YQ9ObaQzXEqkt0VQtA+eaY9/en1WdCammbJaiCd6J6JLb5RH@vger.kernel.org
X-Gm-Message-State: AOJu0YztnLEUReTm/1M1oDS+70bonsgZ/ldP3AdTHIjuo6AoLl8z4IPz
	YmqkSch82lTDljDDerZFaaGehwmpNaWSkb0YOVTgdkfIBBDgp9FPFS1l1x+uQwCs9x/wlqxpTJL
	qcANn/wHkqyCbReuh2PoOcsbdakq5nGM=
X-Gm-Gg: AeBDiesTF290baGB3vPyQCOP5LP31NEAdDf4lM0rBS4Pp2HsS1/yDE0k3lX/oV1I4Jq
	xZv9RQVdK7zvbQJ+wSSQ+X2+8rie7mInA3zsvQSqJa/ev0jWHosqX1sIkOKUcP7WC4thVp/EvSw
	8T8HaO8Y6Qqpq+DjgZHRvy2lqaUw1xEnmtuFhneHEtpms4yHzC+q0u5JBk8e+4JTq2ubbFIK/12
	S3s1ESsxmI6Bz32wHfHtoyKLA6iKgY/l8P6eqD2d0+G0rmakfc7br4uJqhgtYUZn2afV1C87E4L
	WEyhi115gucTSymeYHpp
X-Received: by 2002:a05:6214:212b:b0:89c:5110:751a with SMTP id
 6a1803df08f44-8a704ac00f3mr250748606d6.44.1775525633467; Mon, 06 Apr 2026
 18:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com>
In-Reply-To: <20260405154816.4774-1-devnexen@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 7 Apr 2026 11:33:40 +1000
X-Gm-Features: AQROBzCkX2gE2vUcwz9Vh41Dy86vV6V6vedD5cjTTBBq9Q2y1TRb7sq-3zFQtYQ
Message-ID: <CAGRGNgUpknQi6PzBWQXeAP0Vh7XjntD_-O4QyjU5tAn8_71=eQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Apr 6, 2026 at 1:50=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 fields (netdevsim) where
> a direct assignment would trigger sparse endianness warnings.

I don't believe that endian swapping significantly affects the
randomness of the data returned, so either:

1. Do something to silence sparse (casts?)
2. Live with the endian swap overhead if they're not in the hot path.

Other than that,

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
