Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE035975
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280549; cv=none; b=YmzKtuuIeGEd2d27sc+OI3Er68l/6MHD6HT35gaDDhfRJbfICf89lDz/82/BhOTHt0q1gVkoYesEkeofDlkceX9JOatI+yOvutvZU9P+7RZKy7PEIhsI4wii6KLhBpPmUsvElYpWgEwJYrF6AQmQuqlAvt/RbdC4NgffEy2khsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280549; c=relaxed/simple;
	bh=dT+3gtFCWBHqmUjb5xl/LQAG6Yr+VBHDaoUPJyDf9cM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UzrB4dQpsaLY9MuZDygcvH3H9eaKwIVD4T78+fE4og0UsXYbtLNODg2RxGxM/i639Xh4R0NWaZ9of8HewFkQgz+dysruoCUZWeSylBB5IS9g4UTWf5L7Itjd3Fm2zVhKpJ/Rw5KID7YFXrxlveje45vBSZ6WMtj77ikd+FUxQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=CZGLqYh/; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="CZGLqYh/"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ed073fed0so6367747b3.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1785280547; x=1785885347; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dT+3gtFCWBHqmUjb5xl/LQAG6Yr+VBHDaoUPJyDf9cM=;
        b=CZGLqYh/zu61uhdPTh0UxUXsazogyH8akHkeA31rPuAzPxPy5bgTVyJLgNHn26ld+W
         aV+HxPiqzbNKzM1o9MmAZeXfnqH2xm+ufDwESQk2zi3JndCNN+rEqNme+ljYs15Jzm5W
         0IW1eOeZPRnxAndWbqv4migcnesgLEfy6jFXUxv+FkOROdmfH4jMxc32tY5xED3UXZp8
         GvHw7hHlPPgUsR5qbyMzVWiqOfOxKum7yBxB14mQzBjIFJ4Wv0YTdss8y/nC3Rr3SRal
         Hh1uee/Auq5w8GAErAGQRvNxxrA0tLj9+R0Uccx55DR5dJ9ci8o29E8pwDpKxqSXEy6v
         GSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785280547; x=1785885347;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dT+3gtFCWBHqmUjb5xl/LQAG6Yr+VBHDaoUPJyDf9cM=;
        b=TPv/ovzCupCun03OL8gW0dV60CMki7vxcW8Tb5K+57NQtMwmLZS/P26P4cphQQHKMj
         PGUQt1aMID0LDxz5ZZT48C7+TCd+aokvRrfgWdA6OgPvPMN33kN8RR9ZijRyAkClpTwp
         8ICJmuhKpGZ1d/bl+nuP8Jw8FwYYWFAzLmTtjh0194oNS0XDumjEy0+CsG30n9OzHBAR
         zRrvk8n6shzdevJI/1Ozhb5LzB2ZkUK3YMeNJWZhBf6mmbKK9tMGHDf5LlOSjl26iUe1
         CvrpRENF+rrWFvTH7+5HeqBtAx0B94Ei5CMU2G1r5iGTOcqtzZff6n9aBSqq5w1J7Heu
         FknQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDnnMZP+qJ9R7FIqtPjMRK6tbXxgi/QMvDlPqBJPr3gSU4XybdofH+nWMt9MCRi0CfwABWsMhHwUxD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxo9+YC7AmlAPKjAz/VypBIbVkFZGcwiZgPXSAEamS91XGdFdV
	n/cBZnwp5Gl7xczd5+5jYkVq8Jglp6RrG5gwWleJcHz5FdEXQStlcZwDOua+rfiA+XQ=
X-Gm-Gg: AR+sD12fXxq2D15j5xL7ZKw2PgR84bZQarpSB9KZr1D6qGUDfj1gz1IpYfPQFov8lzj
	WUQBUjv7OoDPHJdIobyn+y9ib+lblSSPLfUWKPna8w4uWHBrhwR0HJBOx+yvCYAFohrDLP4u0/5
	SPTcvdShsLr9nbsNuBdFrus+lumuTGOb7MAb/pu2s9WH7eKm3m0urHdHUyPIF+p+uJu64xc8CiA
	lOKqcNFEPby9JiyHYjtR2K6HECEgvPFtk12R4V6jOPs+FQNug7J2s5hXOCwtA/khHLhkxI/9/2q
	MLrE3r4ZTaLmzaLXXWk2RgYePHG1z1VvybqWZLB9Gfzeb7dGF3jnZRDbJMULggn2geKNXLPg/4s
	2QVUOy+4YzWA8Uz3OBqZfb34GHh/iUvYjOnyZ3XBmYDrVwVphnBGIoXITtNLdqKg7Ggqx6/2HJd
	Q85PNx74sLm5ELFTm3+MrqcpWfP5Q4tRxubNyI8WDnDrsUvVpQmZ+4CJguIzsFiz7M2lgn3Qi+j
	G/rWJjMVFYyX3yp9KYcGjSbaYrAfxm4kSSJkIa51TeKQuqgQQ+El4t4S354ginTqhJtdB2XBYAU
	h+2BXYJuHn+DynyUZN7d8Nge46ULHUetJ1p4Zni3hpq2Tp38ZIY0phw=
X-Received: by 2002:a05:690c:6a0e:b0:80d:66b2:84e with SMTP id 00721157ae682-81f992b328amr23743647b3.50.1785280546865;
        Tue, 28 Jul 2026 16:15:46 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa292a6ccsm7754917b3.29.2026.07.28.16.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:15:45 -0700 (PDT)
Message-ID: <56b420789e339d168e825cc162ddaf6a66daeec2.camel@dubeyko.com>
Subject: Re: [PATCH 1/1] libceph: use RCU to protect monmap in
 ceph_compare_options()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yong Wang <edragain@163.com>, Viacheslav Dubeyko
 <Slava.Dubeyko@ibm.com>,  "ceph-devel@vger.kernel.org"	
 <ceph-devel@vger.kernel.org>, "enjou1224z@gmail.com" <enjou1224z@gmail.com>
Cc: "sage@newdream.net" <sage@newdream.net>, "idryomov@gmail.com"	
 <idryomov@gmail.com>, "dstsmallbird@foxmail.com"
 <dstsmallbird@foxmail.com>,  Alex Markuze <amarkuze@redhat.com>,
 "yuantan098@gmail.com" <yuantan098@gmail.com>
Date: Tue, 28 Jul 2026 16:15:43 -0700
In-Reply-To: <c7648fd0-d311-4757-aeeb-f66d261e3fbf@163.com>
References: <cover.1783423648.git.edragain@163.com>
	 <f9b8b94904378d14111606a3cfee801c60492681.1783423648.git.edragain@163.com>
	 <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com>
	 <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
	 <522d0bf88c127d2c8ca4f4e5055e77e2918d4bd2.camel@ibm.com>
	 <7a71431b-4c39-47cb-baac-0cbad03e13c9@163.com>
	 <ee478394c5d2ec19dd0b5ce39adb9476c826cf39.camel@dubeyko.com>
	 <c7648fd0-d311-4757-aeeb-f66d261e3fbf@163.com>
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

Hi Yong,

On Mon, 2026-07-27 at 11:35 +0800, Yong Wang wrote:
>=20
>=20

<skipped>

> Hi Slava,
>=20
> Thank you for your review.
>=20
> This patch has been sitting for quite a while, so I wanted to
> politely
> check whether there has been any progress on it, or if there is
> anything
> more I should do on my side to help move it forward.
>=20

Ilya sends patches upstream. So, please, ping the Ilya.

Thanks,
Slava.
