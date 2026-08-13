Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B0476CEB
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625015; cv=pass; b=nXbJCoU3AFk67XPjrSn1GnC+yKUhG7iIVM9eD0xY6lLsWA60sT9vx7ZlkYzWfPgwMwFJkIWQzW7cVZyO1Q7XVScz2OPfnTyiOvgpMwBL82jGYa6TjjcieVN4BN2VUpiryAd6z/g2MOvUyAzhUbtz4GHemtKg3njotFvWme9zW2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625015; c=relaxed/simple;
	bh=LE0W4ghIynQhDyZeR2wNn0ft8QjUAQzzYft5G8I2/n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kkd+FAo49Q9FXGr6g8qrR9tvV5c7PSgC20Nw6C+OeAQejxBtVSdqzvkBHlMtsuCreW1bVMn+J/Y1Exwcb4Kc/eFk47I2LEOkmBKW8nXGUuBK9zVa3MwZSQkWT25cvAYhhD5L3gEsxpo8pEaOXdPPAiZYELQYZ1OFbjxnVZXljEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IYvtr0HX; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IYvtr0HX"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1fbe461f59so330129466b.2
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 05:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786625004; cv=none;
        d=google.com; s=arc-20260327;
        b=BU09HK6ZgRdpOZwEm6Zng6h5SQns4NdnVALhht5tXnqI/7wJ0dc5YEwjGetBj+4NjC
         m4dN5sZG2cE2/PcZkUNLlPmDTSDs9dQEBEycURaKtOqtfk1ih7auUA2crnjdkYk7NMFy
         RsHoCDip4t4TqMlzgyjIlhr8aJWv/17krGQoWdVMWKQsKInM6vutVKINmataTEt/mpNg
         fCQkuJbqzZ5cTP8jqttOzPR63+WKG1Nsd1tlfdSnPvpdwM5KGJWp/hSQdL6+QOfi6LqY
         bkzKxM/vkeGNs6nAMQxo2yOOQlrcAipu+o2biMaN02TzvqsrouOC+F3AQ3Gt/m6pYiOL
         LKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LE0W4ghIynQhDyZeR2wNn0ft8QjUAQzzYft5G8I2/n8=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=XW8vteWBuni4VyMYzwNBO4tHWIK0nL5Xc3aRxZmrFRNXrzJUung2QMEPXWZAkwBzZ3
         l5tYEj3yXkYv3Adbv1tsPA6AEN5k5UD6JQfhf/6sL4oi1+jTVzWMszsphbXGkzTJzdC5
         Lbu8s7AI4chhhqrEf8RPJVW/fSsLcOFvj+bd8rUsEk3Hjv7ud2BFNpO2soyfxSLAxYNR
         qzVYlSOxIrB+H2xenfXEckLKpBT9a7jon5O9whf1bBJES0MeAeyv0Td65BMn0xS24mdM
         n2EfZRtFl16hWZRhA9iMnlh0juU7uU3VUtJGoCwDyCiwjI9EHmw5IwLMmnKKAwl2zoJX
         qbpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786625004; x=1787229804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LE0W4ghIynQhDyZeR2wNn0ft8QjUAQzzYft5G8I2/n8=;
        b=IYvtr0HXDT6FxZ09jptQ/5d7ajOJN8OTpQPHtJK6m6ndv6xCY1ulTWkWV9hVFcUpjP
         Et2+7zoJODynPETisIuWR5dUrjJrqsu8TLiZ+W9wmU19g03LSdPFBbvFiMKZHRH1IbmV
         9+8i1s4TMWEqINFLEdjRoCFbHpTu639ukyE6Qf/Dg+DTapcZqLv+y3HHabhXx1MElCfp
         3RTDsMCdlDFssfqoZLctCeFJf5K7KeYLOwwFNEvC80Mpib0IMz6/pxP0VApeR/DWv5Qy
         2OfFTEej2ik4sD5C3D+yvdYs/INOs5jF1Bn1orCbmbBeHe4hBOLN/AmZXuWhiILgCUop
         aApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625004; x=1787229804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LE0W4ghIynQhDyZeR2wNn0ft8QjUAQzzYft5G8I2/n8=;
        b=HXCdHEj2lFpa8Yeh40ffkmBZ1T4tfZjfJR4LXLT4qWClX5YYoPUQKZxAD/DAbwPHJo
         uKp4NAKcoN5E7X2pe75FQ40aO44xq3q2tP89CrLpMdHEeaUgwmoHnY3AUWHapkKznJ/a
         /x2OUsmiIYiMp5KbomIdYUux/bwQzHkAq6+zj5555EcIvjRk/ilNBVSr7hw8FrcMtov0
         KiPcjwplsvEektytj/uvzeJ31AVIrG0bihVo4qC17HrRXncjlQc0rUthCGBpPzB9np+H
         XTuLSKTuBCGgbL2FCUEXM4vCn8fuqceyHTZRkN6T+icIBnc0L39mSAuFnUlPbMXNpBhG
         JpXg==
