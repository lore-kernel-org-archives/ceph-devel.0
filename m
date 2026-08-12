Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD438C412
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564653; cv=pass; b=ThsiGJ674FVCqOSvsmmc3YMUzdClrpxEwaD06tfqXX1ExVleEasGjk2bSiUnjmtsTVmy4k61riWPQ9tXYqn396JCE/5KCRYWZ7Jf3Fp7+Qik4cdSu74A5rpBna/mEI3gM4L4YmQL7Trj8E95YqBw7vgX8RulhUyfvuQbmvFyfsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564653; c=relaxed/simple;
	bh=InB0UYCM2KDM4g4PRBtwGR91Ve9yekZrRHjDpPJaqF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjplFJa6yhz8JeOjtnHVXdjKvceAT79M3U6QIf6yWaciQ1IZdGp69SXRqnApNKvQwXuwwxfpBcWv98yRjJxCoKOSLtvX+AQs3t9QABK8DRJAhFFk1RaX/ky5ZmOwpilVrvENgxDAGJQdrIofI/Px3zizC7hzxF10cYseYB7VGJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXP6a69T; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXP6a69T"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-977258a75d9so20905241.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 12:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564650; cv=none;
        d=google.com; s=arc-20260327;
        b=sxUVY+B+q0PEvBVhjnChIM7eCjaxxd9JFMv6apJiLnnz3BQaphQ/fuhE/Zu9r1YZt3
         YS+vaKjvV5gy88Kmca4uhhO6IPP/AAHgwGT4k+34BCnhvFNGnhRWdO7PGMXbgmeKbqKP
         ZFRmIqPX5JtLZGiUykamp0iSMjGsKsUT4COmLUODhxwZ1nl9qSdWjf/SlEvK7Da0KMUK
         uxeI7HrKaws/UWswG3kJ4/0o3jI8C3G0BAAIi8XcaZgIx/KciFt2Bl0FRHZaH6F9cHjQ
         4sykaZa95smxGUZQuUSXn9oPWLNUBEPfrVaYQyopq1iV1kMoIRRprKWQWP+2+MJTD4ni
         ubQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qd1nK7r6I3PGybOeP4cxvy0VcaUriRACVPreKIcrr7g=;
        fh=8B762EOmNvfpLPF4gYmUTrhSVCmcHIirAuOFMnNr0Cs=;
        b=c6ndhGiUUIQbvNvQoRnNVpA+8eAJu/5jsta9LkPYnKzCzHzsAoSnsNw7YGtI/r/M/2
         NkbhNv8Y5U9x/f5zAQbAoK/D8ypbFzIIRkgsbJSnp6gfgsDYqp9Z1FzSlv/btwJzsWvV
         +dDFYcPA5XRI7B8ABk11zB1qpCSdg9SrkbxizhWPuwh++CcPmbLgUkmF9rVPAQlMDKuP
         9O3w6U3bkcImc7vX6KOGvUSS/1rYthF3SePlQebdRZEBa0G05i2YJc+UpcMsQVVvbmAM
         eXKx+0lqHLr+oSnuKyPrFd4aQyuGWxM3Sq+SqwVXhePimbrNyc3oLRJOTO2YDPYdXB0p
         79SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564650; x=1787169450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qd1nK7r6I3PGybOeP4cxvy0VcaUriRACVPreKIcrr7g=;
        b=EXP6a69TtJDolOgiRrubUDGucwFHO/nu7qttvGCXhPYwLBs9vk4ssI0ByedQosfbGp
         UvROVEyFr9MxiRTTTz24EFVXAPQMqzAmNbkbBcsUpEQNjLa6bfcJaMLmnIIZPUA2qvz/
         0EpOKp5x6TJXkyekDATqpslFtbZYV0uJRVBV8xzoct6UfT68ZjtwGv4UXXcp6Mcw6s3n
         OL2pnTBgMlw0w/t2WCh3Irb1p8Q18ZsAx1ROXH6irVR+1CX0x5wbOxKG5EAw9AYlzlzP
         PJYbNd1TvxKLg6TV+Mw1OTCSWoMv9JUat5PBqPTSZepeB1GeO/E7XeG6QQFR+8ntBnto
         UD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564650; x=1787169450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qd1nK7r6I3PGybOeP4cxvy0VcaUriRACVPreKIcrr7g=;
        b=s58DsaVHp1xalQVkNJZGmcuKEY/zh+7uIqLZXNxhEA43pX+BY83DW56HLBFsbqvAjh
         7qvjVJeUpZEHUEM7q0VY8dhfMa6XTMIj4vC//noP68nkgjkCJZdcEh8dgMvmvb1I0yB7
         IMFdreET+WA24xzLRMDEwnLjq/qQlEx0qThFf/jQBuQu8c22/crllA7FZEy0dAPo3RL2
         lf03Naiuz6Hg9kyDqB80iW4t6DD/oYuBHYvSACZH/+hjUafaIAK9Haf90IvAX948xJoG
         w1x/WXPytmMqaD3mMcYvBr6K4uNW3ueYgxNJ7b8Zc6Na2sLrQatFCVFD+i4U9LdtMrXb
         8eyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rohn3kZPW66b4NXAccH42EuuMMMgzG2lT2hdleOg+bkUKjz9X8fJY4ySQGZN3cI6btJzK6Posrj5DtQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mX/3/MBF1nF7reFwzMDUowAd3iYjfLkO1ZPgzdv6alXpWqub
	HTGKrCdJcqiAK3M9oOieGSuSrYSvDenLCc6elZyDBsrm65J9VkwpmrPGNLyeVLZiuThTQRxrk4k
	KOi0c/VXTHBriF7JgNp67rzICwgq/FdE=
