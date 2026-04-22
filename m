Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA13451DA
	for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872063; cv=pass; b=KHmzHxsAxUkVIxBUJJKCvYcJdc/sO7JUibOTB5jgipH4xBROascCXWq97AHmmDrTqFMqDowuARUKeO1a/K2NMZJQZWmLMJdGvVM7v6j8SyNVHDfFpz8Ou/xEMpdaw5jwCoYvpGou+zRkNht3r+lHo2ENLVOmqWWqXW5B+Ilanm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872063; c=relaxed/simple;
	bh=S/TnKoZdkb9HNlWBiqkMsyeGAdW7oEoOobtapOUR5NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UniQrNfj3P5RzWhOo40g65drIf9ZBvSezwnpMitZzq3xTUBuULGsq0xq4JpIA42fXwEWNvjZZ2iGbJja435s9DzHRBLgC1mSXqRDwR0FUhRsQb04mfgpj6xeflRyIdNn+rZifSLL8QxVDOL//mMGyI5eh0kJHwxWcdKE85TgqeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOB3XdnY; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOB3XdnY"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12713e56abdso3888550c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2026 08:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776872061; cv=none;
        d=google.com; s=arc-20240605;
        b=Vax9AIVi4jbLbJz8nrrdK6dXhFdGZm8wBu5A0NUoxMDH4g4Yq62BQfO1IrxnB7h1Gs
         RdGC4lEtWWNRQrz5XHlhEaoyoPEmy7lLgRFNBLfIE+qQnGcm9XT5Iw9ORtmifW09UKOC
         9TmfxK4raHKpLHQCo6uTFd92/gyr3TcDPSAIC7wJlkyhli6qZLJRZsR0T+5HmG0tAqze
         c4bi9IrKDE9Jb4gIr89nnkKZDyA+u4cYA/6WJ1Xc+tfyK9QXFfzcQZKB4loQsyDlOdRW
         bS5qH+/N9k+xLeSUfl1ptAEP8bWyNWLPTGz5UfMWGbFlnLp3lv9Lo8W7/9Zc36uBUkTj
         lo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0hv8VmWlW7hTbHZjg4sIUbWzKDBkQBwU2+883ho7Cg=;
        fh=epLnwjewX+ahN5w+zrA4VqMcZihS10wdu8hGFy5EbWA=;
        b=f/FeKhbcLevQ83b3OMW6NhGmmZX3zs7+88R9A1VWB41FxmCV3OjlUU7AAZAtN6SWoK
         D8UgEx94Kg71wU9RZZaFztIUnbtpDmlYGc1AoK7+JVKlJzjtD39+7mm2OFVa0hHuUE/Z
         KuBbm5rMkxaPASFVXhEwxc/ea8Uw1tWgVOCb8gOaHwiv0J9bbJno4PQ4AGXNc+ese4nK
         Sfby2htntOitsNjYAZa1NDm5Yq9GTOQc6sfogmnJwjhfIfLd+dPgipKbmq26OKvmf9uz
         HWmJp6HEv0OQGHtHZsT2TNj3qS+nXzkch7b0jAQfGA1smc5vC7fP3w4DgvgeuRUc2+HP
         FrOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776872061; x=1777476861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0hv8VmWlW7hTbHZjg4sIUbWzKDBkQBwU2+883ho7Cg=;
        b=GOB3XdnYx31mBC5qNguWIQAk0h8Di1U4sjkB/fU3o5LIr28dFIE5v74G0JBtTS8C4Q
         BJopacyy/vZzKImkUDb2PmpC2WJyXKT1ma1UCQZWuevwZ4XBr2VLHjWzeqCfVXN5z/IS
         rDVGwswLNLhmpxHnAbCaPr9o84mIqCZBUbkzHEODXNebtIJ7BOgZr+G9r4xIjUuttpD9
         wPaHZpUksPPouClNZyyRgMC2Xa23I9BS5XibqFHpGAh7QmIxuztU9XHOdcjPlM22y8t6
         EAKc4d7QlzG8WR1Th4bxBT6o5YkOOyOy4ZW4owEQh5l9PP4Ay6lSjwHJLaRfoDnalb77
         RVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776872061; x=1777476861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0hv8VmWlW7hTbHZjg4sIUbWzKDBkQBwU2+883ho7Cg=;
        b=bRONaAwt5RiUeSMJMk51g7wmx4D7qBV8Mxi/xi34Deux3hY/X92e8v61DCjb11bUEx
         vOjzdQz+EizDl0mCbgk/qN7JrU/INfdumbamCAaFn/6Kpq+c/os+MQZrea8zZVpX6ZVT
         vFOrucF6JiS8FURKIOPUdPNBft6OEox8EGxHU+gqEi+7JBh/QCcTmV098eknIwGbCz7z
         EloRiMQiY/m7sQOqpVbMFvezNE1fL2tp+eLOid1cDiwisIBXT3WeRreWj9ZMrZiYPFpW
         SsID2CN0iU5ueNQm5SkWMlsy6pWJevhMwk7IsEsxfTn8pRroDN0t+AIuRBRVCCHEAk1K
         g+lA==