X-Gm-Message-State: AOJu0YyaezNfngA4EGWas254miQFp6pxttvyb0jgO2fTkChyvwWhNlnW
	Ry89sacfgKKMPhetLtdOpip7c1F0H1JWKoPz7GktJXSHbxOyR5FrFonmxADwE4eOFof/LJ3IT/b
	GbRuTM6IHlqHrpFyfm2/m42G5FS0eUThYj4TONuNSHA==
X-Gm-Gg: AR+sD119Gn80cDMfVS7gwQhB0BJJN3awaFp6DsOUjdFRkZVW5K2kGTgA8Pq20XMZvkI
	/ihG+2orRsJsLV9KRFg/Y9LmNioGZDSms/e1Q0MfVKT1vJ5xAFLZkJ3qKaIzA8AVHVBInTWwU4N
	s6To2cMqk89NQhvlO4YvhY6QjYnlCUn/qIEFexCjvkZ4Iz3WgeXFULbNZdcElSQMCUIl1Qm/AAR
	SYlPBbIO3Ai0a7XN0qzVFIhLk8v0HfhZHSqTx7CtX0rWsODSEkemhkbzD50VgN8ql95+OeJve99
	zieOE1sKQOjW1q1FcmEwn1OxGbzl/f+/DGl+MeVUNT7GDAmLJDg2MVXpfIu8vmxaJ++yt9cff/L
	gqgZMW8qpYg==
X-Received: by 2002:a17:906:fe0d:b0:c1f:7e26:5b94 with SMTP id
 a640c23a62f3a-c21090f18fdmr274067466b.30.1786625004540; Thu, 13 Aug 2026
 05:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812204920.1805545-1-max.kellermann@ionos.com> <20260813123137.4005275-1-amarkuze@redhat.com>
In-Reply-To: <20260813123137.4005275-1-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 13 Aug 2026 14:43:13 +0200
X-Gm-Features: AUfX_mxGGQgh2dGiezY6lZ70F392Y-hV0DRsFY1TUm7p_EmZqX9tHwxs3LOhUEY
Message-ID: <CAKPOu+8aW59jU81H6ky=9k_M4XRWegiN8x6ZmFzvvS5ek_M0wA@mail.gmail.com>
Subject: Re: [v2] fs/ceph/super: document struct ceph_dentry_info and its flags
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:31=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> The dir-lease time field description still says "last touched" =E2=80=94 =
that's
> still wrong from v1. It's the insert/requeue timestamp used for aging
> against dir_lease_ttl, not a last-touch time.

I replied to that part of your last email here:
https://lore.kernel.org/ceph-devel/CAKPOu+946t8E6b6U0UtyqddoU869-tNg96BkytC=
a2MOsB6QsuA@mail.gmail.com/

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
