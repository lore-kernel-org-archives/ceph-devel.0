Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F634C808;
	Sat, 25 Apr 2026 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777121832; cv=none; b=tcU/qlKwOlAll6Qtr3520OHEO80oUZ1ZmDHcAZ4l2+QC92OtKE5QQJyKju4I5PYOxeG/JuMCCiYHh/4OVkiq4a5Uy4e+hz4oL6au4xQguu6YU11P75MJF0ijrxxUoGlisS0h4mY8x8wDG1Y30eZZ0vw3d+cqkEkOIgy3YvqF/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777121832; c=relaxed/simple;
	bh=MSEBLKpwWzFw4/b4BcdpcVW9kyCUCBNlDWxMu1A7vdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uGC2T7cwAGMrt8148pa48lf98swWEYRnEVL9XmQsaCx8XQHPS/9qaaOMins58JbsoWbrt2ZF/GnT9T4AVegnBuqL+vhSrJNWPM39kfXBTyXwtKUMaBXjSzZxUBRQtKiX8PcsWZAddz8KDHv/SI+Jd5bPMUaOWluiHBGiKN0rGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DC5364A004;
	Sat, 25 Apr 2026 14:57:06 +0200 (CEST)
From: Kefu Chai <k.chai@proxmox.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: accept addrvecs with multiple entries of the
 same type
In-Reply-To: <CAOi1vP8aOtKbcJFU40W_-Os__G9oahNrkMHS4gRaEcrjs-1cNA@mail.gmail.com>
References: <20260423100904.2336750-1-k.chai@proxmox.com>
 <CAOi1vP_=Z9n8aEBZtqLuedfUDka2_80xc28NKWcR5ijgZwUT0Q@mail.gmail.com>
 <87y0idhpfa.fsf@proxmox.com>
 <CAOi1vP8aOtKbcJFU40W_-Os__G9oahNrkMHS4gRaEcrjs-1cNA@mail.gmail.com>
Date: Sat, 25 Apr 2026 20:56:59 +0800
Message-ID: <87tsszgpus.fsf@proxmox.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1777121733571

Ilya Dryomov <idryomov@gmail.com> writes:

> On Thu, Apr 23, 2026 at 1:44=E2=80=AFPM Kefu Chai <k.chai@proxmox.com> wr=
ote:
>>
>> Ilya Dryomov <idryomov@gmail.com> writes:
>>
>> > On Thu, Apr 23, 2026 at 12:09=E2=80=AFPM Kefu Chai <k.chai@proxmox.com=
> wrote:
>> >>
>> >> ceph_decode_entity_addrvec() rejects any addrvec containing more than
>> >> one entry that matches the requested msgr type (LEGACY or MSGR2),
>> >> logging "another match of type N in addrvec" and returning -EINVAL.
>> >> This breaks legitimate deployments where a daemon advertises multiple
>> >> addresses of the same type, most notably dual-stack (IPv4 + IPv6)
>> >> clusters
>> >
>> > Hi Kefu,
>> >
>>
>> Hi Ilya,
>>
>> >
>> > My understanding is that dual-stack isn't supported in general:
>> > https://tracker.ceph.com/issues/65631.  The respective references were
>> > purged from the documentation with Radoslaw (offline?) ack.
>> >
>>
>> Yeah, you are right. I was overreaching. Dual-stack and
>> heterogeneous-subnet clients are not served by multi-entry addrvecs, and
>> the patch does not change that.
>>
>> >
>> >> and multi-subnet deployments where tooling picks one address
>> >> per listed public_network.
>> >
>> > Can you elaborate on when such tooling kicks in, what exactly does it
>> > do and the use case in general?  It's not immediately obvious to me how
>> > having two addresses of the same type/stack and simply ignoring the
>> > second one is better than insisting on having a just single address.
>> >
>>
>> Sure. The narrow case that remains is compatibility. Admin tooling built
>> around public_addrv and ceph mon set-addrs produces addrvecs with more
>> than one entry of the same type on the back of that behavior, and the
>
> Hi Kefu,
>
> Sorry for being dense, but can you expand on _why_ the tooling in
> question is doing that?  With the dual-stack being explicitly not
> supported and the userspace messenger unconditionally picking the
> first address, what are the use cases for adding additional "dead"
> addresses there?
>

