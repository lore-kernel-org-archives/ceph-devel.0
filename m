Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83C4EB86E
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090358; cv=pass; b=SXroREGodPHZA5ezxlkAenbUzOyY+vjgtWL2G32c+eEdr7Gi1TYdGSP4Ie8vPkDPufQvKK+jK/PlcECRGUPPSmpKNGhS975ZW6kTuaYD3vCW967P0QBFaJW2K4C0kdQiC6oWiCjH8W8K3dIw0IQvbdcCl5Oh9viG7rMGqJ8cwe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090358; c=relaxed/simple;
	bh=GIdhD9TeSPWmNsy0fX+a8u6D/y/bXyVjLxaptbqD0Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5AelHtHmjdF3xfiEg9Ja3TLmQcUrO/j9evGDYSi7L5arABgmMcvVgKPk6WJ9O0rC8+PGld0cFpS+CC8BwrALAg+ZDBX8rdteQDPgfmfHxGFPQPuCb96dhOy0itHG0btSxMKnBT5T6JqZaAmb+FSY/UbI8MRN6TA/Esp6ZbbRQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Txa6E1ej; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUOWuOc/; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Txa6E1ej";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUOWuOc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792090351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+sUmonbqyk5xIs2kC+9hn0/UcfQCr5PxfxA1r/ri1EQ=;
	b=Txa6E1ejxMaEJ4n4MlnE6RMotdlUem8Gp3VoRGqOqIOaNMfHPkUatUpLTrKPcDitaqS8OH
	I+AXEQYICGl97PAE1oSEWJagpCe/jqFciQss1M9Qdjpe7xMHuSqBQijVJ/P5lW7pltgSu+
	+G18xqwEm4pnzBfT1sFNYEyaqGlBouY=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-HqXUKOtaNuCTJGMKwGnklQ-1; Thu, 15 Oct 2026 18:52:24 +0000
X-MC-Unique: HqXUKOtaNuCTJGMKwGnklQ-1
X-Mimecast-MFC-AGG-ID: HqXUKOtaNuCTJGMKwGnklQ_1792090344
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98304865f02so4492004241.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 11:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792090344; cv=none;
        d=google.com; s=arc-20260327;
        b=oUA13JhPQsQsHx7p37TlXS4YdMh79OWpVfGyifcByUYmBg9M/C4tM+Ihx+Etar8q/Z
         abpR6h7Jpeqf6HuAONFve5KO3WJb3VafD75sJ8U7EyCf6AYpbDrJV3vGm9yvIRDOOlrY
         2pz9iqlBiyfQJP0FsHNSU9ss+rkrxOSMFpJO2Vw5xP3lMc7W0QMypqjxECvYuVcNE8eV
         WThwaAxghupJiBT9OWHx5/Y9c01LSS6NgiOOvrt/8i9biD9PF9+0fnao4kVS7eVIyd8t
         BZGA9cdVrDkJrGlZVkVAA2xqNbsGWafOnqyfvHHRD1vkgwuNrCWydSm9ixikDbwCPWax
         qAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+sUmonbqyk5xIs2kC+9hn0/UcfQCr5PxfxA1r/ri1EQ=;
        fh=lyy3HDLA7FpLbI1TXCu7aW14Wj1FPypmG7KRDQ6PnMg=;
        b=bP64PhfTeVaRVopqyOncemKckOkY+n0lxxLZQxzboX5MdIwmBPiiLfu2zDdqCX0M7m
         1mF8tkyRjNjktLQosAtxFh4XM3gIXnkmWJg1GqE2QXy7TH/Z1/HjYLv4ycQ1b3nvWeeJ
         WjCQHkp+9iUuXygPfzPAo6X761aXSuX0LjCeAlX4trQJm/voz0OaS8RYcnm2p5x1k59r
         wJ7naML7A90KqcnB/ncFbiJgagCJysVrz9K7zGGvLamWqHnGBzWD2tiqy6rzNaT17cCv
         c9UlT7F3uBMREGynZENjOe2qYI8stTcwMNbX6AmTdD9df/0MkQcToytjc4Q1XH2R0/he
         7Zbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792090344; x=1792695144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+sUmonbqyk5xIs2kC+9hn0/UcfQCr5PxfxA1r/ri1EQ=;
        b=bUOWuOc/GcFMd69JKLy0eWuhWeOXCZmejxzKppZKvnxBVKtcEqwra1R5u/IUYrnR3L
         S8WGpJI23hnUttzv8T0/lNtyB+3n3aWA4LHlty9lDmeE/BSL5t+mRyE/KeZICyftM0Lb
         kP8CgJO8qy1u756dIQqpVmSBGCZ8GjnGuke4UNbt8qVVpa68OhLuQ41vyubXr8U8cZ5w
         3gCy05Q+T6Xcn+tgMAfLZc/IHPwQPQ6rsG06KTwb/LD1My/4PSu1rhi+LWcTcas7ItW5
         G/A6PNuGrRjolNgNnXSb+rZOm2pXTuq4U0wexdqogTTD53PPy0i28mtVhKnjapbF2UuA
         pvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792090344; x=1792695144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sUmonbqyk5xIs2kC+9hn0/UcfQCr5PxfxA1r/ri1EQ=;
        b=ji0l6xcn/64rrTQ7DH7d0925efvuyNuLk2kMk+V1+ZlR7gE1gKvkjNcC//meGGNIc0
         VTnjq8VnzAxSxj4FNXLVVBepNvJyYBPqqpQbRaSKfxHBQ0hrQX2FEaMHzomOyQvGj6Eo
         HHdC73RfBdWtFt5KrpQDeOXjOkQW/AKmod8xEKm7RL5BU3D+uZGjgWhH4DcP07wiIBg6
         HFdoaZWLnP3HViiwZm8secq5HIfA/uNFGDmvYiPt1TwrfUqxU+pWQr6Dj8TGbZ/bHkc9
         YEeFizFB+kMW4UZsZvL1tXuONXJ+B+m3We3hfDTuMUC1oinWx96ehaklSM2mSznqyPM2
         R1SA==
