Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685B43F4D6
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608734; cv=pass; b=PbzUliDq9KWV7c4QYyUmvdQP8nTZq7ckZnr8UNA2yV5cOc+O/3fl1MfELfgRYud7y0mBFrULPOGqfWgzmGK92lIMw4FVyoE/pYt5lPMWiVw8S3LT3tgzdCFqfFzI86GB6zJKd0InuciRUJ3xqPpwmitRIPcIXYw+/QsDm4+TBVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608734; c=relaxed/simple;
	bh=Ka7orBL80bSdVxmjeIp8Xw+VKeAYaow2X0E0mfZXe8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXk96SkzDXl7NYl7bGc7XTqlMlqLz24WFwCruL5yX7DsM8knTtucXqTVTMCqrjeuFImrWEG193APOQdlkPz+jZLpPrJl7OSf6pKl1I59Ud76FhiDw+Tg9VFDok901j+VBkGQ0AF/zPRElRwUpmes8RC+jUaixTGseQFh2ILs5oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvhvPpKL; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvhvPpKL"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9696319e14dso688315241.3
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 01:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786608723; cv=none;
        d=google.com; s=arc-20260327;
        b=BXL9tuyrYIIlAzPEfTWpNMkjl/DRvhg6Ub3LORGu+rX/Ph9MIyucsoEed14yLUyXtW
         F769uDv8hAd4rTKEPlZlZJdfTqbNNhTpluTz2Emb/g/iP4ydB5nZmWuDEkU57t38XFLY
         23dy20xygbtJh0oiZK2EApLYNlE92DSwDn/ADNuEzql+djpeK0q2MRR6FXfjfzBpteuy
         6ejKsaV4YAy4AigQ+tgOaUErGpAdxQ74yEY7+nT9RDXZG0WloYTFoxaMxHCcMwElj2ki
         718Qk4toBZF1I6QNu+K/jvDns43DaKCiQWg2yYIiRimc+aQa0Sj7pZkLB1VQmop/JpII
         Nigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RSCqvfARtlW+QloV3fjBOpPqIk1Lrl+l550+kErTodU=;
        fh=RYBFyj8BoPcr7uAep6RFyOPdLQcGIXbV5dYbEHiCQnw=;
        b=eQzZUoYTivECHbhv2oD7YkjDonkTVXgL3l9mO3UxA0OupXVGmUdBNDg5iY8GKpik/U
         Aixa1UIm+hOCIDN2caex+kz+o7CiwG99H/oEW/fJmH1EvyLCjJTKJiv4aFKDtDHejlMr
         zmkJEz6pC89dOIwhZhGSPsaawz9bEQle2W5XAaAKR5uPgMzDCt9beyJ0BTJGlHX7rcVI
         pn3COBFQsopvHmbYonQUKNnQ7P+KqhwOh7bppDkCh9YI7dqfSoa6/8uBa/hf1POmEHa7
         FP1iqxbS7zUsOO/LqKlE98v+Fe2bhoXhNPyULpLR5Npr6pgbUpScDYSC52WkuKYYqC7X
         96Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786608723; x=1787213523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RSCqvfARtlW+QloV3fjBOpPqIk1Lrl+l550+kErTodU=;
        b=nvhvPpKLE9O3avrTZ0NF+z0yRrgmFnf5qi/Sopnjx4evfQ2MIWdBciFXHlqvM7+Dht
         54NcrAqzeCE9p9F89g3h7Y+LY+/slWLxw/d8n8CO0ZgBDLdprKZSvLicBmeemAEj3Lvy
         KXzPXqTLV1WKf/8eQm+DhAS0v35QSM8H5TOf0jxQEqIN6ofC8VfFE5kIP2tlRfmd/4BJ
         yth8UGqtTGwA6zgBflVBdOqpBLCdIqclQOZ4YaF+GtDUx47rlS7N7zfKhDOIdpwSNZ40
         3Kdvk53BLNgSb4UagGAXm8OUuaaQxGwk5xx360jCS7Zu79ptalrj8UGYY4Akc3gZpsgq
         9bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608723; x=1787213523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RSCqvfARtlW+QloV3fjBOpPqIk1Lrl+l550+kErTodU=;
        b=g2MFO7rKvpqGfWW0M30+j29/5AC2svnd8lWGdrd4h9BVpLfCVpDy87UdyR9V0tkVh9
         hyLuXLSAKQtuOtOnYBvZkDe2mWiNZHZf8XRJnHTHgWAt52VUx97CnLeQvSLxpFtcnh3O
         inOmUY8YJdF4YRwcbam/ev4J5TPXeb+RIttgi+O9wVQMxzh5kTUuvyENe4HcOWu+sIDL
         mLemoVNJFopC85QeHtDVa+dPPeqXql1hKpPTLiovfFy05ugVJpS/51cbM1twAD+v+Yn+
         KXizi0RRx1gWzScqAL0QTFYrv60haDAJlhCbWREEwjeY2NUis26OvJgfTwtBkJFIFlpa
         jkIA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8gmnBft9kzE+Zx/tw5PqlXCzF3WJptfc1W921trX2CfrxnVxDNQpj3XMo5YtaFrd4/MLRei7BaIpb@vger.kernel.org
