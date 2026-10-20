Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460274;
	b=Dhzw5W98t1rVbrn0ZpAviJdIXkqvHwOqzqhEzhdy2tn1OauWzwG+adW/EOQq4hxWUXS5
	 QbKkVQKsdtFnbXSDyzKdY5+4USqIpjFDemfBFQ0z0pN/Nw55OSJsjcpUEA6AF4DzELQA0
	 FURL1ZVxNJveiHYcDRf9l86gq5fHV+vMCR7sFiHQyBt4G58Jy5KrB25c86PIfoD+7eosI
	 +gQcIRqHjZfyNMWa4dgswkx9SJ9e2Pe+j/6hZvUk3d/46cvhXIgasWwSOmdY6GM+rG8Lc
	 X5Do5mw3OYM4X6qQEZM/+yU2XXpnBVsnxwy6l8yMpSNoBcHWXuz5giymRGuZK2DoLmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460274;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jP4lZdaPL1joSK7NmbwCF2Jm8w/+kRdZe+KzVnPHDcI=;
	b=ZQPL3HJ2XeYEBIr4owYIl3C0HOCkpnlg7FVD/LDl3QdWLxgdiyN7sh0xvIsuYcdNoaNk
	 ddOdE817tQ+dFvgIhCDT0Lunjpr70UHAVKJIeromkSW6FqwUxgDICFha2EUbmtZezueNN
	 lzbFTV/dIrxJiMGho0Dv7lfFayY6HkpkJVun/bYqtjma5k3w0En3jks0uJAPkB4krZPNC
	 FKCye8rNMoeQZdgXszgVcQkd2pVrl7pwFIVMwW8rh7zOy4aoq18mw0A/lJBCwj4FnX9/w
	 Q20W4XZu1cJZTHUtvv3zKlcqa1ptynmLw1Utt5+qQzootKxt68Wnj5XQJIE9kOK5xHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwUs8sYb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53502606A31A
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwUs8sYb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E862E1F000C6
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460273;
	bh=jP4lZdaPL1joSK7NmbwCF2Jm8w/+kRdZe+KzVnPHDcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EwUs8sYbDsa6abM4eKkAdjADNnPL07fJ8Of+oiAiuoobRmmTILX5WCaGYq+kpPQEw
	 TXp4GTDlfkPuLpgtsWZtjo2RIeRj33hhKTN79pArl5OFQzUI0gX78LT//iv6c/q5EE
	 Ao8Lrre1gSNuedm5M0BAcMzhP7ZDwNvGcvTjVsf+fOoWKI6q3dezfVirKdlMN7vDhz
	 z93DpIaZrZeT8++BrDn0PF2vkc09TK3jk5oHn11iRhRgtN/CG40qPcR8rn1RtKQ3Xb
	 sRdGhZpBEzi6nGbBJGyXZl3xRgsMCQNdS4v+oWv/Bwc38LBrObOeH/EXn+qfyAs5Bb
	 fOafQhu5OFkwg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be469d4f9fso2396918e87.2
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2026 18:37:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzoX6fM3zGgP3r1eDVGzOdcqMf7/c8l4AsMrQHazGk64the+2CX12HJxTpu92G9Xz7aNanglOiZvTCz@vger.kernel.org
X-Gm-Message-State: AFq9FYJscO/0Oc4yMrmm/z0hoYgHV+4VwgjomYmqg1ae8GufjQu0sYsy
	jNPaQf0L2gKXAZtXLKaqv/MUxty5u1/TpCawJdQLv5DsL1eSeDNJwtA9xwHgvWRGlG4enF6VKxF
	lXkMTqSytdbBEBolic9P9OwKhy3YYDqY=
X-Received: by 2002:a05:6512:68e:b0:5be:4990:9dbc with SMTP id
 2adb3069b0e04-5be50a990eemr2973410e87.54.1792460272710; Mon, 19 Oct 2026
 18:37:52 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015064202.62886-2-vshankar@redhat.com> <20261015155808.140236-1-amarkuze@redhat.com>
