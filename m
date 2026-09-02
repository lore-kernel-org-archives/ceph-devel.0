Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872C4A0EE8
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356690; cv=pass; b=Ld/klnM7frGF1vxajcg/0MArA+EJmsKOIAk24K4/PFj/WMhCuxZ3hRz1yJfQ1q7hf3pIWQpN0vpBPkArym0h0hnF8fj1ztO75nHpHN26vpzlVGz90fxu6LgWyaKNAKJrOvbllhrsek/QHjSJ//yCUJufjv31+lCJkkN17T1b1/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356690; c=relaxed/simple;
	bh=1FmV1x5QxFOQdXdzoayVGJUSKQjfwQz5XyfnM7vvKJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy67MIyp5cv79HXiGB5PClFIWOAuF+w7Vo4TyZNPUtTPEWpkTSsb9o7rWp9+nzNWS3FUaO11EsIudUq3nV1hTJyBh3l64rHIEhSYbBvs8YhIZCGheSxmik07mtiuuGuSCzL19jzONZtAwnhEBURawzrNlDojTDR1FbjTmGSujpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY+flS2A; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY+flS2A"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97cb310ae18so689401241.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 06:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356687; cv=none;
        d=google.com; s=arc-20260327;
        b=kDE9eC9lfULmeQQakwn6X23ZkYcOLoyDS1W/Zr7bMEPJNBaDtW0AeI2re6fGSvCNcP
         D+gvhtRA2Ecf4UlmBrAUjP91ArYFWyQHBwZXjxOWbyvePa+j+BerCbkvhtkZpKId25/X
         Aj4DYXKjPFOz5DKMvnTKc+a6fg9rs4hr1Txld/bH5sQH2p4FmNWawAYVnO4uPJ98kS8O
         u80IMJm/VzYSlDpEWjpnQ+7shM3iCkcyRKxVCZEhnbN34QinS+fZg/yA+4wl4nWjwoVR
         yjRktJ6Jagy1Qe/VlcQOzAzR88l6Nf0jAe1tj8WYunW4ObxKJQwkUp2655mjcdznXwKY
         KVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dSC4i56GDCKpLLN6Iph6zr29jWx7mFCg/VcjlijsBo=;
        fh=41STBCh/PMlZwiWQ/DV871DRJjphSmukUeTMq6z9aoc=;
        b=F/Bw5Tva5sx35TrYyYBOy29pQzC6mqYKY4QNNhXLdB1En1rUbZBfBcjVi2v+rz9ccc
         LoMzX4adgUjkSu1jDqejr9MtjbVtZjtuRfm43nlsbG/0LNipJp+OZSXXyh0IflHIuEdw
         hBmharpsI7mibZALhm6dUEupyVqavKwhNCd7rnKK96K+KJv3EI/vD6kpat5MbcDIPWfg
         PJgZga3DNjyUHmP8w7rF0a2cl/Mnz6LZsB8wMoU1jFZebaNPGozCTUPT+nviGzn6TmvC
         o87qAnpnIo19zbwck1NfwZiryFXKcAveN/mNbr/xNLZWP+rV/8+0zIsjOH4zbP4QpFTK
         B0rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356687; x=1788961487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6dSC4i56GDCKpLLN6Iph6zr29jWx7mFCg/VcjlijsBo=;
        b=PY+flS2AYfW7c/WsVfXXcq47PSXzkHnQBPWB0DQgi2h+hlmuk+WNQ9IBLbzYDXTcW0
         OU1UykZC/figLH82QQvgmAL9gNw986FHtozNGKTjJs2SqYE/2GKXAph+bYJ5DO+07LOS
         gyj7yTEw7t4oskT3O4KWDtjEOH0gGjW6iDaZaRw7nve8utJhK9rMDXzHUlgsBhTEM3bg
         5GinnynACF8X4VQXlWEDRFPm4DezYMFFlCyM9/TGFPul4EeARD+XWgqNYf92xvERIQXW
         KZv2ZP34kUyLQ2fELzlfTtYdETRO4s+k7PzoEjbrqbAw5/6e8zBqz5TMNR6UHnifhLZo
         VB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356687; x=1788961487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dSC4i56GDCKpLLN6Iph6zr29jWx7mFCg/VcjlijsBo=;
        b=Dxw6EO7013C86rwOeLH8UmttDYNJB8wrnlhaSxRfxAo1gGHg+7fzL0zBB4/Mc/qrxj
         AVvoKVMd+Y/4w6mC9NiSS8+vGa/fRN5lR48FFffYAJ9ur/WlBpIU/G/ZYgu/YWDMrOg2
         p80LDFvCbkEPv90iyWVahR8+N0rJMccZx2p8C4hkhkAYG3F3PXyot0TFgRPX2pFBwqj/
         Z2fL3go7aqRAzDfmiBpMzEwmNpDeW+bhZmttUKvaQifPj3HWWkVkc8tkvBARuUwjClKy
         pIrPDpDo9cc7TWKp4M3ltbJ4RJKKl29HI91jHS2NbSPi8TJsjh6PhQhoohq4zONafo//
         Ctog==
