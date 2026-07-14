Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463630F927
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002146; cv=pass; b=LbDtxI17a6Sqed5N1V6wdrIoSz2Np/vfek+g3rfOBLb7qT7n1rHdkSTchqHXTO8imFTJjuTFWNK2ivrxfnzbo2cVHl6DjcxWmZB2lemOvHsk/uB47IK5pb+E1FjafABBQ/um03HokH3w0u7lTQDjjSYvhy9xbbkf229sq9cR96Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002146; c=relaxed/simple;
	bh=zArSiRvxK91b+qFLo2B+VEZcnSC/0u4E7lOGYtMJljs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxka6zLtKxT/uJ1PpVbZK48CFi8HxhUgXa06Z1pRFAU39DdGpRZmpCcLGq7nmpiXoGQZ4A5G/pEoYt/0dgkzp4wCYLl88HYPFpTEbuPGIXTvfY0K6piHYhLNHpDG4mAqMdlQZo2mQcsNo8jZftbWnSX6vusba7ihY79I4M26imQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=ZYhOv18V; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="ZYhOv18V"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c7697d523so719634a12.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 21:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784002142; cv=none;
        d=google.com; s=arc-20260327;
        b=R8p3BsycLA7hp9NyjU8HC5Gpfezn77Mt0yCVpFUzfDNJTvDdYydQ3YsBFJJ5uN+wxm
         rI8xi2sn9F26qEodHLrS7V4Vatjd1Qm0346KAJZlB2BwPPuXah6CrlkXlo/50jNsqjTN
         fMK9EFPYZr8Ua17fRbqYQrqn+5bmWAiJM4r4fpup6Zuylcv7aM4z+SahkCiUTMQKtmqv
         RWxqysegvbXu8eniw+yXWNNYyWujgh0ibsdbrGvhFddR3uwZU6kZv+fW/+twxWG97OCa
         3Xp0LG8F+Chzwl3+oCXYqs31pEcjMSHp2x3WxBfH9kZ1JSKAwmPlESssQo+CPt8XZJpl
         9geA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AUBs2L9BLB1DcAFHx0eRsOx09PDZaWi3/lujG8oI+u0=;
        fh=QakNoIeExC3YD1Mwx7BqTBiwNoySi6Sh1/4FibovBYw=;
        b=NmZw6aiGGTrxcK0NxSeq4Nw5WAw3tUrV1g6AGchUSvPautbpubzKOOY7/gGe2aVprS
         R6idJzGbKG1NLqW4XlhEYtTaTVw2uxJFuCDutah2GT+NIIvApQ5p8KprZawsFSa0wkpH
         xhKPafRclAzMHk0IaTYWueWkoqMkH2op+weOxmkaG8X6nMruW9HbdjxtdKYPC8zRKnXz
         YIe8zrHeud7qKm+lG/HRfehkfGzkb+fLfQbuk6dYuuThboIQC/iyGkqn/SXospOyKUOx
         53z6h+9PG3s6RwBJoJ9Bk/05YP9a0k5KvqR+w65Osv9iLKL5SyiYiCYfTgSZ4k20uBTN
         Sn1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784002142; x=1784606942; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUBs2L9BLB1DcAFHx0eRsOx09PDZaWi3/lujG8oI+u0=;
        b=ZYhOv18VJ7fbMdjZ675yRH3UG6hI0BJxTcNExP9k9N73ndb32yUAQKpaoo8h0CURvN
         Yz4eYw7NVKryMjXqsuHtF2pSpXfOEoGQBmJh12ehAFSiQT5lHdVNX9UVJb2PBCTTxi3m
         CSafYWpQ+IOw5J5IMGAF0QSg53H3l/b/9Wye0nlrwIzAoLj7CzUWotFpSjLmhnRC5euV
         pLENNTDlUNRNAf+hqsf/DWWJ0YjxgdEc8dIX6TceSpxSDW7H8n7MRJUB5KlMF5Smh0+e
         ZkjLLIL5S1kM6R42rabBsvvAP+/NR4adztQOjaaB41jbaNyG26lcX8o2smaQfLY3pOQ3
         I0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784002142; x=1784606942;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AUBs2L9BLB1DcAFHx0eRsOx09PDZaWi3/lujG8oI+u0=;
        b=EQxyzpn5/moCUYnwbGGXDjo37kbxwq1EXgKu6KNGQBVDZ1dw2stVZbYNGpCDk8/AZg
         JguZOSkoP2wQh9fdOIaKV5XwUJkHSoGExlom5jW4pOxZvveKehbZx+o5uCAH+w/amiNB
         AeWzoOsNxpVeQOYPcdIJm9tot6TnIgwXaIlh4QYwbol8mv32BXCQtbiaUV/pfVurJU3P
         sZgk2TCdg/QAGWbK8orlsa8FfYPvAVQ2TcbeBkOUfOit3SnZMNHrVB4FZNOTMyo0/Y6b
         FWFvNn7SwWkfaLFw+iurOKoI03o8PYdZaWaf6i+mq8z9/AQlQPFdiHvX2m7lP6r3cFV8
         8WeA==
X-Gm-Message-State: AOJu0YzFzHAeHu4SXvUTf4IdXNkc6apnZzMGS+eiBZznCBRrLxDGIrOa
	mLV/VCcx0qEkbeJ9dY8OZdWMfbNVA1gEwOcpcQQfw2OGSWfr/YWUztxsR0vl2hBYvT6pQUT5Jl7
	JT/mvZbshff3BLUFkURqj7SxzVxXyWuOticgyocEmgg==
