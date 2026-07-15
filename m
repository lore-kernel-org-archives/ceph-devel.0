Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242F219E8
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084560; cv=pass; b=tJre7Kv6zlgDf1rD/MDDTAlu9asPcnVEPT97Ps5MT84iLqrqsMXfGYuhv1XxEiUq4Dhbd9AmgfJL4laU/BF8s9lQRurfZsfWfu8j+dTie2veFTGsMeALzbG8H+x/gX80X6tmpnoBHBUYYvK7VK+Tx5uFd4Kbs4HjiFfMLmwKoRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084560; c=relaxed/simple;
	bh=dCWzUOpop0LC36kE2PhRRwYnFOIvFAvc5uCJpBJM7Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+sAaDttgLVeId55dOQ0Y6D7WZnZkG1QBa1cuwWll5ks0iioQRRuESgE5blOBmntO/k/X/eyn3ij3YppUVTxKH8aYNsjIijKaDmOEPzq5Hk8TNW9xzsiuOWgnbmf4on+4eUl/OmRLKZbmqRpdRI5udYpVYNMcKVbzZOVS72WZmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=DkgLlbne; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="DkgLlbne"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69c7697d523so2103352a12.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 20:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784084556; cv=none;
        d=google.com; s=arc-20260327;
        b=neUdEJCtAMZTV0f+Yx4bkHJxpkR6ObRozCqTi1nBtWj67v4DYYBcJ10CFonZHH0kcA
         aqjMEULi9tQFfFkgtTAC3qKm0yAR4pK2BaWYy1NjzOwdS7vofbqf18yHM9OA4fJwvR3O
         OCz1NGNDJOFs5uKiw3iWrFkMr5NU1WQQeVVrvRKM7RCBGfbb5iCcihUxydX/P+s6y+QT
         WWCQfxUZmiqt2xtIyEQHje5rWZpdDcq2wdH4D6HCCfh1PMyjY6Sjvr8AaH/anBPC2saF
         Z3jtQVxZwydYza2m1pdkzDMnccX/mMkafyubO7+UMSo4wS+Fk2TUVuXL/zT8U4buJH4K
         dDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8i/9botd8bAVoeMjh7t0FloX9CGPNa3V0bjXRf/QVfA=;
        fh=nqawPa+Mx4+45GU7xrYnDMIAepGVzVo/+EBYB+CfE4Q=;
        b=ItHQnlKAwnTtXFUghEL3ep5A2tAqMQkG7sPaCWXGtfd1qCiZLzrZmF7SD6JfAktxvl
         WLfZrpX7uvRiPOlwpNQx508qiFq+Vyq9C2TbBO774ByhjUuF5a9PqY5aKxyxkEd8Yggc
         E1w3Zw5gQNJmCCQqNyOhLTFmVsdZ5j5uBqZ4AWbQ+BqsJxDqBoe5sH971lDm7fZw7MJW
         9AZ2NM4lW6z6wv4F8xdCIH837lSlVaJmS2TgsX5en9v1A/LXLASGrgOBqB8BNp5WreCM
         8jZPo2mBUbtSqKTPaxUOYbxpVSm0ZV35GsS8DtmKj/CG/8Ut4q5hpYb4qyhCmgeBOYZO
         ERfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784084556; x=1784689356; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8i/9botd8bAVoeMjh7t0FloX9CGPNa3V0bjXRf/QVfA=;
        b=DkgLlbneRcsh2m9WTOydE+xssGh6iq1Mp+g1Z9vwK2d1I5oJtAvBoY2iw2yyWsjOKA
         JhPMN9jF5eRg7msKUZiO6N2R5pGQIqyzzr6/7Ee2xVHD/nhONPd1nH7GcJL5YORrqfVs
         7k+HLUPzZAsVrfv86qd7zkZwai7ObU+YjAHE1QHyfSEtV27Gw9XwdtR0PJjDTS10qPuB
         xVG5UjkjM4GSQoiXOP3TvrCRrt2fS8yqH11oICb/vxLVUX2uGCXeSrSj6hMh6MP5lYvx
         fhAml7jNLn2Hp6IZootXLx3LPAWKDW9tGHuZ/D5SqM6Syk5jaaIdR+Sv/OvACzP//x6S
         CnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784084556; x=1784689356;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8i/9botd8bAVoeMjh7t0FloX9CGPNa3V0bjXRf/QVfA=;
        b=P9x5P1sRZsr+NR04UWOFGcyRYO1Fuf+bjFaEOSLxoYByN+5E6bS5NQOjIdxlj3RqYt
         JYPherVum1az7gt63Cfmc8hGbha0dBJVEWPUkeH3sBBbjW5r8BmwRE5w60Uk3Fs8ErOs
         V7JbR1ZsdurYKnYlkSo1gYGhcCpugP++c0lKqzEndpcp0VvPszvj2JANAzzsmP9/G3hf
         X7uKenwPiNpqqRa8NVqiTrWNyGDh4aYyb/B0yACyPcg9QGroNSOSP5T0vjn5hpAi4dwd
         4K+GheVGMtrRjj1513PDxTgFo8xeTpMQnQqZTtrHUpIRXM2ycsmtpzxQAaej9wZr/e4R
         EcDA==