X-Forwarded-Encrypted: i=1; AKwUvBwN8QmAikfF1u3xRei9WB1mr6UlCUAgRnXHMoLy679VxlQg875kwAn1c6pN7I+56Dfv0D/lO5PCTxQl@vger.kernel.org
X-Gm-Message-State: AFuF++lC+61fwHw7hvvJ+mlsrCdHKywHZfik+vFE++xaifASak8nL24L
	NezLITsFqivngmPLUwSq9vZI0jvMAf53Im/Na9sUnRgOO9oyXQsvOQOx6VSvZzwAMlp/dV40rVS
	VGVOT1+8ULON9NFU/a0wZw5RW2eTzG+Q=
X-Gm-Gg: AYBFou1acdhfna3ZeNBf4TNKweU02drzcobK4iO2Ua7otSp4d14QFX30mDk68MwUo5+
	RM7N6cRL7rgm0gx5/7/JMp0wd7YvDJsamEnRnK2J+NKfm4F3Mij02IA6r4o4TBKsdReGQAci1wk
	Dg0vUkK/sRXHIc5ck9k/5Z5BD9BErRRDyxDHBqapkc2cNYrwnNuacMTCEOuWDqCSEHkngAoUEsX
	N20R2xPbyEW/7RUeFVhywoufAAfCspPV1yZpHkWl3SYwsyWGbL89LovHUWJgbQe0rIRoFHDY6Tq
	D0pZZF4V8VTDGI661fdIccGGLRdSsO2Mvebrlt7a+T4if22AFdduE+TnvC8kbJTH0+KePYaZOaB
	Jkayx
X-Received: by 2002:a05:6102:41a6:b0:779:328:8a2e with SMTP id
 ada2fe7eead31-78a1f725fc6mr950132137.5.1788356687181; Wed, 02 Sep 2026
 06:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
 <20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 2 Sep 2026 15:44:33 +0200
X-Gm-Features: AcwNN1Vvf7FpyU1HrqjBI0mng4bI8rN-Wlo5S9DqsAbNDuh3hnayuNaPhBcoE8o
Message-ID: <CAOi1vP8SCZaFTodwm3_c9cFfc4UB5X8J8vF-sxh+4TuhCS8iog@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] ceph: fix error handling when the OSD client is
 stopping in ceph_submit_write()
To: Tal Zussman <tz2294@columbia.edu>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 9:15=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> When ceph_inc_osd_stopping_blocker() fails, ceph_submit_write()
> redirties and unlocks the folios remaining in ceph_wbc->fbatch.
> However, none of those folios are locked at this point: locked folios
> were moved to ceph_wbc->pages[] and removed from the fbatch by
> ceph_process_folio_batch(). Unlocking them triggers
> VM_BUG_ON_FOLIO(!folio_test_locked(folio)) in folio_unlock(), or
> unlocks a folio locked by another task.
>
> This error path also returns -EIO without fully cleaning up the folios in
> ceph_wbc->pages[]: their references are never dropped, fscrypt bounce
> pages are never freed, the writeback congestion count is never
> decremented, and the pages array is leaked. ceph_wbc->locked_pages is
> also left non-zero, so ceph_writepages_start() loops back around and
> hits BUG_ON(ceph_wbc.locked_pages).
>
> Leave the fbatch folios alone, as ceph_writepages_start() drops their
> references when releasing the batch, and unwind ceph_wbc->pages[] the
> same way writepages_finish() would have. Abort writeback in
> ceph_writepages_start() instead of continuing, matching the handling
> of ceph_inc_osd_stopping_blocker() failure on entry, as the OSD
> client is being torn down and further writeback cannot make progress.
>
> An LLM was used to verify that the cleanup was comprehensive, and
> suggested aborting the writeback instead of continuing.
>
> Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260804-remove-wait-on-page-writeba=
ck-v2-0-81f0ab065284%40columbia.edu?part=3D5
> Assisted-by: Claude:fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 1f77aec8e960..d5a349daf4d0 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1482,27 +1482,28 @@ int ceph_submit_write(struct address_space *mappi=
ng,
>         BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - of=
fset);
>
>         if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
> -               for (i =3D 0; i < folio_batch_count(&ceph_wbc->fbatch); i=
++) {
> -                       struct folio *folio =3D ceph_wbc->fbatch.folios[i=
];
> -
> -                       if (!folio)
> -                               continue;
> -
> -                       page =3D &folio->page;
> -                       redirty_page_for_writepage(wbc, page);
> -                       unlock_page(page);
> -               }
> -
>                 for (i =3D 0; i < ceph_wbc->locked_pages; i++) {
> -                       page =3D ceph_fscrypt_pagecache_page(ceph_wbc->pa=
ges[i]);
> +                       fscrypt_finalize_bounce_page(&ceph_wbc->pages[i])=
;

Hi Tal,

fscrypt_finalize_bounce_page() was removed in 7.3-rc1, so this one and
patch 8 need to be reworked now.

Thanks,

                Ilya
