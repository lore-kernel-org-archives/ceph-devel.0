Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469F4DEC08
	for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410004; cv=pass; b=HpmrJG7/8ClTmb9bp85aKtmCbf6bklahco7hEYqerWs4CWcEwDDxGS+rMkkC6thOOh6vBK8l2W9lrv1MnSjytgdBQUyz37HudCfCmFc3dS6ge6LlUk9aArPLE1YLi7IiJ9UbGH7FTuGyxXPjE1AzL09TSRMFYr2XtjJAslg/ORg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410004; c=relaxed/simple;
	bh=cu/fzzRijQ+u6vzeeclSie03z58e3zGOZFpuat5uD2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLU2qUv57uMYwHEgLzoR8IbgfaOaTr7ccS7ZEz7LyZMa7LRMVUmsJaKrxYG+XdJrFN/jfVo7pk9PETfOaitbgPTNNyJhaAVIrxnuLP0Lo59RBc4fRmIzEWx7DyNXcplingKM3YrjxCHXqPMnS8J6u+ozwjsi2KP7lLTCh+GStBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=H8C3lPHR; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="H8C3lPHR"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2692884a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2026 04:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792410000; cv=none;
        d=google.com; s=arc-20260327;
        b=HBiJjDYmhOyVvIzOPgwjRjZZfyt3ZxRMpVTxvvt3S0Qz/fnPIMfkvzjQIozRgGRClu
         1DQpkd2yCZWt/25j8LnOxrUkCzCInbgXxDCJ3AVYQg4hJp1JtV7bOR0UWL0h4XaCpTVz
         L7DvP/G5S/e6JHe4tJZRi03r6w8hJ9jbdl5mFCu43uhoZwZfwEu/CJv7062ngB0y08nH
         LfEOhX7NqnIAg08zAz02aHN8Mi//E4B+HL7Cv0bPIasjiol0uNqjajibJW+2DkDO5t3J
         W1WiluGZlYQ12Gert3IytUtcKw7CcZklwluEt+pwk0GdfQ8gu7MrHd3DjdcI1ppjdass
         LtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3SdCIbsw0UKolWrHktaP57PlIE6jDh4bZ6F76CBNyZk=;
        fh=6Np+EIAifSC62WZ8xcfsGsMmnEoYAIJ5YImpyKolce8=;
        b=TksMyHuVjAL+0SdbdGHGPmidM4RSbVglcFbIOnaeDENqxEldxFYiEcPk1UMJvDAKmf
         ftjFjmBjgwESiW3BnXR1qsxPH1f/99TStL+CbviYgruFelhLPEhA3H8HZ+kqhNAJHBkB
         klDmrFNe/fu/cJTTkDOK+yA2qYiukkOlQEs4URSSNfZujxpGZ03gxwP2y0TzP9kW90zy
         0RpIsFOP1BrsKUD0g6qK+UGw6OLWaWW5WogGQJKZfD/9Qpj5X/MNtAVNNfCCUdJbiAKn
         ZkjvBlZyok6LeFtEu2O1JAQGFrw1NBKch6LLwrEIYVXNyeC4BYFzk5bPYgYwzOYd5lGm
         rtdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1792410000; x=1793014800; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SdCIbsw0UKolWrHktaP57PlIE6jDh4bZ6F76CBNyZk=;
        b=H8C3lPHRwyFiGNdJY2JyzhSNT0qykKPA3zYKXSDeya5FSDNkWjIc4Y2janQAJN+66c
         lWdidjesm08SnbhP5GXVQVfm+P/PjGqjzDJyc4H+LWRCaZibLaxCStpPcmY6yxrw6m9X
         dNvssKWREKgICp5wzhkBWxC+KEmf4bDIwvar4l+8vL9X5F2QjR6M32Az0NkWHNUyeqRR
         V/hJIOjVy5PH+t1DPWGv9g4qnP7x/Xu+HARrbU7y2ffvSLjvD/QFa9D4aGy1Oolqycof
         L6mgk3+NtoSWLc4EbStNSWaRvyxIHnPe3XC1VS1BHUSmTaMS/yWbv1/2acaHMWzBfURR
         6qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792410000; x=1793014800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3SdCIbsw0UKolWrHktaP57PlIE6jDh4bZ6F76CBNyZk=;
        b=mPVEx8dvcQGegDJ9wT9GcUnGuSqQfVrgMZVepzrYyFfpmymQuSKWVaJji0fNI0VL9D
         DjMNS74JYy+wkma/iQCfvF4Sz6Vy+1TPTUKnOxbQWzBrB6gGdTHvhXJra+x/C+8pHbtD
         tXoAk4loLwICVF6hYfcEuwibWXNqvkA3bgGUdGrn9GXyXi8PRzl74+Q29FIPX/E19cmT
         t1lDCi9BtWpAZlERkpo6XI5FjIKphJsFv9RYxxVNL7+4zd4bY/wkVAb5QpYKJCch6wzF
         9ZY0+6OyJdyggwl6MfaW47e+fqFSy1WBujysFjMOZT5LO+Ad0sJ882Vvqlcc86q/B7wQ
         ENYQ==
