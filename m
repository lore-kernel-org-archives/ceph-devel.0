Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA7441B8F3
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970357; cv=pass; b=reOI34covfLQqXkuRPo1QR9Ml5XZX0aBf10Jrw3lWeO+38tDVM7pYGwLuH56zTR9Q5A+0hmjaohwG9kO/HeBjGmaeDkSDv18cB/QhJ/KW1aW5WkRE7MuRULQe3E3rw3D8QCgB30smtYV1wzE+ZQtSLwz5c/vKJSc2Z8XjSJL+Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970357; c=relaxed/simple;
	bh=MZ7qGVaJ7rnWH15e8hVtHaFbNv4/mRLVsvxRBdrx2Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qikUgssKQ3r445T0ceMwQSJ4KZCRbnARhqfjH6h+NtyYtmWCXIIBwRmFDO8nSHeE+1NFCx2c3nl55rdebdyKShoagCDQbfZFuau5nr65HB8M1P26QTFjBnW2sQjTuqIMHcQZ6Y2jsI19llvsfZkdOBo4s4c6hU3rlIJVG03kkg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYVA0Po9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tpn2UMu3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYVA0Po9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tpn2UMu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786970353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHH6tnBGIN4rU3ZB2nxXbmK6lis9375DMRzBzQgBH80=;
	b=ZYVA0Po9Tvz9MyEBNEsj759VCFArmXZ1gO49c9yaFEQrXRwFM6hOnhtB8hqV0QCL6qQtQi
	p36bv9QgMYXR0ZYhhtcYXGVeNQtls56V6zIdTLOHoctrjTvtTDheq7Sn4HfYYn9IV9bCaZ
	x7JOzMXfd6QynmRrP3t7oEOvGjBptQM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-3iHTVL7JMeGDwFK9Hl8MWg-1; Mon, 17 Aug 2026 08:39:12 -0400
X-MC-Unique: 3iHTVL7JMeGDwFK9Hl8MWg-1
X-Mimecast-MFC-AGG-ID: 3iHTVL7JMeGDwFK9Hl8MWg_1786970352
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so4144262a91.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 05:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786970351; cv=none;
        d=google.com; s=arc-20260327;
        b=Rr5wZCxoKK9sgSv4lHU9P2w3ysNFKFbnvQNySCsnyDOGe6opDSp1f+7yEYCVNuMV+d
         wUg2ODPdm/R+SEO0Byq1BlWP2u0gWjoUE31awaE8CI0R+EysB2ZYOQh8SNJA9urbAqtN
         ezaVzqpMofbqU548fciw98NTECK9NCWJW5iHwL+7AjtSfLwhsOqnCJK+6NvW8NJCtRYV
         aPvR3grU4vsMx6KJxSb33IZeNIoA4dR+qgQEPg7m6nlPu9gnod4cq9sFCOuNhToMVPyb
         eHAr7RNMkN1dow+toi/0QHs5J8G74zBlj4iVAf53fj2Wo+K1vD40+CG+5JDoQt3NAAYW
         YBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yHH6tnBGIN4rU3ZB2nxXbmK6lis9375DMRzBzQgBH80=;
        fh=PYQHpljZMXljcFC0WrDdRHN0VFSOnO3PzpQ7gfgYGQg=;
        b=PO1gjD6hrWMZB2MlRZakW35kZeYy+FIEYVXk7oLf45mi+MToCydtYmhL90Tsm6COJ0
         5Cdou2KTlx4ZjL9/a03naCh41wXBiK4lmGlJOpUrwtbsqEIYG6i12QyDAw5zcA9oBUs2
         5P37rXM/BJ8YiqfWBQmKKbQfUAuaUQAVv2ZwmW7iehp+qPN0Sa7nvExxPakko3j0ydqi
         FmYNtEm4wbmCaeYp4G20n1DWL4QHJeEBKxdK0V8Uobe7mFrAwtaGQhrae1vYOk8ODJE4
         7BI5TgI/lF1Z92OGjdh3O5lYLByF4LMMq6Xh7h0odrHjRvhIH/M9GUtLDnKacTqmP3dp
         nDpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786970351; x=1787575151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHH6tnBGIN4rU3ZB2nxXbmK6lis9375DMRzBzQgBH80=;
        b=tpn2UMu3fKp5645Y/7Sk5d0C++58803B83jHh8vj6teI7QQSjZcc10fkCl/wq8KKQu
         KM6u5EACsGq5MO3xc+qGTxJtdxMUNE9wtFJa7dD7r3PCheRFVXXCyKw+/zUvCykYfn9s
         B5b1b/1hvZW6Hdg6FdoTgd062cR7fQdCUajF7Hx5EoAdFp5vyNJfJEFaBt2UEL5E5fWv
         yW9g1ovc/5fOMuasBBADdh/3roiduSLiHSoDjjZaDmDnVteA963fGaicKfMmyKkDbVXd
         EKqTeAY8mI1fNU6PdGh0uarYZImrqzzEmSuUgZzDAv1KqixMdbjMfEHfASo53DVn8G6v
         eH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970351; x=1787575151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHH6tnBGIN4rU3ZB2nxXbmK6lis9375DMRzBzQgBH80=;
        b=Lfk5l5iG2s0/ygeEtGri1A7HvufPmQR0TSDsQQNllDjLVDbItXY3au+hH1LvWtHXi4
         iXTXcMm8FV177qOP4XA616uOJPf9smfyEHful2+HdvTqKTQYwKsbdTQL3JTdCDavglAu
         aFtUCKhyUzo9EpoGcxir0aksHOEaGSn3aJA9jZHnugP0H4QY2rqHya2KpyE1KMgZYMmS
         mBvyu9bhi7jeVeA9aQyARAaSgFYQuf/EYEDQcH99W5Bt0qZPVXJgHC9qGLgWuTDZOD8s
         990WDH8kuoHNO3mc6mJPJtm0nKDbIliFZVdVS3htUnpXvZMmVEmq97XLd1bS1yds9R4Y
         Fi9A==
