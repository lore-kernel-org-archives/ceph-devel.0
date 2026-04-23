Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526C296BA9;
	Thu, 23 Apr 2026 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944661; cv=none; b=cuyu5RVQn1qXOLIB8i+drHcEs+n+7Bd9xMRHMGiaqOZuYwB/vo8PAalkiI/MGgFYawc+jGx+9kIK3+KC/ixZDGxwoDrbnwBIIdtbdmjpLEXKmuzQPgT8RNgWh78i9VtU+g+gtyWtaPH/7hD0tVU36AIFZL4Ky+XPL9mqrg+D/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944661; c=relaxed/simple;
	bh=KrktPcvQbCk/SHymWcbFvd8d9FV5FoFYyR5n7bYx9L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SKJef3uN2cUBgG09k010ThR2mholEubAk5GJXKiVMrK7HRlQps5rTMqjnjeH6exdrPMi851/EShYrxYAHmkrWruD5Tz1k1DSyd71EnUJn8vhIG6Fn4G/bYsaiT/3WMFk1FNVyYLkDMk9kVS0UE7ThY2e+piz+cHPceljAI+bQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3790C41C68;
	Thu, 23 Apr 2026 13:44:16 +0200 (CEST)
From: Kefu Chai <k.chai@proxmox.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: accept addrvecs with multiple entries of the
 same type
In-Reply-To: <CAOi1vP_=Z9n8aEBZtqLuedfUDka2_80xc28NKWcR5ijgZwUT0Q@mail.gmail.com>
References: <20260423100904.2336750-1-k.chai@proxmox.com>
 <CAOi1vP_=Z9n8aEBZtqLuedfUDka2_80xc28NKWcR5ijgZwUT0Q@mail.gmail.com>
Date: Thu, 23 Apr 2026 19:44:09 +0800
Message-ID: <87y0idhpfa.fsf@proxmox.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1776944566396

Ilya Dryomov <idryomov@gmail.com> writes:

> On Thu, Apr 23, 2026 at 12:09=E2=80=AFPM Kefu Chai <k.chai@proxmox.com> w=
rote:
>>
>> ceph_decode_entity_addrvec() rejects any addrvec containing more than
>> one entry that matches the requested msgr type (LEGACY or MSGR2),
>> logging "another match of type N in addrvec" and returning -EINVAL.
>> This breaks legitimate deployments where a daemon advertises multiple
>> addresses of the same type, most notably dual-stack (IPv4 + IPv6)
>> clusters
>
> Hi Kefu,
>

Hi Ilya,

>
> My understanding is that dual-stack isn't supported in general:
> https://tracker.ceph.com/issues/65631.  The respective references were
> purged from the documentation with Radoslaw (offline?) ack.
>

Yeah, you are right. I was overreaching. Dual-stack and
heterogeneous-subnet clients are not served by multi-entry addrvecs, and
the patch does not change that.

>
>> and multi-subnet deployments where tooling picks one address
>> per listed public_network.
>
> Can you elaborate on when such tooling kicks in, what exactly does it
> do and the use case in general?  It's not immediately obvious to me how
> having two addresses of the same type/stack and simply ignoring the
> second one is better than insisting on having a just single address.
>

Sure. The narrow case that remains is compatibility. Admin tooling built
around public_addrv and ceph mon set-addrs produces addrvecs with more
than one entry of the same type on the back of that behavior, and the
kernel's strict guard rejects the whole monmap. The handshake contains()
check is the one concrete reason the extra entries need to be listed in
the addrvec rather than dropped at advertise time.

>
>> Match the userspace messenger, which since Nautilus picks the first
>> entry of the requested type and silently tolerates subsequent entries.
>
> Do you have a reference to a specific commit?  I'm wondering if it
> isn't on that "merged more or less accidentally" list.
>

The pick-first selector in AsyncMessenger::create_connect() landed in
Sage's commit d1a783a5f733, and Xie Xingguo's commit 50d8c8a3cce3 fixed
the loop to actually honor the "pick whichever is listed first" comment.
Both shipped in Nautilus.
=20=20
Would you be willing to take this as a compatibility fix, with the
commit message and the comment in ceph_decode_entity_addrvec() rewritten
to state exactly that and nothing more? If you would rather keep the
strict check and handle this on the tooling side instead, I am happy to
withdraw the patch. Either way, thanks for the review.

Thanks,
Kefu

> Thanks,
>
>                 Ilya

