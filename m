Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877630F92D
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290090; cv=pass; b=iX623hpBjZL4S+O9uO4M2zodEZQpYesi3V25dGvu9XcKOJejOjwI7S/qids6sSvbhzvlcxnmjMukVlF3JJTQHRWTbI8JrFG078pQcDOdaglZMucxKUKBv5exqIdf2aZR5YrHytBuDqPDv1uGzRX72Bw1m0ZJpn2Av0bX9eooU8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290090; c=relaxed/simple;
	bh=wTL7DcS2E1yrlCb0noedQpMMItWRmCTLLjo4xGooGeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkCGl1uwzFolBQaFINz+t7FiqjmHa4wW3t3wi1ru0WcsHhiBtNV6UnMXWtCTdDA6CwziZs14e4hWVM6j3lsB/vbZQqNgTn+udbFADR1Mv6WQ4hnaAeXBlgr9+xkePu0/kK0cq3fxnr9i+43CIDWxiLnNYLX0GUbVLX02d1XsIZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmCALxlf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W49/Dkl5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmCALxlf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W49/Dkl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777290087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PK50sUFtD9wC79Ym2+1b4rOaaH2eGEd7ZGmhf/7O580=;
	b=dmCALxlfkXz3NrA2LbmFzqTq0hBxCiJNiqMtwu5lD9Fq5fUHtTeOKpuEv+s3LD5HmpqlWs
	EQ1Zvz6XJuldYAwCH9bm0Gc2nn+VyJXfdTuNBby1n8An+cXut9/CFYRb83ed6vTN26InBW
	Kld2bbvP7BdErZwCBSONhvFn8uDe1Yk=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-BOYXFQq-NqC_VXg3AWD-Ag-1; Mon, 27 Apr 2026 07:41:26 -0400
X-MC-Unique: BOYXFQq-NqC_VXg3AWD-Ag-1
X-Mimecast-MFC-AGG-ID: BOYXFQq-NqC_VXg3AWD-Ag_1777290086
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6102a8e6eb0so5220001137.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 04:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777290086; cv=none;
        d=google.com; s=arc-20240605;
        b=JfAvMSvj36znYH3faEEw1jZMtovcLrGbr2VqpsJV+915SW6IoAyHcIfOFrgT+I3Fcw
         S0SfMq/T73e/JblxhCUF4rBVVj1/qa3I2G5QQEBun3ZBFpn8tEZstTfuhKBJBde4eiSv
         on95nQuOgBSvgV2tq8y7a4ohoGDrmt6kqYHB0vEQOA6ienb4V4DapWFrqOClBVPzMrXX
         pMmsu8nOteDHT7ZtOI2xePGw+sq2Mr/P2xMcgogKQgM5y3rm3zEy/3tAtxJG+i/l02WU
         RejhIScNg5LEE4KAcfBDTLh2xWS9KtXoYaH/h8NoRSXBSSDJYeI9DuSZWEeiyXautMb8
         3tOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PK50sUFtD9wC79Ym2+1b4rOaaH2eGEd7ZGmhf/7O580=;
        fh=4sJrSkY7V8JT6AvZB1ZW0rR3MBJS7LN5g3XPU6S/PJI=;
        b=cvwikhNzj9RgqG86XLjmfqcltHh3SHamub2/r7Gp55WE1X7Ta5uLvYAV1IZs6IGnz1
         3DgTbIBUXGdTySZ0Ci0a+Ad5tBRmU775aAApyYes71p0vdZQi6AleeZ0BoNaFLL6jz8u
         +Vb3ja9bKJCOrsnBfl+IRi1Q/B6FacAHIleZZekuOUtKSX855LBqnu9nhAOdT7ZWKiNS
         l3rRSoXhvPQma4mSpevJw0BnLj/0W9RR2oYWwjFI7BKyKp1gLLU1qwTr8Pa8TW30HL+3
         gIhC0rl0i8GS8i4tUkCu3INomgY2SGnCjZ8RveLfh2D5K5WFp8R+b1bW0yjsl7g7UDnG
         TRDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777290086; x=1777894886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK50sUFtD9wC79Ym2+1b4rOaaH2eGEd7ZGmhf/7O580=;
        b=W49/Dkl5S4TYICw/Gv/LbiUcDuupGcKviYfN7uNf8OFUnYBApOkO12HOnnTAcB25nr
         Dr4HIa0LzSUVRlXhrIwV/ZW2Uovlufh1MdC2UdMa8LzT44zjlPz6FXuD4xsIXQ20Li7t
         WWoHWw974EMc95DumG8vUxuEjYLf0pLdHJZBz6ox6baUq7Wen3o4lRFeDkmBg6To2BMr
         Lq2OAOxIhY8tYVpjicp05P3dTBUz3dgwaSp0d30LF3+Qb+bCwfJ7E8T+tTf2RDM6SjwW
         O9H+C2kZdPXvx+kfnduPA8eFgJSQ3txl8Xh9bCCp+Kw0tJay0hMcQ7GfazyOVFD2/A90
         A8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777290086; x=1777894886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PK50sUFtD9wC79Ym2+1b4rOaaH2eGEd7ZGmhf/7O580=;
        b=rwU2uC4JC4S/d64UzmdOaQLfYaQFmLLhY6jylaa9tcoAcxX9p37eCvxIJ8hoSlZFNh
         Fp2a46/84ZxYUcZenYt6Zs40vYg4CsyNjiTinc/wnBurP6jTsyX8+VYITctyEbFa4d8c
         s4rFs6Ozsks0x/OnRg28uk9BsXqs13qMTLHX+PjASjLApbjHnV9brJQrElfk2OYVkJrv
         mZDkYkX6HOPyWdCMdjBEsFrHjihQicmd/8pGUhKBrZpD7rr9YPElKWch4vh9+GTcSB3j
         a3g7/s2S+or1whGYXyEyjgcYY3qow4uWNFDw2AGE/2e5c53J1oJZP51tgyNPWqCzQMiC
         QKrw==
