Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A1477E58
	for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523104; cv=pass; b=KetxxzXWSa2CVOJzK/Jt0Y/dN1K6V6EZTQohrc5JMwn7jqEBasXJVgCkswNqEr33njXL5SU+i/kPGrWJx85qcuyI0hs0rAwl/GE71TisMrcXqzlIREO17zATBry2r9oPKbeFZWlb04L/QqnZ8aisx0Qqy1ahSVSkdV3IbMZHkyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523104; c=relaxed/simple;
	bh=0o0kenJO1opyWWZVsbWqqXLN/pcC/4sHJU4JmVgI1Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnQPgoTDYB+tWyNvnpKhXBQdBrNesUNFDrJJDvXFOhEpsPt0XgBLpkxkZzfP8jNkdS9XSRh5tIIjUpo/Ax9tONdHZGi8MNnSz/XtxTuck5JNO0qO0dlx9uTwbS53tpxsHNj3/U1cUe6t8xzGJijJJ704Lzlw1ydqgyeqr7jv7HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ7cX9E4; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ7cX9E4"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6314cff521aso1108338137.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 11:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778523102; cv=none;
        d=google.com; s=arc-20240605;
        b=SOJ7Cw3nZJgqw6OpMlnHnsIlgLBwy/5IAcDBQmsegClEBMIcAdfCcD6tP335+DAlXU
         upA283oGPRenbydoe7aRsKV073l1T0dGFAdGsHBglwYXlhwg4GxyAzaz587kal+tUlx1
         6cj7xN4JwpEAoPcdC913K0prBTHzc4RzcDL1+Tgfaw3edlKTXNrirq8+/gedZ0+fYUAK
         8u27LvH7Fhp3oJ+OVgkto9dpb8oBIMwxTVPQCJKz8OY0pRQ5tPz+BpwC8no8ePEK0JuW
         fEbyDGFcU8AVIkAk/q4waBF0S5XKADzBu7uUFbUKVLNA00E4Op2eU9Sa3r1kVJA1uOM/
         FMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VZ+ZgOUuKpV3ZVjTXGraEsYdq5X/dM79JX1cjXec1vk=;
        fh=2H0Lt+N2MG9NlMVTXMuJxDjWjYn21cK5l1nGndtQCUo=;
        b=XzS2uXD0mtYyBCd+D0acDpkbhAVyRQStAHaEZBydgLfi8QEqDfq4i9Iz/aVE/uw9XP
         6ONUThUo/0ljLHVo+cC9vJc4fCkr6RNSGg3qdgUCX7rxWOhe3d4pxIgA8j0GvvYUyP6T
         9typ/ioHvTeYx/z6ogxy2oK8FWzrRq+yop1J/CG0k/+S0/tNxzKr6ipea4QMmr1pglTf
         /RdysLXYxGFqb2EyXmJk0iMvbPzZQfk2gZdBA7wVurxuT2SkJuOCD/TT5voF2e3crBst
         WlO7gvbyVeMhZBSx24s8UHJRlxndaeJ6t1GQawGXyUbj20B43tB2Bpd7aSJc/vI3Jvck
         5q/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523102; x=1779127902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ+ZgOUuKpV3ZVjTXGraEsYdq5X/dM79JX1cjXec1vk=;
        b=AJ7cX9E4MXVFErPouUcjWgbiNR/vDZBB4t0FIHcAzJMbSRaSPT6QJ/k0sbCtpDGwug
         1StGqRNRc+Quxrm2p8hleLbVfcYZQvJ8fKt+UH9ZOlHRDCzpV4syIrrUDs7vUNl+ryPZ
         17/rGw+8TxXYKL9cNTPmH2XioI7kDv9b3DbF8Akp/2t/hY4qiWqwQj9uLfnJlBKdPm4i
         0LwCmYPlIe3iEC1Xjj2T03wFpLIBWw/bVySV4ooFYyW1MsQ0zvAtyWVzQW9R0xVMdyWX
         aZ+75nK1OadWP4wwGvbF/7eHt09nmk0s86vWiwgFhhCXchZbwUJJ0gWFV9MpppXKDu4c
         8Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523102; x=1779127902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZ+ZgOUuKpV3ZVjTXGraEsYdq5X/dM79JX1cjXec1vk=;
        b=YYuHgWG9nsa18COBlA0tzkp/Jbhiauu6hPbiGzF/EhZxy1ih3MapEKElyAqpWqasBO
         wi2PlPilokwgpOerqxX/cO0wFeQd9h87YWu+oYY0d5PIv4Yz/ppxFRtq322nFCb+0mdB
         DAbklaP98rUygM/KVD+EeHdLCy2UDL6Zarl1KKTjtV3WfXb5qR3OQ5axAToTrAaUUSww
         8VRLCyEa1oL4Fs+l95HwALHR6xsY4xvQ9KSPiIRtxu0Fj2u8afH/HAz8hrgxrcjk6zJu
         LkGOyWCpD+0f4Amr2qknACWxjTEzRKsWPG4pA09TjnolWJclGdAJSc75ALNUTkyxzwyB
         PraQ==