X-Forwarded-Encrypted: i=1; AKwUvBzjoVepDpDRQyJT05Iywp+7CZb4jwtAA193tGmtKSO6oBVYmhpJnKUcLeHG+XvdWFY+Gk+TuATE1+g+@vger.kernel.org
X-Gm-Message-State: AFq9FYIoKCOE4+0iiBiGJi9q/VL0tqmFYBhxj11PDVLXqMZWaCzwf5xx
	T1oBR06AGY1a1aRzjPQe1s+a1TIAfNsCpML4M9AAtm98imWFKFgK/rTd0kc0iDpJDNuo8WA/Cjk
	3GDU48ujlLnANqspYcxV29+3j++wAEAhzjgAu0/aCCqMk+M7Ab2yOBbVNdDwDMwMuAgiP3Md0aN
	o7WioBE7pubuZk+AaVlTf18KunMe/s2wmg4eF6+w==
X-Gm-Gg: AYBFou3XPEIpJ8a3I8PJB3ZhHFc5OyhzQ3jE8wSlJ6276deN9nz5tgp4AEmV0sySEeX
	d43c1ITpzxf4MU8q6byg46jGx7R02IgO/SBqjIStOGgNPI1hSRAQS0Ew8gT2CIKGKnKPwRZgAof
	DrUOPQJRBi8MTIZb0ZQgT4DO5SfivkcpaVHSaO4l1nHBSZCG+IT/Qx+ulvbVTLnS2IMWF2jDuEg
	8TRWwl/KGVUsr3SFWpAEHAkFnv92ZNCnjB+Nl4k/CoRoctDtFuYcRgRvI6kapDkM/PiprrweJIM
	ba9BJchxHiQs/40S3ffapJTYzw==
X-Received: by 2002:a05:6102:2909:b0:7bc:1de3:39b0 with SMTP id ada2fe7eead31-7cb3a15e9a1mr7057334137.32.1792090343766;
        Thu, 15 Oct 2026 11:52:23 -0700 (PDT)
X-Received: by 2002:a05:6102:2909:b0:7bc:1de3:39b0 with SMTP id
 ada2fe7eead31-7cb3a15e9a1mr7057329137.32.1792090343324; Thu, 15 Oct 2026
 11:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a01d0a297a3e174d21741a3ad586ce546327603e.1792081664.git.amarkuze@redhat.com>
 <20261015183548.GE2170687@google.com>
In-Reply-To: <20261015183548.GE2170687@google.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 15 Oct 2026 21:52:11 +0300
X-Gm-Features: AclHuK8AcY6paQ-tWkxVfhofIbCNjjczg8Wu8LAM9XVRyc2K231BtACLuWOj-8w
Message-ID: <CAO8a2Sjr6XSizdgobZK1ZAO8PUd5tCDFKjdD-=3TXHwqOU6qfg@mail.gmail.com>
Subject: Re: [PATCH] fscrypt: allow filesystems to disable symlink target caching
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubo.li@clyso.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

This supports the concurrent CephFS subvolume quarantine series.
There=E2=80=99s no Fixes: tag since this isn't addressing an existing upstr=
eam
regression.

The quarantine series adds checks to Ceph's ->get_link(). However, if
an encrypted symlink target was cached prior to quarantine, the VFS
bypasses that callback entirely when following or reading it. While
the target data is still valid, access now needs to be denied.

This patch adds an opt-out for symlink caching and enables it for
Ceph, handling the encrypted-symlink case for the concurrent series
without affecting other filesystems.

On Thu, Oct 15, 2026 at 9:35=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Thu, Oct 15, 2026 at 05:46:24PM +0000, Alex Markuze wrote:
> > fscrypt stores decrypted symlink targets in inode->i_link. The VFS can
> > use this field without calling the filesystem's ->get_link() callback.
> > The target can remain valid after the access policy changes.
> >
> > The CephFS subvolume quarantine series adds access checks to
> > ->get_link(). Quarantine can revoke access after a target is cached. Th=
e
> > VFS cache can bypass these checks.
> >
> > The no_symlink_cache option in fscrypt_operations gives filesystems
> > control of this cache. It applies during target creation, lookup and
> > getattr. With this option set, the helpers do not read or update
> > ->i_link. The filesystem callback can then revalidate access.
> >
> > Uncached targets use the existing delayed-free callback. Each uncached
> > lookup allocates a temporary buffer and decrypts or encodes the target.
> > This lets Ceph reuse fscrypt's target validation and buffer ownership.
> >
> > The default setting keeps the current cache behavior for other
> > filesystems. Ceph selects the option so cached targets cannot bypass it=
s
> > ->get_link() checks.
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
>
> This sounds like a bug fix?  If so, which commit is it fixing?
>
> - Eric
>