X-Gm-Message-State: AOJu0YyNQLXX1WgyJVFLk/sm/p2Bqt2iFON2VCh4zsIkifznSi+6mMWJ
	tQzOxMg+Fbz3AWPdxHf45SGBtaRZv4Y9JCb1q/ki6CmAtJFTgfghQ7rhsi/5SNvJquB5QPCHVSW
	q3TXuqQa/bpL6rt4z7SJsTovB7wmJp472LaxsxV6lyCZLZJLZ3mkGGpHq/RtiHak37wHTGNa0y9
	+yM1FzVaczmynMLhY7rEf+1ulBK+KeEClYeUGTBw==
X-Gm-Gg: AeBDieuvZS0Os4dw7pJH/oDgsFL8Y1vQUobAc+bZkYnNMibrenaKzfkYG9g7DSZQZdR
	GDWVYqdLK2i+Dl+9L27SgxzPQQto8kJ3IO56+HxuWCpuCiodrQcJBOiAxgFmABXbu4imadCVKmm
	E+KiF3mlfwmAbpOS1qxd7xyFzNYJAS1+Smxm1h5hFP9QDBT6zACZnDsurwCHbOeU9mUo9+CfET1
	wCO0YwJYMxe1Wc=
X-Received: by 2002:a05:6102:c51:b0:612:c135:1b77 with SMTP id ada2fe7eead31-616f88b4239mr18746504137.27.1777290085868;
        Mon, 27 Apr 2026 04:41:25 -0700 (PDT)
X-Received: by 2002:a05:6102:c51:b0:612:c135:1b77 with SMTP id
 ada2fe7eead31-616f88b4239mr18746498137.27.1777290085429; Mon, 27 Apr 2026
 04:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409193832.318303-2-slava@dubeyko.com>
In-Reply-To: <20260409193832.318303-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 14:41:13 +0300
X-Gm-Features: AVHnY4KD1EYx0jCLM0-mkaTaeru5bJKkFPryoQlvnJKC-66PL0-5j9Y7KWAqtGw
Message-ID: <CAO8a2Sh6otfEtw2MTCy2vdeJEah8HOy94buMP+pxGzOnjxQ+kA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix a buffer leak in __ceph_setxattr()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Thu, Apr 9, 2026 at 10:38=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The old_blob in __ceph_setxattr() can store
> ci->i_xattrs.prealloc_blob value during the retry.
> However, it is never called the ceph_buffer_put()
> for the old_blob object. This patch fixes the issue of
> the buffer leak.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/xattr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 5f87f62091a1..c6fcbf428317 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1294,6 +1294,7 @@ int __ceph_setxattr(struct inode *inode, const char=
 *name,
>
>  do_sync:
>         spin_unlock(&ci->i_ceph_lock);
> +       ceph_buffer_put(old_blob);
>  do_sync_unlocked:
>         if (lock_snap_rwsem)
>                 up_read(&mdsc->snap_rwsem);
> --
> 2.53.0
>

