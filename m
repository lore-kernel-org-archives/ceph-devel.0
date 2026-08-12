Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651C43552B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534341; cv=pass; b=YgMDZHfPZY8KpYFjI39E61e7mbXXKIyiU0rCE7e0Sm3Zw1vAjNHHNiU3mIV/JOJqk4r9sxsdfYSpCvbFdwWBsOrXtOLIM7qQwv5J765dOHUxm/n1zl0xwVEh3wTCUpgPdoQ3JVPiYs/DA8hRKbHt8hn/qf3OSlAqNwxh9BNlH+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534341; c=relaxed/simple;
	bh=i3fasR6deTxIk0Zf3pmhJBq+WV2nwYJeBvt7+ya3+JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOQal3Wou6xk0+hfZHJ+D/sl1/gq7dYV2X81KZ8BuAtS/i4JTuvTDvWgbW53vks8eredMpd/3mzDmlhE4lS2knUpoi8Zrz33Vo1SR8X6Ssd/ugSp9rgG0dz8weiz2cI5sRT5ndRnZuYZme2MvMcqQdjb3tMNVIKNqpHG8XeI/yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=YLJS4dul; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="YLJS4dul"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so80778666b.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 04:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786534336; cv=none;
        d=google.com; s=arc-20260327;
        b=M41nvwn0L/8U6xae899xJq2qZ626ABUpXNdOlDs6Y8byr+Q7izwou5BGgzetTtzPOA
         avCzZHYs8Q22xs6h+UpYCVLhj1OnaojS/r87tgz4RenXQiQKX1OOckrEMiN1axEtUs+B
         pZQXt5R7HpItCIHk+MGH8Enp7POVwVksximh0vdg15++uV00MrHevF/z0qoVfG2VZd96
         or4suBMpMQraaxu2kL6JkJQtouyMKimdDx4zCG6RymzGZVllyi7bk8GfnKq1PGzTJT9g
         cq9tsIaD7gN9MuAsCA8scMxdL6wc/cYScfr/v8uXwpV/J+9WrlkqsiSlD0EA4oWEbk6t
         6fCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVXAUVrsaloJXqEm9a0tpYBwBB/k0h2yk4WhWvUDEBU=;
        fh=n1XbS4FDNyRE+DQF5mW9LZE1FLmX0m1oLTii8Lyei4I=;
        b=lWAc47E0KxZ50XCLWdo5UzebMCpChMQBjCO2z0hYix34i9z8O9s7N/kotq9xAnaVW5
         Ie7qLsHEk0IHIyXqZqjlEHegON6Trcqp3ka/xhikHmDdC5GudPMy+4t81vWjGRes6gkN
         nrpzvPMYezQOkjIMrEKVdUh3EsWVMiWYB7jMdJw+yB9CGb8Y7nlrBiOP28y/3xW2dRba
         G25J9kavzIiL3DmTxZekp9/ntAxDXKPt1dS0Dv9/J4b+oNiRsFdgLpsklwb9Wfb/eALp
         YPOBZlUsYL+I00A7fyvC8leQpgMuZlF4rmUjJeuDWvS5M0XL/wloZfgTpe+K5SXICokF
         zQHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786534336; x=1787139136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BVXAUVrsaloJXqEm9a0tpYBwBB/k0h2yk4WhWvUDEBU=;
        b=YLJS4dulordBSF0gf9/fNwTd3c4K2YmqfqWXCkXc4FD5+NEkWffnfVg+iphTngBV/3
         AqHQmG0g5gPLQ5ZPtqazBa3ipPCuGUkwqUD7fiqSAwG4aVeQrq5Y9hABF2W10d2MsH3a
         Q7VnmaV2WkjUwLQilJ9PomsBYWgY8QBcrxMbB1xmwNMC9SuTaCXGXftwvsPmsd0M5jym
         C1tfJFwxKh0is3ic6LWvVBEIYYYrCrbP6XuOL2llO9znREytd1MX7xugqDKhO45fu0rD
         j9xVVeUJxQqmNMghZUmDq6nKf/CWFAe+D2qT08H9xgUTO/xRi1PKTTmCU7Z9SIUWe3Su
         VofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534336; x=1787139136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BVXAUVrsaloJXqEm9a0tpYBwBB/k0h2yk4WhWvUDEBU=;
        b=YhW1EPYdOTSgYKuEWG8Pt3U7Qm3FxLYeV7OtXhuIoi4Xkg0MEKvsDR+Za8tuJz+SXr
         BajWYX3pmFqyap2j86dvJfyzspaj8O3ZrEQhZwwqCwvTyrcxiHimBA+I0SmUi9fOaE1p
         uOgSxrtDn7tiLzstQ05Y98Atp1t6Jai1a/Tu2cEPIDIdD+g64KkE26FDFUq0lDlaF/i0
         zyomZ8uyyZk2g4+NOwcRpe/d09dE7woIH1CU4S2HV47Ybn+7PyEPmnemOB+RgNAuRc+F
         VU2po2gh5i+hBuTPNFBYbtiPggkLRxsMAbKVoN4RzEgXkO9FpV07sHdSFgFN24J7Ps0z
         I9iw==
