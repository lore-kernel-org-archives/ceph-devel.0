Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFD42FCAF
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343646; cv=pass; b=RdiKwNbsQBHgSZX/teB0LPq+CwmfkZELjs/JhGchGB0lknOr/WhXzC70FXNOg1KI/Q84CJMWeZ9U5stc3pc8LvTbqpmYwLPg8B3fTGBXzvUEu0WUks4FU0lWa9XlFguAkY3yYztG3OHqUOAyPwWkPoKYXrAHyL8q1raHCTqQQBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343646; c=relaxed/simple;
	bh=1xa+lElD+YJMoo2jLjMuafTdhcpMKsbzXGbVsD/2zXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByodvE/VU16cMdblL0jJ3PRnz+VUT6XztWQdJ84nclU/Ojm4szzgyxjmBi8LxLW6pKoaG2lhj3jEjiV020G96PdA8nQRiWbD3poqVyFH4gJD5LiubGT8diJwOUJYcVZGoxeY9DZCIuDjFP1D4oQimvIHUQgMDoj3ReZA8rZTBK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGe9ZU8D; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGe9ZU8D"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c2ae02f69eso809447e0c.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 03:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788343643; cv=none;
        d=google.com; s=arc-20260327;
        b=HQ/VNO+nVbfE5zGOlSQk9ih3TfLD7AtMByloYIccpfHm/Q96wTXutnKcL6O34wfye0
         yiuVdeKrHJ8mJptMhqeiu88RwK3ALzMXg6Z+uoRPZUFZ/Epl8dr0UZhE6c3n7hKbvMnv
         Pqq7lTOQvpC2ih6/43lDJIpFjwFBKd7AZyn35mssaFNJEGb8Sty9ucqjj1nDxi/ReIHm
         Xu+aGcfIug4flWNV4bfZNHy0px4tzjFzmpHpB6upM33pFSo41K+u4LaJ8TtKvG9qPS0K
         79aM/7skHA+kus5ODMDGXFxKOiSuW26MGSl1+fwKdCemiN4KjQb5f3Yx3dOpq5hJh1ZH
         xwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LtaXRwU7EmfoNAd9qDxh30eMQcuF5WCOAQg3rtox4ZA=;
        fh=H40w+CpaVwwR2VEJJP5WVXUwKUA27aLcaEzQEVpB1Gw=;
        b=IiuYOm1jaq6qw2ODjXXaVFiSGaIQxcxbncrQjkICO9JLGWm22Kgi6H3K2FnHkml30s
         PfFWnjy11EN9uZ3VBmKmgoHDpnK5N2RtMIXO9PcEaumaQSczxHErblVHkMi5f5QtreDv
         b4xzix+Fj0xraj7bdV1JoIf7mtjKbjZq7Sy9ws7nxnsSTcCWUzDS66cSJKuBPnOfl9LX
         Rn740Vl/gpSOE0Pbxr1DnQ+hyxdyN0R63hzDzle5AcyB0r/e/kzKHK47GzVnVcNlkOBv
         UYh+Wnk/23BInmsOEiMGB+E5usonz8tPbP2IyOeQQmkTaLkRf8y3gIV/ruLr3V2z2Fav
         xMHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788343643; x=1788948443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LtaXRwU7EmfoNAd9qDxh30eMQcuF5WCOAQg3rtox4ZA=;
        b=GGe9ZU8Dc94fA77fMlFhyZI9JnoyD41q5AUAEQK0ULWLO+bGGfIxwH4OlMF2ZLjQXU
         WgW8W9yRNY93POrTBOtK47UMgEDuZPj0oitr3Ww6a2Jo8069gAyqTSdl2B4s1sCsHD7A
         mt44zKg4NJsm/jlF8sXWsS1IXTTwwpFiiye0B6BQ1XocPMAZyuk1qQexUvmZwyKT8PQJ
         G0FpG1UwlWGUq0soz3yj2PPNquv8MD4BJiXFRQnUrZcSPBCQyuaSvo1XZuQy71KUaolc
         yHhvsRKxx9tSlTYk5lsvjW9s9fkU1Lim3KaFazS+jMF4ufXF5RCrqvvo/uFxgw/2Ah/c
         eaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343643; x=1788948443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtaXRwU7EmfoNAd9qDxh30eMQcuF5WCOAQg3rtox4ZA=;
        b=MeCUDqZBYYxmH+1JaZhEtsREhKuP5W14QPXQ3RMU7+m4HmTlCL84c9SPiu+THpJmxu
         HvYa/bLimZHX8NAkf60GFLspreQNujTU3FPoRvF+Ap2cOJc10pHxuqvHB4U1s71VAL5k
         Yrlm7Y/+7Z6fSrOdcy4VTJkTKqsfv0o6xennl/ZtUFb8uE0zKEWLpomv1aYyS1h8y0sd
         Ds8RBTLYmgbBVL8qg8tJAWu3kuOwVhtUrrjyaNDNCXHio5OZKM98GUAA/oahG9uOT6aY
         NFgi4oAF+9R+vI0a17/p6BTs9V/r9/p8gGIe98nACxmrHoLQP5io5GlMwGtisKbXGRiA
         C/JQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOMA8ZgjOT+G0AbNQgJwyHB+KcZF45ZxNxLKU1hUNRwAsdgFLb0Q4UdNg/3DslBzWekFCQaecdm1+x@vger.kernel.org
