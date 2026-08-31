Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBD3ADBA2
	for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160962; cv=pass; b=c1ZTb8OrL5xaSYQvQ09p8fVKVdYRmaTRnVxcPB8RvXNZ7vVgmHLK4+MxZfgNbe8jm59WJd+pW2E1B6Rv9cOuEYzRvv8dxWWI5Vhw6DVlS2rtrQRGecBAyIRfDGgPGHRUjyEJ0QSSQFK+E+JMAMbL2v70EGo/c3yQobLt+CXh454=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160962; c=relaxed/simple;
	bh=eR7Ar5hzbRB02j4/+nLnQvdvDXrSRzVYcDag94nm+Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJ+J0lIh9Sa2uhgordyQQ5UIeSwF7lWelR6QS9ujRHaRz+JBaiL01ROMfsDDsu44rOtBrFcK0TwtEr7Ci0eRZfP4Ob1TCaCpII4XelAivZu+n2HZ7LEBgiQQI72dfPc7+KyN7Ux8W6T7x1aMoL76qVvKEGwfwnl+RkN+FxJ1eLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=mgeXdJXq; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="mgeXdJXq"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c20ce3c118aso626427866b.0
        for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2026 00:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788160958; cv=none;
        d=google.com; s=arc-20260327;
        b=giyq8YmKbmS+M9tCUQwsXp0UxfV9z9Q3RZhmfENcFTt3WitQHOJnTz0gL/uK7++yDs
         fJoN6ojG1YhFVvj03jD+ePm+vujlyyw/86frfru6SiQNNzwyBxUSypYs6VHRLbZSu8x5
         KrPSEkWIGE1rdPXPf3jbL/GtlYeGGo0/iesKI4KZgi7Vb87jwH0PJTLtqDFk85IU6sWB
         sdWSw8rgzM/yKfsLqrSVd+kXMSrFBvsE0GzmBILFNNPpLQK/8CtQc06eVJs08lhVPIHj
         veKJcnMoGpS9qZeGUc//TBnlEfsScYml0AjHyuc3T5IHDi9wG1oeG9RUXfKKDdB6fNO8
         dxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PzTSfpqlwmbxqkM9lhhcvAoRE+Fd2+/qhN1A6SnUrnU=;
        fh=ms2HSwhC8rJ/m7n/ET3ch0sZck9B/fLCKAXcyX0nATQ=;
        b=pHxSozky8qcSZT3uSbQfYTMf0LVkrWS9al4Gr91/2m6pbYSmMRv7zzHRakpfgO8xkF
         j30Ef9lBw1pbrai2GfszTV3VijnPU3U1aNwJrBTHvOzEXoCByy+mFX8cBO787prH060E
         oZnxFPPiP8H8ZpCv9oLFBENocwPqET7LicNFiHXq1Fo6qrwE8aw00VM6vHf6Rygyfoax
         ZCYGuMNer3y7tF4yiNn1usn5hk386944GHP3cqw7x/NGZTovc2Y6TWbrZiK0lOq2GyvO
         a84EG3xppTPOVa7IpZ7qDLp2uYAZwTDTlEBTARdGS04QSItPtKYZ5+vxWwiZJ/GUA0Bk
         jewA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788160958; x=1788765758; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzTSfpqlwmbxqkM9lhhcvAoRE+Fd2+/qhN1A6SnUrnU=;
        b=mgeXdJXqhvdzYYSjtrSnsYivYf/qolDP+rHR5CbGq8Joik4Cil2J/hW/0cu4EXqOUW
         PTab44Q/e3AtAvQXpol0fcC+ltYnfDItRYjpZyKvjM1/myo7cLp6sHILwor8AV8XVi5a
         5FUImqK6I+UBs5QLrmCx7S1mBZ7rXDeiQcrDMMRmG9JMWLgbGO6mAvcynVQfCuaw52o1
         QBt2CgAvezMwHXPhnuiGEpHlHDNsWS8A8F1J6JVCHmRWJZvHEncOlzc3PwViCFpnolo9
         5ber2Sqhjfy8Epse2jzseuEzahYvu1r3q8FgpnyosmOlY2NpcgCc/pxVY3z4xbeGDC6x
         ulpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788160958; x=1788765758;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PzTSfpqlwmbxqkM9lhhcvAoRE+Fd2+/qhN1A6SnUrnU=;
        b=eJlzqmW9032N7jvMpBaJTTx0pBtzFRCOSyVXuam+u4Q7BjS2KZDnFiTd5uwGNXCKpd
         8hqySgolFdmW+BixZHB9PsM/Ckzqxha/8vsjsdE4+JMNWYgExe4Gp0lXdMyJSDJc06bD
         MW9Th1v9tbldIIio8o9WV7gW50Ey+ADgT+XIZs9O8/F6XI1qtHuFyhbuheED1Nm5bqW9
         yKWtFR6IOEBX5E31YzhbKKJ+VIBXZdY/D1v6D6o7rPffM1dfjhjSRIyiatS50Sh497ZN
         iMto6kaZzKdeYhX9Qtybi9JbfTbQVn5KcNJufraj4qWGAN0pKg70Y/jiLvNDOzRuzZn/
         XYLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpc1otpW2HXP3OHlHvzaNh0MCLJk+9UNYRPgdv/NLQ01CAsSzPVfOeHwVHApY4uuvL1/JEETHD+o6np@vger.kernel.org
