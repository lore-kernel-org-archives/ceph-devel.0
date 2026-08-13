Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938C361954
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604641; cv=pass; b=TH+x6sCohRLYOF2kUXenQOiq8sqNtOJ/TOW3bVKJY+MbEExFqL24A/XT1aaiwEFc6HuKH14rZGzY95iGSU9Jo5lNjJYLq3VvdAix1EUb80OUxdXpKUfLtXDjD2M3m2J4NgGTDsDHclR1RN9lK8tby2cr4XUxFQshCh1xVGDQ/6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604641; c=relaxed/simple;
	bh=9K47MKJkOX4Imlq/XePjv0OeOE50zPp/VsxPOYek/EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwX6ONtd9+oJgSWggo2urJCXI1BjHHQvVmazm3qjbOrj7yyqUvqeGeUigfBw+5aNtXnLW++qoa5mHfSJLMgcxcAN+NqE4rB/pDsKbWOm0FvwyR4L1lhvXhJQZHcuRKbWw9RtxH3Hv2F/Zlh9ks51OFV7H5QEJx77cQSpyW2LTeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=YmLmwIVS; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="YmLmwIVS"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15e2dab83eso284750466b.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 00:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786604635; cv=none;
        d=google.com; s=arc-20260327;
        b=boszEg9gI0LtfGupVyXtk5tV08jGbZRVA79lI9AaGBJBKuXwrFqjq30TzKj4OdsTfR
         OKlOaO52pusxj7REh21Z/uCggPQPsSgCiEINCb8kvysnW48mRxy7hlkyEy8zv31RehuG
         9KTtMk8kuS9ac/9+96+Hx6rARc6BDw6ieW1d/Jj8soDx7SOizfthTi8INQJiNwuDnG+8
         EEkw3OqLyy2LYL0GnZWPMWpa4iFSdmaSzq07r8wiCq2zeY8LY73BormE5Iw86pZeARsY
         G4119llfu0WDrGcqJaBta6YLv0mTE53iTms++RM7EDN8LZpUKi/xv7O/8OrRLTUmDQdn
         KKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A7yoEOJbb0UjYrEefoP7PhNCYIqC+XYvUQcR5OcOtJg=;
        fh=fSuriGKkD7F4O+lMViZYgTH00AyiFq6nBblBZTw79RY=;
        b=UL6dMuyz6KAHmC51iWCUEjkqZR2D0QfjWU51Rw0o9Pk88eKppLB4BBQyABMAab/gek
         eEwmoV7syVasfmBwa1N1Py+6nlLjRovxinraLr3CkzglVebqOdDyfbF81Q48NlngnaZa
         zaFaHRm6lm5ScMZbBpKdvix54qaG8uNtCdmZs5sU4KTfnjQfrulYnM/vXerbJXUWGcaa
         kJ3jY8QNeiz825dVSVx+9RNcWh4IIgm6TXDkk6tWhIu5VVG3EC8j7etKsUvKnIHsOlsF
         bdaBfgtPjcssod1RNQHS9iQUJwq/lHBg7HePr0j/S2NE2Z7HgJPVuM/rpjgszmXZ21VY
         m6Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786604635; x=1787209435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7yoEOJbb0UjYrEefoP7PhNCYIqC+XYvUQcR5OcOtJg=;
        b=YmLmwIVST7iKBtV8qAP27Y9+QA1BTasP0e3gG2ZZ8PJlmU5rLy3S2exfMNjfrISzvI
         Wrav6/YISbE+bRuD7IcpC1z/LnVqw2fDr7rHYwGeFaltwh0hS/+nsYui81KQ3qIrbdBd
         ts84Z3NQDNuls32UIZT9A3BhMmiJChLtA5Qfa5zjsT+GD1rx9eKmRuJ6jH0KLaBgT3ks
         2QmgAdKj45lo/UPGblCfWekTb6y0E3zLIdG5fBCrfFDOSHLs/JYHcaJp9iEx/atgYWSC
         kD6fhPTbuy7iugTPVoC2BxwNwdGPPPi7XCp2ieCYRAVF99LViVtbbWBU8NNaboRWmQqq
         sPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786604635; x=1787209435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A7yoEOJbb0UjYrEefoP7PhNCYIqC+XYvUQcR5OcOtJg=;
        b=Lc8gvaU7HgAQ0gM/zjUBk2agABGemNidSnLCJ2jfHd1GtKjD7BvTQXVBmVIxu1cwvN
         yms7F2YE7jSnWBwNytNA2PCwVvdm3KgXbFiVRfNKdD7u/JAl7Y/LCcwgEBXCcSon44lZ
         TgteCutnMr+ZeI+Rl+JCIX8OcD6dlf/VK2Z3j8V62jl2iXJ5DAXkoIwTvypFGPo1Td1r
         oCW0T/435ZFa7IC3DopaaKkW71dzuCFsb4Wd7mp/92tyMpfsqTPlvU8uT8yp3mDkyISq
         Vk2goQ4fwb1iSe928+22kgWjbbqgWeQ3raBB4pCL2zSf2W6wv0PdihVIXX72hiDx8iHH
         0gww==