X-Gm-Message-State: AFuF++m9p8UCId9cQyja6PWzsHa/7EfWZV3nUTSPRrXRhirvDzYBzRu8
	vU2e5zuq93ewrZXRVbRQrjAOmyr6lgL3bhJy1BSNwtmntLtBUShB+xRmp33w1snyxlnEXtrZSEj
	2w7HCUsNLS7QTblmn2cJtTxCETWAO5AY=
X-Gm-Gg: AYBFou0smh4MYqVWwxWpjZxinPQN0m9Et1l5vBCQ/LlSvb3VK5ilpgjQlFsnRrhQ4od
	8OdxoB9DZyAwshAoeSUion2UtgCOI5oQ7C39AD7GTxPWDbLTzOm65LDKOH/QQbaYcCbEInwe8x4
	EN+nLvJPjq7wu8k5CtYgkiC5Qo8FPdKHBNBpYgFu+2XJNoFG/Jlu/r4JZbcrwirIEf2dkVH6LUz
	stHckpbotG/mG84Ce4oYnOHE6OYHCdST/eWaYDD52d3PYt6etSsX3gRBk8aTUphJ5/TYU2Fr1z5
	IBh3bTkVmSWQbCI8M7yo736X0iWJFOUp+5ob6JZ501IF5byjLaWomUSzUp6eNq1L/vg+REiV1iV
	T9U4o8oAmcM6VWA==
X-Received: by 2002:a05:6102:2d0e:b0:784:b9ec:913d with SMTP id
 ada2fe7eead31-78a1f364141mr1279608137.8.1788343643602; Wed, 02 Sep 2026
 03:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-ceph-msgr-writeback-v2-1-840ef541b0c2@columbia.edu>
In-Reply-To: <20260825-ceph-msgr-writeback-v2-1-840ef541b0c2@columbia.edu>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 2 Sep 2026 12:07:10 +0200
X-Gm-Features: AcwNN1WAleROut0sEKdtlOPPnJNCWxFi5LIaqqirKxexZnt_ltqakLRjMrs_NzQ
Message-ID: <CAOi1vP-ObFuVcD9OJW2aeguZ0pUYQZf3pF2L9KxXQ3wKpHgNEQ@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: remove pinning assertion in ceph_msg_data_iter_next()
To: Tal Zussman <tz2294@columbia.edu>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	David Howells <dhowells@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@lst.de>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:41=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> ceph_msg_data_iter_next() gets a page reference from
> iov_iter_get_pages2() only to immediately drop it, asserting that the
> page is pinned some other way. The assertion is the last caller of
> PageWriteback() in the tree, blocking removal of the PG_writeback page
> flag accessors.
>
> Remove the assertion, as it is a CONFIG_DEBUG_VM-only check of an
> assumption the FIXME comment already documents. Converting to
> iov_iter_extract_pages() instead was considered, but the messenger never
> releases what it extracts, so it would still rely entirely on the caller
> holding the pages. That would be just as much of an abuse of the API, so
> leave it as-is for now.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
> The assertion is the last caller of PageWriteback() in the tree. The
> removal of the PG_writeback page flag accessors will be sent
> separately.
>
> Changes in v2:
> - Only delete the assertion and leave the rest as-is, per Christoph.
> - Rebase onto latest ceph for-linus branch, as v1 was applied to the
>   testing branch.
> - Link to v1: https://lore.kernel.org/r/20260817-ceph-msgr-writeback-v1-1=
-38f3754034b9@columbia.edu
> ---
>  net/ceph/messenger.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 34b3097b4c7b..95929eeb1f85 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1003,7 +1003,6 @@ static struct page *ceph_msg_data_iter_next(struct =
ceph_msg_data_cursor *cursor,
>          *        we'll get an iov_iter_get_pages2 variant that doesn't t=
ake
>          *        page refs. Until then, just put the page ref.
>          */
> -       VM_BUG_ON_PAGE(!PageWriteback(page) && page_count(page) < 2, page=
);
>         put_page(page);
>
>         *length =3D min_t(size_t, len, cursor->resid);
>
> ---
> base-commit: 91880e4a7fac45bc407771bc57bbaf4f37e9b4c3
> change-id: 20260808-ceph-msgr-writeback-a67d25e28f1e
>
> Best regards,
> --
> Tal Zussman <tz2294@columbia.edu>
>

Applied.

Thanks,

                Ilya
