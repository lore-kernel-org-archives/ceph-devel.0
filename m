Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D77342523
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026140; cv=pass; b=bbQgqigXaBhg0gkjWG6829LFOyPAxzjG1wPRoV90EVFArqEKFxDvkk8OgLEdUt+nBo+6a4EE1M5K/iXGJLTHfTe2PZIDWRu7Pw7O5hbt3GVj3BeObBUszcC+tJRiUh/nugjMXL+CTuVG584TQacD3yKgQdaGyxyIbpC80stx/Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026140; c=relaxed/simple;
	bh=qwkdZtPwPaCl3X89xMpkQSbOGgQa5R8LkAKoZCqUTeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M817OuliNZYGD1q3FJ4IVu4gOfYUN21Zu1ZkV/JMgxOvLosMAJsO9ibKuztcN9FsGPUDHVEhVg4WEaOXOMl58vNkt59IMkflTIXBt+0Jz/49W7NI0nEkciUex/sxr4qv/Vk+VTOKbIeP4KUAxBUAwP2oaAZHz+cQql82WYoKwJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF9Kufm9; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF9Kufm9"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c565476d7so3133840c88.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 03:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777026138; cv=none;
        d=google.com; s=arc-20240605;
        b=jpyc6I9XuYGhoNcRW/wpOsgJUEComDl2roOlpfIlAsi+thj5ytBABxW14O7f94svEI
         5tPf6b5yOTEo03wzGgMuL804/ttKYBvK6OCW95LcC44AIKPcUcQAhPHqrs8GMC9wRW+w
         gM/VpQWQ0cq6XmC1mOmWx/yDhxdGpjNd/bBA7t4+UvAVSFUsokx/OBR0gN4hGS0HRsa1
         B5jnS00bSKa6VAmUzXeGbuTnKW0Hz+bCmUWmijzuKTpVVjzOEV09MAFHZ1H3Wrerrt0P
         N1o5THnSlmSzSoHcht6tPupllMWOV1UAvEGJnw4w57Lw4Qe94yw5huSsRlvHzkJnIWOv
         XkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eheeWEUfzmB0M3rbJTls4P9xIKSst+zUcfI2+fpkm+A=;
        fh=Gj7/q5pQM8PSakwveabuaj8rkedXSNliwxjvUWb8Viw=;
        b=Nw/nRsjDGUty3XygHbcij5HiZ/2u+Nh2IgICs/b2AW5qw2oqOTJQXjN4eoSMslwP8I
         JiSPMNsjKMXxS6v3uNUjzoip/NRHJMIoqteHFHiOxIT2UzXGnY2YsQugDx21bPu3pkjd
         Xafk1MZQ/zrGGmmF8edinQ/6yVEDDB/78zcP4MHUPulpDrNkHb863pvTlNGqm0wAH8NL
         IgTQIrpoXEWppw6pSmz3PT6j2wU4gz6c9fHqpRBFf6uYQNvAt7uoX+NQPHzqIEbZHQza
         dvNc5IOiu1iH5xkFknDCQ1Qh6PJsU7rcTnOBfE/xysVyhpGWBkY7KzXMADMdGU+eiy4Y
         pFlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777026138; x=1777630938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eheeWEUfzmB0M3rbJTls4P9xIKSst+zUcfI2+fpkm+A=;
        b=dF9Kufm9P6JLHF1Ah/BuRdPnuFsOEcb53/f02YtPm1rNiCCnG65Yuz5h2GRIfB3f4c
         qO8cvRSgrjkigggy00HXibJ69hh5dsfdPSHqQxaHLanPDnlTjHE3ZxD2xbe65F3cDSo8
         13LmfRPxmhY4hBhlpZUsbIFBFj74l6debFqAr9OhPSbFn22TiRHBenTj3AXIpGpRfOgV
         Vr/1u8BofQ+rrlt8rTgW5YHfqieKtlNb3EQyF0FfbfGyMtDImOMMVtXHDAzXVVa+/FZm
         04phSCXmy9seUIYMy8a9lq2OlzkL34fYR5teVO8c/0nEGb8/rowUOIyRh4jlGrQSVQ2t
         D29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777026138; x=1777630938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eheeWEUfzmB0M3rbJTls4P9xIKSst+zUcfI2+fpkm+A=;
        b=DNiP5rpAXBwltyGJixptWZI8zEZS8BOsFKOiDt/rWKnCgWf0IwK/IwdctplhIO3S7J
         OVhpNfTF2DhvTliUn0aFx4HZfj4SNW1tiBIBrddx/3IHpiPILRdOXvcqtONojn+eiXSW
         ykCDtHHqx/c6GQGYwt6v8NVCB6XGYZryq0qsK97hCj6Wc4cu7aSNF4UKNd+QXgSjBkaE
         k5RpDWhobfS37YnMpirODMgjiKiG6glGEXfoiujuiuS6g6rKoo433tBj1jIfvI1zcdOm
         WeTSyFdI0doxf8xpLXGcl2hmr0iCajDCfjPkJnskKfudk3Sb0ZVBrNR1c6Km9KOEty2p
         w2tw==
