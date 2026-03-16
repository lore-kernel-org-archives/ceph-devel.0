Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7D3EDAC1
	for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692108; cv=pass; b=orUvE0wUI+IfTbhAQGwqFxOu+l7K1/9lraXMNhtFWCF/+EQSKIEzX0mYfipjsNUCaJ1Glejk0TsVQtwZgcpRv+ozHWGbmUq3TqeLkqHnFVgGoaFSS2NLbzDjREJxTVdpq1P4YFA8fbdwbBWURlCZdexr6NUrdrZRSfP21v7wkjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692108; c=relaxed/simple;
	bh=8niDkbFsuiT/+hqsTJO6w83pdohKFBF4kUT+Kf+V3LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B394FgTOUqkpBSCZyrjie5hInhhWZbSxX7u7vlgx72PQCdUlUgq8ecVooqoHw3TUqqNiGkdO8gAmlgoKMzAl1x/3qzzp7uxgMyuzEjR6RVgN4nE/iESg0d6hgPpG/bw1ZBjrJTh/fVnINnvBwhP3eBUXm5QI3Mriom7Z2oQAkq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVDEnNlo; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVDEnNlo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48539d21b76so35513135e9.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 13:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773692105; cv=none;
        d=google.com; s=arc-20240605;
        b=WVumpiwBSYlagCjk/QhRFX6R5QBaNbUUSgKLlpzSaZhZym2zj8cHDos/pdWHHpdJIo
         MVQRZ7Wsy1QneESUnrPVIVEkan17X4oRo+1Jg0kcLE+Znwf+WvjpKdXpivyVO0ylCysw
         TnF0YttSifvifO98RFYgnBdJ9753lmt1xri/jwsnh/VHyESIdc13tqX20cod0Zw1JC/X
         Wn2LeLlcDa9Ge2WtWhHf/8Ap/0UkA7vRZRnPyWRJ5ODa3eG5GWbkzbEjhKVAY8Sfo6Yo
         gpHRVL9YAcbogsU8ZnQEkj6H6Ts0IIbZ0ehKG0YVX1FiotQ2GSer68bg34Ov6TbS90kn
         sj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CYoN8btAUIlvILFgoOAtc9iU/qNjitR/kbbHyyiUI+c=;
        fh=oitUqEBkl/vrYfShG7PNWOHq+PqjRsslkfUQTnFc9Vw=;
        b=Y01IcEOVRMPbjR5S3y1W3yilOPJDr/0QPDNj1Txl6pEo02YYyieFgjPQcho7K+vVHr
         orP185cgDFDt9s6P/7YyvaFNCwemF+Fj1c8DqJaHVAqsN8SGZd3G4qlWJHJ+uthna5XY
         oO7cLqpYLUPb5S9D8+fagiQqvjybA4XsMAKWRZ4tUcDC+Sc1JLBEpsL6QbJHYAHfyMud
         e2hgI1RVzYry2NB9U6jsCDiQzdFxEceizMo+3JNtnpyKQukwzNLTISOVag5iKV3BNG6Y
         +8FMg2H186mehOsQhkCN0XK2bFPXltGLoG6oGzLTQZzANZTtub8UtvchQ7FrKZVeU2kQ
         CR1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773692105; x=1774296905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYoN8btAUIlvILFgoOAtc9iU/qNjitR/kbbHyyiUI+c=;
        b=fVDEnNloFqOdz29Kk0eJSkXisqbgtBhtZ1GCHYD+Lsab5Q8Q2p0xKTAONLOEZa+5tm
         wQag7wou7pfvRJn4tYIs6Uy8qbcg5AvzBDQXaAYFZMTHJTEp+3IpaviYtCRza5zaye0k
         /5B15r1I68hI2oyeyW0Hhl8YzFZoN7X2/QJSgweIRh5Xai38JjELR5y9/oShn1IZhFyG
         eZAuUInSIKlv8KGwY8xLpurNSatih9Iqm2CkbvsmXSg0Gp/r5fqL+zBvvkfCVd1nxC55
         EkLxKb9nxySVeGvdm31dqDrsS6xk56EpYk3nHQoxEy4nJi38t4oSRqYpAPgu9GwT69y8
         Qgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692105; x=1774296905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYoN8btAUIlvILFgoOAtc9iU/qNjitR/kbbHyyiUI+c=;
        b=A80aYLLn7AZJTlml0lLP1bOp0KZ2lO9Ky2MNoNG1orFGsvdZ6pTk6pbJPK97isXILn
         AwvLKMVtPVcRwihbbkhOSwV7fR8RAkM0yeM9G/umTfyCpSxxOtPk+v2Y4IJf7bKuBvmg
         52TSaYqlcK8/D9aUQ6W23hi+UQRPcH9pL38JFjz1YUSU/vza8n2WOr9zRIntaW9W0hPV
         2ewIT38Oa8g5WlHsvitzwLTBh91amWlJfWLqxt6B1F+3IBuXRNsfz5LFrwhZwGS9H2mM
         2kFX5OP1kg1OVL4Jj4ybdzXmLtY+kG7n32QiUuC5xgXeYWMGAin+TQRFrpdpXS4aw9Vx
         LCvg==