X-Gm-Gg: AR+sD10PByiGvfbU9v2+dA0EBICF7hoQdt68XikuwYF104dCgDy7JUk9rcwuzQRf72B
	31Jv5IL5xTSGCZhYSowk6Wh//CgsB9Ru8H4oEbhb1nh+UL33EkoQ+rN4XJaXc+kjcF1Wb31sM+z
	ZYh7ABHMP0hRS7EwySiqFjgzggPAwK3AHTXKNeNPo0z2E46nscoLigcTEEEjUQT29tN7cFGB5br
	KEtgZPZiC1p8bGzlUIwH3SsGG2+mHy5isFY/M00dnpGMKi+8fl5afTgk9Xs8ShOyOApqJyUyTuV
	DR3dV2Kc0iheRCdTvqZz7QGbsRqVHaKj5u0RIWVWHm280E//O+n25qOEH5a/D+UVRmJyYeF/UEC
	uEw==
X-Received: by 2002:a05:6102:2b89:b0:745:1c72:cf72 with SMTP id
 ada2fe7eead31-76db7e94346mr273467137.13.1786564650214; Wed, 12 Aug 2026
 12:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
 <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
 <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com>
 <CAOi1vP_oJC73d48w_qJaxtxrX-mVMYip3-rg-iYoHwHn6Tz-FQ@mail.gmail.com> <CAOJNxRK7F5vij-tw32+UjPztbzLX3zdhhD+Br9voD5wwQSANdQ@mail.gmail.com>
In-Reply-To: <CAOJNxRK7F5vij-tw32+UjPztbzLX3zdhhD+Br9voD5wwQSANdQ@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 12 Aug 2026 21:57:17 +0200
X-Gm-Features: AUfX_mz78KT2Pxu-FZVbg-W3PDMj5g_4TwUllzYisPa0Uv1biboX1e1ncUZkZx8
Message-ID: <CAOi1vP-xdpg8KFiW93bhwtP6+8f5DB961afu42bebii5SQ3cNQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 1:32=E2=80=AFPM Xiubo Li <xiubo.li@clyso.com> wrote=
:
>
> Hi Ilya,
>
> I'm not sure why I couldn't find the original email of this. I checked
> the changes on lore.kernel.org.
>
> The fix looks correct to me.
>
> On an idmapped mount, using &nop_mnt_idmap compares the caller's fsuid
> against the unmapped on-disk uid directly, which would wrongly deny
> the actual mapped owner and potentially allow an unrelated caller.
> Both functions already have the struct file, so switching to
> file_mnt_idmap(file) is the right thing to do.
>
> Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Applied.

Thanks,

                Ilya

>
> Thanks
> Xiubo Li
>
> On Sun, 9 Aug 2026 at 10:33, Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > On Sat, Aug 8, 2026 at 8:31=E2=80=AFAM Max Kellermann <max.kellermann@i=
onos.com> wrote:
> > >
> > > On Tue, Jul 28, 2026 at 1:31=E2=80=AFPM Ilya Dryomov <idryomov@gmail.=
com> wrote:
> > > > Was there any specific reason you used nop_mnt_idmap for these chec=
ks?
> > >
> > > No, I copied that check from another filesystem, probably ext2. I had
> > > no idea what this parameter means (and I have never used idmappings).
> > > I guess the amended parameter in this patch is correct.
> >
> > Hi Xiubo,
> >
> > You reviewed Max's "ceph: add owner/capability checks for
> > CEPH_IOC_SET_LAYOUT*" patch.  Would you be able to review this fixup as
> > well?
> >
> > Thanks,
> >
> >                 Ilya
