Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751F23AB9D
	for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940518; cv=pass; b=e4i6dTnZ1CHz53rBnU/zHoi6OEeBQfwZgw8h8C5gY+RlQkKAhg++KZlxvrd9ABSpgu5vQOp02G8VZcJ44wIJwUMRQTho2b5zyQfRVBtoin3BusQfGvpQh010V4BkjAa8824ADE7r/PZ3ikPlPdw16x4KsNub2a/0ZubrjSnqAJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940518; c=relaxed/simple;
	bh=BXC+LeXncZBU6bkPxvBsoOCWbiBsY5i65vLwdIrGt64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh2HkSnthLMIRZURl7ilF61vOxFwsP80igaPgQ9d0zE6oKm2GIUypOlwAkGrkN9BC0WAoBXMUyUOgtW318HvJ6njK3VmJbNb9iQLB5hoQ1f2zi3Whh1HntRskwhR5i+kyfyYNlg3m9zEcuOjSRGL2uxa2ehPL7RnKNGMy0CXj2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKAS4mmM; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKAS4mmM"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1279eced0b9so9521061c88.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2026 03:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776940517; cv=none;
        d=google.com; s=arc-20240605;
        b=G15SFSHGEWJgTRJSGyv2srPyCg+9pRxyLbWLUJIkG9TrKHb+ILJPfyeXTs/h+wHhRP
         V/f7ps3329n+4Csw7AZ2vpJpf43HIHU0JBC0s/Co+EOrB5EXxHkTaPiw2UtytKrlNHdz
         8n5WwUcsPj4o6qnsjdTcNgFMs0FR3Kgxmm0asAle/+vDeWE2pKEyM5DIUSTWI6aWSkLf
         A21/Fn7aw6MWVi5u1STPP4sxyYHqt9bEs5o6jIQ4M0iy3hIYg883DFuf9JqBnxttYFZS
         XD0HLHklY5v/7QYC6MnZOqz88G1VKtpc2D4OxOTZd6ASYozUrF6B2jbTW67NS+j+a6jC
         mnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OwiAv+9dvo63WFf0DfIy1mnFWCFx44dnSEZsCWN1fX4=;
        fh=2H0Lt+N2MG9NlMVTXMuJxDjWjYn21cK5l1nGndtQCUo=;
        b=YDBb2IBvfeAZB9BvRc7xZVYcTLQIIsWvNKG7MYoEmDGPHDGXRBOrDwIl2NnXQve7C5
         HR7IhE2h07DwGpAwfDq/PVB4YJDO+MVrn09K1svsV8whRzUZbEf9oH0oNHRMVmWMF3S+
         1V/nRCjEYiZIC1o1ypBo5orpJRoTIghbdDJ7IlJKEIIS0D95Ii5cbSmbCdTcGy/jKzkF
         A7ZyOV2yDuEiLHeYeJKWWKb/O3owoVdLHpf1SKKQlBQqatjit2VAQJBA1bJEqE+zU1yj
         5BhqM30zODoTor6B4+8kjwNouKsYSjgVrk5wLsdxvnXW5NJaCLNXH5A4AGHk1x1Q0O7V
         Z94g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776940517; x=1777545317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwiAv+9dvo63WFf0DfIy1mnFWCFx44dnSEZsCWN1fX4=;
        b=FKAS4mmM1EfoYCG90zDjOx6KYxJxuYBNdLLnCPhIJOPqkueQKneBqvHbzswgDdiKjj
         +1wLY3mNBSo/vblDPL3bko4cw6k84zXkNwu9oWH2+u80kN/8zQ+a8GyZlStFprkYks8I
         Fs9rpCQgDBYRv0RR3NPx4rcC17RqQNLvv/hsWzEej4+QeoXxHAm1go+YwK1uEiNT+jKX
         G3D/seaWdzIUBmH/NLbOin4YSMCdXb+mBVk7bsN0kohRwzCO/sZWCNlTsDbpCRSWnHXE
         au4/HraT4MQhOfDCh13uYguiQoDMuVsBFamWL7SA6Bzoj558tbHAlg/Q9KjtUPljWTkO
         Nv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776940517; x=1777545317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwiAv+9dvo63WFf0DfIy1mnFWCFx44dnSEZsCWN1fX4=;
        b=CYV1b2o/AEICiFzzOihyH0SG5LwOmmYuybzrWrmUIe+jgowCC94EqXxQUPLd2rIVRa
         KmVPFEhqhmULiuJgNyu1+RVG5IpccqmSRYHd2BxxLi4ndLGxroE82i4jtaomLYc0mVtR
         JdfWb2ROZ/NHIOlaGWdo08KzqlstBlP40irILgNwYsyyE+gcoFIGAq/Kg63OwcOTZKfb
         BdV0fE3YUC3OxryFd1aPshqmhhm8I81/BMu/mL1t6kwXEGqu/m7jsAXmJ6o0DxKYS4Qw
         5l3SJa/AfHY7LNOLTmPBOdkaYssc0F2Vhk4ZtwO+cTIeMt3aXICIKdgdgtJFW2jGVNfE
         AtMQ==
