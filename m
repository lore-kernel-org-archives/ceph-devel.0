Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF836A008
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603746; cv=pass; b=n+v7hxhXnkV4IBa80dMDbRtfSOdaDbRcvuM7MOnkjt0jBUgNMEJOSuNfTewZAIBHNnTnEWBklbAkk8sdasAAEbC+CjDhNImMXIiUYAnN3f3hsy4nEaGwdeEMPFxM5LMKGPmkzgL9XPwi183sFA1CLVTEJcYSdwe9pgyFvVWRZhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603746; c=relaxed/simple;
	bh=kwrFk1W5GYQnFmt6azW0Gwu+Itg306CKJgFaYftp4sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWZSbzUxvA9MiSd0I8QOroRH9pTT6pnpgHcv/I7IUw3m27MB1XUCLkF/bW9zlkgVMsB1BSxR6V7foadlq4yLtppp3LN4jiKW0q+yf07E5WWVA9VIzFhiUZa/1UinnmPG2J4C4LYhmIFajZonKgBkTIbXUo2y2bzb2HmbD/4+ncM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=M9Hjb+F+; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="M9Hjb+F+"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso2793392a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 23:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786603741; cv=none;
        d=google.com; s=arc-20260327;
        b=SX2o2TCE1QCfzf9xqyzLp/avhqaIqWIKDUooFUZJouDQ9lzol0ORDwDdF1wU4S9LAV
         hUw7NePkZOIE4VPCtAMO3Lq4T11JMCYcBqrQFuWuc4z5HV0mypnxjmlmxM7lf0A1E/r1
         8F7ikNFEohowd+ilo4rDaLR9QDp2UtmoUVbAf9+ONNN0E7vIZv6PA/wby3VXGUnuh4/a
         KM2UVbi+xGhskgqj2R+WzvPMQQd8KfFb8dMBnUnvzczxf/znliP1m3Lu6FfmbgZSFjwa
         LqRNW4RHOzdq8luu49iw9TaNzQgqwrBAxOHzlnpHiepgZFasSBOcwtnTwmE2rTcQnPX8
         OUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WLAxYc0ECoqtCL+iMqW52lPFCDzkKN7h/d7O0K/EHjE=;
        fh=hV6OU55aaWbdlm7X4bx4YC1yVj2EKlBsmPGgSSNE09c=;
        b=ZXZRLyNMnO8iNGjT3Wfr4q3HJTDo9rkqyktiph6QC6u7u7234bj7rAVeuHdpA72BJp
         FDIcmnsKsrRREpF9KR9bPtlsYbazkFz8S80/owOLmaiOl+z3mD20cf99OPDK3NstAtJ8
         3hBj+YkiqOcCBvYV1P2G4r9h9YssTHbrfNYu/TNGhOK8L2lTLzY0Aogv8EYl/e4vpliL
         XWcz//4YezLfah42gW4rwPZDsVnP+eYRGlOo9b9UQYQyHTHKPmVuh52rbv+Nqz4oPC08
         eVg2CEys/2smEcLWYjsgF+9TRXUwRKfTij6Xcbj5UkW+d8Ag64tk14iIOBL49+dJp4Uf
         Avig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786603741; x=1787208541; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLAxYc0ECoqtCL+iMqW52lPFCDzkKN7h/d7O0K/EHjE=;
        b=M9Hjb+F+ANh6JQb3JNk0U5o31/kWCyh10gfYCM0Ws4+ZH1oPARJ3y4l7mg3UAqfrj+
         r1cH06u/QCsbm0nsJ9f0Cl8ge5Rx6pRhkwItW0r4/UQGObw9hZ0vqyDkIL1EYsuh/G3e
         RtArOzrw6ByvHcj5FDtrpThTnQRADzehKTsVaM2Y4eeZT41d5a7G1SxTxVgKMqBqiQju
         xDxKCxqZhh1MGgkqnowMOHnkVf5KJzEy4EYTmpAQT7B1+Qbq7BoLf4jH4X3mGU01uY88
         TXqEgXA9Xq4Z12H0A3+G8kFPzXJwx4ydpElGj+Kxe48HTFfTuzrXUkkaVY/GFihRoBsx
         nLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786603741; x=1787208541;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WLAxYc0ECoqtCL+iMqW52lPFCDzkKN7h/d7O0K/EHjE=;
        b=Ax1bKNuKTRTIBszUYQmGgMlFGShufrvJBeS0viaHREswjwV+kFJd0QFeMkAbnCBZaG
         gLGrL/jQ0zU+CkGBJPoiq9xry24tn+1amPYyLWfCpO3wmMtoPJ1TIIzkrjuAZ4+3Kskt
         XV4zgAJVk1Uec0XYWQrlE5M+loIIH8AE+xfMog81rVPZEewVpdznZ4L0/Z4r+fgkM8K2
         XtaWHKhL2g5BYGmvLtOuYK3ArDRnJhwRFcpOX0pw39wH16kwglOCP7kAjy4yB89vuiJC
         flJnHcQdSo7i5cYNdgHl8bXjAbYzZnXzOhoeBu+c4c3xlyBpYyZwZpEa8lfbMNUHan/8
         LzxA==
X-Forwarded-Encrypted: i=1; AHgh+RoGvs6hkN8asVX+QuAqmvTkwZ0fmcdBVeoM7g55lGkP90qRIKFfcr54DdM8KwHxJ6XSsAI4QsW0qRSk@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxz27Onk6nEsIq0kOSLSPPPudQsaaeYPhadHxDAkIFcwGFLkT
	VwyFc8lj0Hl4mpnMSrgNPQ1td7MoQvK+UMDdkCNkQElgojd0Zwt/Fp8YiIqduNXfx3+W2A4yqX0
	mg+mehqSqZAN9lZpRuOxxpBqh/DWptlF9Pg3Faowfeg==
