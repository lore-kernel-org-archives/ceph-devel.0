Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB33385A1
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jul 2026 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063158; cv=pass; b=toDkQZtNA45Enaj/7I3XZlMwhT0qzlEEwi/Z55hK/4kmOh0ixWgH4ovWWnIZ+LxfTpX1yMILhnZp5FqB8arh61d7dnabNsiI75Acwn+pSV8VhrBJD8aWgA1E0ApFBO6PkYHA4M4CXTVxe7rT2of7AnQFzxbQT/FZx/c+4sQ6j+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063158; c=relaxed/simple;
	bh=3HXCEvX6N6nX0aCFEAS+jMcqF5jkOBzezFSMDmPp8Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRvI/SS6y44MiuHLNKJilsIbVTkspixBoWTinRzDVOe7rD8IorcrnT0pEHHL8IHzHN/914nRts4D59mfZTpS3HN80zyM/ZfV6/zdghBZqgCpU3RU5zeczbgewnfkHyy8ZczLu2XdL7pjegwG2gieMnbmkf5No2pvO3ukpAg9qhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CJeJpMxY; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CJeJpMxY"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6989c0ec3c5so511334a12.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jul 2026 00:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783063155; cv=none;
        d=google.com; s=arc-20260327;
        b=pv12wzBK7gN+RSaH7rpe1/XKsvXsrRCWmQstQOq1p7RqzxIP9QLdnK510OgMF7K72K
         AOH7b7aavMcAphBQgAeMr+OWtqw7iZaBslFscNlwQieD765I7rOgUb8Zn/xxGIQKV3/n
         cWmZqZoj9+kWr/st6zhKMq2rjtUuAOjrI5PC7VIlVfETO82GAEGE5bDMCUadP1cCmSWt
         8+Kgqp2JP9vd+cUNhyIifWAIFcfcvjQUI2Jcw41BTdkovuNxPYidqSVjTg28s0dxxPee
         kIvZaBjYqzhttWOxcNcOG74dyXZ+5vNzaSqMS6WJzBa2F0PjNJnS3Tv/iHh1AtGiDhe3
         Dzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pbfplmAijPEwOrPInr8EHkAX+cXCfBoQnNptONvnCJk=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=dtcQbyiCKWsEfvDoMCg0idk2J5VwKgBwvA+Zplo7srscKkQVHH8w7rxWbkhUQ79n6Y
         u17OZdShIMbtq+36ZmwU6MCCngLNK3JFv5jZUuOf024nTP7ddH9GXmviO0dw+sDpbuUx
         drHOe808Go+/3j98ZE03yghxXt8LKvCuV7asFu2vR/6HjhTpLjZpjB5I2xf+1fGBXsGu
         78/nJmtPhRruomo1/HYzom5iG2iMThqQeeDnfdoQ5rWVLEwBj047lsC2wE5WXaWCyZq9
         SDzDbCRYRkqmqagFu6p4tYxfq3H22T9ISqVrn96ajZ+bUAMyoEzIWVkhphitWKokE6c3
         qC6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783063155; x=1783667955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pbfplmAijPEwOrPInr8EHkAX+cXCfBoQnNptONvnCJk=;
        b=CJeJpMxY0Yo7ixasaYrmJmu1Zhyy8la7NfQvjHiK37CRVq1vFtLkg3DfSQVqHC+mZj
         xUl8dV21vMBIyaTzIfmp+DxN+JUEezxrFZp5BZnqKxOUbz0+Nsj31CIQGayRovdOd622
         beEM3sb2KsFwIKZX2PQpcUA5RHzZ/UZLYAPw1qtxnUyzsK5Uof+wMr48u/BV5qUuRNQD
         4jgzBNULcoj9ZFcdrMx65J7GFE+au7mfv5cuTBQtGH0wfGST4to37H5HO8Dr+sxcyqLI
         Y7ZDzqaiwRJTlD4BjX6drt3Kk/1svXB3ZXlpATneHSNI9Z0b18KC4RwNO6pXPLxmuAeq
         DYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783063155; x=1783667955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbfplmAijPEwOrPInr8EHkAX+cXCfBoQnNptONvnCJk=;
        b=QxUEWtWQhZUYkMJSSYr8/wLBFgd7ZKXXoEVDCYwDBwSzrVVatRU9JJvY//uljTCavu
         wUy85riR0+wEfM2PHe4w+zm7cRzP2B8c0H+JMNjDZ+5XTQr51MpOUWhoKvfdHshIs1zm
         M1kQg7ATdRXb8gj6aTvesQQZB4vaNfAYUe35Id9bHe8k82Ogm9WGIb29eZ71tIFAfCNx
         cvFZ+cu25ownOyDRfCQdKafuFPGmS0WA6tfIBcBSTPiTj8dcQ/971B0Yu3WFWvcpLTko
         soRqqos62AL0F3qBxre78slX9v8YzJsmUQsU2fSsiYDiBEMwtFZ93fkSBlz4MNmsmNQ/
         K1mg==
X-Gm-Message-State: AOJu0Yyaj0HAiSbRXe/X3D33C0Dn6eV4PJAl51djC21+sINHUZ9/yXYB
	wSByS0F4nuFb+fj7Ezdh+EiI4TNak/5Zu8xRcoR6I5l5zllKjThS8P5tiQmf/l8KXQBlZ6UheY4
	/qIVbQW0+IhUIUWAL/fRsL9FNfVZwJ/0fZ+pAaM09BLeTN5jR9nUrC4o=
X-Gm-Gg: AfdE7cmdklnl+ZChklSVhOlecOZ0nVIRMzkYT6rFfosVY7jKq8T8dFBtRNI0r+FA0D7
	hQ9kde4lPgLQvfB6LQm3hmtNmCWrLqog72AAsug5gIqimsg7+s5sW3X7OXEclY+FqDLZu2qUtNl
	BUz0O+tJMDla6bwc9tAMi+AavFVCBq8AYWTS3Lle5PkAtllHvMAU3AF+86kTQ8H4jDXLZ5Im0md
	WP5HelNKeBTMzaOW9zwnqS/NiVdC/a0n98qgaHpXlt4gLw/l/n9B35eqBLjDCyUBx/SlbJPjmvK
	6C3QyUfUCop15m+iGL5/zT9ncw==
X-Received: by 2002:a17:906:fe03:b0:c12:b2e0:2835 with SMTP id
 a640c23a62f3a-c12b2e02ca4mr335071766b.10.1783063154921; Fri, 03 Jul 2026
 00:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629195540.2892415-1-max.kellermann@ionos.com> <20260702114034.917507-7-amarkuze@redhat.com>
In-Reply-To: <20260702114034.917507-7-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 3 Jul 2026 09:19:03 +0200
X-Gm-Features: AVVi8Cf9ZZP3DRA9-WfKRh7Xac-EBx9zIB8b8SUoCc18-0-BbxGFPoa2wDjwQbA
Message-ID: <CAKPOu+_hTu+v_whwC6cA-zvXV4SfmUox5_Ghc0UkPBJbV7btnQ@mail.gmail.com>
Subject: Re: net/ceph/messenger: support IPv6 Link-Local with scope identifier
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 1:40=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> w=
rote:
>
> Hi Max,
>
> NACK for now. Thanks for the patch, but I have some concerns
> that need a v2:
>
>   1. [critical] net/ceph/messenger.c:1251: NULL pointer dereference via c=
eph_dns_resolve_name
>   2. [major] net/ceph/messenger.c:1251: IPv4 port parsing regression

Need more information on these.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
