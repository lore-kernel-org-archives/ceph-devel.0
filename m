Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792658906;
	b=nnBjbiGjYCb+H7I/yaNuPrEzy+5Y83Dypcvvfzy+Y0Co2xQLGyAd5POCn0TY72PS0BFZ
	 OA2h3cBktYFB1byTqs/sQJHdiRxCTDEJ60pX39Tm9n8NQcJApUTnQtetoR0EBE4BCcMrZ
	 rhfqFmrG8c2l0asR3IDoXXtz3mjXoBUJTTPiE/nWgOHAEx4BpLjKJ4b6Xnk5dDENIpS1T
	 /F1l7+JNWCvT/zl7zvTZ0OfIQLqrBW86N+36vV1GNMPhIutjhRADvCOU+ThaQhar5omS9
	 RTHnP8OCjJiwwYm6ejNOj4detU/4g9MWBAJRSj8yritV2JdbNuUWA/Jp9jdcuQVpjuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658906;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=89BU+uNF/x1u6v48KixxfZCXk7VKZGXb0yTb0ddA0rw=;
	b=IDTDU0R/cl/LeXDqipTI5QXjauV5bB/OeAv0l2PUj2FP7uMruovcbW0GFu8ChVFFU5u4
	 sv7S3tnV5Ungq52lrStdj4A3gLf2pX/eQcIONcazrqnt/s5rENdRDiIXwq5lolBxlZdnQ
	 0o2ZN2tEeVYAnUXtlWFlOB3Ea5RYMX4SXZdOZ6No6IZW8/Vyt9JDIWnyTitjrTe1gqCgO
	 EssoqP1GPOKTs2PNldmB4nfZsqpS6eMxgU1CMVs0HFAy0VXCCpn9+NG8bo6gX/IXZALKK
	 rxbgzoy+RzOodnV68vjlowMkmPJDcWnwOXkFuuBR1xoFYw5fOSuOjEbJgct+bn0cS4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hst+WwLQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=p5Sg1jKb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B477606A319
	for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 08:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B477606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hst+WwLQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=p5Sg1jKb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792658904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89BU+uNF/x1u6v48KixxfZCXk7VKZGXb0yTb0ddA0rw=;
	b=Hst+WwLQ2sGIXCyWwC8Obf4+Ve02s/K2ESThBnZYFwIZTIHzOhxMb61GDgWDCl7G90f+RY
	thTJizO2NJqJIRS3ZzilLp1VLfi+8ouFfYg227NPH6RphRcxqI7/dcsSL+VN/vByx7eqP5
	dJMhhL49miYs/NMHFCSRIuHU14xn7jw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-ZbOl0XE-M0WJo8XVTAbsHg-1; Thu, 22 Oct 2026 04:48:23 -0400
