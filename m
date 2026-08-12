Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B8C383C93
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516566; cv=pass; b=Ia3idWn1y7DgHxWx6me/vB6PRLClvEDzha6Wl9Cij0YnSQZB3lj0CgrsuubGEWkApWja3aogZKvkxFIUkkQ0bXjWOhXEPmXbNc5DurjQ+wEYKRn4WMSnFMyOVyWAIbJBnknrOULr0g2LmoIwuq8CDTUAkz/lMQWkI414ez6VuVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516566; c=relaxed/simple;
	bh=vZjnB9XvOlu2L4QyBDmq09CxmCJwYnY7F1cVEmYJzks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OovOQcGTEBNWUF17YAqeSIKs3Q9bk9uJpkMqVyw/4XNEIU5A3IZmfpKVSNcjtDqhR7ghl6k1paok5wOdzUJiYnDHOVi0+yFwX7ihv92j7H6ksrenLtBbvRe7Kxc0j7R55LeRhagjUwau49+mcx2NCDh/PACH9cmeQtjPoRrY8PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=q1Hl/PEt; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="q1Hl/PEt"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c20363107f4so56379666b.2
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 23:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786516562; cv=none;
        d=google.com; s=arc-20260327;
        b=XCa4jqLScq4I/ewTeHZiMgzGbM7HwIigpFguccIYmEU0BOm8D+yGvf7d5JL5yZix7N
         V8WXKIcRvq3vDDhOsjB3msptlV7On+Pia2bOhdN1VfhDZEFvMnOyg6NTdwJl2vV2e6eM
         gKKvIUl2TFvuYaU5MuejzjrYVs7HoePXrR13uLLbtTKGXJPlohDq8r/CrII22xNQFrXF
         6rBpKd2HuPE7cXUhpE8BiOwjcJju15CL3HKTBKRZdx+oF0MWR55kkJSpxL186rOrrbFB
         k61M9DqJGN90nCYGFGXybBrEwIUluoft+UM1fCDx+hG0GgOFVb76uRqk5geT6If0Cyui
         l1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vZjnB9XvOlu2L4QyBDmq09CxmCJwYnY7F1cVEmYJzks=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=OcMtijd9Ezisz+/IAr/6/+0qg6QxylDhMu5y5RZapg63Zr/WWSb1yUqtLm74jkqMDq
         YVPzPqlKNAM/SuIiDLP9MVljHu9cc46sfqWe3ItjAXzVn5xjkSSTyMF5MR4eEsYLrXI/
         8rrUtORx4uIQC1/Jc7jZL0rumvKTs4T1BcBcLqUxp9gnachCFNu7+G24zexB8JzxTkCe
         YlUiH6A3Jll9h1BbYYbhEQuUXHOh2oLayDQpVb5ZKmuhlxEx5r2v5iAukz6z9I2/SZf2
         N97WRcxVwNJoefn57SpRcxCG3VH59CT0lBi3R6o/L11XRH+1BE7thygrPY6//g5XoC6B
         yBvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786516562; x=1787121362; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZjnB9XvOlu2L4QyBDmq09CxmCJwYnY7F1cVEmYJzks=;
        b=q1Hl/PEtQgixStYoX2nwLrgOaelRGecw9tXQtTLD2rqEQmuIIQ/H8Z27A9dtMPt8M2
         V3zZY6fDeCI9MxNXGffA3DPr/puvcaKXurwnAL+BM97/16W8YL8YAWC4fnm4FB2UCRfD
         peBXd5B5jTkHOYW9LsR2E6zfWWnbWm0TF5Cah2/SrDJeRxDmb32wsd6wQdqJipYLGnAY
         aRlfiqwtVpa8J2tNu45pUUPKwGMPHK9HUzBGmmmXVOCWvVZ/ZvsT19Kqs5UpNTo0HllH
         VRvMnq0MRDq349SRmOXTrBaUG8F8EiaaHO1r7vNFU+joUVX5hOj/xm3xQ71zkhzEOWe4
         cAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786516562; x=1787121362;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vZjnB9XvOlu2L4QyBDmq09CxmCJwYnY7F1cVEmYJzks=;
        b=rxZQ71UXw5CXMnuvWnCb/fgODkp4/yvrJ/QT7M5qmtQ2o/udn4zU6REc4Jppr7i7V0
         YAEfkU21Uk7uWtFYBBpRKTsIUKUtFhrWgwMPUZZ9v02YXuzOn+FWi73N9V08N8z1VA6H
         QeCe8cH+pT2gVwXBdVErzY+XZeo4gL2gf5148/uG+DmbQboq2myeKXfOB9nwh1NoFJos
         Z5f3d5lwGewAxhUuyo6t6un8si+UMm5yTfPT9Xw1wjRtXukTLzxceQolt8U78BDYfjNS
         FGDNH6uO99Hr9gcrNLlp4RtbjkDRK6ToU5siLORLRJZsOicOEaVQEkI1mMPS7ea+r0a4
         zPoA==
