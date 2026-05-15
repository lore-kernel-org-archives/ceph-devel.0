Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8D36213D
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837116; cv=none; b=e8+K982rDjpmGlJHzJ4UglSZWnpnc4XEltoknyrT9EpxgtyV9M7ioiOdP2vUUST+EF0tff8mXTDEMecoq3eufo9a+xyEO4zIhIDFwXfuRGjKAVQw3x4BD0pTVH2ulUoTKlmO2oJRHDwvis6lFcswlAgvG4VH1dUcB0OebkTCQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837116; c=relaxed/simple;
	bh=lhZC0hNmhrRSXTFhzJmYuln2jcA1nY2Sfx1xJETVgRA=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=ffiys075eCJFu3jA5a7euz1URC99dYcvEKuPLMgdupTQmvYHBiVEboxoFfST8uE0zFHyCVbtq4apCQzewqTKSDcp9dSd7zB2RlSmnt1QDo/JRkjHQn0/zyLMJLA9iUB8cLf/xacwx0MeFtNiKLouqbSr1QwwmUoQE2zWbf6qP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=weblinkconsultant.com; spf=pass smtp.mailfrom=weblinkconsultant.com; dkim=pass (2048-bit key) header.d=weblinkconsultant-com.20251104.gappssmtp.com header.i=@weblinkconsultant-com.20251104.gappssmtp.com header.b=hx3Bq5jY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=weblinkconsultant.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weblinkconsultant.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weblinkconsultant-com.20251104.gappssmtp.com header.i=@weblinkconsultant-com.20251104.gappssmtp.com header.b="hx3Bq5jY"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e5eb0fabaso84218671cf.0
        for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=weblinkconsultant-com.20251104.gappssmtp.com; s=20251104; t=1778837114; x=1779441914; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhZC0hNmhrRSXTFhzJmYuln2jcA1nY2Sfx1xJETVgRA=;
        b=hx3Bq5jY67JXeS9A3gzQfdRn54YqsD06E0T0gJWX26mhxkDJnsfDzlXffKrEj8pBuJ
         mT8jkuviCOoSJdTAi/E/n8edOXN8ZW2vY0MWyMo7X6OoAUuuPcdUJSl8rG8270zjanZP
         P2w36r2079dMWl+b5T3m9CWY6Vfv0heHa8FqP6RIFKrxN5/Stvd3f6gKlYESaTkqt0JY
         qgOHI1uojEBxl0tonsuS4/07Ly8PAxcUgtbSYH0peSpWo+xSoD+/s4Q9fJHJMoNhY2FO
         6BB8TOgn7u3QvuAubFKUwdUgOipqJxzT+zoXjxLU/UfHwmqop6a9oAgENH5y3853Oe3/
         bl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837114; x=1779441914;
        h=mime-version:date:content-transfer-encoding:message-id:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhZC0hNmhrRSXTFhzJmYuln2jcA1nY2Sfx1xJETVgRA=;
        b=Ji95fJN9RPLdonecC32YCZI4YBz05Pz6ZJLp/bRzl+RlpoP2gn+dn/oh3/AIieyWBX
         CjURhozQLxccq4GRwP3Vsm/Hn6RfswhqOqPKeyc+s6kxsFMbCwkWx+r7/KpXdEhxVnRS
         A+iOXmJnkZk1lpfXy2LF/fadUz8Zbf3H0Fx3aNHk6mPT/9tgHXSDzl/PAkYUbP+1Ia0Z
         El0YpNHjuBicUuyOt5XB81dxwBfexDneMtF0JHJOx8ScLNdsj4RZtAYHTmUsrzlG2yV6
         5xgFpi/u9BVfVnitNrpSqOcm9nuF8sLh1QHHcw1PzyMiHNPbiosukW14Yqa3r5KBpHyA
         Rh0g==
X-Gm-Message-State: AOJu0Yz7MMNbCMGHl50iyY6HH7pq95sPYJ0Hhc5TL6TlAyzIBUASbG0e
	Q6Os1UIJgdmYdVNkKHbuqCnyMllg9gN2Lmwmll/pPAvBtaWjyNiMpzy/WQaay2jmf3NLrxKUcQ4
	OX/EV2wc=
X-Gm-Gg: Acq92OEQbiLMB8i/pFXVUTY47Vcu064Q+29leGhOTQwWfRaSYz4hq+KkJU7LiEPeNjy
	BIlMn+uiOdRIc5eGDPKx80Lg4rJMLIso4FkHngwHmAjocZjrgb0zTvvMlg2NGJQtxprCZZezigC
	DAIsXyMO2qyw6fMIqWmSCczE4bIoZvNA8QvvidttVMl9WueWIlHGnzkAnvLHO2OMuNpMqQxo/67
	L3D5s8sPxWMEBMlJ508Uu77kg1tZPU1DmyM6U4oA+VH8IsMC5VW4GECdLZqXRW3nodcftgiCKhS
	R9T+cSgg1JTTObjXlUU2Js6W1yx3aGsxhjscALNCPrwZoKN5ZPKcQ9O7eaAlJ1Qk/+9Fz1sG/SE
	GaxjBvZMtA33lUZ/uoiFx8LkVgIiZWap8wlBThBJ6J00iCz+MRu2YboOWpP5R5n+X8cPHZkL9nk
	zCoMQMVFFOtxGwY5MRoj2MPpxGFbZZ3vIyAeO53+bOE4YbX7yIKKJUGDlf/gdW6xuSaSlpJ/kT4
	5DMTw==
X-Received: by 2002:ac8:7e8a:0:b0:501:17a9:5ff5 with SMTP id d75a77b69052e-5165a026c94mr41299121cf.21.1778837113811;
        Fri, 15 May 2026 02:25:13 -0700 (PDT)
Received: from [127.0.0.1] (ec2-34-227-222-246.compute-1.amazonaws.com. [34.227.222.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2db7fbsm47819476d6.28.2026.05.15.02.25.13
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:25:13 -0700 (PDT)
From: Ruth J <ruth@weblinkconsultant.com>
To: ceph-devel@vger.kernel.org
Subject: Partnership Inquiry - Link Insertion & Guest Post Rates for
 ceph.io
Message-ID: <6584ea0f-269e-95d4-7839-139b36c3f67c@weblinkconsultant.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 09:25:12 +0000
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Greetings ceph.io team,=20


My name is Ruth J, and I came across ceph.io =
while researching quality websites. Your site&rsquo;s content quality and =
authority stood out to me.


Our team partners with various clients across =
different industries and are looking to expand our network of reliable =
publishing partners.


To see if we'd be a good fit for collaboration, =
could you please provide the following information:
1. Link insertion price: $? (existing articles)
2. Guest post price: $? =
(800-1200 words + 1-2 links)
3. Link validity: Permanent or time-limited?
4. Link type: Dofollow or nofollow?
5. Sponsored marking: "sponsored" or =
"advertisement&rdquo; or no mark?
6. Content guidelines: Any restrictions?
7. Grey niches: Do you accept CBD, Casino, Dating, Adult links?
8. TAT: Publishing timeframe?


Our aim is to build long-term partnerships =
with reliable publishers.


Looking forward to your response!

Thanks,
Ruth J


P.S. Need immediate help or have quick questions? Message us =
directly on Telegram @ArchSeoSG - we respond fast.


P.P.S. For every reply&mdash;yes or no&mdash;we donate a pack of dog food =
to a local shelter. Even a &ldquo;not interested&rdquo; can help a furry =
friend.


Click Here to Unsubscribe
