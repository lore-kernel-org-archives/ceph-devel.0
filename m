Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768A2701BB
	for <ceph-devel@vger.kernel.org>; Fri,  3 Apr 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239995; cv=pass; b=aI1mWruSnPT65HE+9a8Y6+E386TGwElAfusQJNJ1IekkEkjOYDjifmb8SP7fx3L8GEHpvpWRTThvCmEDXu5lh3X/xQ3LE54dgDJ3k0gVcDdwqnEvIueiVoCsP7OQFx6nr+gk26uGlFbOB/2Ng8zR9UAQ1cYaGFbLVFFn+guoaoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239995; c=relaxed/simple;
	bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmhbCYMjfzMNLYN3IVvXv4vZsYxz1YWNejf1QdMjlXplS23E6mIQ8HO69XcyP2ao4qF3RDdHS5cEp6oVtT1OYoQfkv3BFKfZkkN0puEtrFoudcDb/anJKnbERw/cX/p1O3vCawT7IbtsAiki2/XefE6SBNK7AX1NRXi0W6XFjy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GVvl531T; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GVvl531T"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9b1ffbb9f5so237701466b.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Apr 2026 11:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775239992; cv=none;
        d=google.com; s=arc-20240605;
        b=I0+dfN03cw7rBTJ/5iUeuwZduCbWLC20Ju0cZgE9CojxVj13OSgjQ0jwO5ddocKwHH
         xERqdwKkJdu7z27USlE7Ta5CdzjrfKJ4bdmKKiNXHclLiSD1yAo1yirWZKnN3/P6voby
         oHAb3p86mEzTg9RIUd93imm+74x0v+AJvfVxEdqbSOiBuvCC5PyHlpqOz+DXScAlO1G1
         pg1zEfKxq6rltmSsGXQvivUT6oW5+GyIq859L0Kk+WDOnAJL+zaHQ6YD54jt0fhcjCqt
         Me3kCypshXDUrOP19P8ZDxPFOc8cC/+pRHN+PlVYhx/SpCfJ8UGluLOjbfV29OW0CSCk
         uC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        fh=cV8Ke9886QsAmHh3sFuoCgW0jetRgWbRSUPDPp6W40w=;
        b=ImkSaWwbb//pj0msqfeyj1uxm1yl9pfUc24jyXdFYRXOaRwKsi9g+mr773ywwCjVmg
         KHLyUA5NTkJ0rtrF2FkeDgSIKEp2xzp8HVXw0jXfJt3LUsXMExf++4mZvNb6/IVpx7v0
         xVAyx9JZtkIrwaORrK61ODHGOTs3lYU2zQTA6oChpBCw4/Z7swe0uKHUAzaVUrpGPsun
         03ytqctdCCXKTS0zYyEuPgX+7ZQ/wlwUzdLvHJUY9D0nWX0n1GfgiHTmIu08Nh76zRlv
         IuGGe/mDh9K8TOR8RDg3v1tW1Y0kxQGz0FbiVoDDf9utbn/NB3uGavreD+mzPfe+YJCt
         8ilw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775239992; x=1775844792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        b=GVvl531TxMUOKpb0vNb+9XWD54gbzLa8iMX9bcfWNLMvhKREOiQUmVoaGUy7VTkiSq
         U5qsESEgWGha73syRHIBhBjUjm0fcmyEyviElh5OB0Id2v/2NW8I+2iA5jrmoQv4jkdx
         LNH9xl/kOIQAoOzOmZgTzeX285myu8rzd36mJd2DX/LJPt5Z40Q1HgEap3nrqwQIWwkH
         PEQ7sgKqb+Kz5TKrykDt1pQ4E5s//1gwc7pPA6FaJWnsFmBGFAey+saFHCJwzFFMhTfQ
         kc+qHL4vjYfW/5PXA0yL3EPSHJB3EFUFcwXQ/N3dM9xwevJCTZ5dZZKIU7yJOtYo1nfu
         VuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239992; x=1775844792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        b=i12EsHFluwS9KuNzcWnDP9YPgWm8N2rqXgPLMRo6nx+SopvGhwoYbnaCRVra5lZN0u
         YcYuR8oRmBdyCk6mbc2XmI8CJnMN1FB9+fJaiirxJ8upeja2euRg7HYuKAuIE0JkfDxD
         XuTqqG9u3i68hCuIj8cx+Xx612+/Byvmcwu6O1fm8BC3HeW+kxF6uXxZrakjZ8lAJRsJ
         nCQ+s/3xiNhTGUDcdqYTlxsKRz7V0z5wvtHJCb1Bo7FE1CE5ka6Zx0Cr5wKfdoxl77ag
         KJqo/rh8FBXAQ+zRabjR8tWMxyWUb19CUYFQWVI2zTq4CwoFDcuTAWvYRtRnMLuviGcO
         NQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXZB8p6drRYFbLSK+R+yJzCrQ4oYSSbIzQBH4wvkqz2ezq6rUwegsJXRVZXhDZTwQ4nSw4PNfxIbycy@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFYjAkE4sry3hixAvQ30w6zzQ0rpxsUbLCLxs6BMGeZVokM6V
	oNRkbM42Yxo8RcoOLieggyX0u+FytqdoLivu961ufqb0v+7WptEPxsRyK4MZG+kJrN6mQWCy2o0
	t3QphKwxZrBq8r6uPI664kEfHF8OSA4ZnEJ400c6OzQ==
X-Gm-Gg: AeBDiesrS0pAvnglSGEwHvSGfgFAgj0hYsgTNhotvAdm7jrnj5Bp7xbgFMpsekECAR4
	UE8aSAsg4yyiNfqmBk6fiiphS7m0aYrATx+dIgBZVUzgAw8Sxnq9ywaaxuVHKxSar7ulIqTFIPN
	7pRV+BUYN9R7ZjnnK6vWM4FUEAQ6LN3g3SJkd+DwpscZYbo8pq4/U12yH+Pp//l2sQ9b+y3Exbi
	VTB6P4gsAdJL+tBedYU7k6xszu6Cjs65x3KabcQbEpfhQ/ueyejcXI1KetJuQ5JU8zzlcsF83g7
	W3XHZqX7Owhnt10VLnAw5UxVnSPo26M/RsIP
X-Received: by 2002:a17:907:c002:b0:b97:f22f:43c3 with SMTP id
 a640c23a62f3a-b9c67951924mr190315866b.31.1775239992468; Fri, 03 Apr 2026
 11:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401205613.2095623-1-max.kellermann@ionos.com>
 <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
 <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com> <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
In-Reply-To: <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 3 Apr 2026 20:13:01 +0200
X-Gm-Features: AQROBzCml0wejgS8KWhp_lEvInrGoAcd3uhJWZZ3HEky3MQRfu_mu4yL7bGyHI4
Message-ID: <CAKPOu+_ghf7cw8zT2K-hyKhdWiFaQss2jFQ-JsUUPBU0MmSFfQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 7:18=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat.=
com> wrote:
> Why the offset is not good enough?

Because the "offset" variable tracks the whole write, including the
folios that are supposed to be omitted from the fscache.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