X-Gm-Message-State: AOJu0YyIx2P29PwpBCXl4ewENUwiqHGVtNws4Xt/mL56bFgJNscA5iFd
	1MdkEF7St4ywtBbpHAZEtRm/+TzIDujw3WG2yjSykNUIJ12UfF4DdsEv610awz7xeoxBC6nsT1L
	eiGb550swu6rE1zbMf9LBu+Nxr4xO3zhPswpxOiYs2uuYiS9taqOhlSk=
X-Gm-Gg: AR+sD124I7UrwT+wTxlSPRxq1dm3UdOhx+GESGTRGiyQNfqUD+wGRZjEevjVefGDfuR
	QPGW+E7KH1XLdmq4/NaYZPTBgNng6CJ11zMkETWiMGvjpfzUeNm72RWIvWLGbfn8QhXM+9SOigv
	oKOm1i6q9GexoRkHB4XbA+DtNe5kM0pqVfoqqPfa0c9Al3RcVC4T5/gPv7ni1Xak+XuKDqndnFO
	DWKg7XxAx0Xty4oiBaVZyOZKnnJZ9STgzNn/fgP+qL4EUeG3clahKCDjd6k8PNEZwWkBBBd3tkn
	I4Lv8YRxlsIaYlg16s/JH6qbbA+t+WT2oTlbLaUkhF6JvA==
X-Received: by 2002:a17:907:d1d:b0:c1f:97f3:7225 with SMTP id
 a640c23a62f3a-c20f2e3c984mr124257066b.6.1786516562289; Tue, 11 Aug 2026
 23:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ceph-mdsc-mutex-optimization-v3-5-d031114419f4@clyso.com>
 <20260811134432.2689604-1-amarkuze@redhat.com>
In-Reply-To: <20260811134432.2689604-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 12 Aug 2026 14:35:51 +0800
X-Gm-Features: AUfX_myjm_gFfw6QrpClgx8IjCrwbNPONVwl2oPUsmNVe8nHxETveFaH-Oq4jl0
Message-ID: <CAOJNxRLygNEbDNqsvW9doiR_db9BzJkm80HU8NXLVaFX_+wopw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] ceph: narrow mdsc->mutex scope in replay_unsafe_requests
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Alex,

Yeah, this also makes sense. I will fix it by adding one r_aux_item instead.

Thanks
- XIubo

On Tue, 11 Aug 2026 at 06:44, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> The collect-then-replay pattern here has a list-node race.
>
> list_move(&req->r_unsafe_item, &unsafe_list) takes requests off
> session->s_unsafe onto a local list under the mutex. After the mutex is
> dropped, the replay loop iterates unsafe_list via r_unsafe_item.
> Meanwhile handle_reply() -> __unregister_request() can call
> list_del_init(&req->r_unsafe_item) under the mutex from another thread,
> mutating the local-list linkage while the replay loop is walking it.
> The kref prevents use-after-free, but the list traversal itself is
> unsynchronized. Same issue affects old_list.
>
> One way to fix this would be to collect refcounted pointers into an
> array (or use storage independent of r_unsafe_item) for the local
> iteration, leaving the requests on their canonical lists.
>
> --
> Alex Markuze
>