X-Gm-Message-State: AOJu0Yz42dtlVefR0zltW6jhd7iL2Hf1IQYt8StNZFd7eHEY7ietlEbL
	LlFfO0Q3xNqHjfouqjdOgZ55VSdsXcHKR1Q0ks0ntrUg0wn2gs6rqpCcYjTwTPwTYjp6ac3dqtl
	Erz3oQGRZSidG0MnEJo5jQzRhY3lWu64=
X-Gm-Gg: AeBDiesqj4Pkoi9KEodBe67+cTHUnDMPB9GSmCXz5LYi+xHgf01dQ1+Y8oKn/zA1JMB
	dn/6lR3+LDqmWUQx9/wgViwwzNlr8B/Jl9/qS8Ysmj238OeoAtf0K30YT9O7SLttmQLHrfzoxdy
	kXrjOKWpiKW0md5/eaWf/Qh3M1J3iKQZ4G8W5kvWBjGe6pcRlAgID1D300ci78DT/skhC9FgpAz
	a9lDQo2UQfwuVr3PhFFyqZ0wvFfQUCImitmctkBT70DZ+g66+LOXUoKMOc/gkW2OjfPF5jNJx94
	5rVN9KcnnoRQVH+Uiw==
X-Received: by 2002:a05:7022:6728:b0:128:cf5c:535a with SMTP id
 a92af1059eb24-12c73f7595emr14698985c88.11.1776940516595; Thu, 23 Apr 2026
 03:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423100904.2336750-1-k.chai@proxmox.com>
In-Reply-To: <20260423100904.2336750-1-k.chai@proxmox.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 23 Apr 2026 12:35:05 +0200
X-Gm-Features: AQROBzAF6kmEV4gwl93pWKt8OtV-yE4bTf9dDTuyM4XdneFljqbQjcu2u89ygXM
Message-ID: <CAOi1vP_=Z9n8aEBZtqLuedfUDka2_80xc28NKWcR5ijgZwUT0Q@mail.gmail.com>
Subject: Re: [PATCH] libceph: accept addrvecs with multiple entries of the
 same type
To: Kefu Chai <k.chai@proxmox.com>
Cc: ceph-devel@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 12:09=E2=80=AFPM Kefu Chai <k.chai@proxmox.com> wro=
te:
>
> ceph_decode_entity_addrvec() rejects any addrvec containing more than
> one entry that matches the requested msgr type (LEGACY or MSGR2),
> logging "another match of type N in addrvec" and returning -EINVAL.
> This breaks legitimate deployments where a daemon advertises multiple
> addresses of the same type, most notably dual-stack (IPv4 + IPv6)
> clusters

Hi Kefu,

My understanding is that dual-stack isn't supported in general:
https://tracker.ceph.com/issues/65631.  The respective references were
purged from the documentation with Radoslaw (offline?) ack.

> and multi-subnet deployments where tooling picks one address
> per listed public_network.

Can you elaborate on when such tooling kicks in, what exactly does it
do and the use case in general?  It's not immediately obvious to me how
having two addresses of the same type/stack and simply ignoring the
second one is better than insisting on having a just single address.

> Match the userspace messenger, which since Nautilus picks the first
> entry of the requested type and silently tolerates subsequent entries.

Do you have a reference to a specific commit?  I'm wondering if it
isn't on that "merged more or less accidentally" list.

Thanks,

                Ilya