X-Forwarded-Encrypted: i=1; AHgh+RrNnZ9MSGEmMwPCoxUFBZrxXMeBspL202iN/aoDMK9TNYzevL6roECFU7+hzzFOVeGuFbenOkq661pn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55aQly4jlDUZKPzvWYj8g3mWPw6NptoYAQUhGJbtAAb1qVbro
	TdTBuDJCfvFixQ0Lf3m3U/04LtbjeshtgrZ/8IA6/yzI38UjzSPrEnWZragvE/6sbhdpgJ4EIg2
	rWtVrDRrawYMFtc77EmPSHQsEDCQUbKo+Kcr5QSsHoLo5sjqLObMDTLhtGMd2G/gCml5dJxTyv/
	3GZ3MBv00l9LHnXuZQCtcMsu/V7hLYeKPKjj/BISWXpK8a9sgF
X-Gm-Gg: AR+sD12w0VI4vxGnPzGPiGI2cBRU//QObP/ciah5Oi7NWXhqBJ+FwezVvOOqSKV5lbi
	GbYamA/rhplY5Pn3hzTWrJkEVG2BIA3TfDFv+kIE3fprCDAKyp2ySdwLPpUdK1SW0HK0QNNCVIg
	htLrjLQy90fKlNfikmd82GCL/XLCF+iOTZY+BkxuT0BA6oDz8tuKyWhso0B1dYsY1aP0TvG9a4r
	kKtzYY7voUMAgLoNGnq6mLtwaU=
X-Received: by 2002:a05:6a21:8cc1:b0:3bf:63af:85d with SMTP id adf61e73a8af0-3cc71ca38a5mr30285480637.18.1786970351438;
        Mon, 17 Aug 2026 05:39:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:8cc1:b0:3bf:63af:85d with SMTP id
 adf61e73a8af0-3cc71ca38a5mr30285393637.18.1786970350836; Mon, 17 Aug 2026
 05:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812201915.1783578-1-max.kellermann@ionos.com>
