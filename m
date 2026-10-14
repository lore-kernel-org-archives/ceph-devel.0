Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E364F6485
	for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977280; cv=pass; b=gIpPfVfT3uKk0gI/BdySdReDoJdrAkfNwYnhEvUQ51wvpksIpr52M3ahVcCQUINV7/jdcpDWkiUK2H6medzfxCgSPjv3nywhoNQF2ohDzI21uMxJPygTJO1GE3vXOsGHGxjImIs+ca0iTga8uJk5jp9vwBFiNMGChLW3cUv/tM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977280; c=relaxed/simple;
	bh=a5L7wozFkjsRHYT3hIlj5vF3CGkGjnoIBdPSuy5ToFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1uBt8oZX52j7SbN3bZ0hK5NGjWJuCLYMr71FB2EWRlRFG7NZUXtU4/zPoE84vSD7Bbbd67AQpK5MK5WcITEUelUq+Mdod0uFaAaDc1ARuNeaLJYN695X0J4dEyN4zrTmLlpB0oxGfXSBm8uS3SYE3uKVe72IWnX/PxZvAcKAVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWlJJANF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+PwQ7h2; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWlJJANF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+PwQ7h2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791977277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5L7wozFkjsRHYT3hIlj5vF3CGkGjnoIBdPSuy5ToFI=;
	b=KWlJJANF0kAW0/76/Xexm2NTzyomO/CjR2YTg2ZRZ3ngcqXoN/0NYyXV+HeWUdGa9rVxs/
	Yx81tPEKaJaN1yRcWkf0mpwEGP+OjdPCmsms9LIgQdkF4ebC4IUatcJJjp/TpPxhiz4F34
	wKANnL4oUMx9FFgljHEq1JqvqWk8w/Y=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-vjVNLBiRMYep24L2nPIkyA-1; Wed, 14 Oct 2026 11:27:56 +0000
X-MC-Unique: vjVNLBiRMYep24L2nPIkyA-1
X-Mimecast-MFC-AGG-ID: vjVNLBiRMYep24L2nPIkyA_1791977276
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98087b0c5deso3039219241.2
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 04:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977276; cv=none;
        d=google.com; s=arc-20260327;
        b=Zd70xfbgv7onzg1uCl7CvlUEr6M9EBPqgTqMpMy++sl0zPP/npk1fmqhF3IajuLunQ
         MNBA5q9Svina4Fia1aOOMvzAZKtGPoBI7dVhQW2vV1CyaYQHEY4eEveJpHcubNPYVBoz
         8OQWmM3RFCdP1TnJu3OlzWQVm93/VF/c1B6hftBNXcJtBMbM2Oaej0fSRH99CiHz+As9
         4iBp3W9hTH6zMAgs8CWuy4Og4DPECY80rV+YsfTDayrrGIaPlJqrSo5+eokNJPtF18IQ
         N+w53oprEj0/gs8n/VGw49OhDfxd5ft4+ciKb+GTL1qfV3mkTmewF1+V5e9pUePN8SCS
         P4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a5L7wozFkjsRHYT3hIlj5vF3CGkGjnoIBdPSuy5ToFI=;
        fh=mPQxhI2U/CQyy8sxigRRGzEZkNy5m0LfVjI4lWlHSZs=;
        b=h6gHUR8cSQ8ylKUpbxMnd8wDZrlzu+QMHCyn22+U1eCMD7HFBVdZ6RYdrWcigNI4A8
         8bA5AikpQ4GYXFby/vVWj8kXmKgui8/035xCJonqFsP7DWAYNmj/kDQiRYdt9oX7MCKi
         q8OGQXJ22GbIq6HvS/z3DRTl1NPbhiceUKnXq/DQvRd+8vyA/ZbXdSkvo5990cQv8qEz
         Yrl/i0Xcnax7OvAVmogkk0Da0VXCb3RcvtSQvfbdm3eGeuYFUNE9flMtC6BSrMS5GcG2
         rmJHc/SjYP5XAuQJkh8n9O4eFFZStWpAHRuNHsMfLjhkdY23p3d6lWKFQnc1h5/boYRu
         umiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791977276; x=1792582076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a5L7wozFkjsRHYT3hIlj5vF3CGkGjnoIBdPSuy5ToFI=;
        b=G+PwQ7h2b14exe+hjOHrGOljFppyQr3giJWS06N1eoYjRxC4e7IQcOewyGtkpmNO9D
         tRGSl8M2XU2ck5oqhfVF2whFfK4j6o5o+8a9h8CiF9EI/Ubk+pNWFjfsgyX5vzCTufhJ
         9H6FD0wulQbYLaQkHlH0u2/7C4rQB64Sa022+nijCRD96y3NGklArT14fbgGjL8JyBhp
         RkkauDChrvYSwhkcmToJGoBf1vagLjz7+Xl6D/D70F+fvFoCtzwNhUbAS9ubNXgUxvmO
         uY1PfHIaDR+TqUdNy3fQs2wJ8tXLhMvDuM4Tgd7a0wK5ufI2X95DXAGyj3TmPv89I3GG
         MUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977276; x=1792582076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5L7wozFkjsRHYT3hIlj5vF3CGkGjnoIBdPSuy5ToFI=;
        b=x6cuu7UKIXPvjS15hMGOoPexZkl+PSAEf9kUHN57whqFT3BeSpb5BhcML1s4uuYa9L
         pH5Szx+GeK97yIpDW1Wr/dQeN1Bvb52N50rWbCk9SplLLNQ/tKneY9VOwDlVBD5Z16n/
         tt0cfotlnvCT4F2Kc2oG1NmmGN3daP0IcEmEiQ+H/HO3NQXqMsL6K6I1JP6+LPGU/05R
         K6pHRBYENdPxmnsoRby0E1Zc0De0YacyDDmc6IFG1ysdDjrHlmVxo3muybjKgJpGvNBa
         8S3QPzxM3BNRMHUHXk5DD2j0G6rWjin1tOANVpSaRKfjS5QKA5XI9Qww98FGSab3iDe0
         pCOQ==
