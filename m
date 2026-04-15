Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B06E378D87
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283069; cv=none; b=t05AsSV0X+21Fyl4Syj+tkO8biBJyarRixuHWicph1i1ZeL3yr9WrfOQ9/lPW7lkSqSrFFZBMCa27PPib4Wn7pqFYyfRksh8XhR+KUOecASr1UlSHoqLFfQvUUt738wjLkGubCIEoghU2+pQ5MSl3MsSqMcT2lBsSNn02IW/9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283069; c=relaxed/simple;
	bh=VmAcNb9P3Qr1tYvLopyU/QeEdk/8EC4lozC05QVaB4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kPLiTDswCpdkjO3EId7XtgvqvcpDYq5IPtDfoXxt/NELxKqcM7JKy/B65QVLevll7sJ3ItbUY2IZ60+SbanCeUjfJAIFib2PlaUZrjX/qKjfzVVVbpw47DhNB22sCNzyZd4wCZ/5pOCNn3n09/oVWeugO/pR5vkBu8gFe2v3PfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSgasmm+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MD/UYzrX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSgasmm+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MD/UYzrX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776283067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4oSjRXCWU2fv/i32WfN8ZJBnI6Qk7Ic73APVL+9OGw=;
	b=LSgasmm+JkovwZDH82HnSsAzRxVEz0INmq8JNtgpr3xDFUvtifMisgb0Az4l4YYKqeooUN
	OKYi+aAV8IUZlbMBj4GTLCh/9XfCuJGGaHMGbfOgCpBwABfpA+JC31IGA3KZJ9ZyMc6w2W
	R0bq4wllN8AKQLoUmcKYS2OKAqgK3ak=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-1-ul9h-jORaBtwNzrDnqmg-1; Wed, 15 Apr 2026 15:57:46 -0400
X-MC-Unique: 1-ul9h-jORaBtwNzrDnqmg-1
X-Mimecast-MFC-AGG-ID: 1-ul9h-jORaBtwNzrDnqmg_1776283065
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7900fc7033bso197873517b3.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776283064; x=1776887864; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O4oSjRXCWU2fv/i32WfN8ZJBnI6Qk7Ic73APVL+9OGw=;
        b=MD/UYzrX+Sb22N/G0u7fAeS8ezU6TKjBAirVQMgblVM5ap+e5KiEe4K8o94L4BPCsi
         Da5eozdLgTvLRgi/UDlZSoKhrIDIaphNO/zHkypOcY6gvhqDHTyv5GCZajliYz44E7h1
         yJQ/Ve/hnkwlDk7mvRR74GigEMkEiVtFoJ1++kgLLD+Rc/nQLkteQP/9/NPFE0k+PZNJ
         dNMd86m+KgCiIDAFwzqb4ss3sVX+ezu/PEBmi/MJLVfyJo+YtvJwYBXGv6O/I+RoeWVY
         VJQb5dueWJd3ViktYAKAyzyTpVg5XavlGgzlapRR6HBZ4artqfyBNLZLErdI89K28LOu
         lQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776283064; x=1776887864;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4oSjRXCWU2fv/i32WfN8ZJBnI6Qk7Ic73APVL+9OGw=;
        b=VVgDqLVBM9tSEYNTWukK9u1KJTYqdDlSMqDgQXjGqP1F/mZkBRfBcVKJkDPXGqxIrx
         joIaL6Q2MEDTsU/rVCG6iZks4q+b55x6qEKj3PtheIxH9GJkVS7aicGpgNsvT3aWwL+3
         HBiZsz0e+jLm7o/EWii+caw4JTifwwSz/V+AFi7zQew1NtF8yI5SviSMvS+OkNgECbNf
         MPzSmk0LMGUm3V7ROCJWJmCrcPXnIFfWEIvd4MUDm0WqKL2ScfP20HTjZOKOn61XU2ww
         5Z98E5tKrYqAuOmLCUkDSx0YjMSrEX16FSSdJNQyHAFvz31DtxUP7ZjHBo3uNUEQ4GYN
         AoZg==