In-Reply-To: <20260812201915.1783578-1-max.kellermann@ionos.com>
From: Venky Shankar <vshankar@redhat.com>
Date: Mon, 17 Aug 2026 18:08:33 +0530
X-Gm-Features: AcwNN1Wd7jBR0vOwrWQOfLqaaohCkivUYqze-nDZzzed79MIbQHTEapwBdYzkE8
Message-ID: <CACPzV1k6LZk5_L+iQGcM=98WB2jt_wME38yQyktfj+ULOVGf-g@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: force a cap message when a deferred revoke can't
 be acked immediately
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, xiubo.li@clyso.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 1:49=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> When the MDS revokes capabilities, handle_cap_grant() normally
> guarantees a response by setting `CHECK_CAPS_FLUSH_FORCE` (see
> commit 31634d7597d8 ("ceph: force sending a cap update msg back to MDS
> for revoke op")), so ceph_check_caps() sends a cap message even if the
> client would otherwise decide it has nothing to do.  That guarantee is
> skipped whenever the revoke has to be deferred (via revoke_wait):
> revoking Fb while dirty data is still buffered (writeback is queued
> first) or revoking Fc while pages are cached (async invalidation is
> queued first).
>
> In those cases, the ack is left to the deferred completion
> (ceph_put_wrbuffer_cap_refs() after writeback, or the invalidate
> worker after invalidation); both of which call ceph_check_caps(ci,0)
> i.e.  without `CHECK_CAPS_FLUSH_FORCE`.  Nothing gets sent under one
> of the following conditions:
>
> - the inode is retaining caps because the file was used recently
>   (file_wanted !=3D 0; retain |=3D CEPH_CAP_ANY)
>
> - the revoked cap is still used because the page was re-cached (e.g. a
>   file being re-read)
>
> - the MDS has meanwhile re-granted, so `issued=3D=3Dimplemented` and the
>   client sees nothing being revoked
>
> The client then never emits the cap message which the MDS is waiting
> for.  The MDS blocks on the revoke indefinitely and logs, for minutes
> or hours:
>
>   client.NNN isn't responding to mclientcaps(revoke), ino 0x... pending
>   pAsxLsXsxFsxcrwb issued pAsxLsXsxFsxcrwb, sent 964.899182 seconds ago
>
> The client-side state at that point shows the full cap set still
> issued, nothing in the revoking/flushing sets.  Thus nothing gets
> sent.
>
> This patch fixes it by remembering that a forced response is expected.
> When a revoke is deferred, set `CEPH_I_FLUSH_FORCE` on the inode.
> ceph_check_caps() replays it as `CHECK_CAPS_FLUSH_FORCE`, so whichever
> path re-checks the inode next (the writeback/invalidate completion,
> the delayed worker, or any other caller) is guaranteed to send a cap
> message to the MDS.  __prep_cap() clears the flag once a message is
> actually built.

Thanks for the patch, Max. This probably fixes
https://tracker.ceph.com/issues/75735

>
> This is the deferred-path counterpart of the existing
> `CHECK_CAPS_FLUSH_FORCE` handling; a normal (non-deferred) revoke
> still forces the response inline as before.
>
> Cc: stable@vger.kernel.org
> Fixes: 31634d7597d8 ("ceph: force sending a cap update msg back to MDS fo=
r revoke op")
> Fixes: 257e6172ab36 ("ceph: don't let check_caps skip sending responses f=
or revoke msgs")
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> v1->v2: fix CEPH_I_FLUSH_FORCE/CEPH_I_FLUSH_FORCE_BIT mixup
> ---
>  fs/ceph/caps.c  | 40 +++++++++++++++++++++++++++++++++-------
>  fs/ceph/super.h |  5 +++++
>  2 files changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index d7283fb54cec..8ad17787b172 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1410,6 +1410,7 @@ static void __prep_cap(struct cap_msg_args *arg, st=
ruct ceph_cap *cap,
>         BUG_ON((retain & CEPH_CAP_PIN) =3D=3D 0);
>
>         clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> +       clear_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
>
>         cap->issued &=3D retain;  /* drop bits we don't want */
>         /*
> @@ -2038,6 +2039,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, i=
nt flags)
>
>         if (ci->i_ceph_flags & CEPH_I_FLUSH)
>                 flags |=3D CHECK_CAPS_FLUSH;
> +       /*
> +        * A revoke whose response was deferred (see handle_cap_grant()) =
must
> +        * still be acknowledged.  Replay the forced flush here so that e=
ven a
> +        * check triggered by writeback/invalidation completion sends a c=
ap
> +        * message to the MDS.
> +        */
> +       if (ci->i_ceph_flags & CEPH_I_FLUSH_FORCE)
> +               flags |=3D CHECK_CAPS_FLUSH_FORCE;
>  retry:
>         /* Caps wanted by virtue of active open files. */
>         file_wanted =3D __ceph_caps_file_wanted(ci);
> @@ -3757,13 +3766,30 @@ static void handle_cap_grant(struct inode *inode,
>         BUG_ON(cap->issued & ~cap->implemented);
>
>         /* don't let check_caps skip sending a response to MDS for revoke=
 msgs */
> -       if (!revoke_wait && le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_REV=
OKE) {
> -               cap->mds_wanted =3D 0;
> -               flags |=3D CHECK_CAPS_FLUSH_FORCE;
> -               if (cap =3D=3D ci->i_auth_cap)
> -                       check_caps =3D 1; /* check auth cap only */
> -               else
> -                       check_caps =3D 2; /* check all caps */
> +       if (le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_REVOKE) {
> +               if (revoke_wait) {
> +                       /*
> +                        * We can't ack the revoke yet: the response is d=
eferred
> +                        * until the writeback or cache invalidation queu=
ed above
> +                        * completes.  Set the CEPH_I_FLUSH_FORCE flag to=
 remember
> +                        * that a forced cap message is owed so that defe=
rred
> +                        * completion (ceph_put_wrbuffer_cap_refs() or th=
e
> +                        * invalidate worker, both of which call ceph_che=
ck_caps())
> +                        * actually sends one, even if by then the revoke=
d caps look
> +                        * unused, the inode is retaining caps, or the MD=
S has
> +                        * re-granted them.  Without this, the cap messag=
e is never
> +                        * sent and the MDS hangs ("isn't responding to
> +                        * mclientcaps(revoke)").
> +                        */
> +                       ci->i_ceph_flags |=3D CEPH_I_FLUSH_FORCE;
> +               } else {
> +                       cap->mds_wanted =3D 0;
> +                       flags |=3D CHECK_CAPS_FLUSH_FORCE;
> +                       if (cap =3D=3D ci->i_auth_cap)
> +                               check_caps =3D 1; /* check auth cap only =
*/
> +                       else
> +                               check_caps =3D 2; /* check all caps */
> +               }
>         }
>
>         if (extra_info->inline_version > 0 &&
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 1d6aab060780..878440a2eb3b 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -687,6 +687,10 @@ static inline struct inode *ceph_find_inode(struct s=
uper_block *sb,
>  #define CEPH_I_ASYNC_CREATE_BIT                (12) /* async create in f=
light for this */
>  #define CEPH_I_SHUTDOWN_BIT            (13) /* inode is no longer usable=
 */
>  #define CEPH_I_ASYNC_CHECK_CAPS_BIT    (14) /* check caps after async cr=
eating finishes */
> +#define CEPH_I_FLUSH_FORCE_BIT         (15) /* a revoke's response was d=
eferred;
> +                                             * force a cap message to th=
e MDS once
> +                                             * the deferred work complet=
es
> +                                             */
>
>  #define CEPH_I_DIR_ORDERED             (1 << CEPH_I_DIR_ORDERED_BIT)
>  #define CEPH_I_FLUSH                   (1 << CEPH_I_FLUSH_BIT)
> @@ -699,6 +703,7 @@ static inline struct inode *ceph_find_inode(struct su=
per_block *sb,
>  #define CEPH_I_ODIRECT                 (1 << CEPH_I_ODIRECT_BIT)
>  #define CEPH_I_ASYNC_CREATE            (1 << CEPH_I_ASYNC_CREATE_BIT)
>  #define CEPH_I_SHUTDOWN                        (1 << CEPH_I_SHUTDOWN_BIT=
)
> +#define CEPH_I_FLUSH_FORCE             (1 << CEPH_I_FLUSH_FORCE_BIT)
>
>  /*
>   * Masks of ceph inode work.
> --
> 2.47.3
>
>


--=20
Cheers,
Venky