X-Forwarded-Encrypted: i=1; AJvYcCXeGPJci0OkyK1FyKKE9vzq3IbubzD0qLuajXwUEFCg7tJQU99nNaUpNiPMe5FF6OqSsNJHTQ4PWbFm@vger.kernel.org
X-Gm-Message-State: AOJu0YwSM5FwRh2ju0d7XSfQXSMSmsndwgB1N1QpagEpiRUUYPlL+Jdd
	IZVCQo6NUdcy/dPPntqCDBI48ctF68+ZPk3tbCjulHT3GnBY9vYVwgLJ5mve1X8D5CYn2KGXYCs
	Dtq/UNuDPiyW5ch8DGvfLoLb55zCB+2A=
X-Gm-Gg: ATEYQzwqxH8kmVgsrXNQtnxlExSiQr3VvKDlTfy7gT8yuZS93x10MrMJnZlsn7kz7so
	SPKyM7EJvqcM0bdzvct+PQ37ChUaQiRFHu5JkVpYVe13zsfKGXNxxSFnVnuVVJVMrBHPN/rQviN
	Vx9Z6QVZ4kfDGFP0fNF7t7wjDVeM/3NoyI4MOfP4xUBd5wG+Z+M3fFFMHHlTDVWpDI9Nu+oaTgT
	MZgBZnJz7n8sFRVlryl411qhXzvrZF2sprv45mbv+jjTJk6uVhaD+4NuI+twHa35jR5YwCjgBN8
	AgT5RVugXvRLfPe9m5t0Ns2LMoMPKhI=
X-Received: by 2002:a05:600c:1395:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-4855670b72fmr237585685e9.27.1773692104868; Mon, 16 Mar 2026
 13:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315232500.251088-1-CFSworks@gmail.com> <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
In-Reply-To: <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 16 Mar 2026 13:14:53 -0700
X-Gm-Features: AaiRm51dpPBipZZWQanwptiEoyoB_MXYhvmujHnwSw7-J6BK8JmDh4pDIUmVfgQ
Message-ID: <CAH5Ym4j6gPCR9UhM1ywkDmvcDAccNrL72LFLy468T4PfPTxU7Q@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, Milind Changire <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:44=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Sun, 2026-03-15 at 16:25 -0700, Sam Edwards wrote:
> > move_dirty_folio_in_page_array() may fail if the file is encrypted, the
> > dirty folio is not the first in the batch, and it fails to allocate a
> > bounce buffer to hold the ciphertext. When that happens,
> > ceph_process_folio_batch() simply redirties the folio and flushes the
> > current batch -- it can retry that folio in a future batch.
> >
>
> How this issue can be reproduced? Do you have a reproduction script or an=
ything
> like this?

Good day Slava,

Is this question about the preceding paragraph? If so: that paragraph
is just describing current (and intended) behavior, not an issue.

If this is just a general question about the patch, then I don't know
of a way to trigger the issue in a short timeframe, but something like
this ought to work:
1. Create a reasonably-sized (e.g. 4GiB) fscrypt-protected file in CephFS
2. Put the CephFS client system under heavy memory pressure, so that
bounce page allocation is more likely to fail
3. Repeatedly write to the file in a 4KiB-written/4KiB-skipped
pattern, starting over upon getting to the end of the file
4. Wait for the system to panic, gradually ramping up the memory
pressure until it does

I run a workload that performs fairly random I/O atop CephFS+fscrypt.
Before this patch, I'd get a panic after about a day. After this
patch, I've been running for 4+ days without this particular issue
reappearing.

> > However, if this failed folio is not contiguous with the last folio tha=
t
> > did make it into the batch, then ceph_process_folio_batch() has already
> > incremented `ceph_wbc->num_ops`; because it doesn't follow through and
> > add the discontiguous folio to the array, ceph_submit_write() -- which
> > expects that `ceph_wbc->num_ops` accurately reflects the number of
> > contiguous ranges (and therefore the required number of "write extent"
> > ops) in the writeback -- will panic the kernel:
> >
> >     BUG_ON(ceph_wbc->op_idx + 1 !=3D req->r_num_ops);
>
> I don't quite follow. We decrement ceph_wbc->num_ops but BUG_ON() operate=
s by
> req->r_num_ops. How req->r_num_ops receives the value of ceph_wbc->num_op=
s?

ceph_submit_write() passes ceph_wbc->num_ops to ceph_osdc_new_request()...

> We change ceph_wbc->num_ops, ceph_wbc->offset, and ceph_wbc->len here:
>
>                 } else if (!is_folio_index_contiguous(ceph_wbc, folio)) {
>                         if (is_num_ops_too_big(ceph_wbc)) {
>                                 folio_redirty_for_writepage(wbc, folio);
>                                 folio_unlock(folio);
>                                 break;
>                         }
>
>                         ceph_wbc->num_ops++;
>                         ceph_wbc->offset =3D (u64)folio_pos(folio);
>                         ceph_wbc->len =3D 0;
>                 }
>
> First of all, technically speaking, move_dirty_folio_in_page_array() can =
fail
> even if is_folio_index_contiguous() is positive. Do you mean that we don'=
t need
> to decrement the ceph_wbc->num_ops in such case?

Yes, exactly: as stated in the commit message, we only need to correct
the value "when move_dirty_folio_in_page_array() fails, but the folio
already started counting a new (i.e. still-empty) extent." The `len =3D=3D
0` test is checking for that new/still-empty condition.

> Secondly, do we need to correct ceph_wbc->offset?

No, we do not; the valid lifetime of offset/len ends when
ceph_process_folio_batch() returns. I'd even argue they don't belong
in ceph_wbc at all and should be local variables instead, but that's a
matter for a different patch.

Cheers,
Sam