In-Reply-To: <20261015155808.140236-1-amarkuze@redhat.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Tue, 20 Oct 2026 03:37:41 +0200
X-Gmail-Original-Message-ID: <CAOuZWzxd85AzOGGh_DQduVRbGLnDrfyQ0ZJXcWEDJmVEVZPdcg@mail.gmail.com>
X-Gm-Features: AclHuK9zWVjq3K7bFzvukN1aHd9zJr81f91xdZSiwcaIVkk2cLLNuX5YYSi3AYg
Message-ID: <CAOuZWzxd85AzOGGh_DQduVRbGLnDrfyQ0ZJXcWEDJmVEVZPdcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ceph: don't drop a lock grant that races with an interrupt
To: Alex Markuze <amarkuze@redhat.com>
Cc: Venky Shankar <vshankar@redhat.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 08:44, Venky Shankar wrote:
> When a blocked F_SETLKW or LOCK_EX request is interrupted,
> ceph_lock_wait_for_completion() marks the request aborted and sends a
> FCNTL_INTR/FLOCK_INTR request to the MDS.
[...]

Hi Venky,

Thanks for chasing this down. The analysis looks right to me: once
the request has been sent we must not drop its reply, and clearing
the wait flag so that a resend gets an immediate answer is a nice
touch. I checked that __prepare_send_request() rebuilds the message
from r_args for SETFILELOCK (it never gets an unsafe reply), so the
cleared flag does take effect on a resend. Also, r_session is only
cleared in __unregister_request(), so !req->r_session reliably means
"never sent".

A couple of comments inline.

> @@ -219,10 +240,14 @@ static int ceph_lock_wait_for_completion(struct cep=
h_mds_client *mdsc,
>         if (err && err !=3D -ERESTARTSYS)
>                 return err;
>
> -       err =3D wait_for_completion_killable(&req->r_safe_completion);
> -       if (err)
> -               return err;
> -
> +       /*
> +        * Once it has handled the interrupt, the MDS replies to the
> +        * original request: 0 if the lock was granted first, -EINTR if
> +        * the wait was cancelled. Wait for that reply even with a fatal
> +        * signal pending, so that the caller records a granted lock and
> +        * the lock gets released when the file is closed.
> +        */
> +       wait_for_completion(&req->r_completion);

This turns a killable wait into an unbounded uninterruptible one. If
the MDS doesn't answer (laggy MDS, a network partition with the
session still open, a slow failover), the task sits in D state and
can't be killed. That's the container-kill case the patch is trying
to fix, and the pod would now hang in Terminating, with hung_task
warnings on top.

It's also not guaranteed that the interrupt reaches the MDS at all.
With SIGKILL pending, ceph_mdsc_do_request(intr_req) returns
-ERESTARTSYS right away. If the session isn't open at that moment
(e.g. it is reconnecting), intr_req is only queued and then aborted,
and __do_request() won't send it after that. The original request
then waits behind the conflicting lock until it is resent to a new
MDS (with wait =3D=3D 0) or the holder unlocks, which can take
arbitrarily long.

Could we keep the wait killable and, when it is killed, leave the
request registered instead of aborting it? An r_callback on the
request (as the async create/unlink paths do) could then send an
async unlock to the MDS if the late reply turns out to be a grant.
That avoids leaking the lock without making the task unkillable. At
the very least I'd prefer a bounded wait here.

>         intr_req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETFILELO=
CK,
>                                             USE_AUTH_MDS);
>         if (IS_ERR(intr_req))
>                 return PTR_ERR(intr_req);
[...]
>         if (err && err !=3D -ERESTARTSYS)
>                 return err;

These two error paths still abort a request that has been sent:
wait_func returns a negative error without CEPH_MDS_R_GOT_RESULT
set, so ceph_mdsc_wait_request() goes into its abort branch and sets
CEPH_MDS_R_ABORTED. If the MDS had already granted the lock, the
reply is dropped and the lock leaks, the same bug this patch fixes.
They are unlikely (-ENOMEM, -EIO/-ETIMEDOUT from the interrupt
request), but the commit message says "Don't abort a request that
has been sent", so they should either wait for the original reply
too or go through the same orphan/async-unlock handling as above.

> -       } else {
> +       } else if (!req->r_session) {
>                 /*
> +                * haven't sent the request, so the MDS can't have grante=
d
> +                * the lock: abort it.
> +                *
>                  * ensure we aren't running concurrently with

Nit: the two comments read a bit disjointed stacked like this.
Maybe merge them into one paragraph.

Thanks
Xiubo

Alex Markuze <amarkuze@redhat.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8815=E6=
=97=A5=E5=91=A8=E5=9B=9B 19:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Venky,
>
> Thanks for the patch.
>
> Reviewed-by: Alex Markuze <amarkuze@redhat.com>
>
> --
> Alex Markuze
>
>