X-Forwarded-Encrypted: i=1; AHgh+RrQnCLmhTpLISN9r4TXJrv5Xuhjh6Ooxu10173SP5F72lt4yk0UwOj1V4gXUQMm6g8RmIX9MmqXUZ8b@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+DQ1uX0T/4YuIywZH3PvDM1Js0/Ic4tNhWJPHB6WZYde+bSw
	HUdHeYBJCZSK8OhITA1lfg3REizLcN8LsUIpOT3H2YHIpXnbXTeVXTHm/G/A1yHqEyEq6BlxT0P
	5+wneu0VnPOVVBvJ4bYZxyqgxr7exS3DvPpVKlBmT6A==
X-Gm-Gg: AR+sD11vOtZi3gwifJgpjgOSACwOAnUoaV7AaUyerjPaakEoWXWjHLmKNvlU1pWVmtE
	D8U6tVEAL3baAgBJ42jkpEMha3ZNbWuDLrKKpnlBw2zxzzEQOwakT3YDacTP2J9n3h5EjB/CO0K
	ezsRjS70ES7rV571g4FpNRkk9utMtDWt2MYIql3P6Av9x5MzJhTjkOXbrRPrpJxJvI9+HmGHiNn
	u5ZFzLRVZdPksFg13l8khAuHLHeOX5AjTr/UTGLqmaBBkvFdannALOWuXifK376ePHn/9zN5/fY
	6XBYgHjkiTRhUVUxYJoJuN6oDmVL7PYyCzw+MSj3ecZ3zA==
X-Received: by 2002:a17:907:1b21:b0:c15:deea:a178 with SMTP id
 a640c23a62f3a-c20f300fd34mr193811466b.25.1786534336286; Wed, 12 Aug 2026
 04:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
 <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
 <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com> <CAOi1vP_oJC73d48w_qJaxtxrX-mVMYip3-rg-iYoHwHn6Tz-FQ@mail.gmail.com>
In-Reply-To: <CAOi1vP_oJC73d48w_qJaxtxrX-mVMYip3-rg-iYoHwHn6Tz-FQ@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 12 Aug 2026 19:32:04 +0800
X-Gm-Features: AUfX_mxsl7ht9RvBRitjRFRj3rwaJuBRtFsXu0-en7gJ-F1HP6iU4Xprt3t2AE4
Message-ID: <CAOJNxRK7F5vij-tw32+UjPztbzLX3zdhhD+Br9voD5wwQSANdQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

I'm not sure why I couldn't find the original email of this. I checked
the changes on lore.kernel.org.

The fix looks correct to me.

On an idmapped mount, using &nop_mnt_idmap compares the caller's fsuid
against the unmapped on-disk uid directly, which would wrongly deny
the actual mapped owner and potentially allow an unrelated caller.
Both functions already have the struct file, so switching to
file_mnt_idmap(file) is the right thing to do.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
Xiubo Li

On Sun, 9 Aug 2026 at 10:33, Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Sat, Aug 8, 2026 at 8:31=E2=80=AFAM Max Kellermann <max.kellermann@ion=
os.com> wrote:
> >
> > On Tue, Jul 28, 2026 at 1:31=E2=80=AFPM Ilya Dryomov <idryomov@gmail.co=
m> wrote:
> > > Was there any specific reason you used nop_mnt_idmap for these checks=
?
> >
> > No, I copied that check from another filesystem, probably ext2. I had
> > no idea what this parameter means (and I have never used idmappings).
> > I guess the amended parameter in this patch is correct.
>
> Hi Xiubo,
>
> You reviewed Max's "ceph: add owner/capability checks for
> CEPH_IOC_SET_LAYOUT*" patch.  Would you be able to review this fixup as
> well?
>
> Thanks,
>
>                 Ilya
