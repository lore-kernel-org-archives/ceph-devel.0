Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE9292B4B
	for <ceph-devel@vger.kernel.org>; Wed, 25 Mar 2026 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407380; cv=pass; b=odiYnBkmO2wqY1FBnm5PMfMlFGRQ6k6RuyctZuhuiHvq5mUHllkTEmhgqiyDH6cUKlOXDLmraUvAVUr/dQ5MiktYsNFnITVZQzYjJAI1DuPte0hmacLYtA85hQ5AxmGQXnFUmiGbBKNJfugk5D52pQnIZPDF5LaGQPblVkMSCq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407380; c=relaxed/simple;
	bh=+uPMDPPtiGZlDWZpdQ5piUM06engoMAUBApWm8b8a4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2nRMRcV9IFcl6T7K/8NMfbtz3BN4JQS2tiOawEcP0IXNI3h0PYT9kr6F6JyjH6u1UxT240A3j6tIwb40k/jBxUKmrlr4j3RZMjWg09mj+6UM6VMKudUay+iY96eHqrCGCSeqf/FRt7DciciLt4Yw1laBFfhwBv0oGE++1wD1EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpbOC1wT; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpbOC1wT"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so184904f8f.2
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2026 19:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774407377; cv=none;
        d=google.com; s=arc-20240605;
        b=DSSKoRtkqjnRHHzoa8rkDjE1Fn+KKBS6TVp7EM0D/tVLOPrXClbpBNNdEBGLdJeCv1
         P1vIRvSLgVqhuVW2yEYPQ4ds+Bl7j/aaPSyNIDTxLNjFQdsndvYCOhpCpatY9HZagLyA
         RTG9wT5mzSDk+c60SwpcjqJEdswFdqZeci9pje8jf/w8+WO1j93yb5Xrp2x5Hdb7x1NR
         PIS6ohE6kUGKUR7ofWR2poqSWMZbaPfbkerdOtenxiqX51yEvR8vwz6qURqHODKfJljZ
         Q6a0WPy2PGhIrNdURdn8CSHw5XXFbXQrfj+HcRtZCGgWU+Bjl+6YyU+u5YTQ19jLrieS
         7wIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M8beg8RaijPeg8FFoZVPlIFnyuzA+pj3RPJBxTKpVis=;
        fh=xQ1ynZHVDjTjX0r9f2d9ecpuvqaNO4HtXW/Ivu7dOe0=;
        b=XfCjBzsOMJ5r6zeCddtuYZvvp+3sA283E0EFPPgjOFyDiX2jKmtkibr9oEwx6hFf4a
         FqUoEI2qWoFWld2zIznOL0ZrpYmqWZyN3++tbkZZQOC9kzjHTL5NeBsSFVrFOi3SXevb
         02YRLYjyKNQGTQVQ6PPLJIjtMM/KGTplyhVRWYX+afMCcmghjv4XAr/af+BFF3By+C+B
         nbl1fXjkvzd4Yj8X3oOMDhD0i+VoYrh9MEXelhqa7mdGd5eHKa2dLP29jX2e8wGWCApB
         DZPi1m7fS7Ar7slOs0ifTf3626BuK8h8UUHLQ1tpQXsv04FLynXWBAYQKVrp6G2ldoOv
         /6eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774407377; x=1775012177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8beg8RaijPeg8FFoZVPlIFnyuzA+pj3RPJBxTKpVis=;
        b=HpbOC1wTwno7znp4XtV4JgJQq0YvB68QNRJzcsB8DwE56PwsssnLSQy/3ER20hRFby
         7aphxGoUNt/rYHrpJ8V7P4Mpmkc7quE8kqrC4TIBEsAPeegmZUekU8FMzxAklAXL2UAQ
         c+DoWp4PnsyajSlG4VX07Q3x/AgVtHyx5zN88JXjfYNvzRRoFasMvIEqViwJRr1IqxTi
         zy/o4ZjISc02UqB1rbIc9hsabrXa+cSklNF2ebtpbcDL3qcJy+P6BRjCtcucv+uQ8Ps/
         5oEwUjfN5jKSloLLM5SJmEZecA0EhzhRTPiw0G+6JHxgk+c+D/TFKqjkiLzvjffkPfBa
         LaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774407377; x=1775012177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8beg8RaijPeg8FFoZVPlIFnyuzA+pj3RPJBxTKpVis=;
        b=obY2mYgw4RrEU/cWUyVw60aX/HKNoRK2HbWeDCfrrUoX0D3PdgCnPjjUcsERvEyB+/
         M90qEx+XaHqTEgLvLorTAlBFBfWIaMzsOyljMdNCOCueVo+ic46YyH5IoCl7itRmoB47
         owshPMWoTVhUrebumJr/FGSwoYDHAQhUC0JnaSViYIi9/69GGCtkqhDwWWXlzGLSfgv4
         8+oBALlK5PejPWPZv/Qls1gc19u7wbtqLvTeOms/0Yf1qeuYTNOs3WguK0oX7OZwz821
         QRt9e5gZZ0J8cH6gYvnlOzYQirMsfKHuCBq7hJhRk1OTbrGo693/V2iW/7yYy/4baU8/
         h3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1rm1fNYO9Jee0K6P/8SPx9WaHVAJRnVSkc1tngCgZ7Hc77Fu+paIokJ4PHXhHs+8YpZT+gT0SRgE/@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrWEOuyJJEfbCF0uIXqTq/OwfsKJffsur+Yp7X3cUA+PGORwF
	KqPJ02luLnZpymJ0YZgGRi0VebGt9vS6ivQoYQn0a2m3rwHcNy0bE4qb7z4SqkZITX11dkT1EZi
	xtilPkPFi68lf6Bjml7GF61Fhgu+wYu4=
