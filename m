Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBF52BE5F
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073278; cv=pass; b=DZDfZX5aOoR5ZOq4RHqzH0Pq9eb2/Xfh70H1/IfVJ6y5Z7cUlYjfaYC6u5SSO5/OX/hh99MEhcuqzDKKXNeouiKvj/Ui0OHEcCYlNfSKMfu9FF0xE9YOa2ntSzIrTTIpfLLSsCLJBJYamOFxGDwScDBJw6zfLxRhhkTz90FIoxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073278; c=relaxed/simple;
	bh=ItHKc3HnkTEkz1Ak95cIQWYaLbvA42BxU4/kqbvpTsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jiqpg2cHstQ7I0yHrIHlpVSOiFjOJ1q6y1VL4yybYqbpW3/MNwAVdjpynHPSq2Fe+hJELjQRf0tuGQd7IIt2+K84GS9GM0t/gRUn0RzNny222qoOZV6fkk7XogPdD8NL+4cqtS+qSAqVC1OarkSMY193V4BY+NSYqSYUNB7U3lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KXw7BxKX; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KXw7BxKX"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso136944666b.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 07:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073275; cv=none;
        d=google.com; s=arc-20260327;
        b=VxNyfkSP1Nc6nOwBC/1pORUI6XlD503LaOIMX3Q6PAgYTtZ+cDueLK9JkMa2pkeqqE
         RWaoh/oSJ8dKKvExJ4+1j87pTUmvB61EIXE/lLPNxPv1yTrHNbostMlEHWboKY7/siu+
         QJBDfGFShsNN5Xfvu38d2/EW7YOZh3EZr+fNgt2Dn+zFbEtt1lmC0apQP0qdjU79lPq3
         49BFOac1PKjm1jOL2LqC4isdIgUTKtAAP6tVs0HBzs/p4gINi8UOR0/Nuu7uWmijpfKT
         3BSdV+kBArzrICeMwsgBxK5bFvxAOJIzIpWXwJPaXdslnXMgbi6rouJXQSRbG5nVgQ4a
         LfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ItHKc3HnkTEkz1Ak95cIQWYaLbvA42BxU4/kqbvpTsc=;
        fh=mqr4HmUMwuieRs++QZvaNFv4Juiyn4jzR+w2b0dA/CA=;
        b=dtcpzgPFYQjyWRCH2A3Yv2xydIA525t/+0Y0LiJC9/He3pUrt782DIWUiAdOvepFQS
         dNfXSjYb+s/Gj9zVFfMjufaVyujzTP1E/dVpMRiQPMdkgLaE2fWVJ60Tq+2v0DneMLvq
         IvwneKqJtbBfTJC5k8+gNBegb1xD7fHEA2n8rDV4yMu7Wi78lby+dhznkistRM4GgJpB
         4TRa0sdsEApDelA2SXbkKGZA3TX9MX1S5N2NRrl4pnLU4wG1G1eE6Pl/yD12FwvdOFWA
         MbBbYgi3hFhGUCdNcIyEA5Hi278U1ReOLRsIdA3sLYyPneX0VRHuEtvW+Q00ARqqdjVQ
         HPTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1792073275; x=1792678075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ItHKc3HnkTEkz1Ak95cIQWYaLbvA42BxU4/kqbvpTsc=;
        b=KXw7BxKXPQDpdGXASq6eNZfdi/QZyW4YWHssUtB6Pnx1HNbIabhrv7gXZZgxFm0xiP
         MywBsZys4hjY5ABd0tm5lsONDwLJMooisJI70q7obaaDR5qikQlxnkRBJbve4vjbnFYw
         KYDqeiu0EsAC3KW8BdcIFCaUB/IQ4LWlayzK2vhTSieRxNSUEvk2U7y7ac/MmUTcd/0h
         zQ9KoIGjmxbe42BP8pdI2CxV/vi56K82Wa77L+qw+VCMnFAhqkpLgc9KtBro3S5q5XwG
         RLhOXUWsFmKfHyP74bfzMJz8VE8Fb8U2h6j4vop76811sNZJs3xqYzZjWfrbqLAHEbn9
         6HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073275; x=1792678075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItHKc3HnkTEkz1Ak95cIQWYaLbvA42BxU4/kqbvpTsc=;
        b=BUDqVqCiTZ/dxiuvFE8EVKCFevXsE9idjbRlc74e4mzXe/aICX96ngMI3g8cBSSVB7
         38kYLL3EhFSD+C9MyN3mvq4u/qnzJGYTuOCDojHy/m2IohtPBq9gcIJfoB1TDuzbu0/Z
         w0wSDKESlT+mvHOGyey2QwyXbMgOYkrY4vNLF05CB27FTdbmbwk8Ffp6HqiHltvXFm2H
         Hedpzzgt97Qp4SZs9guPpjOkrU8ViyUUjp/Qq4Myq/EjZJxGuzWnRyNQiW9fim1K3jFm
         fFW6YbtKzQ73I4wNuSDO8tz4m3msvmzr/B5qBfh6YRr0QkkX332N++tantzMnmCv/3Ox
         Ww2g==
