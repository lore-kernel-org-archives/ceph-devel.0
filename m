Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270C53E30C
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084570; cv=pass; b=eNr5dVwgi40c4kvEZeDSr3QuWUIntTjoSQShJeFt653bCLW5zsNq3m17hTfVQ+4mt5+t72fGMPwK8Ig2giG2WGs2B3tO91ayEE5Y7ZUHGCmiRdqIkhYh9xvpQpSj5sOJ8yOJ1ExNSOpfGjE+5EdpJESV8qhC/85CLwcN3Nams3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084570; c=relaxed/simple;
	bh=HtdOozzHl5Z7pUX61SnkDUc9ufG3gbqOfQ5vzj23cVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qv9NPL56609Ukp2nawE4u/PQrdfdxBfKPbLFb0xyVPAXErROfoknI5wGIQRDlOD11SHOr0jTrXuu36s+FniHBTQkyvDZ+wI+ECe7yQViF0eQo6pqlil5NfouTdVTDUXYWe61NR0xZ2ByVtpEyOv5JJpsV3JC4R6jNn86VqBW81g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Yek4SuzI; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Yek4SuzI"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e5d08214dso349866966b.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 10:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792084558; cv=none;
        d=google.com; s=arc-20260327;
        b=aSvLfAQvq13GgclBrwX5iSIoG3WVvpaQpgTGHfhYlEsSR0HakDD3Pi+3gD3iPFJxfD
         nrY4zdugVdCG04b7TcURbqQ15ByGNQuSuYwaTuZgzGa91EEXo9Maz8CsnPehbFwfDHOU
         UIdiwru+cBrvr+zs0Hf8fhiY/DQuKIDfilRLGlbNPueRl502XdHDbiAILJxHAnWY6FMh
         +do1BuqIU5pjvP7jt5oEviAsFJ3sabLF42dt0si1PHMIdf5sks2eoKIQGYSiSRTP8cKL
         10bSkmfmc51Glxhxjzkoo6Y6+P4BwJm+LkAt9YlTYb2V5wdBOu4Mrhu3YpeN/m7SQCF3
         yUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ew0YjksX9uYKVJLdU/3s4eNBwnZozDuzrVZ8OLd5tKw=;
        fh=ghlfTZNM3kbQssdL6ziKFEUes3BLW8v2Vpz9hcmuYDA=;
        b=H1Sjg951dnc3rYr+KAQypiuO5Iwk4w7zVkqZQzuLas16b4kn5Ykc9y/G8BfYZXNY1m
         /56Qv/8L/4hCOwOnPc9qm24TleyE+M4PBi9DNi8nWpoB9O1mAC91JTwUy5pOV1iXLbJf
         9ODd03oeuWpXJ4p+MsxcIj4Cx5SqQKP9PNpn3XHYbvc5T/URiCWs7gtMkoM7BMl9e6bI
         chRsTMBzRNPYN5Sge6o1ny4tSu94/8U4O2GHlgwv4uHWO9Fu62jHri+vcsUd8ep26BZn
         kHZ2GeAWnU0bW0wo3xmFT4Ygqf2xJULjpibc+aFdWmLEAYB66G+/FfMXx+1OPtY9R42s
         fPYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1792084558; x=1792689358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ew0YjksX9uYKVJLdU/3s4eNBwnZozDuzrVZ8OLd5tKw=;
        b=Yek4SuzIG7FTQuyEBxyvVH9kQodG5MUtHT7h/+BWLc6ve+tdMY9VlsfBSPXS5KdIzf
         mcvjsDjljW2oevHOWh7cKQRdJ+dZkNEaUWJo9joRs8SzYY3WQeB6OsiccaY+koByj+Hn
         nJMwlga8c3UR2OuEobWZm56IqPjPhnqQqZ78cZ0jElny1kmd+INPxNSoUIKqms5MQlee
         XCrsi9josFejyb25LVjagfp7Xbd4VWVPsQMd3zCZJ2zMUY0cZWLWLLOBfYsSXKSQEaZp
         p6lDotkr9/svvq/EQZF8/lG0QYGkyhJFc/W04Ws1bNg5P5ZXVWZHgVcGzXL8+yl3F/sF
         DfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084558; x=1792689358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ew0YjksX9uYKVJLdU/3s4eNBwnZozDuzrVZ8OLd5tKw=;
        b=NeI41qvFmqLJZHpWITJ6pJrL9974LGcArhF1s38Dvc65AKODDhc4cBu6JCJRDMt1PZ
         vz+xny1pfCdi0jxmZ0Fmzl0naOdzn+8l/n0LKvrlcq8TL5B4vyG5+0FDOuGUvTaNawXW
         3BW4+iw/YHqpM5Q7x6Ix/Aj9bV15ruPmxjK39VR/QPHwV6Eb9RbvWPCWjocrJAq84pB7
         haffKpSCwsvD/sL15LubTI3bmOsmSwWDxaDVG6rOogqigmKgM1nGRvpUr5ZBOVFfLr3W
         aBqXl648h4MNI8lMRkZOxuSbzMYsWb8CpfdPCrhamoZHKLk86lb/zLMhgW872lH8D1Tu
         O/OQ==
