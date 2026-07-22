Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84542F6E2
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2026 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751425; cv=pass; b=DbLauN70YOQ07ZZlS0OnSad9BQtnFN6YIuwTWzbzYo8SFUmQ61st/+Zm0xaUiiKt1ECw7XRiydHy2e7mWBWav4S+6vV3J+VR7IimWSBSky5dmdH38SHfUMdI0SwNtcLQN+19NcPraEL9ypIrtiCE/OLjfkpCt86i8fEL5zHZ/9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751425; c=relaxed/simple;
	bh=R/H7i6hShZyRr/Z9cecb26G3znEmUv8W2scXXCzt0n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nf0Vkfu/2N6Yya3ouV3bGxcl0honyu8qCrRwSVal7l1hvYGE9YWvON2S7xgEcoHgzCV9+2cywYoYvgz2RpWvA0Xi5YOwO9z1qUkSCWIa6XQLkhql8BLPwMNYtVNxhvIpf/6oGOC09v3E5OWRdcipwo5bVoY3hMe1L8qkA3J4GF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGVR3yWP; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGVR3yWP"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9773c6ea885so685484241.3
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2026 13:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784751422; cv=none;
        d=google.com; s=arc-20260327;
        b=Jq2UmKkOpSZ8tc3TeqAbsTNlKYAR1QSK0y/UjNRD6l4jGDKcjWw7kPOlQFJYN5aiEC
         1iPAu5J/RBmgQ/GUTdlthsFTc1PcW95Irz1qt6yxBDlhIhHIVV74qKqNF8c/y2oP9HA/
         bWrJh1ZlzyR/+ARKmAGDzyE93ANltQzbBIcz2bkO88QVydR26msvgea68dCOWeemjsB7
         NoyO008AJMFQnt1kuM9+7oUrpq3iaV7dd7r325QvoKwyCrSGoLrzeTjKJAgOqmswSukb
         4nrSxIiS+AIBc25Rq/IJ/23nhdRB7Z+aVdOH4urbOsPhp2KvfFmO5J/mPVm08xRhiWwB
         F12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ctgAd9wg0GRoSGzcHXcHc1w0XtOYIWZCmYqQKxqHkHE=;
        fh=8LgzqN6dVJrRINj4FA5FSvYujPRdJT3foLwZhX4q9RI=;
        b=rM4K92Z28IB1Af9VCCemZXQGah4svGqgGHV3KUKwj0db3s/brXReqS2dX1WBsfdJTm
         mIuCSl6n6b3Y8k0OwzW75prEmitpGunMeypsLXaS4jUnO/fsrx3yiNs9jNWAr7dKRzbc
         y5gQs/aKpfp7GlOdGMzJ5gnXbtsphviyMSvLX48kQFBk4tuEGj2keiZKjM99vQosmfZo
         oHCt1kb5QotTa/2XfaL0AQE0gEz33zG/eaCHutbTElSMH0wwgPWjQMNmtS7rKsXWyIsT
         fedNyANznxTDP4RC/BdhUPtmQB/G2H3s8B38wpyEWrc2envGA70YH1DNa8EsCoLLTCs3
         mBEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784751422; x=1785356222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ctgAd9wg0GRoSGzcHXcHc1w0XtOYIWZCmYqQKxqHkHE=;
        b=gGVR3yWPtJOBOTfJOTWMVx0q79y7J0VwtPGpj6HYUuEaoenRFlycSCHxkMezz+HkHd
         CjZx9YktqQWt9JAgkm44cYocr5DxinF1KrfwlVScJ3BrU9QFuK8T65hnYMhuq7brAw3P
         aqdwWaPG4bUjc2EkFtn5+1juWdJk3LliBB07uP6W7Rc/rPuQcnh/WGB0JwtsBdFfq4Ks
         z1cpzN99+MbvWhV1vSbGhhWfPFWjEhBsG13c8ux9e2xynkqnROo3heibNtUuIY7sYPuo
         w2RbWbY7BYhn1Z63Ou4TqdEFcqPtZ9R1ui09WDvs7gEO6p92PojRTbrvVbUgyuqr+QrP
         EEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784751422; x=1785356222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctgAd9wg0GRoSGzcHXcHc1w0XtOYIWZCmYqQKxqHkHE=;
        b=OWmQndEEAow4w08rGoG6ycLV2f3VxStRm5u47nZ9cPbMVz4oIM82+zIN5DnB/Y22k2
         1dQG2cb7Q2Ot9RUTnWU0IvkzUzdvcsx98YhcHxla+IsNH/CUgfTsKZ0yKrhmDpZGYAtW
         +1UiDxDodwvPGLXXy/NfsNBYnku6jDNBPx2tMR5xaqFVl8nLV8rRTh93LHCwTI8dD1q5
         4bluopfCMtuqStUY3UKT73jB9SoDqzfbJgj6KYwCdZ6783/xspHfT8+ySpWSbRffKe+f
         GdVe1DlOL3zk74xGe0LqcJadITdhugBiz0IZlyAj173Txcf1OEw1wPQSiaBr/VwmAQeb
         wasg==