X-Forwarded-Encrypted: i=1; AKwUvByCVzrLWkBt4LeEBeFBUG4N9oPwPPXDp1n8Oo2epPDL2qT44Bnc0+KG5OZVyAQvYdUvIx5Sw3IXumlj@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4OSdLuoeVh4IQLd3fgJQa/owiGH0fZJtZ5WhuLy6Ir2pEiEQm
	Wfa6EtLfNeiqORhACdvIBJziST9kpHZHy17lFf18QHsCDx+qTd5YE8SSFdKu2VVSTkuvr/HRPZ0
	eEWuI0DOiioUCFRe8wsPmO7/tpc/thDO0OsZ5g8oMEw==
X-Gm-Gg: AYBFou3faLa/V4HQsNzFViITcJ7AF1UaBDJNhREaoSih1BjrDw89Y9A6ajcsIyoF4d+
	bAZw9pfwijYlqgORNszvaooWVYKp8sA2kRv2jJYIn5rNZ2IY8GfALJ4EBI/5XJhWchUXBvzqQ3J
	LrMQJUH/bozLvyMgAINZt4eGL5h2xP8UIHiMvYJ83NwcPeZIM95h5tzBMuLhhMfkLP26i5xq7vW
	xyDs5Ppz6IJrp++beZErJFKqOUFk/LOmmoDOaFqMgcAWDOr1Oexc9eJ3B4wt6A3W28deSyTizII
	0c68b9+zMuSEidpmtuMVyEjEOPVcxRLRe1pwD9UJQgNkwy/zWOjMs6xmAE6WIH05ncbfb8U01T7
	XP5EUEPGH
X-Received: by 2002:a17:907:2d88:b0:c2e:4373:521 with SMTP id
 a640c23a62f3a-c31aa0d2286mr1635346166b.46.1792073274619; Thu, 15 Oct 2026
 07:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com> <CAKPOu+_Msno=mux+FUc-oV1-ywRFujJcnKS2HNv0sjtRVtUP3A@mail.gmail.com>
 <CAO8a2Sj2UbocxY+_MRdcH1TWht=UJT+ANWmzqLY9MQxZ0ujUpw@mail.gmail.com>
 <CAO8a2SiVWYSR6s=Z34QcfPVNVSLGk+YQQza4DDEt8_8+j37AHg@mail.gmail.com>
 <CAKPOu+9x_7WQmKhW==AmLoSzuPrUqeSV+JR69-TaovjEhuj6Ew@mail.gmail.com> <CAO8a2ShEjqyNA41ujmF5GfOM+YbJvXqCHKO9V++KBkJCXNOSUA@mail.gmail.com>
In-Reply-To: <CAO8a2ShEjqyNA41ujmF5GfOM+YbJvXqCHKO9V++KBkJCXNOSUA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 15 Oct 2026 16:07:43 +0200
X-Gm-Features: AclHuK8oqOt_bo8LfOev4v7Ru6cCWNONf2R_xe0ALbyDnAjTbsaYA2fl8J-_3FU
Message-ID: <CAKPOu+_+oCzprewMeggY=32eEUt5ukTvhVMbEFGSh3Owa1zJhw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: Alex Markuze <amarkuze@redhat.com>
Cc: "chenyuxi (D)" <chenyuxi19@huawei.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, xiubo.li@clyso.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:42=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> > I see no rebase conflicts with linus/master nor ceph-client/for-linus.
> > What other recent changes would make resending necessary?
>
> Please use the ceph fork and the testing branch.
> Since the last merge with main Linux the testing branch has grown by
> upwards of 100 acked patches.

I just did that and got no rebase conflicts here either.
I still need to know why you want me to resend the same patches without cha=
nges.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
