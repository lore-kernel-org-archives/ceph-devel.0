Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79627AC4D
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602615; cv=none; b=QULRFBgjHSSjrTZ+GONvjaqG17wuYZmjQV+WCzYEHWPyuSUtyg59yY6tosb88yPlIteDOo85B6SllNDhgGRTRPIp5fih2DYAfh91qM4dGOG+3eTYcGVRUGhSDTjbpKa/358J6Y5pYeqqOPuUfM+VjLPuOOcYG/umruW9iVuuQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602615; c=relaxed/simple;
	bh=vc5CloJP3iwGQJfVe1DwrpQ7ImQBwnfgauprD3QCFas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSW6vZgSL102PWiyJBeROB+0OBrE2+gMHPnjxKoGNBkg2off62tkL/ZKHnnBkpfxqS/6s0HtwL0vYkKPt7mCO4icztMAyBHzAkXhX/vSB9M2GzbwmZhfXZYgTcQ5WKCl1LVtAZuvwfqLfaVWN+st5QarFzwSJdxEImmgWpuRvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Nc72oNFd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Nc72oNFd"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dc6fbf3e86so14178797b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780602613; x=1781207413; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+0N+J7SEZ+XonbXnjCWL+A+FfzC//efRIvTT4+t6kWU=;
        b=Nc72oNFdzujoCOihaPhfk1gs9awPLi0FnYttKpMpKoL6aND83TdmVSepbtmonCwQSF
         KV0r2eEVgb6lfXLDvIXSSB6iS8WEzU3mNZbvOhgoc3XUboZFBJW34TSf2mH9tr49MEq5
         wBgwkxhOVRLjh7mLf9OVh9ngRsu3ba29mCKojMJtI0rh9juKwZQYeKnTFvlmiGMOFxWi
         JUtthDGOSgXDy4KVmniSDsuTAVGBJvapUA7O85ZCZ2WsTCMVvGZAIICV1nDFXVgb0Lem
         M9RG6kEU+Fea+pTLrL7CNSCK/XxyJMbJeQ9+G26Yo0FFfSe26RPswNsWgqrRCjoEdR7v
         XApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602613; x=1781207413;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0N+J7SEZ+XonbXnjCWL+A+FfzC//efRIvTT4+t6kWU=;
        b=QFUdEDaj5nqqsGlRNtOGzRz74Wa6LJBJ4uTxBJsJyRdjmXnocTHPrV2+FwF0Qktm/V
         gM51M60+sthr1quW0GWjygOovzFsPTUmUaPMuS+p7wrbFWz1Qm8G3g/SuUuqyF4zGybk
         oYVuXD833/0R/QWcWLkThVsGFy1vngR4UGKq3jLCQ3x+OPjcbacN6kibyI9QH3L5xkZO
         sge7kCyArLiwih1xuNJ98jpiLw8Nw9C+ewFQywgQRlZZT6uNWv8ZTkCcUFgdsWebdNr/
         P7/FuJtL9v7oN1paYByWHhzgs2EGk8k4d2DSi3KclQ5766AJVos8W+RJZTJczx/HQT7i
         siAg==
X-Gm-Message-State: AOJu0YyqqhNbDunLaJ77oxMlVkMGvKDU6F//B9YLlPCZL37UUufzClxP
	iiZRItrgwYricjJF3miF23eusuBnTqkv6UtKgW31DCNu5ornLhPPIGyVYupL+UEB850=