X-Gm-Message-State: AOJu0YwKeQNiya2JH0EksHZvXDWQHtVQ9vz6n0uqmxesds38UIu4I7Z5
	eRq4IeT/BNQNYvg7fi40dvpHHJFIE/66/zSQqsJRU5vFoRFJ+TfpNrWyYnFJb2gIIs4cFGQ55w3
	g3hnDabw+NlDA1+BPUUeC+l4vNAmhtVw=
X-Gm-Gg: AR+sD11gSaPMGi3wENGb+RkJ6lsmHqO5YjuIq2L6G3NcmzR80QzMZRYyEeVIkpi9e+7
	p0IYBAfLhbJtJuwDSzRGbqyGlrDqXdsUn76dHoH6RF8vve8Hw4CWtgnafuIXAV2PoJzJN/qDmdt
	87okY1bxO+kCofuXb5BxD+NBl6lIIU2pKeY/iCDHBgBDRgB/gfVOQA+BFPcnXeMntsRTVn1q9Kj
	7KzhlEmUetTp3LXZrQmoRvtxXH6B21nlpRMNXcnx9RYuW6LFZU2zONB6MNGMunbKFfEds3XqbEZ
	yjNJ2Odxcg6NBXCEFcijzsa354pTA9sb2Uv5dC36ZJ+9v90K+KvVnDehicMke6DONzZznKg1W0J
	MbVvHfrL0MaYOTQ==
X-Received: by 2002:a05:6102:801c:b0:73a:128b:ea07 with SMTP id
 ada2fe7eead31-76db866455emr991115137.14.1786608723524; Thu, 13 Aug 2026
 01:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-ceph-put-page-vector-v1-1-57ab2a08ec90@columbia.edu>
In-Reply-To: <20260809-ceph-put-page-vector-v1-1-57ab2a08ec90@columbia.edu>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 13 Aug 2026 10:11:51 +0200
X-Gm-Features: AUfX_mw2wKiFaq3KlhNPqnKc6tEfkHU7TezpZsF4GZrbHAU8jcVTJrcW9mdbOOI
Message-ID: <CAOi1vP9j72RiKGiwPo6oRe_sA1VjjORUPDvEYAsraLnH55pcwA@mail.gmail.com>
Subject: Re: [PATCH] libceph: remove the dead dirty path in ceph_put_page_vector()
To: Tal Zussman <tz2294@columbia.edu>, Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:04=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> wr=
ote:
>
> The only caller of ceph_put_page_vector() passes dirty =3D false, so the
> branch is dead code. Remove it along with the parameter. This removes a
> call to the deprecated set_page_dirty_lock().
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c               | 2 +-
>  include/linux/ceph/libceph.h | 3 +--
>  net/ceph/pagevec.c           | 7 ++-----
>  3 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index e2da3ab9f808..83752f3688fa 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -257,7 +257,7 @@ static void finish_netfs_read(struct ceph_osd_request=
 *req)
>         if (osd_data->type =3D=3D CEPH_OSD_DATA_TYPE_PAGES) {
>                 ceph_put_page_vector(osd_data->pages,
>                                      calc_pages_for(osd_data->alignment,
> -                                       osd_data->length), false);
> +                                       osd_data->length));
>         }
>         if (err > 0) {
>                 ceph_subvolume_metrics_record_io(fsc->mdsc, ceph_inode(in=
ode),
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 63e0e2aa1ce9..3098306e6173 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -313,8 +313,7 @@ int ceph_wait_for_latest_osdmap(struct ceph_client *c=
lient,
>
>  /* pagevec.c */
>  extern void ceph_release_page_vector(struct page **pages, int num_pages)=
;
> -extern void ceph_put_page_vector(struct page **pages, int num_pages,
> -                                bool dirty);
> +void ceph_put_page_vector(struct page **pages, int num_pages);
>  extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
>  extern void ceph_copy_from_page_vector(struct page **pages,
>                                     void *data,
> diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
> index 858359873c4d..828b003aa2fc 100644
> --- a/net/ceph/pagevec.c
> +++ b/net/ceph/pagevec.c
> @@ -10,15 +10,12 @@
>
>  #include <linux/ceph/libceph.h>
>
> -void ceph_put_page_vector(struct page **pages, int num_pages, bool dirty=
)
> +void ceph_put_page_vector(struct page **pages, int num_pages)
>  {
>         int i;
>
> -       for (i =3D 0; i < num_pages; i++) {
> -               if (dirty)
> -                       set_page_dirty_lock(pages[i]);
> +       for (i =3D 0; i < num_pages; i++)
>                 put_page(pages[i]);
> -       }
>         kvfree(pages);
>  }
>  EXPORT_SYMBOL(ceph_put_page_vector);
>
> ---
> base-commit: 30c0913a2b44a66dc17283a88489b3f3e12f4327
> change-id: 20260809-ceph-put-page-vector-458bb3aa87f6
>
> Best regards,
> --
> Tal Zussman <tz2294@columbia.edu>
>

Hi Tal,

I'd suggest getting rid of ceph_put_page_vector() altogether -- it's
pretty confusing to use it to put something that wasn't allocated with
some ceph_*_page_vector() helper.  It looks like ceph_put_page_vector()
was paired with ceph_get_direct_page_vector() which is long gone.  The
put_page() loop and kvfree() could be done in that single caller.

As I was looking into this, I think I spotted a related memory leak in
ceph_netfs_issue_read().  On the fscrypt path, the "page vector" coming
from iov_iter_get_pages_alloc2() isn't put in case of EIO caused by
ceph_inc_osd_stopping_blocker().  Alex, please take note.

Thanks,

                Ilya