X-Gm-Message-State: AFq9FYI8cUrFqzD3Gy4D9NPfLkNvIWqfAiXvmyWvb6FcJQPhYMvkc95T
	7Gqq/BIkA9+Pc/9nXkUleeA3jtX+etpsMdD8IsfQDnPlL8NgfucG/RJ8WygGarfloQ6dZ6BHM5E
	rMZLDuWL6y4m0P1jfb1DXcuqK7twXTYxNvmgfNXObWg==
X-Gm-Gg: AYBFou3pwhrNiiYctRHjKGkcL4sM5EWAh8W7G63Kyq1SYdJvJ/rALJNi0JkfySrg81x
	wIVDfETBHndgQkbcLsnOleYGUboLtcImGI8AVfkh6GnmkLLGItUGqZ9Sh6BZy560y6P1jJBff/6
	dTRuUU0lkn6UizvYSRuMw8KkLpgr9m5RRMmJcONY9LKCogwnX0aBP9dUdb2K++dzAIlX3E3FXlE
	PFvEIh6U1jRVEY2M51+30qgCLWW7IFbKAbHL1Hb+3nlAsdq2c1jOXXGM7QNiThThx2ogH1zHVg1
	L60ogI9f8YYVKmyAmhuPrRlebkpMZP/IOCAUjlrAZOWmjkLGL046s+Kq5Q==
X-Received: by 2002:a17:907:7b85:b0:c21:1b58:fa96 with SMTP id
 a640c23a62f3a-c419a93bd77mr492376966b.3.1792410000467; Mon, 19 Oct 2026
 04:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015061805.3366-1-kmehltretter@gmail.com> <20261015175056.156195-1-amarkuze@redhat.com>
In-Reply-To: <20261015175056.156195-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 19 Oct 2026 13:39:48 +0200
X-Gm-Features: AclHuK81oh2PIz-ZpSepgDb69ienFAWOTjMrg64KX0wsxApbEC5ZVuDGvH5rzuk
Message-ID: <CAOJNxRLnX7O0XVBsW0RSu4hAgD002=9w1yr=XAr=ynwuP=OuCA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix uninitialized err in ceph_netfs_issue_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Karl Mehltretter <kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alex

Thanks for the fix. LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

BRs
Xiubo Li

On Thu, 15 Oct 2026 at 19:51, Alex Markuze <amarkuze@redhat.com> wrote:
>
> ceph_netfs_issue_read() declares err without an initializer. On the
> unencrypted, non-sparse success path nothing assigns it, then the
> out: label does if (err) netfs_read_subreq_terminated(subreq).
>
> With CONFIG_INIT_STACK_ALL_PATTERN, err is 0xaaaaaaaa (nonzero), so
> the subrequest is terminated while the OSD READ is still in flight.
> netfs then frees the rolling buffer that the OSD iterator still
> points at, causing a KASAN UAF / oops, and finish_netfs_read()
> terminates the same subrequest a second time. CONFIG_INIT_STACK_ALL_ZERO
> hides it because err happens to be 0.
>
> Restore the err = 0 initializer so a successful submit leaves
> completion to finish_netfs_read() only.
>
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index dd2bd8ed2424..55226eecd090 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -392,7 +392,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>         struct ceph_client *cl = fsc->client;
>         struct ceph_osd_request *req = NULL;
>         struct ceph_vino vino = ceph_vino(inode);
> -       int err;
> +       int err = 0;
>         u64 len;
>         bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
>         u64 off = subreq->start;
> --
> 2.34.1
>