X-Forwarded-Encrypted: i=1; AFNElJ+WdMY0fuhES4Aq3szUkv+mMfjH9oVc7j3bp2JOgfnLbN8q2xyoXCNfYC6vaw7JLrWzwk71rk3Kmm2s@vger.kernel.org
X-Gm-Message-State: AOJu0YxZMVN+cik5n2GxXZwSwKKSsy/PO3p5lQTCSvxZioIRzgLHTFxw
	UoOyDyXtZkaewZGCpCNcrAagJ6meVQ/WUoK29OWhgLc7bBJsDNrjSa5wzWBAPEzURGf8oRJTSiJ
	0c80cn2vB8QVOSpG9EO/vufik4R4bW02LD2ezIQ2ehqdCCJWbP6HNOPf7VOWqVfi+dmbs4i8=
X-Gm-Gg: AeBDievLJLWWx0u7luYjFOVQEOQTT5atN0qlFMUYFlovOeq3fHXwtAp/3FBcx5FMS5L
	1y2IKbU3LijUKA6+qk+lj2kiD2ZvcjNqq/iwGExosZtdKBlcV4R2KPix13ZcdvU9y6qt3FT8qn6
	czSjoNCVwgOW47r9N9u0COEEMFB31bkipLqu5ADndxAjBnv3G4H6ITWVvziZ4INBW/clIRmLPbo
	5d/+afDu9ac8Cf9Repq/NdINXbQSUFlMnG2qRQiXQFA9o5xCI08pg8vcn4J/ASsGXRqhlQxWBqa
	mqAbQuG3cl1g0kXn49VhVmtByxiRy1xFPOLrn+mf1zuevEz8oNM/DEMdF5ErGCDZ0kXDDkNlz2i
	BhRjbO+aj95+rhjWtJUvQB+zlRlBa0M/E2xqnZQppfwwUN9FW76mhnJMF1s9aaXQ=
X-Received: by 2002:a05:690c:6a13:b0:7a2:ce0e:863e with SMTP id 00721157ae682-7b86542b1camr10545957b3.27.1776283064383;
        Wed, 15 Apr 2026 12:57:44 -0700 (PDT)
X-Received: by 2002:a05:690c:6a13:b0:7a2:ce0e:863e with SMTP id 00721157ae682-7b86542b1camr10545747b3.27.1776283063968;
        Wed, 15 Apr 2026 12:57:43 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b76941160csm12724327b3.41.2026.04.15.12.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:57:43 -0700 (PDT)
Message-ID: <e912c9fe27f9254b570178615a2f5248dea8acc5.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v2 2/7] ceph: use proper endian conversion
 for flock_len in reconnect
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Wed, 15 Apr 2026 12:57:41 -0700
In-Reply-To: <20260415170043.3882912-3-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
	 <20260415170043.3882912-3-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 17:00 +0000, Alex Markuze wrote:
> Replace the __force __le32 cast with cpu_to_le32() for the flock_len fiel=
d
> in reconnect_caps_cb(). The old code used a type-system bypass to silence
> sparse; the new form uses the proper endian conversion macro.
>=20
> Also switch from a raw bitmask test against i_ceph_flags to test_bit() on
> the named CEPH_I_ERROR_FILELOCK_BIT, which is the correct accessor for th=
e
> unsigned long flags field after the bit-position conversion.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/mds_client.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index ccf0d53dde2b..871f0eef468d 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4693,8 +4693,9 @@ static int reconnect_caps_cb(struct inode *inode, i=
nt mds, void *arg)
>  		rec.v2.issued =3D cpu_to_le32(cap->issued);
>  		rec.v2.snaprealm =3D cpu_to_le64(ci->i_snap_realm->ino);
>  		rec.v2.pathbase =3D cpu_to_le64(path_info.vino.ino);
> -		rec.v2.flock_len =3D (__force __le32)
> -			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
> +		rec.v2.flock_len =3D cpu_to_le32(
> +			test_bit(CEPH_I_ERROR_FILELOCK_BIT,
> +				 &ci->i_ceph_flags) ? 0 : 1);
>  	} else {
>  		struct timespec64 ts;
> =20

Makes sense.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