X-Forwarded-Encrypted: i=1; AHgh+RpAupb7pVXGwkUIelhpnwMkKGygca1IBKdPe3tRh21lWRPgVVLc0nUGbxh9L7YHQOQNVFgAPUphVogt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaf0ZYwkntA4ibNeKuusNyCk/CpLXGcCNcIy2mYjeov0zlJBlc
	k4/5OkMQ7Tq21+EJiIhrD+PPvqpMbY1t0IbJsr7Xr3/VMQvDccxbMyhzzCXsJobjW/qdGsSfFUo
	6NwC6DJ6Ge00F62aHGMwPre6cyC7OqL+EFwZ3tBTk0hDU2USa/hLq4knaBA==
X-Gm-Gg: AfdE7clqiLpbX+ujV/pSsM9jsG7ewE65dRW1bZxfeN+FNW6K+v1wdOjQqaJldnjnLwR
	C1H8K3urQsQ2caJuAM4xofTe016zrKvm3JAMW9bKhpi25jwSkwfNiOBByxMG1O8bVLANGj3B+UB
	CBya96odsh/w40YCugPIrAa+yDGhCHqrulPjVkEahs+xE2E8T5Izg83Q50lSlb7Akxk5iT41QSe
	sGng9xcKO50ok7FAXdqwz2p/uXJV5epNwVnbUsk1mivw5YrmkdidwJdpGMujYtLgiL8dg==
X-Received: by 2002:a17:907:c00a:b0:c16:2dc0:e1ed with SMTP id
 a640c23a62f3a-c162dc14308mr787801466b.4.1784084555975; Tue, 14 Jul 2026
 20:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
 <20260713-ceph-mdsc-mutex-optimization-v1-4-9ae5ac135c34@clyso.com> <132f81feebfc532ac55823a1238a10c3d62f5e5e.camel@dubeyko.com>
In-Reply-To: <132f81feebfc532ac55823a1238a10c3d62f5e5e.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 15 Jul 2026 11:02:23 +0800
X-Gm-Features: AUfX_mxv2Kp9bdHo7Otea6yMm8YX806yft5zH4aG2luaT3RbYVMTEI6lOvMRyKM
Message-ID: <CAOJNxRKvcoQVBbF4ZeVg9aO3D=DzcG-4RYf06H-tSBVOyxJLnQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] ceph: move mdsc->mutex into __do_request()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026 at 02:52, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > __do_request() now acquires mdsc->mutex on entry and unlocks at
> > every exit point, so callers no longer need to hold it.  As a
> > result kick_requests() is now completely free of mdsc->mutex:
> > xa_for_each() is internally locked, list_del_init() is guarded by
> > wait_list_lock, and __do_request() manages its own serialization.
> >
> > Remove the no-longer-needed mutex_lock/unlock around __do_request()
> > in ceph_mdsc_submit_request() and handle_forward().  The do_request()

[......]

> > @@ -7088,9 +7095,7 @@ static void mds_peer_reset(struct
> > ceph_connection *con)
> >
> >               wake_up_all(&mdsc->session_close_wq);
> >
> > -             mutex_lock(&mdsc->mutex);
> >               kick_requests(mdsc, s->s_mds);
> > -             mutex_unlock(&mdsc->mutex);
> >
> >               ceph_put_mds_session(s);
> >               break;
>
>
> If I am not wrong, we still have comment [1]:
>
> /*
>  * called under mdsc->mutex
>  */
> static void __wake_requests(struct ceph_mds_client *mdsc,
>                             struct list_head *head)
>

Good catch. I will remove that comment. Thanks Slava.

Xiubo Li

> Thanks,
> Slava.
>
> [1]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L3793
