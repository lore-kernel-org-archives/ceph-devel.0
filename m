Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31C35E1C0
	for <ceph-devel@vger.kernel.org>; Fri, 21 Aug 2026 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787281712; cv=pass; b=CIXe0YPjX655R57FiRsp03ZHkNwPKlIIZ7/ApH6Ki2blcKIzWVPF3Gp1r0MSLpSTA1+qXisn9fi3j3ZZwhQHA6tXKqOAP0iWNlTNc26fKQlyfd5c0OKQ1Jv5yE/kGgb55rdQbzHHEJlFowwbHKocaAHGSmiUiPwpi+tah6IpvWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787281712; c=relaxed/simple;
	bh=ZRCtp1Pk/5php0fzGvPHVtuJ44j/HswL8aZvE8T57aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIM+cvo39uh/PLjuuhQX/W1wwFUK5AHl242LvLK+yBoPPvjyKKNxGbnbyH5/c0vDU6ScDmyP3Nm853EJ+m8p8IgrVbXGGYOW8+GjhMXJTQlj9iFdGeWzlhUKQK7ac6B2fcQQgoqNe0XjGm35kS4WnOkNU+c6Zoj2ncT23WOY9eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=J2jdL1HB; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="J2jdL1HB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a422090b14so882425a12.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 20:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787281707; cv=none;
        d=google.com; s=arc-20260327;
        b=ezB4E+GPitNDchD4qi7mXM8NL7JUNvyCpgzwCGQUPZO9SWsJHvqGxZuWJcGW6dbSii
         Bn0Bye1uOP5OoBf15FVsI9JntxaDRh0XnqwV2nIdZ4zj1jFJQjb1EA5qTCTOjItTy2aj
         SBIEgEpnPy1GjJtGycWqAafP7xjvs6QH+xUeQ2Empgj+wckExyUJRTIq7/72mK/Ny+u0
         WD2qti31qdcnUTEmkFqivRqWtIIO2szezqALGuPGxSnJQaT8unmpv5vbZJssQ5SDa55M
         WsFGk6CsaKqhsO2mMEidfCC61CLxKWehT+x+g6No7fRWLweKPSHWvJCE1gmyiU4hS9vQ
         rthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRCtp1Pk/5php0fzGvPHVtuJ44j/HswL8aZvE8T57aU=;
        fh=BpgHPY7t8tyg82M1nPIxs7flfos2lTJan/7QtyP1R0M=;
        b=BytlQ/AuYXO87hZek7IkkEYgEwOdwQJ9BzuuUwEqvm5Y/EQAM4dWQIZe/gLtlRbRwr
         z2DXqjVCmZHQNoIaUSQp2hXqdmy03ZES2ynMaOm2GYVA8dfVDwcXGzLINgPUv5ldihHT
         Ni2cZaeM1Vyr+EWKO87pHXKhz33LZNAYNHggZvSZBTn6ZozBrZhn0zEjACQ+Rp0yEbPE
         IkNVhljIfVD/U2GkDMI7AtT0Gus1IdJCHOiZhIBYBLVwIPEtx1/U5SBHh338X2I90W4L
         JeX3469NEIA+XjfAEJdN5u8A+5AkWH7Lu9ouSW9KtgIk38h4eS+ayQATNGS36ueuW5rP
         gkPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1787281707; x=1787886507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZRCtp1Pk/5php0fzGvPHVtuJ44j/HswL8aZvE8T57aU=;
        b=J2jdL1HBtqImPNI8MN0rd2AjS5XMkJf5EdibJ0DKldhvBR+gfO85mpQYvmKEl/HLG4
         5MxfqL2MAaZKuPrBycH4oHj/Hl1m2GiOFC8VOqNOucwzbsV1/Nvup7mBQruU4B0Ewu9v
         d+3COIkKv0G+s3djx5tFl4qBIiPOF0X9ToR0NYWXpVFTCafmxDi2vf1fWuj18z85aGS8
         Bz0aBIa5sJnMzVcgtEHaS7cmw0X4zGkRLT6Zbcwc7aKJUFFHDpRSyq+k8AGyKe5Yo92k
         PCZEPcihVtbsPLugPZCjgyszUM69nRZurWwnUeghplJywA3YxIx1m5ivI9QUXzOVbaQE
         fEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787281707; x=1787886507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZRCtp1Pk/5php0fzGvPHVtuJ44j/HswL8aZvE8T57aU=;
        b=gyrvEriQUEgiYFA0llX4yYHBJ/HzAVeWTBH0JxdkjZU0dsWoakaGhcaZPzuhs0c82M
         xJfYBRGIii5h+XGMoi/cXPkkf3L6+qsgiKdksgyQY5ShXHFzFFmEPxYyIAF4gcloHJLT
         dcjc21rvLEkPSmtoKL7ohZz2B21fOk/n8AjubZlqWAuqpqUr1pkfHDNLdqKLAzPFNq0L
         qLnp/LcmEvy87UdSQBGTs3hIDPwbgLOQQx7Ds/n/6vSLlyQxvQSfIGsZRjiR18glNMwl
         y2GcrTAF590K4I4ZCeOiz+ZWykp1kha+Gc3SFsXnp3dM96JEEkulz9yqDQvYNUPxZplQ
         8pOw==