X-Gm-Gg: AR+sD111SrNr6p5GfaYIdhCCztMZn1l7+3mRwa0vu/Jy/FfPmslUohL7yfOJ+gvD0iX
	9i+YT4RgDIHneSeGoP5cW6g+R+6KX33s1Zz7g/gK9GTUaL7J5qO8OmtvJNcyqmvnEejLpecMS4k
	uoOvTpTqFUfRfYpcFxg1kofGQeVxIVkQj7ONAZiPnsRDRMMdEh/a00fT2x5cm98YU3HH/RvlBfN
	Qyv+fruiEUWopqeooPOckfofwoAMM3thwA7pD1puIxPZVHPJsppMEZz67gX4K6n+uTLCO8BveGh
	Af3pKbvChagtOxIRJCEuYCF7OgXW09pTrTG64VcfczCFeHatGi4geUso
X-Received: by 2002:a17:907:6092:b0:c20:3733:a8c5 with SMTP id
 a640c23a62f3a-c2108dfa531mr161205966b.8.1786603741507; Wed, 12 Aug 2026
 23:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812171321.13112-1-matthew@bargrove.com>
In-Reply-To: <20260812171321.13112-1-matthew@bargrove.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 13 Aug 2026 14:48:50 +0800
X-Gm-Features: AUfX_mzCOujvIRjQu-mmV0P453mym75w-lXp4yK4eb4vq8BiK2nmT1yiNExZBP4
Message-ID: <CAOJNxRK3TO_qQWGf1NdVADkRSmJJHGTx+GaQ25uLqWoPcycSYw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix leaked inode reference on writeback abort at umount
To: Matthew Brown <matthew@bargrove.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

On Wed, 12 Aug 2026 at 10:13, Matthew Brown <matthew@bargrove.com> wrote:
>
> ceph_dirty_folio() takes a wrbuffer claim on each newly dirtied folio: it
> bumps i_wrbuffer_ref (taking an ihold() on the 0->1 transition) and
> attaches the snap_context to folio->private.  That claim is released only
> by ceph_put_wrbuffer_cap_refs(), which for a submitted write runs from
> writepages_finish().
>
> In ceph_submit_write(), if ceph_inc_osd_stopping_blocker() fails -- which
> happens during umount -- the request is aborted before submission: the
> already-collected folios are only redirtied and unlocked, so
> writepages_finish() never runs and the claim is leaked.
> redirty_page_for_writepage() -> folio_redirty_for_writepage() ->
> filemap_dirty_folio() sets PG_dirty directly and does not go through
> ->dirty_folio, so ceph_dirty_folio() is not re-entered to rebalance it.
> Because every subsequent writeback also fails the osd_stopping_blocker,
> i_wrbuffer_ref never returns to 0, the ihold() is never dropped, and the
> inode cannot be evicted:
>
>   VFS: Busy inodes after unmount of ceph
>   kernel BUG at fs/super.c:650!
>
> Release the orphaned claim in the abort path before redirtying, via
> ceph_undo_wrbuffer_claim(): detach the snap_context, drop the wrbuffer
> reference (letting i_wrbuffer_ref reach 0 and iput() the inode), and drop
> the snap_context reference -- i.e. do what writepages_finish() would have
> done for these never-submitted folios.
>
> Only the locked_pages entries are undone; folios still in the fbatch were
> never dirty-cleared by this call (folio_clear_dirty_for_io() is the
> ownership-transfer point, and a successful move NULLs the fbatch slot), so
> they hold no claim this call owns.
>
> Fixes: fd7449d937e7 ("ceph: fix generic/421 test failure")
> Signed-off-by: Matthew Brown <matthew@bargrove.com>
> ---
>
> v2:
>  - Reword the commit message: the leak is an orphaned wrbuffer claim on an
>    unsubmitted write (writepages_finish() never runs), not
>    redirty_page_for_writepage() re-entering ceph_dirty_folio().  Thanks to
>    Alex Markuze for the correction.
>  - Convert ceph_undo_wrbuffer_claim() to the folio API
>    (struct folio * / folio_detach_private()), per Alex Markuze.
>  - Spell out the locked_pages/fbatch ownership split in the message, per
>    Xiubo Li's comment.
>
> v1: https://lore.kernel.org/all/20260808101425.49616-1-matthew@bargrove.com/
>  fs/ceph/addr.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index ecf33b6..e9f561b 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1426,6 +1426,16 @@ void ceph_shift_unused_folios_left(struct folio_batch *fbatch)
>         fbatch->nr = n;
>  }
>
> +static void ceph_undo_wrbuffer_claim(struct inode *inode, struct folio *folio)
> +{
> +       struct ceph_snap_context *snapc = folio_detach_private(folio);
> +
> +       if (!snapc)
> +               return;
> +       ceph_put_wrbuffer_cap_refs(ceph_inode(inode), 1, snapc);
> +       ceph_put_snap_context(snapc);
> +}
> +
>  static
>  int ceph_submit_write(struct address_space *mapping,
>                         struct writeback_control *wbc,
> @@ -1489,6 +1499,7 @@ int ceph_submit_write(struct address_space *mapping,
>                         if (!page)
>                                 continue;
>
> +                       ceph_undo_wrbuffer_claim(inode, page_folio(page));
>                         redirty_page_for_writepage(wbc, page);
>                         unlock_page(page);
>                 }
> --
> 2.44.0
>