X-Forwarded-Encrypted: i=1; AKwUvByKg5+MQBLxxmSkcce2MQOB0wGlRxOBr3z808BmIVDQ+JlV86mXMuGX/kJzHSG6hYZY68QT2dO0qYAZ@vger.kernel.org
X-Gm-Message-State: AFq9FYLeILdQpYIo/H6XqccDRBB8tpZ9QOemNEJ274ACeUss+zzTHVfw
	bvtOIC+ghmo3xHSbc563Zs4ExqlAjgJk77TmMfsP1C2GtvgWMeHxzbPoqJxSKkISZc5o6Oi+ohH
	gx7PH2ECnV1MGDIg/7niQwd/nVk98wcookl+oEYoSpA==
X-Gm-Gg: AYBFou3G7ZRy6riO/vzoIaxlgWgTd7g4Ln9nvhCWmlZPJ002y4MrfjMqFxgMYD3mj6k
	h+QQi17BHjsqqomZzrBlssNLaNT9nI9ctNAD5QM0XH9r4yKExqY5Z4Mi6l0Gi9KdqxfR2Bwm3W9
	NBTWI+zDJwU3tiWSI+e/nX5fFcd2airmuQaTCG7eKigshZjCfZ/dy6mKUED2I9NaDYLAqywAzpS
	YIdEZBy3seetWmd5cJgZhzrv6j32/7JtwMydoVxu9396rmy1fh2itTJDDmSxS88eHZv3um3tYpE
	dzun9UUH7XjD9GOufR2C5wBZe54iVBk5NBbP7mJCxBPEKihO4lUO6vI6hkv+6HANoPcu7rDuHYX
	oJYWL1M+079h/gKVBjQo=
X-Received: by 2002:a17:907:7296:b0:c2e:4f16:fbf with SMTP id
 a640c23a62f3a-c31a9f8af14mr1836004366b.31.1792084557587; Thu, 15 Oct 2026
 10:15:57 -0700 (PDT)
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
 <CAKPOu+9x_7WQmKhW==AmLoSzuPrUqeSV+JR69-TaovjEhuj6Ew@mail.gmail.com>
 <CAO8a2ShEjqyNA41ujmF5GfOM+YbJvXqCHKO9V++KBkJCXNOSUA@mail.gmail.com>
 <CAKPOu+_+oCzprewMeggY=32eEUt5ukTvhVMbEFGSh3Owa1zJhw@mail.gmail.com> <CAO8a2Sj-_hbqEc=z0jgWW1oP36obzWWPm6KhQEDFAUB4v_2kaA@mail.gmail.com>
In-Reply-To: <CAO8a2Sj-_hbqEc=z0jgWW1oP36obzWWPm6KhQEDFAUB4v_2kaA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 15 Oct 2026 19:15:46 +0200
X-Gm-Features: AclHuK_DVNQ1cCsgoRsOLGAioGI7muaBF4j-vbq4dIKwEKH2CugUVaCzVBezlsM
Message-ID: <CAKPOu+_7ep9K8UPXbLQVewUXGSGOUaq9CVSdzxrfE1zjjy-k0g@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: Alex Markuze <amarkuze@redhat.com>
Cc: "chenyuxi (D)" <chenyuxi19@huawei.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, xiubo.li@clyso.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:22=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> Two context lines still call
>   doutc(), and testing calls boutc() there:
>     ceph_mdsc_open_export_target_session(): "to mds%d"
>     send_mds_reconnect(): "session %p state %s"
>   That logging change is already on testing.

You mean your new "BLOG" subsystem that I questioned, but you never
replied to my review?

This is one of the things I will revert in our kernel fork once we
jump to the next LTS. Everything about it feels wrong to me. I'm not
happy with where the Ceph kclient is heading.

>   Unfortunately, it's not scalable for me to rebase every patch sent
> to the mailing list, your cooperation is appreciated.

And it's not scalable for me to rebase every patch that gets delayed
by you until it doesn't apply cleanly anymore.

Really, this was only caused by you, and if you don't want that extra
work, don't ignore my patches, and don't merge conflicting patches 4
weeks later - it's that simple. And no, I won't "argue for any other
patches". Our kernel fork has all the patches we need, that's all that
counts for me. I have offered everything in the past, but most of it
wasn't accepted, so I stopped submitting a while ago (because upstream
lagged behind my work so much my patches weren't compatible anymore,
and I don't want to do extra work to maintain two branches).

In this case, it's really trivial. There isn't even a conflict. Just
some patch context changes. Apply my patches to a commit before your
BLOG merge, then "git rebase". There are a hundred other ways to
resolve this without editing anything manually.

--
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