X-Forwarded-Encrypted: i=1; AFNElJ+T/i9S5W6AbKUDiLzrH4m+KYXOmT1TD2GBHUsMnWY0kaBmEZWUCpwtmSXZ8c6lPbVuD28JkF9OCh1D@vger.kernel.org
X-Gm-Message-State: AOJu0YwitjF7NXlQb7a6JF+fsf/A8g3W4cIisMSBBWvIETaMLjJ8Zfwv
	gDClKXSpBE4GKcgHUm6teXkoxEY8LabVT6xJAxjbGQMr/XkBJ05KSKeDu5ZNQN3h3FO/uH/02Yj
	XGZPYaTJOMWRUw4xj7kVP5OCnhVN3nkQ=
X-Gm-Gg: AeBDieuGQS8P5CHA9TTlq/uQ2ED1dFOTiMok0Ut1tCCQbZdpl/VIoaa4UfmJmn0CHbp
	zyj20u0D/Q21o5PETmULkUaus3dffYyWuniUYKW7WR4DW4uekxJlyj5LtLaW/gItFvGbTgUnC1Y
	y+asByZKeOW2Jq+7ULcVvYdN33lub2y0awxJQlpIcN+xwnHcai8j8QGIOSuzPIzI7foE1WfnFkD
	uivpz+umQeGNhmitISfphzXPkzWV9xHvEZro2l+UXcoq5X2iGzt7K68Ttigczd/82r6wNUqJwgr
	IhLOtgl/B4hN7GhIWA==
X-Received: by 2002:a05:7022:513:b0:12a:b3c4:c3b6 with SMTP id
 a92af1059eb24-12c73f998b1mr16786993c88.21.1777026138293; Fri, 24 Apr 2026
 03:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409191517.318015-2-slava@dubeyko.com> <CAOi1vP_OFnzuJB438=L_MUS2K0m7j49en=U2K19ZrH-xYUzaLQ@mail.gmail.com>
 <1a5b5d23dc54c9099643795bfad9f14705505fed.camel@ibm.com>
In-Reply-To: <1a5b5d23dc54c9099643795bfad9f14705505fed.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 24 Apr 2026 12:22:04 +0200
X-Gm-Features: AQROBzBqIrAEqAV7UyZiBn9NAaxN5qQFbZC7UoDQrtfspODu3u6onvyUqBQd-G0
Message-ID: <CAOi1vP95f6x5LX0TmsKxG6k57mCq3HdGBQRL5UJR7sprjHLq-Q@mail.gmail.com>
Subject: Re: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to WQ_UNBOUND
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 7:59=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2026-04-22 at 17:34 +0200, Ilya Dryomov wrote:
> > On Thu, Apr 9, 2026 at 9:15=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyk=
o.com> wrote:
> > >
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >
> > > The ceph-msgr workqueue was changed to use WQ_PERCPU in commit
> > > 27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users") as par=
t
> > > of a tree-wide transition to make per-CPU workqueue binding explicit.
> > >
> > > However, ceph_con_workfn contains a while(true) loop that retries on
> > > -EAGAIN from socket reads and writes, making it capable of hogging a
> > > bound CPU for extended periods. This manifests at runtime as:
> >
> > Hi Slava,
> >
> > ceph_con_workfn() does have a loop, but it doesn't retry EAGAIN from
> > the socket.  Both msgr1 and msgr2 munge EAGAIN from the socket to 0 to
> > indicate the "socket is empty/full, need to wait" condition.  See
> > do_recvmsg() and do_sendmsg() for msgr2 and ceph_tcp_*() for msgr1.
> > For example:
> >
> >     ret =3D sock_recvmsg(sock, &msg, msg.msg_flags);
> >     if (ret <=3D 0) {
> >             if (ret =3D=3D -EAGAIN)
> >                     ret =3D 0;
> >             return ret;
> >     }
> >
> > Ignoring opening, closing and a couple of other special cases,
> > ceph_con_workfn() starts by trying to read.  When the read side of the
> > socket becomes empty, it proceeds to trying to write.  When the write
> > side of the socket becomes full, ceph_con_workfn() terminates.  It
> > doesn't even go back to trying to read, so I fail to see the potential
> > for what you have described.
> >
> > >
> > >   workqueue: ceph_con_workfn hogged CPU for >10000us N times,
> > >   consider switching to WQ_UNBOUND
> > >
> > > Switch the workqueue to WQ_UNBOUND so the scheduler can freely place
> > > workers across CPUs, preventing starvation of other work items on the
> > > bound CPU. The loss of cache locality is acceptable for network I/O
> > > work.
> >
> > This might be true, but I'm not sure this conclusion can be made
> > without at least some benchmarking.
>
> My system log is full of likewise messages "workqueue: ceph_con_workfn ho=
gged
> CPU for >10000us N times, consider switching to WQ_UNBOUND" when I am tes=
ting
> the CephFS kernel client by means of xfstests. Which particular benchmark=
ing
> would you like to see?

Hi Slava,

What kind of a system is it?  If it's a small VM, the backing Ceph
cluster is a vstart-style deployment co-located on the same node and
the node itself isn't beefy, the performance profile may be very
different from real world setups.

The first step would be determining the source of the hogging.  One
thing to keep in mind is that OSD and MDS request callbacks are executed
in-line (i.e. from ceph-msgr worker threads).  If there is evidence of
significant lock contention or any other activity that can potentially
hog the CPU inside of e.g. MDS client's handle_reply() that would be
the thing to look into and fix, not the messenger.

Thanks,

                Ilya