X-Forwarded-Encrypted: i=1; AHgh+RrRDSBDyusEVaeCd8D4UlQIW70SIB0n2hmxJAtoHMyhCns+j+KbOXWP90IEgtZxOkhzD+/0tD3QM2y8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZaeN9WS05XFZik4jghMY4IsMSltvOBXfqz7jVau2Pk5RZW0l
	oJL5CLHWmVnfBeMSvtLxwDHAM4xjSX6zmuyFHekAzU9boiiMx5UoUa9rvhXDce+GgogYC2NdSgZ
	Zm67A1q/zgW0N39eVdQhvoBdjZQgaVME=
X-Gm-Gg: AR+sD11SnJaiPRzabaKRN1nIFwRAsRCDfH3Ao5RDaVhKAEPJsYhlMHOrENybV7eeGaD
	ZUlq/QaplzECU5NZAQK33d0Mhn+Bc/2x5y3/YHe31PRUaVSnjWsVutSAazPxMDrcOKTizsX+lyR
	IxClixJmzgLO+aFdLxVZw+Y3gLN8DpQN9j7NRCcHfSUIKxyOSyP8SZu+sFAz4/3f6Nh0sfdE+UO
	/ZmQ73g/3KeFIyJpfUncxc1fDx65dJ9GknpFrhMTYJ2bh6jauR44ugFuAUcLp5hTbekT5moRiVr
	rY18NQbjrU6jgsUH5IwXw0DhigI45w==
X-Received: by 2002:a05:6102:5788:b0:6f0:6293:747d with SMTP id
 ada2fe7eead31-747536b1402mr6696333137.14.1784751422409; Wed, 22 Jul 2026
 13:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780640154.git.ldy3087146292@gmail.com>
In-Reply-To: <cover.1780640154.git.ldy3087146292@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 22 Jul 2026 22:16:51 +0200
X-Gm-Features: AUfX_mxT0ZHctWRApNg3PEgJzlysrWSxa24rucIWCILUw4qqoEr2Q6Ehc0Njyvo
Message-ID: <CAOi1vP_tQV-v9R3=-kdUj26s-0AutxaxaFOJkMLjeVbPuRQbXw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] libceph: reject zero bucket types and clean up
 type 0 uses
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, ceph-devel@vger.kernel.org, amarkuze@redhat.com, 
	slava@dubeyko.com, sage@newdream.net, Slava.Dubeyko@ibm.com, 
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	ldy3087146292@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:43=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Douya Le <ldy3087146292@gmail.com>
>
> This series fixes a CRUSH map decode issue in libceph and keeps the
> follow-up type-0-to-constant cleanup in a separate patch.
>
> Patch 1/2 rejects bucket type 0 during CRUSH map decode and defines the
> reserved device type in a separate enum.
>
> Patch 2/2 uses that type constant consistently in the CRUSH mapper
> paths that identify leaf devices.
>
> Douya Le (2):
>   libceph: reject zero bucket types in crush_decode
>   libceph: crush: use CRUSH_ITEM_TYPE_DEVICE for leaf device checks
>
>  include/linux/crush/crush.h | 6 +++++-
>  net/ceph/crush/mapper.c     | 8 ++++----
>  net/ceph/osdmap.c           | 2 ++
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> --
> 2.47.3
>

Hi Ren,

I have staged v1 of this fix (i.e. the version without the new
CRUSH_ITEM_TYPE_DEVICE constant, touching only net/ceph/osdmap.c).
While I don't mind the constant, there was some discussion about its
name, it being in a separate enum, etc which needs to be agreed upon on
the userpace side first.  The implementation of the CRUSH algorithm
(include/linux/crush/* and net/ceph/crush/*) is shared with userspace
and the userspace side is considered to be the reference, so the flow
for changes there is supposed to be userspace -> kernel.

In userspace currently there is no constant and "device" is also
referred to as "leaf" or "osd" in some places, so it's not clear if
CRUSH_ITEM_TYPE_DEVICE is going to stick.

    if (type =3D=3D 0) {
      // want leaf?
      children->push_back(id);
    }

        if (type =3D=3D 0) // osd
          break;

Thanks,

                Ilya