X-Forwarded-Encrypted: i=1; AHgh+RoWFCboRrEC1WvkhHBpUOzzTTy/1QWbNSLNqWAd/ukcttLNi9gfTjbcfsaSR15StoKihF8Fq6GBRd94@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxkkjV90nq3X4Dxx09vELDN7w4BAUY5QkAkx/x1vXEFx8QiVJ
	BlYoafo06bZwZ/R1oHeyzh91428nzS1Nq6QF0azJlttLyVy4lP/qLQnuBu0Cg1Uv17TH8RxYB0j
	SZU3cpPVX6jY7gS+mk45TgCj93pBWAxHS/akYMYdPfg==
X-Gm-Gg: AR+sD13s64y++Q6buIPQ7mmi6kJdoZXjBsktKGXny9sNeri5PphL+xRLzYsZQKZcIx5
	JZHqJUql+sOHwLGZEhxIlMRkjCGe+eedgAiJ06vpHqQ1RuXMDg9GjcMNE0Fc8QK+tioFSNDruPM
	4WDmyaPncSWuERMdzpaBv9iiczbc/kE9IxRrT7qgI2HypXrML8VgM/H/lqIlHUtKUvCjpheKrrV
	BLs9niTICe+O3MQqLZ5p6WcMF0UorAqYCZZ28qgavicTxfwzCbhUDj0SrC5CHRniNU/yYHtQnvX
	NknWXl5Hgz32uwFY286ipn+KDzShwPhdtYg/xgFPQFKhcFATUAP+dTiS
X-Received: by 2002:a17:907:60d1:b0:c1c:3b06:ed24 with SMTP id
 a640c23a62f3a-c210907f844mr169931866b.28.1786604635434; Thu, 13 Aug 2026
 00:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812201915.1783578-1-max.kellermann@ionos.com>
In-Reply-To: <20260812201915.1783578-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 13 Aug 2026 15:03:43 +0800
X-Gm-Features: AUfX_mx9zXiB0sinbSIZ3j7gQJbtLh6t3KQuhjwAzyVbbmskfPWbScO46DO8YzY
Message-ID: <CAOJNxR+7oRunYEwBZwiy1z_5yczK2jz7zN_Rg0CyS4ZNe=LmcQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: force a cap message when a deferred revoke can't
 be acked immediately
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2026 at 13:19, Max Kellermann <max.kellermann@ionos.com> wrote:
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
>   (file_wanted != 0; retain |= CEPH_CAP_ANY)
>
> - the revoked cap is still used because the page was re-cached (e.g. a
>   file being re-read)
>
> - the MDS has meanwhile re-granted, so `issued==implemented` and the
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
>
> This is the deferred-path counterpart of the existing
> `CHECK_CAPS_FLUSH_FORCE` handling; a normal (non-deferred) revoke
> still forces the response inline as before.
>
> Cc: stable@vger.kernel.org
> Fixes: 31634d7597d8 ("ceph: force sending a cap update msg back to MDS for revoke op")
> Fixes: 257e6172ab36 ("ceph: don't let check_caps skip sending responses for revoke msgs")
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
> @@ -1410,6 +1410,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
>         BUG_ON((retain & CEPH_CAP_PIN) == 0);
>
>         clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> +       clear_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
>
>         cap->issued &= retain;  /* drop bits we don't want */
>         /*
> @@ -2038,6 +2039,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>
>         if (ci->i_ceph_flags & CEPH_I_FLUSH)
>                 flags |= CHECK_CAPS_FLUSH;
> +       /*
> +        * A revoke whose response was deferred (see handle_cap_grant()) must
> +        * still be acknowledged.  Replay the forced flush here so that even a
> +        * check triggered by writeback/invalidation completion sends a cap
> +        * message to the MDS.
> +        */
> +       if (ci->i_ceph_flags & CEPH_I_FLUSH_FORCE)