X-Gm-Message-State: AOJu0YyJ1TvvUjC6RPFBu0rY1EolCu5fmovug8aB/Q+5/l8+v2ARi+aS
	M01nsXrP8sI9znt6b48wbLvew/7oEL4gO5vN26R7E2rQiIV1d70qR2OVaWEZ9Ofg4vJJMfCS4Kr
	yetAh2qvvnDtNiz4rLH6c8bZA+1Byjuo=
X-Gm-Gg: Acq92OEHDWkRbQ1FjiMmXiaTGjmRWxdPLD7QeKpyYGCoRxjvbwxfL3KIJYWk2gAAQM0
	cs0DEfh3pe4uR31POkc8wBQ8iquFsmMfLToYIbJCCU+rsvAnMwbvGVug2Bh2n+6ZmaVUOHoo3Hj
	U6LOXx/wqwvMaJq4yVE2UTYs5MFxQw3KglxzKThQjg4jRjX2QJpXPbzywdDP/oI5TuXcxfHOxc6
	iQaVuz7Arw/ucsp8DNdJmbe6vSdlKja8OcrL0iIULYS0musQwVuSJW4IVmYISo1NPYKeb6TnpI2
	sOJSujruL4A/MQYtsg==
X-Received: by 2002:a05:6102:1620:b0:631:2472:e832 with SMTP id
 ada2fe7eead31-631da131c39mr4062385137.8.1778523102133; Mon, 11 May 2026
 11:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423100904.2336750-1-k.chai@proxmox.com> <CAOi1vP_=Z9n8aEBZtqLuedfUDka2_80xc28NKWcR5ijgZwUT0Q@mail.gmail.com>
 <87y0idhpfa.fsf@proxmox.com> <CAOi1vP8aOtKbcJFU40W_-Os__G9oahNrkMHS4gRaEcrjs-1cNA@mail.gmail.com>
 <87tsszgpus.fsf@proxmox.com>
In-Reply-To: <87tsszgpus.fsf@proxmox.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 11 May 2026 20:11:29 +0200
X-Gm-Features: AVHnY4L0KoBoMn9_4HLEeTL2sy2YkqRmMGMdS4msIULm7KJ2VZrlVWoLzDQzmI8
Message-ID: <CAOi1vP8zE_cuTXyWCf7UmCpRaSwRT3rbHVBbOgdgmvNF8QBq7w@mail.gmail.com>
Subject: Re: [PATCH] libceph: accept addrvecs with multiple entries of the
 same type