X-Gm-Message-State: AFuF++mWZkByqWG0qmMXIij69jOPi2WWHmAv1fzNjTYFI6iTsQnxdJh6
	7JVAr1008T+egQxEq+opxT/IBNsLyS2SQYEs7TJi/Ua35DzMPfizVefTp3TZT41Qj5pEPfOWo5E
	CH22rIjr674hVkJSqfamvDNVZsDO7pEQ3ZahVPxPFzg==
X-Gm-Gg: AR+sD13kCwRTLFY/UfjQQnJBSmdhbi+AWy7s4sKlEIJWQGeM85cxPab4qovTuBdVcaa
	O2R1etgVtJbHc+dSGHdNw/+QVY4UiS2tqLpdplN99ruU9sRRT6BQDhtVPTJ1ROD4N0TY3IAkbyn
	9fJvWAJ4lcYw5I7vFNvzveUFGi4etBZs5S4u2kSYHtFhTl8k9S1S0M/0tmLSpudyHS8orpWwkqp
	aSamK0t42mPlcQTg3dbdg4xLKYFLzIzzu1Wn/CsYsRitbq6U+tyT5qM7k6DQqVBhX92lRIvvzSD
	AP/oL0rl8yy5VQK+3Jv/w3Dgr/q+MgpwPfmfHmG2R5q55A==
X-Received: by 2002:a17:907:c499:b0:c25:32b0:e56d with SMTP id
 a640c23a62f3a-c2596859df5mr342549166b.7.1788160958525; Mon, 31 Aug 2026
 00:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827151621.2758276-1-amarkuze@redhat.com>
In-Reply-To: <20260827151621.2758276-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 31 Aug 2026 00:22:25 -0700
X-Gm-Features: AcwNN1XqmIyq_xmYnB4MNo9LpZ4LoEEVwEA2rI_PZl3k-39auBPXFGRh_3Gsvyw
Message-ID: <CAOJNxRJ3Q7nM27k7pCnWN9Ucb9DW4+d6pLoi5evzOxL=uED67Q@mail.gmail.com>
Subject: Re: [PATCH] ceph: apply nearfull_sync on remount
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

The fix looks correct to me.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

On Thu, 27 Aug 2026 at 08:16, Alex Markuze <amarkuze@redhat.com> wrote:
>
> ceph_parse_mount_param() stores nearfull_sync / nonearfull_sync on the
> temporary fs_context options, but ceph_reconfigure_fc() never copied
> CEPH_MOUNT_OPT_NEARFULL_SYNC onto the live mount. Remount therefore
> succeeded while writes and /proc/mounts kept the original-mount flag.
>
> Apply the flag the same way as ASYNC_DIROPS and SPARSEREAD so remount
> can enable or disable NEARFULL IOCB_DSYNC promotion.
>
> Fixes: c7a12c20bfba ("ceph: make nearfull sync writes opt-in")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 6c6e9a1100db..d8ae49495c39 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1423,6 +1423,11 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
>         else
>                 ceph_clear_mount_opt(fsc, SPARSEREAD);
>
> +       if (fsopt->flags & CEPH_MOUNT_OPT_NEARFULL_SYNC)
> +               ceph_set_mount_opt(fsc, NEARFULL_SYNC);
> +       else
> +               ceph_clear_mount_opt(fsc, NEARFULL_SYNC);
> +
>         if (strcmp_null(fsc->mount_options->mon_addr, fsopt->mon_addr)) {
>                 kfree(fsc->mount_options->mon_addr);
>                 fsc->mount_options->mon_addr = fsopt->mon_addr;
> --
> 2.34.1
>