X-Forwarded-Encrypted: i=1; AHgh+RprpOY/we8pv9trVHYJNeQlGRE1lcw+0zX6UePWhKEDNy7w08t7jxrtyP+OpPysErfn8xcBHDrgWPCG@vger.kernel.org
X-Gm-Message-State: AFuF++kWsOBDPZF16KVK98oePm7kfFRLwOf1XL26klanKbxvTHnYVBe0
	qhqp0+/IY7i+ndbomvFYzDGBelXh/yJ5UgMG60wEIphNDkWK2I6dOrcY1BM3jqrpM7ZrQzh6SZb
	j5VsukhYi6LT1QvKmzWDjhG5eEYr0QLAs4j088DvbAQ==
X-Gm-Gg: AR+sD12VGXOZLvLtl+oTmGBBq8gO6EYqv1lpkO8dSpyXOyzGiHklcz/zSJ1DN+qr0vf
	ahXB69PFxYDlMvIHKeEcGcmS+1r12FVRmF7cxiLj3K+sU6QGjsrD8EPW66BM460EpeGZzHE/m1n
	MW0lyKDjqAWtofLmDro7AI7UsN8UrX1Y8FriG4vGr8pFEGvbcdtRZa4KyLMX72j5CRSP3lf/S/p
	RanCQKeRffHwhWCHO3q7dlsLZlmLjlOh2QwFXMZvc5wFO/GGgCGtCfDVAjciBT4fV+AcHWPXB4j
	qzgA6yyFMod4y6613GngG4inNONPltikCA5Tn60lKOcbbA==
X-Received: by 2002:a05:6402:322a:b0:6a1:f895:1ba with SMTP id
 4fb4d7f45d1cf-6a42f20b899mr3730375a12.12.1787281707008; Thu, 20 Aug 2026
 20:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819-lazyio-v3-1-21110d37c4be@clyso.com> <20260820184337.2284093-1-amarkuze@redhat.com>
In-Reply-To: <20260820184337.2284093-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 20 Aug 2026 20:08:15 -0700
X-Gm-Features: AcwNN1UZY7hUs_sQBjw5D0BRSW54oLzfP1_EZXKs04FI8sOb9oWBio0wq1H83ek
Message-ID: <CAOJNxRL3XExcEznL=x_kFBB4_=TkOXHUv25goZciyB=MYw+Qxg@mail.gmail.com>
Subject: Re: [v3] ceph: add 'lazyio' mount option to kclient
To: Alex Markuze <amarkuze@redhat.com>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Good catch. You are right, let me fix it and respin as v4.

Thanks
- Xiubo

On Thu, 20 Aug 2026 at 11:43, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> One issue in caps.c:1014: ceph_adjust_caps_used_for_lazyio() maps
> CACHE/BUFFER onto LAZYIO only while LAZYIO is in issued. The grant path
> in handle_cap_grant() is fine =E2=80=94 the writeback/invalidate wait fir=
es
> there. But after the revoke, ceph_check_caps() sees used as BUFFER/CACHE
> with revoking as LAZYIO, (revoking & cap_used)=3D=3D0, and ACKs immediate=
ly.
> The MDS can then hand the cap to another client while dirty or stale
> pages are still present.
>
> Fix: extend the mapping to cover implemented, not just issued, so the
> LAZYIO-revoking case holds until writeback and invalidation actually
> complete. Also worth queuing writeback when revoking LAZYIO with
> i_wrbuffer_ref set, matching the existing BUFFER path.
>
> Minor: the commit message still says CEPH_FILE_MODE_LAZY is set in
> ceph_init_file_info(); since v2 it's set in ceph_open()/ceph_atomic_open(=
).
>
> Could you respin?
>
> --
> Alex Markuze
>