To: Kefu Chai <k.chai@proxmox.com>
Cc: ceph-devel@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 2:57=E2=80=AFPM Kefu Chai <k.chai@proxmox.com> wrot=
e:
>
> Ilya Dryomov <idryomov@gmail.com> writes:
>
> > On Thu, Apr 23, 2026 at 1:44=E2=80=AFPM Kefu Chai <k.chai@proxmox.com> =
wrote:
> >>
> >> Ilya Dryomov <idryomov@gmail.com> writes:
> >>
> >> > On Thu, Apr 23, 2026 at 12:09=E2=80=AFPM Kefu Chai <k.chai@proxmox.c=
om> wrote:
> >> >>
> >> >> ceph_decode_entity_addrvec() rejects any addrvec containing more th=
an
> >> >> one entry that matches the requested msgr type (LEGACY or MSGR2),
> >> >> logging "another match of type N in addrvec" and returning -EINVAL.
> >> >> This breaks legitimate deployments where a daemon advertises multip=
le
> >> >> addresses of the same type, most notably dual-stack (IPv4 + IPv6)
> >> >> clusters
> >> >
> >> > Hi Kefu,
> >> >
> >>
> >> Hi Ilya,
> >>
> >> >
> >> > My understanding is that dual-stack isn't supported in general:
> >> > https://tracker.ceph.com/issues/65631.  The respective references we=
re
> >> > purged from the documentation with Radoslaw (offline?) ack.
> >> >
> >>
> >> Yeah, you are right. I was overreaching. Dual-stack and
> >> heterogeneous-subnet clients are not served by multi-entry addrvecs, a=
nd
> >> the patch does not change that.
> >>
> >> >
> >> >> and multi-subnet deployments where tooling picks one address
> >> >> per listed public_network.
> >> >
> >> > Can you elaborate on when such tooling kicks in, what exactly does i=
t
> >> > do and the use case in general?  It's not immediately obvious to me =
how
> >> > having two addresses of the same type/stack and simply ignoring the
> >> > second one is better than insisting on having a just single address.
> >> >
> >>
> >> Sure. The narrow case that remains is compatibility. Admin tooling bui=
lt
> >> around public_addrv and ceph mon set-addrs produces addrvecs with more
> >> than one entry of the same type on the back of that behavior, and the
> >
> > Hi Kefu,
> >
> > Sorry for being dense, but can you expand on _why_ the tooling in
> > question is doing that?  With the dual-stack being explicitly not
> > supported and the userspace messenger unconditionally picking the
> > first address, what are the use cases for adding additional "dead"
> > addresses there?
> >
>
> Hi Ilya,
>
> Not dense at all. I went back and walked the history. Turns out there is
> no functional use case left, just a history of admin tooling producing
> this shape.
>
> The tooling is `pveceph mon create`, where pveceph is the Proxmox VE CLI
> used to provision Ceph monitors on a PVE node. In 2021, we added support
> for a `public_network` setting that lists more than on CIDR. When the
> admin configure, for instance:
>
>   public_network =3D 10.0.0.0/24,10.0.1.0/24
>
> `pveceph mon create` pick on local IP per listed subnet, and the tooling
> emits both a v2 and a v1 entry for each, which is what produces the
> addvecs that the previously referenced bug report [2].
>
> The admin's intent was multi-subnet reachability, but after auditing
> Ceph's code, I realized that nobody uses more than the first matching
> entry per msgr type.
>
> So, multi-subnet reachability has always relied on plain IP routing
> between the listed subnets, not on any addrvec-level fallback.
>
> >
> > I'm asking because Xie Xingguo's commit [1] mentions dual-stack
> > (already covered above) and in the ticket that I assume got you
> > involved [2] it seems like the user was able to implement the setup
> > they wanted without resorting to adding those "dead" addresses after
> > all.
> >
>
> Indeed. In our issue[2], the admin repaired their cluster by editing the
> monmap by hand.
>
> >
> >> kernel's strict guard rejects the whole monmap. The handshake contains=
()
> >> check is the one concrete reason the extra entries need to be listed i=
n
> >> the addrvec rather than dropped at advertise time.
> >
> > Can you point me at this check?
> >
>
>
> Sure. I pointed at ProtocolV2's server_ident.addrs().contains(target_addr=
),
> but after on re-reading, turns out it only requires that the address the
> client connected to (picked from the monmap) be in the server's
> announced bind addrs. So, there is no concrete reason for the extras to
> be in the addrvec.
>
> >>
> >> >
> >> >> Match the userspace messenger, which since Nautilus picks the first
> >> >> entry of the requested type and silently tolerates subsequent entri=
es.
> >> >
> >> > Do you have a reference to a specific commit?  I'm wondering if it
> >> > isn't on that "merged more or less accidentally" list.
> >> >
> >>
> >> The pick-first selector in AsyncMessenger::create_connect() landed in
> >> Sage's commit d1a783a5f733, and Xie Xingguo's commit 50d8c8a3cce3 fixe=
d
> >> the loop to actually honor the "pick whichever is listed first" commen=
t.
> >> Both shipped in Nautilus.
> >>
> >> Would you be willing to take this as a compatibility fix, with the
> >> commit message and the comment in ceph_decode_entity_addrvec() rewritt=
en
> >> to state exactly that and nothing more? If you would rather keep the
> >> strict check and handle this on the tooling side instead, I am happy t=
o
> >> withdraw the patch. Either way, thanks for the review.
> >
> > I'm all for reducing the number of inconsistencies (whether intentional
> > or unintentional), but I would like to make sure I understand the
> > background first.  I'm worried that by accepting multiple addresses we
> > just confuse users into thinking that dual-stack is supported and then
> > they go on attempting to implement "a second subnet", etc.  AFAIK those
> > things aren't tested upstream at all.
> >
>
> Yeah, that worry is far. The remaining argument for taking this patch is
> purely backward compatibility: there are existing deployment whose
> monmap where produced by `pveceph`-like tools and hence contain extra
> multiple addresses in addvec.
>
> If you would still rather keep the strict guard and have those clusters
> repair their monmaps manually, I am happy to drop the patch.
>
> If you  would consider taking it as a pure compatibility tolerance, I
> will respin with the commit message and update the comment in
> ceph_decode_entity_addrvec() to explain the rationales -- not because of
> dual-stack or multi-subnet support.

Hi Kefu,

Please respin the patch.  We had a wider discussion about this today
and while there is some unhappiness about the status quo (both the lack
of dual-stack support in general and the CLI/config option parsers
being too lax with what is accepted in its absence) the consensus was
that extending tolerance for compatibility would be good.

Thanks,

                Ilya