X-Gm-Gg: ATEYQzyK5NpUxqi2/j14V98/v8smVbLbAmRoR5MmS5b1DShDECFPwUSzXLgHjy+rfee
	5diUVf4iTpuInmVN7WPcwAkln058j97mnvQCFzxa3S5l0OH2BNOd/jwnQYEJ6yfpTmnKi+e+RDu
	FmpkYGt+//WIYoUVd3LR2//BqGSS38mGPtF3TTHbMygBu0C63NM79BrATERDiZ6ntB3Ufi1ZVDb
	wjQMXXQDPah5oAAo+qBu9n2Xji4MObBYvnEQXSZCQcvi1IHZCHSGjlKZlPVLWhGjdO3/izsNVNi
	NPb91epGUodRgkZnYg==
X-Received: by 2002:a5d:5d13:0:b0:439:b629:42d7 with SMTP id
 ffacd0b85a97d-43b88a0d06bmr2402635f8f.46.1774407376729; Tue, 24 Mar 2026
 19:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318023733.116789-1-CFSworks@gmail.com> <bae7a16910a7b2cff6b9f8996d93ea72dabb9a6b.camel@ibm.com>
In-Reply-To: <bae7a16910a7b2cff6b9f8996d93ea72dabb9a6b.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 24 Mar 2026 19:56:05 -0700
X-Gm-Features: AQROBzAlSbvlJ_j1hrAwDeyayBxlZCGPHoqUP3hJK2r7_KYkhbvBusND6PVGDs0
Message-ID: <CAH5Ym4i_Vbu88yHr5UG=6=kOS_jebsSaV3B-AvZjrn+jk8h-xA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v2] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, Milind Changire <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:42=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> ...

Hi Slava,

> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This looks like you gave "for future reference" feedback and provided
a R-b tag for the current version of the patch; is that it? Or is this
a tag to roll forward to a v3 with your feedback applied?

If necessary to pass review, I can do something like your (2) and
amend the commit message:

<excerpt>
contiguous ranges (and therefore the required number of "write extent"
ops) in the writeback -- will panic the kernel:

    /* in ceph_submit_write() */
    req =3D ceph_osdc_new_request(/* ... */, ceph_wbc->num_ops, /* ... */);
    /* ... */
    BUG_ON(ceph_wbc->op_idx + 1 !=3D req->r_num_ops);

This issue can be reproduced on affected kernels by writing to
</excerpt>

But I fear adding even that much sacrifices clarity: the central point
is that num_ops needs to be correct when ceph_process_folio_batch()
returns; I understand that documenting the symptom of the problem
(where it panics) is an important secondary goal for helping affected
users/stable/downstreams understand the impact and/or discover the
commit, but I'm also trying to be respectful of their time by not
reiterating code to someone who would just CTRL+F the source file if
they wanted this level of detail.

Best,
Sam