Hi Ilya,

Not dense at all. I went back and walked the history. Turns out there is
no functional use case left, just a history of admin tooling producing
this shape.

The tooling is `pveceph mon create`, where pveceph is the Proxmox VE CLI
used to provision Ceph monitors on a PVE node. In 2021, we added support
for a `public_network` setting that lists more than on CIDR. When the
admin configure, for instance:

  public_network =3D 10.0.0.0/24,10.0.1.0/24

`pveceph mon create` pick on local IP per listed subnet, and the tooling
emits both a v2 and a v1 entry for each, which is what produces the
addvecs that the previously referenced bug report [2].

The admin's intent was multi-subnet reachability, but after auditing
Ceph's code, I realized that nobody uses more than the first matching
entry per msgr type.

So, multi-subnet reachability has always relied on plain IP routing
between the listed subnets, not on any addrvec-level fallback.

>
> I'm asking because Xie Xingguo's commit [1] mentions dual-stack
> (already covered above) and in the ticket that I assume got you
> involved [2] it seems like the user was able to implement the setup
> they wanted without resorting to adding those "dead" addresses after
> all.
>

Indeed. In our issue[2], the admin repaired their cluster by editing the
monmap by hand.

>
>> kernel's strict guard rejects the whole monmap. The handshake contains()
>> check is the one concrete reason the extra entries need to be listed in
>> the addrvec rather than dropped at advertise time.
>
> Can you point me at this check?
>


Sure. I pointed at ProtocolV2's server_ident.addrs().contains(target_addr),=
=20
but after on re-reading, turns out it only requires that the address the
client connected to (picked from the monmap) be in the server's
announced bind addrs. So, there is no concrete reason for the extras to
be in the addrvec.

>>
>> >
>> >> Match the userspace messenger, which since Nautilus picks the first
>> >> entry of the requested type and silently tolerates subsequent entries.
>> >
>> > Do you have a reference to a specific commit?  I'm wondering if it
>> > isn't on that "merged more or less accidentally" list.
>> >
>>
>> The pick-first selector in AsyncMessenger::create_connect() landed in
>> Sage's commit d1a783a5f733, and Xie Xingguo's commit 50d8c8a3cce3 fixed
>> the loop to actually honor the "pick whichever is listed first" comment.
>> Both shipped in Nautilus.
>>
>> Would you be willing to take this as a compatibility fix, with the
>> commit message and the comment in ceph_decode_entity_addrvec() rewritten
>> to state exactly that and nothing more? If you would rather keep the
>> strict check and handle this on the tooling side instead, I am happy to
>> withdraw the patch. Either way, thanks for the review.
>
> I'm all for reducing the number of inconsistencies (whether intentional
> or unintentional), but I would like to make sure I understand the
> background first.  I'm worried that by accepting multiple addresses we
> just confuse users into thinking that dual-stack is supported and then
> they go on attempting to implement "a second subnet", etc.  AFAIK those
> things aren't tested upstream at all.
>

Yeah, that worry is far. The remaining argument for taking this patch is
purely backward compatibility: there are existing deployment whose
monmap where produced by `pveceph`-like tools and hence contain extra
multiple addresses in addvec.

If you would still rather keep the strict guard and have those clusters
repair their monmaps manually, I am happy to drop the patch.

If you  would consider taking it as a pure compatibility tolerance, I
will respin with the commit message and update the comment in
ceph_decode_entity_addrvec() to explain the rationales -- not because of
dual-stack or multi-subnet support.

Thanks,
Kefu

>
> [1] https://github.com/ceph/ceph/commit/50d8c8a3cce3bfbfc9be5acfa60bda165=
d59e2bc
> [2] https://bugzilla.proxmox.com/show_bug.cgi?id=3D7518
>
> Thanks,
>
>                 Ilya