X-Gm-Gg: Acq92OGbs4YngZra/L4cUwQ6SLRMt/GVHN0ti3y2/PwiviDQ1a5aXc3YgSM6CjTgU68
	hvgkYyg03725i8Z+xYDHgNsX+Jazi2+2+mAUDlarQ4Jf9nCpHjUIz94Ag0NAnPN+cKQCJWxt5zx
	hogApw5KmzSHvBo7HmAm617NOM1r/lJQYoepcf1Pso5g2f9/d1i+tHncPa0SdG2bKARdpyrtWCh
	kVb7TCxJx+TvBrjcp5n/WOwDPh3t7zoPr61G3/0RFNIHQ+ZILQ1JX7JWvbsIkjZLIKOUS8B57b0
	Ra73ZsA/VxiN4MS6dP2jRTsCzthzxgEYmK3fmRuGY0iwWweG6dCOQLIA59ap4/pI3vOmJF+xVEJ
	ls4IyCJ6yfw9UwfG16MZnWXOMgipf22nsKXqTWWya0iIQKqL6FCQARemvjcIlOfor99aZ/nz+jt
	Fd/vLTLJOcL7QHSlzoSp2aR2WyqwpAdApb/RmtjFmINWxiJ+IUeV2yHD7Tdqmrk1KQoBj+SJDQC
	gr9ZmB4AfvWAhPmdrvLC3fCaIP0nqWQXs0PS/mo8ghhjcdGM+BaVrws6xcr50U8HI1JaGc=
X-Received: by 2002:a05:690c:45c4:b0:7b4:6f40:635 with SMTP id 00721157ae682-7ed0ef4c22fmr3364177b3.16.1780602613472;
        Thu, 04 Jun 2026 12:50:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ae19:b6b2:5990:ed2a? ([2600:1700:6476:1430:ae19:b6b2:5990:ed2a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2399ab1fsm39834287b3.33.2026.06.04.12.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:50:12 -0700 (PDT)
Message-ID: <3f1bfd3ef4a83e02ee9e5886bb78c5b9b188c01b.camel@dubeyko.com>
Subject: Re: [PATCH 1/4] ceph: bound xattr value length in __build_xattrs()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 12:50:11 -0700
In-Reply-To: <97a34ff3743172b1278f211d47a500a07eb25732.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
	 <97a34ff3743172b1278f211d47a500a07eb25732.1780596023.git.michael.bommarito@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 14:08 -0400, Michael Bommarito wrote:
> __build_xattrs() decodes the MDS-supplied xattr blob one attribute at
> a
> time. For each attribute it reads a 32-bit name length, advances past
> the
> name bytes, reads a 32-bit value length, records the value pointer,
> and
> advances past the value bytes. The two length fields are read with
> ceph_decode_32_safe(), but the value bytes themselves are advanced
> over
> with a bare "p +=3D len" and no ceph_decode_need() check that "len"
> bytes
> remain in the blob.
>=20
> For every attribute except the last, the next iteration's
> ceph_decode_32_safe() on the following name length implicitly
> verifies
> that the previous value did not run past the blob end. The final
> attribute has no successor, so its decoded value length is never
> checked
> against the blob bounds. A malicious or compromised metadata server
> can
> set the last attribute's value length larger than the bytes actually
> present in the blob.
>=20
> The blob is a dedicated kvmalloc() allocation sized to the wire
> length
> (ceph_buffer_new() in ceph_fill_inode()). __set_xattr() records the
> oversized length in xattr->val_len verbatim, and a later getxattr(2)
> runs
> memcpy(value, xattr->val, xattr->val_len) into a user-supplied
> buffer,
> copying bytes past the end of the allocation back to user space.
>=20
> Impact: a malicious metadata server discloses adjacent kernel heap
> bytes
> to a local user via getxattr(2) on a CephFS file. Add the missing
> ceph_decode_need() so an out-of-bounds value length on the final
> attribute fails the decode and returns -EIO instead of being stored.
>=20
> Fixes: 355da1eb7a1f ("ceph: inode operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
> =C2=A0fs/ceph/xattr.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index e773be07f7674..d488bb8fc00ba 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -848,6 +848,7 @@ static int __build_xattrs(struct inode *inode)
> =C2=A0			name =3D p;
> =C2=A0			p +=3D len;
> =C2=A0			ceph_decode_32_safe(&p, end, len, bad);
> +			ceph_decode_need(&p, end, len, bad);
> =C2=A0			val =3D p;
> =C2=A0			p +=3D len;
> =C2=A0

Makes sense.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.