Since CEPH_I_FLUSH_FORCE is now defined as a bit mask and the flag is
set/cleared with set_bit()/clear_bit(), could we use test_bit() here
as well?

if (test_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags))
        flags |= CHECK_CAPS_FLUSH_FORCE;

This keeps the set/test/clear operations consistently using the _BIT
definition and avoids mixing the bit index and mask forms.



> +               flags |= CHECK_CAPS_FLUSH_FORCE;
>  retry:
>         /* Caps wanted by virtue of active open files. */
>         file_wanted = __ceph_caps_file_wanted(ci);
> @@ -3757,13 +3766,30 @@ static void handle_cap_grant(struct inode *inode,
>         BUG_ON(cap->issued & ~cap->implemented);
>
>         /* don't let check_caps skip sending a response to MDS for revoke msgs */
> -       if (!revoke_wait && le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
> -               cap->mds_wanted = 0;
> -               flags |= CHECK_CAPS_FLUSH_FORCE;
> -               if (cap == ci->i_auth_cap)
> -                       check_caps = 1; /* check auth cap only */
> -               else
> -                       check_caps = 2; /* check all caps */
> +       if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
> +               if (revoke_wait) {
> +                       /*
> +                        * We can't ack the revoke yet: the response is deferred
> +                        * until the writeback or cache invalidation queued above
> +                        * completes.  Set the CEPH_I_FLUSH_FORCE flag to remember
> +                        * that a forced cap message is owed so that deferred
> +                        * completion (ceph_put_wrbuffer_cap_refs() or the
> +                        * invalidate worker, both of which call ceph_check_caps())
> +                        * actually sends one, even if by then the revoked caps look
> +                        * unused, the inode is retaining caps, or the MDS has
> +                        * re-granted them.  Without this, the cap message is never
> +                        * sent and the MDS hangs ("isn't responding to
> +                        * mclientcaps(revoke)").
> +                        */
> +                       ci->i_ceph_flags |= CEPH_I_FLUSH_FORCE;

Similar here?

Thanks
- Xiubo

> +               } else {
> +                       cap->mds_wanted = 0;
> +                       flags |= CHECK_CAPS_FLUSH_FORCE;
> +                       if (cap == ci->i_auth_cap)
> +                               check_caps = 1; /* check auth cap only */
> +                       else
> +                               check_caps = 2; /* check all caps */
> +               }
>         }
>
>         if (extra_info->inline_version > 0 &&
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 1d6aab060780..878440a2eb3b 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -687,6 +687,10 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
>  #define CEPH_I_ASYNC_CREATE_BIT                (12) /* async create in flight for this */
>  #define CEPH_I_SHUTDOWN_BIT            (13) /* inode is no longer usable */
>  #define CEPH_I_ASYNC_CHECK_CAPS_BIT    (14) /* check caps after async creating finishes */
> +#define CEPH_I_FLUSH_FORCE_BIT         (15) /* a revoke's response was deferred;
> +                                             * force a cap message to the MDS once
> +                                             * the deferred work completes
> +                                             */
>
>  #define CEPH_I_DIR_ORDERED             (1 << CEPH_I_DIR_ORDERED_BIT)
>  #define CEPH_I_FLUSH                   (1 << CEPH_I_FLUSH_BIT)
> @@ -699,6 +703,7 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
>  #define CEPH_I_ODIRECT                 (1 << CEPH_I_ODIRECT_BIT)
>  #define CEPH_I_ASYNC_CREATE            (1 << CEPH_I_ASYNC_CREATE_BIT)
>  #define CEPH_I_SHUTDOWN                        (1 << CEPH_I_SHUTDOWN_BIT)
> +#define CEPH_I_FLUSH_FORCE             (1 << CEPH_I_FLUSH_FORCE_BIT)
>
>  /*
>   * Masks of ceph inode work.
> --
> 2.47.3
>