X-Gm-Message-State: AOJu0YxAIECbmkTcC/ksUgp6vz2QpcpVjELeXmDqN9eI28XmrglLs0Xl
	ZYKCBNu/H/6a+3Pw/D4FkeGAvkFKJY1ojUdyT6FcT5BzKXflN9cPemCqS3gGEOr0EJj8+HjcVCS
	qVg1MgWFXj+8lC5+d7/7goKC9dcVWVI4=
X-Gm-Gg: AeBDiescBX3iJLTAEVx8VTymBMKtQK6VEZLt+8G9gurJCacJ29XSFMuASbWV/EPTzey
	dbDQR+g0NtQOp8j3IXTjc7/yeQpK4qEl4jAgnezb/XwuzfI4t4G8l5LXj6fiOcfI1m22nsPcDGf
	WfAdi+rHR98IdiQJB5WiO0Huhn4BtyFf6SWBh1KyFN3mzViqegncv8jbeSpRfeQ/wBxW0B9ZSCi
	hFUBu+bNlUPSRz+PW9Nntm6E+MBb/Cklfy9x5GyfiddMBS14OmsEQ0rjQZ4aU1OrR+kve0/WLXc
	ut1owdULwHZ2JtMG1Q==
X-Received: by 2002:a05:7022:fa2:b0:12c:11d4:61dd with SMTP id
 a92af1059eb24-12c73b39a41mr9850951c88.18.1776872060807; Wed, 22 Apr 2026
 08:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409191517.318015-2-slava@dubeyko.com>
In-Reply-To: <20260409191517.318015-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 22 Apr 2026 17:34:08 +0200
X-Gm-Features: AQROBzCBL6n6MOVuI1650s_ve_MMIwwV6uA_md14TRV4yKcjEc5J6RafImsad-s
Message-ID: <CAOi1vP_OFnzuJB438=L_MUS2K0m7j49en=U2K19ZrH-xYUzaLQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to WQ_UNBOUND
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, amarkuze@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 9:15=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The ceph-msgr workqueue was changed to use WQ_PERCPU in commit
> 27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users") as part
> of a tree-wide transition to make per-CPU workqueue binding explicit.
>
> However, ceph_con_workfn contains a while(true) loop that retries on
> -EAGAIN from socket reads and writes, making it capable of hogging a
> bound CPU for extended periods. This manifests at runtime as:

Hi Slava,

ceph_con_workfn() does have a loop, but it doesn't retry EAGAIN from
the socket.  Both msgr1 and msgr2 munge EAGAIN from the socket to 0 to
indicate the "socket is empty/full, need to wait" condition.  See
do_recvmsg() and do_sendmsg() for msgr2 and ceph_tcp_*() for msgr1.
For example:

    ret =3D sock_recvmsg(sock, &msg, msg.msg_flags);
    if (ret <=3D 0) {
            if (ret =3D=3D -EAGAIN)
                    ret =3D 0;
            return ret;
    }

Ignoring opening, closing and a couple of other special cases,
ceph_con_workfn() starts by trying to read.  When the read side of the
socket becomes empty, it proceeds to trying to write.  When the write
side of the socket becomes full, ceph_con_workfn() terminates.  It
doesn't even go back to trying to read, so I fail to see the potential
for what you have described.

>
>   workqueue: ceph_con_workfn hogged CPU for >10000us N times,
>   consider switching to WQ_UNBOUND
>
> Switch the workqueue to WQ_UNBOUND so the scheduler can freely place
> workers across CPUs, preventing starvation of other work items on the
> bound CPU. The loss of cache locality is acceptable for network I/O
> work.

This might be true, but I'm not sure this conclusion can be made
without at least some benchmarking.

Thanks,

                Ilya