X-MC-Unique: ZbOl0XE-M0WJo8XVTAbsHg-1
X-Mimecast-MFC-AGG-ID: ZbOl0XE-M0WJo8XVTAbsHg_1792658902
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so2175603a91.3
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 01:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792658902; cv=none;
        d=google.com; s=arc-20260327;
        b=eYWvIFAQq3SZX6s+Xi8Xm6z2vPEuEFhWcc1vZivJIGURkpBI64xBZUerN+W6TsdvPD
         WRdfrecr2ge/qDh6hDgAjUNW39TG4mUMnKlVdtKf2mdjGvNPRdZGSa+SSmiKixO58lbU
         wOAep9w0Gjr/Mo2EP9n0VfbRXKchfmK3Y6Ty/JSmg1oGvXVY77epkaWBS7c0v4xNpWyp
         /cDwSJFWXAJKl1M9Hqx5aGfOF6lH2oThHac1rj1jabPsD6UoUI+3tpYL5uve6pRHCDZr
         LUgE6kYJqZwxD8a9CNe7m2b+yn9WfIJnXEZmV40jn4kcCZ1VkFwgJVQv+mHykR8kKEAL
         0Olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=89BU+uNF/x1u6v48KixxfZCXk7VKZGXb0yTb0ddA0rw=;
        fh=PMfKZ7IpRevUnoI2D5+FkiqvdCcawqF9XymMkhVnG3g=;
        b=H8D6pU6tils/2YQs9MsleYFqmfdhs5bJ84g7p325QuAbas5qWeWaBwu7Pk7O/2ZEAm
         jKJr1ava4aBGWpJei3ySSPLHc9kGrNQHR9hHvbjb1hRwndfupF2kjwUT6trePGsm/cuc
         y4ruviOT1yz/SwTE7c9q0yvcG8+OH5O9HK52ZXXJeLVdK1/WeBRQqGDZUP3//78PqGT9
         gbfMncnlrbLF+0O0vwgjfMYsSvLhjG2kDX+Li3+WGHYzITYVbVT2BP2mZUBEpH1G6DRY
         wRDpECJfcwsRp8EUVbCO4U8ORudNOQyTO4jWBKz8mFCdnymr09obDjwZ93Q8tvcPJwo9
         CxSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792658902; x=1793263702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=89BU+uNF/x1u6v48KixxfZCXk7VKZGXb0yTb0ddA0rw=;
        b=p5Sg1jKbplfVIS0bkeo1bFH9xciXg7EMF73ivB27077T8NI9VjMe96s4+P09IduqrB
         04+xAWhA13nt9w7KBB8tKj8ZslKAoyiNmAdP93mZq7ajB72t5tqb5QXYXm1qrIMWJ1fz
         36KJ6aOwOGrF3kp5/kjXwsLrIqj2mSv7/ZA+AdTiOyHHPJM318f2eoysGeMawBiukX4b
         ToslimtHdiSi1drKTXRPJwO2jcjdtKp9F7x2ozRP/7M38UQSik3jyQYGpWVpy6bN57WM
         TCiweznaZH1IKuFGxaLARWXZvRndncNDsX3eWxZQLPJPkNk/moRani/KiiwpclNoF4oI
         x0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658902; x=1793263702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89BU+uNF/x1u6v48KixxfZCXk7VKZGXb0yTb0ddA0rw=;
        b=tiiFwp98USUfIthWr6Y5oZ9RYJDfY5FLFUSxTU5QylsgsUGHWeoh7ZQvOtZyTHcMSy
         W0aJ28C9K1/6ueEvpJ6ngei71EBnojFUbmXQX2HhoK9ovPo1c53jbQzRLDiB59Uutwua
         /ctRMi4mxkDhZrvRxbDA7EfL2THN9+9CvE8wIm2VWz967BGgfyQcW3kSI/tABX+DfZpD
         BonRcSf07c8k541d09THAU621IDMvSyrDRIJr/pkrIvmHKGjpHSWfYYunxv7uUBp+qn9
         5nSNzTQPtpmGXw9Fhk6CkHPmH100FuEIWMeaUFNBcKoSgx6lRcIZFvov0w2NqOLmdBi4
         Ekww==
X-Gm-Message-State: AFq9FYKafWPz7VXzMsGjLqMDUY+j8+Qat0xld+ibNFjXM1+AJLQVJ8Dn
	iLeaNUYt3OQ9wuOoUb7AnYTSsDOhhOCs5tAJakSH6c3ypC+TEz31HAyp4xYR0DezcdYchUiqG+l
	QL+y6ATEvu4xcXlL83cXQEMuk4AgZfdkVWA7r+MSaaK8DWYQL810pBcz4MpGyj2VBVSSq2GVdPm
	93wG1ruKYLOOy2cU0TbtXAM3atauxyBNE3c3hXAw==
X-Gm-Gg: AYBFou2U3OiJm0RFQvny9OSNjbDo8jm9yo/2nuzgH/W4ezuPfwlSSjrl9veZbPxLUwj
	vXT4WR266pJWhVW5R2nsl2cZ4QCYgZBpsSzTCmyafXGog0bINyQqirGSbVgzGdvKUkN2vib2v7/
	dl6elhbCVadn7YmwoEqgVj52mmJob27FjFgMM64lTYxh+hOmVDxDL9jeVocce0YSMjppvpJl8Wz
	73UHS/DlZTm8zl/cRH+3HzvxrI=