X-Gm-Gg: AfdE7cnG5NvSGuSreNdVyNFGbq34+lRM2JfImF+hOrvwSZpN7N7CZ4PXaBr5nlWxAz1
	aX3tdcHdSL74vEsIEHFvPoMbPf52bl/hNWEpUQLqwij2Ao5x9Aau9JPioMKrl+rt3fkH0h+nZX+
	6E2cYF0/H5zgVSySd88dLHzN1gOoAQXD2SAY33J+cCSigV9Jz49FsP5cZBysd+mmmfgU42Wwhsw
	AAfNYNrBjhwSbELtuTrzdKHkFx9O6Kk4+Mbijlrc8WkMC034LOD+dU4px2sJ0UTwkIuPA==
X-Received: by 2002:a17:907:3e1a:b0:c16:358d:df3 with SMTP id
 a640c23a62f3a-c16358d0fecmr432592366b.63.1784002141814; Mon, 13 Jul 2026
 21:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143843.1980879-1-amarkuze@redhat.com> <20260706143843.1980879-5-amarkuze@redhat.com>
In-Reply-To: <20260706143843.1980879-5-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 14 Jul 2026 12:08:50 +0800
X-Gm-Features: AUfX_mwSxlFW6Aec_-cehIgGDDDg5dl2cCVrouMgU_Xipmd3cTD7iaK8yb0uPyI
Message-ID: <CAOJNxRK+Y8LwbiccNtF=n-+wKPEz3ap2tLNT8fiRXmVkUNVQgQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] ceph: add BLOG magazine batch allocator
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jul 2026 at 22:38, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Add blog_batch.c: per-CPU magazine batching for TLS context recycling.
> Freed composites go to a local magazine; subsequent acquisitions reclaim
> from the magazine, making the common-case log path allocation-free.
>
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/blog_batch.c | 312 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 312 insertions(+)
>  create mode 100644 fs/ceph/blog_batch.c
>
> diff --git a/fs/ceph/blog_batch.c b/fs/ceph/blog_batch.c
> new file mode 100644
> index 000000000000..6daf853b8201
> --- /dev/null
> +++ b/fs/ceph/blog_batch.c
> @@ -0,0 +1,312 @@

[......]

> +/**
> + * blog_batch_init - Initialize the batching system
> + * @batch: Batch structure to initialize
> + * @mag_cache: Slab cache for magazine structs, or NULL to create one
> + * @nr_prealloc: Number of composites to preallocate (0 = none)
> + * @retain_limit: Max composites to retain on put; excess are freed (0 = unlimited)
> + *
> + * Allocates and initializes the per-CPU magazines and global pools.
> + * Composites are allocated via alloc_pages() in BLOG_MAGAZINE_SIZE
> + * batches.  Pass nr_prealloc = 0 for batches that start empty
> + * (e.g. the log_batch).
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int blog_batch_init(struct blog_batch *batch, struct kmem_cache *mag_cache,
> +                   unsigned int nr_prealloc, unsigned int retain_limit)
> +{
> +       unsigned int nr_mags, i, j;
> +       int cpu;
> +       struct blog_cpu_magazine *cpu_mag;
> +       struct blog_magazine *mag;
> +       struct blog_tls_pagefrag *composite;
> +       struct page *pages;
> +
> +       /* Initialize counters */
> +       batch->nr_full = 0;
> +       batch->nr_empty = 0;

Possibly the aboe initializaion code is not needed since the logger is
allocated by kzalloc() ?

> +       batch->retain_limit = retain_limit;
> +
> +       /* Use caller-provided cache or create one */
> +       if (mag_cache) {
> +               batch->magazine_cache = mag_cache;
> +               batch->external_cache = true;

[......]

> +/**
> + * blog_batch_cleanup - Clean up the batching system
> + * @batch: Batch structure to clean up
> + *
> + * Frees all magazines and composites, and destroys the magazine cache.
> + */
> +void blog_batch_cleanup(struct blog_batch *batch)
> +{
> +       int cpu;
> +       struct blog_magazine *mag, *tmp;
> +       struct blog_cpu_magazine *cpu_mag;
> +
> +       /* Free per-CPU magazines */
> +       if (batch->cpu_magazines) {
> +               for_each_possible_cpu(cpu) {
> +                       cpu_mag = per_cpu_ptr(batch->cpu_magazines, cpu);
> +                       if (cpu_mag->mag)
> +                               free_magazine(batch, cpu_mag->mag);
> +               }
> +               free_percpu(batch->cpu_magazines);
> +       }
> +
> +       /* Free magazines in the full pool */
> +       spin_lock(&batch->full_lock);

Is the lock needed in cleanup ?

> +       list_for_each_entry_safe(mag, tmp, &batch->full_magazines, list) {
> +               list_del(&mag->list);
> +               batch->nr_full--;
> +               free_magazine(batch, mag);
> +       }
> +       spin_unlock(&batch->full_lock);
> +
> +       /* Free magazines in the empty pool */
> +       spin_lock(&batch->empty_lock);
> +       list_for_each_entry_safe(mag, tmp, &batch->empty_magazines, list) {
> +               list_del(&mag->list);
> +               batch->nr_empty--;
> +               free_magazine(batch, mag);
> +       }
> +       spin_unlock(&batch->empty_lock);
> +
> +       /* Destroy magazine cache */
> +       if (!batch->external_cache && batch->magazine_cache)
> +               kmem_cache_destroy(batch->magazine_cache);
> +
> +       batch->magazine_cache = NULL;
> +       batch->external_cache = false;
> +}
> +
> +/**


[......]