X-Forwarded-Encrypted: i=1; AKwUvBysqVaAaCtx4n+DSBoSiKJ63Lu5PURLSJ7TRVYvNLaj56+rlKBUauT6zyIRFz0VjwLeXnvGODIR5jIb@vger.kernel.org
X-Gm-Message-State: AFq9FYKSHmVX91Oq2i6ynBzI1pu/LhENnns9h4xMpDsMm4gu2xHaU4aL
	ZukkL5T9ap4i6W39SCLZV9akrCgH8NpdVws8b2HTQg8ej2N6NSL7vTWdC7ywj/WAkBz77pnSYW3
	kPjjeG/wgdWLvJawa8zm1A4fp6uuivDeChRlRZdvEpkn1DlXqHELjDJcTf78rHN/ZmG5dYseQ8A
	MbO1IbpKAu5gmmVw0jEWsx7HSjLaA1oAgbxct8aw==
X-Gm-Gg: AYBFou3fapFSqRxuScucYtsXRMTedutIVglIUS+Mf25bUwRpkz0T089nbzj/+HWiaXa
	otmN7CRHpgbg7ECaFR3CX9pDqfbrrLGHFoJVLqN4xkmaDX6aNhxQNOA3owoZAlpJIkWsKXwMLCo
	W2/79i1tfmCuwQnP/ZonYNl0YOAsXvUBn969FqVHYlNjLN+pW3iccB52LBH6WStIXmteDc+d5Ys
	iCTk9wpLfyxlmpUXY8XZSF0EgKAp0aLDPg9Gdek
X-Received: by 2002:a05:6102:2c82:b0:7bf:6218:bc59 with SMTP id ada2fe7eead31-7cb373e93d4mr5360959137.32.1791977275643;
        Wed, 14 Oct 2026 04:27:55 -0700 (PDT)
X-Received: by 2002:a05:6102:2c82:b0:7bf:6218:bc59 with SMTP id
 ada2fe7eead31-7cb373e93d4mr5360949137.32.1791977275179; Wed, 14 Oct 2026
 04:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com> <CAKPOu+_Msno=mux+FUc-oV1-ywRFujJcnKS2HNv0sjtRVtUP3A@mail.gmail.com>
 <CAO8a2Sj2UbocxY+_MRdcH1TWht=UJT+ANWmzqLY9MQxZ0ujUpw@mail.gmail.com>
In-Reply-To: <CAO8a2Sj2UbocxY+_MRdcH1TWht=UJT+ANWmzqLY9MQxZ0ujUpw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 14 Oct 2026 14:27:43 +0300
X-Gm-Features: AclHuK9Dt6BVQBEgP32q9R0awIinzTpy5bwl4pmAWJh1Bh7UXUQjRVmYFm298y4
Message-ID: <CAO8a2SiVWYSR6s=Z34QcfPVNVSLGk+YQQza4DDEt8_8+j37AHg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "chenyuxi (D)" <chenyuxi19@huawei.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, xiubo.li@clyso.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Max, Please resend the patchset, the tree has diverged since this
patchset was sent back in September.

On Wed, Oct 14, 2026 at 1:46=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Since the last merge with main Linux the testing branch has grown by
> upwards of 100 acked patches.
> Xiubo acked your patch, which is good enough for me, Xiubo is back on
> the maintainers list for ceph client.
> I'll take another look at the discussion for fairness' sake.
>
> Feel free to submit and argue for any other patches you feel are necessar=
y.
> If a patch solves a problem or adds needed functionality it will be
> reviewed and applied as always.
>
> On Wed, Oct 14, 2026 at 12:50=E2=80=AFPM Max Kellermann
> <max.kellermann@ionos.com> wrote:
> >
> > On Wed, Oct 14, 2026 at 11:15=E2=80=AFAM chenyuxi (D) <chenyuxi19@huawe=
i.com> wrote:
> > > Do you have any plans to move this series forward?
> > [...]
> > > Is there anything still holding the series back that we could
> > > help with?
> >
> > It was rejected by Alex Markuze, and he never replied to me after I
> > questioned the two reviews. That's what's holding this back.
> >
> > As for my plans - I have more Ceph unpublished fixes in our internal
> > Linux kernel fork, but I'm not submitting them, see
> > https://lore.kernel.org/ceph-devel/CAKPOu+8SiwxT_44e63-EZ4T_4d-tGjwmk_L=
x8i4KgZOL5JnMtQ@mail.gmail.com/
> > for why.
> > I just looked it up: the stack of Ceph patches in our fork has grown
> > to 67 patches. They were either rejected or ignored. One of the
> > rejected patches fixes a security vulnerability.
> >
> > --
> > Max Kellermann
> > Principal Architect
> > Hosting Technology
> >
> > cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
> > General information about the company can be found here:
> > https://www.cm4all.com/impressum
> > A member of the IONOS Group
> >