X-Received: by 2002:a17:90a:dfcb:b0:3ab:d45c:59da with SMTP id 98e67ed59e1d1-3ad86f717fcmr3601105a91.40.1792658901932;
        Thu, 22 Oct 2026 01:48:21 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcb:b0:3ab:d45c:59da with SMTP id
 98e67ed59e1d1-3ad86f717fcmr3601081a91.40.1792658901318; Thu, 22 Oct 2026
 01:48:21 -0700 (PDT)
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
 <CAOuZWzxd85AzOGGh_DQduVRbGLnDrfyQ0ZJXcWEDJmVEVZPdcg@mail.gmail.com> <20261022061630.1832692-1-amarkuze@redhat.com>
In-Reply-To: <20261022061630.1832692-1-amarkuze@redhat.com>
From: Venky Shankar <vshankar@redhat.com>
Date: Thu, 22 Oct 2026 14:17:42 +0530
X-Gm-Features: AclHuK8fY30wAvzMfX_gYfDw481QybOQFsc5L1OvrWj_8xE30zmCWRXiiZOxxYE
Message-ID: <CACPzV1mpiUPPg-XN9_P-ZFmx3NYGP6ATK6RBPK6A-ZTXwT3Qgw@mail.gmail.com>
Subject: Re: [PATCH] ceph: unlock an abandoned file-lock grant from its reply
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubo.li@clyso.com>, Xiubo Li <xiubli@kernel.org>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Vaishnavi Deshpande <vadeshpa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, Oct 22, 2026 at 11:46=E2=80=AFAM Alex Markuze <amarkuze@redhat.com>=
 wrote:
>
> Venky Shankar's "ceph: don't drop a lock grant that races with an
> interrupt" keeps a sent SETFILELOCK registered and waits for the MDS
> reply, so a grant is not dropped. Xiubo Li pointed out that
> wait_for_completion() leaves a killed task in D state, and that a
> failed interrupt request still aborts a request the MDS may already
> have granted.
>
> After the interrupt is sent, wait with wait_for_completion_killable().
> If that wait is killed, or the interrupt request fails with -ENOMEM,
> -EIO, -ETIMEDOUT, or -ERESTARTSYS, leave the original request
> registered and mark it abandoned. ceph_mdsc_wait_request() returns
> that error instead of aborting or reporting a late grant as success.
> The reply callback sends an unlock when the result is a grant.
>
> Suggested-by: Xiubo Li <xiubli@kernel.org>
> Cc: Venky Shankar <vshankar@redhat.com>
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
> Base: https://github.com/ceph/ceph-client.git testing
> 797fedea5c2bc44fc6d92526999fd4242052a4ee ("ceph: fix uninitialized err in=
 ceph_netfs_issue_read()")
>
>  fs/ceph/locks.c      | 119 +++++++++++++++++++++++++++++++++----------
>  fs/ceph/mds_client.c |  11 +++-
>  fs/ceph/mds_client.h |   1 +
>  3 files changed, 102 insertions(+), 29 deletions(-)
>
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index 4bd96d0beba4..308de4c4f31a 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -163,6 +163,66 @@ static int ceph_lock_message(u8 lock_type, u16 opera=
tion, struct inode *inode,
>         return err;
>  }
>
> +/*
> + * The waiter was killed, or the interrupt request failed, after the
> + * original SETFILELOCK was sent. The MDS may still grant it. Unlock a
> + * grant so the lock is not left held by a caller that already returned
> + * an error and did not record it locally.
> + */
> +static void ceph_lock_orphan_cb(struct ceph_mds_client *mdsc,
> +                               struct ceph_mds_request *req)
> +{
> +       struct ceph_client *cl =3D mdsc->fsc->client;
> +       struct ceph_mds_request *unlock;
> +       struct inode *inode =3D req->r_inode;
> +       int result, err;
> +
> +       if (!req->r_reply_info.head)
> +               return;
> +       result =3D le32_to_cpu(req->r_reply_info.head->result);
> +       if (result)
> +               return;
> +
> +       unlock =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETFILELOCK=
,
> +                                         USE_AUTH_MDS);
> +       if (IS_ERR(unlock)) {
> +               pr_warn_ratelimited_client(cl,
> +                       "abandoned lock grant on %llx.%llx could not be u=
nlocked: %ld\n",
> +                       ceph_vinop(inode), PTR_ERR(unlock));
> +               return;
> +       }
> +
> +       unlock->r_inode =3D inode;
> +       ihold(inode);
> +       unlock->r_num_caps =3D 1;
> +       unlock->r_args.filelock_change =3D req->r_args.filelock_change;
> +       unlock->r_args.filelock_change.type =3D CEPH_LOCK_UNLOCK;
> +       unlock->r_args.filelock_change.wait =3D 0;
> +
> +       err =3D ceph_mdsc_submit_request(mdsc, inode, unlock);
> +       if (err)
> +               pr_warn_ratelimited_client(cl,
> +                       "abandoned lock grant on %llx.%llx could not be u=
nlocked: %d\n",
> +                       ceph_vinop(inode), err);
> +       ceph_mdsc_put_request(unlock);
> +}
> +
> +/* mdsc->mutex held. The request has been sent and has no result yet. */
> +static int ceph_lock_abandon(struct ceph_mds_client *mdsc,
> +                            struct ceph_mds_request *req, int err)
> +{
> +       lockdep_assert_held(&mdsc->mutex);
> +
> +       if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags))
> +               return 0;
> +
> +       req->r_args.filelock_change.wait =3D 0;
> +       req->r_callback =3D ceph_lock_orphan_cb;
> +       req->r_err =3D err;
> +       set_bit(CEPH_MDS_R_ABANDONED, &req->r_req_flags);
> +       return err;
> +}
> +
>  static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
>                                           struct ceph_mds_request *req)
>  {
> @@ -191,12 +251,11 @@ static int ceph_lock_wait_for_completion(struct cep=
h_mds_client *mdsc,
>                 err =3D 0;
>         } else if (!req->r_session) {
>                 /*
> -                * haven't sent the request, so the MDS can't have grante=
d
> -                * the lock: abort it.
> -                *
> -                * ensure we aren't running concurrently with
> -                * ceph_fill_trace or ceph_readdir_prepopulate, which
> -                * rely on locks (dir mutex) held by our caller.
> +                * Not sent, so the MDS cannot have granted the lock:
> +                * abort it. Take r_fill_mutex so this does not run
> +                * concurrently with ceph_fill_trace or
> +                * ceph_readdir_prepopulate, which rely on locks held
> +                * by our caller.
>                  */
>                 mutex_lock(&req->r_fill_mutex);
>                 req->r_err =3D err;
> @@ -223,32 +282,38 @@ static int ceph_lock_wait_for_completion(struct cep=
h_mds_client *mdsc,
>
>         intr_req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETFILELO=
CK,
>                                             USE_AUTH_MDS);
> -       if (IS_ERR(intr_req))
> -               return PTR_ERR(intr_req);
> -
> -       intr_req->r_inode =3D inode;
> -       ihold(inode);
> -       intr_req->r_num_caps =3D 1;
> +       if (!IS_ERR(intr_req)) {
> +               intr_req->r_inode =3D inode;
> +               ihold(inode);
> +               intr_req->r_num_caps =3D 1;
>
> -       intr_req->r_args.filelock_change =3D req->r_args.filelock_change;
> -       intr_req->r_args.filelock_change.rule =3D lock_type;
> -       intr_req->r_args.filelock_change.type =3D CEPH_LOCK_UNLOCK;
> +               intr_req->r_args.filelock_change =3D req->r_args.filelock=
_change;
> +               intr_req->r_args.filelock_change.rule =3D lock_type;
> +               intr_req->r_args.filelock_change.type =3D CEPH_LOCK_UNLOC=
K;
>
> -       err =3D ceph_mdsc_do_request(mdsc, inode, intr_req);
> -       ceph_mdsc_put_request(intr_req);
> -
> -       if (err && err !=3D -ERESTARTSYS)
> -               return err;
> +               err =3D ceph_mdsc_do_request(mdsc, inode, intr_req);
> +               ceph_mdsc_put_request(intr_req);
> +       } else {
> +               err =3D PTR_ERR(intr_req);
> +       }
>
>         /*
> -        * Once it has handled the interrupt, the MDS replies to the
> -        * original request: 0 if the lock was granted first, -EINTR if
> -        * the wait was cancelled. Wait for that reply even with a fatal
> -        * signal pending, so that the caller records a granted lock and
> -        * the lock gets released when the file is closed.
> +        * The MDS replies to the original request after the interrupt:
> +        * 0 if the lock was granted first, -EINTR if the wait was
> +        * cancelled. A fatal signal must not turn this into an
> +        * uninterruptible sleep. If this wait is killed, or the
> +        * interrupt request never went out, leave the original request
> +        * registered. Its reply callback unlocks a late grant.
>          */
> -       wait_for_completion(&req->r_completion);
> -       return 0;
> +       if (!err)
> +               err =3D wait_for_completion_killable(&req->r_completion);
> +       if (!err)
> +               return 0;
> +
> +       mutex_lock(&mdsc->mutex);
> +       err =3D ceph_lock_abandon(mdsc, req, err);

This also runs when the INTR request itself fails (say -ENOMEM, or
-ERESTARTSYS from ceph_mdsc_wait_for_reset()) after a non-fatal
signal.

Suppose the task holds a read lock on a byte range and requests to
upgrade it to a write lock, which waits on the MDS. A handled signal
interrupts the wait and the INTR request fails, so the lock call
(correctly) fails in user-space and the task still holds its read
lock. If the MDS later grants the upgrade, it merges it with the read
lock, and ceph_lock_orphan_cb() callback then sends an unlock for the
range. That leaves the owner with no lock on the range on the MDS,
while the task still thinks it holds the read lock. Consequently,
another client can now acquire a conflicting write lock.

The same happens if the call is restarted (SA_RESTART) or retried
before the late grant: the new grant is recorded locally and then
undone on the MDS by the callback's unlock.

> +       mutex_unlock(&mdsc->mutex);
> +       return err;
>  }
>
>  static int try_unlock_file(struct file *file, struct file_lock *fl)
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d4ef8a355a48..f485beb3584b 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4076,8 +4076,15 @@ int ceph_mdsc_wait_request(struct ceph_mds_client =
*mdsc,
>         boutc(cl, "do_request waited, got %d\n", err);
>         mutex_lock(&mdsc->mutex);
>
> -       /* only abort if we didn't race with a real reply */
> -       if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
> +       /*
> +        * The caller was killed or the interrupt request failed after
> +        * this request was sent. Leave it registered. A late grant is
> +        * unlocked by r_callback; do not turn that grant into success
> +        * for a caller that has already given up.
> +        */
> +       if (test_bit(CEPH_MDS_R_ABANDONED, &req->r_req_flags)) {
> +               err =3D req->r_err;
> +       } else if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
>                 err =3D le32_to_cpu(req->r_reply_info.head->result);
>                 if (err > 0 || err < -MAX_ERRNO) {
>                         /*
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 863cdb8d588a..e198ede629fd 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -360,6 +360,7 @@ struct ceph_mds_request {
>  #define CEPH_MDS_R_PARENT_LOCKED       (7) /* is r_parent->i_rwsem wlock=
ed? */
>  #define CEPH_MDS_R_ASYNC               (8) /* async request */
>  #define CEPH_MDS_R_FSCRYPT_FILE                (9) /* must marshal fscry=
pt_file field */
> +#define CEPH_MDS_R_ABANDONED           (10) /* caller left; reply unlock=
s a grant */
>         unsigned long   r_req_flags;
>
>         struct mutex r_fill_mutex;
>
> base-commit: 797fedea5c2bc44fc6d92526999fd4242052a4ee
> --
> 2.34.1
>


--=20
Cheers,
Venky

