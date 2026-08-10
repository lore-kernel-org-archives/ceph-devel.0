Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1EC3C3F41
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362599; cv=pass; b=ubyv6xTcPAPkll4/egKb2ewGOQSMQoasLo0LHEPTewV5BtoiHk4JPK8YDCupzLHe4myGsMHmgj2pwZQC4aWF7phX70aVBwMgz6agLYsWV098/nlJem52tObxFUQ+iLdIZQRzqsw1w3P+TGy+tSxs1qi2jqd3P7iyn608afbxKL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362599; c=relaxed/simple;
	bh=bqxhj80OHCfs2l0pmZXo9T6EE/Q+XSI4ASVci9J8bsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tO3UepaxqZEOeYnRYuuyqeN80k6sMzxhMZg5lDExvhgJF+imRAaXSbv2H9QOEaW7efiNOnFe9mNWkv4rqydw3YCseubduDczJW1VQWkYPc+fUEPsY49KVUXE6O/WEYKLNWsnEd1ZQ1GP4CIsy9GO+/HL4xUM2jE6gefIN4kTj/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JbIlTHjY; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JbIlTHjY"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92f03daaa97so81763885a.2
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 04:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786362595; cv=none;
        d=google.com; s=arc-20260327;
        b=l8gpAq/+sAKQJ6bMlLhf6DDdv2D4DjXtT20//WPA9uBS937oGM9YinU0dFngzt73XD
         GPzk4B97Yr+k2m51AwiHKiscxmvflJivPqTD22sR6/y6csVZNz8NO9nMV36qaRUW9guf
         yATmJjLFJ696As0FX40uKtontQqvkIDnCPOCG7cys9xT+QEPmwHJQ8R5HlQb9N8VF8P8
         wVivAktxKHK+f1FB/wfGJO3Px0E4RLj3GJeVagE1/OkGr78iBOgJZoRiZeLNfZ1jTVaa
         3XWxrZ7vuDDKbEMsyoZcsaTxN86lUfGXo1mTKS9d5kF5yWyYpdDywmkBfyonv1rtETSo
         cmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        fh=+Y6tgETjFFEYAzeaF5b43uNys4fgsfibys4Py1br3A8=;
        b=pbiX+1mf+P5c9auI8ePYnzIqC1oSqIRwBgwcrh0H718JZBOMXuikRmi6DRzmHXjZyi
         bCa7qGCAVhACWLITtj+74/eAFpPmXuzJ4fBANqOSxTJhIU6vQbRu9Dfl+KuadEFB0GnQ
         TyWMz7wqt79uk1ZrCQg+gfU4BtEGURblwfwAShSyjuYulNUH0dkErHaqK2A+Z5HBsWiM
         AZ7QPFIMnT1LPLBvChJyEh6sohbR4yC1NKybZnEk4mQh5Wzre7CrJO6Nj1Uy4daUf4s/
         5a1QjNZC45sluAJJQrlf18cjNRoL08o1xBBEBvc2mjaobJlYF488At0o/dGt7bMlUXPB
         IMxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786362595; x=1786967395; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        b=JbIlTHjYRbq+ZIsCxsszUYyLNHxgDCPjN9Ma1WEhKH7MRmWe7joIBbYWWomP9gcZOk
         LFfIYMBfmj2D+xlKmRu9u/RX7WEdZqwmK+o11C1r04InwcwfFNVdcqh2Sg5WKYqi1/Rt
         KFQGIwIBoE4APpF/F9Jcwrx5z06thfkeft49Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786362595; x=1786967395;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        b=aUuvt6y/iHwuKo6MEpfsEGPz91U3U6f85muaZOY8JV77mGjA/r1UGo3a7oDGx9bKgB
         L71dyP36g+ypfxbPm1QcyNBgti3hIn/5RTSkfeZf7aECgBvZ6lhNM+KUJXTneEFf+ect
         hhbSyOsG3y4xmGNy3IwOnAh7vZKd9d3Hf6dkEKaFNC5upVBXpg292vpjMjw2fIFZ+Ubz
         1XeAm2KVIjxR0ieHcFThFPA7hMgB7QuDJRa9CLCBVPHhzpY381oJDFu2lflOm8WFBizq
         UhWRd+ZrPBG4m6I70VNj5YHcPICKfXlFt4D5n6927EoIQ8+QH+JZe89jHsGBntmu5V77
         xJ/A==
X-Forwarded-Encrypted: i=1; AHgh+RqT22N2z09ngNQVAf/eHdB1kN5qCIbDHp7H46iOVlFv7b4G3f3HqO0DtA1Ij4SqIBvmFiS6aXmymq15@vger.kernel.org
X-Gm-Message-State: AOJu0YzlC692TrPh2Jr2sTUKBWlwTDlpHACkzCbbmCO7HaPBaVPaqYEn
	4bgduLsp2gIw5vpFca3AVN4mTirIiifGVW8MvsL0ncidp3tBu3w2VNZW/53ADGQypTcpSE9jiM2
	PJ+zNCdsohKC9xdBYxGaawgwSIMjbvDjka2RANJhdKA==
X-Gm-Gg: AR+sD10y24TnhhpA4RYNJZvsZdz15O2SXKG1ST/nlHCWk6A/Pi8Of5IyH4UQjUtkNS3
	ECTn8e2/rArrcBMwe9j32YpFSvPNm8XuEG17hgzXklBuH+SMmBMcpm7xM2hoCrBUk/WCExCTnkh
	d2vKYo94Pyift5dGPZLhcaCqZJUkg1d5SCQyxCbEVkhITXlgUsGxnREV8Paqp0Q4r5eMt1xuBfj
	0eWS4T+JWCOr6uQTs44UocfBMtp+Q7kWshBTZvGq87suYm/RrmgTzhz7fY8daFGiAfiwfNCJMGN
	YcsIIg2OWDwGzZrArjk1LUtK3dplZI7aF8VBCMDzK6QUBPWFCCLC0nhnKJD1o5U/bFL9RSTILKM
	=
X-Received: by 2002:a05:620a:818d:b0:914:bf8a:ba81 with SMTP id
 af79cd13be357-9369d1ba3femr59440385a.27.1786362595054; Mon, 10 Aug 2026
 04:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-2-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-2-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 13:49:42 +0200
X-Gm-Features: AUfX_mzmgezsTeEsc_HIV9oG5qNwHpchZPEJUwGx53Ztx5haBzb4JhKil_bknQc
Message-ID: <CAJfpegt1wHngLs9uR943gT6zxV67D53k3n4GiFKowsAb3C6LJw@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] VFS: don't count references through ->d_parent
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000eb44720658aff3f2"

--000000000000eb44720658aff3f2
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:37, NeilBrown <neilb@ownmail.net> wrote:

> When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> added "before" or "behind" an existing child, so it will never be the
> first and so never needs to adjust the refcount on the parent.  If it
> remains on the list until dput() it could be the last child to be
> removed, in which case normal handling applies in dentry_unlist() (where
> it has been moved from dentry_kill().

Not handling the parent refcount together with cursor removal can
result in inconsistency, e.g:

 - add cursor (seek between two positive dentries)
 - remove all real children (parent refcount not touched, since cursor
is still on d_children)
 - remove cursor (seek to zero offset)
 - close directory (dentry_unlist() will skip parent refcount update
since dentry->d_sib is no longer linked)

Repro attached, produces "BUG: Dentry ffff888107ef75d0{i=143e,n=dir}
still in use (1) [unm
ount of hugetlbfs hugetlbfs]".

Thanks,
Milklos

--000000000000eb44720658aff3f2
Content-Type: text/x-csrc; charset="US-ASCII"; name="rmwhilereaddir.c"
Content-Disposition: attachment; filename="rmwhilereaddir.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msn63w320>
X-Attachment-Id: f_msn63w320

I2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGRpcmVudC5o
PgojaW5jbHVkZSA8ZXJyLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgoKI2RlZmluZSBDSEVDS19F
UlIoX2V4cHIpIFwKCSh7IHR5cGVvZihfZXhwcikgX3JldCA9IChfZXhwcik7IGlmIChfcmV0ID09
IC0xKSB7IGVycigxLCAjX2V4cHIpOyB9IF9yZXQ7IH0pCiNkZWZpbmUgQ0hFQ0tfTlVMTChfZXhw
cikgXAoJKHsgdHlwZW9mKF9leHByKSBfcmV0ID0gKF9leHByKTsgaWYgKF9yZXQgPT0gTlVMTCkg
eyBlcnJ4KDEsICNfZXhwciAiIHJldHVybmVkIE5VTEwiKTsgfSBfcmV0OyB9KQoKaW50IG1haW4o
dm9pZCkKewoJaW50IGRmZDsKCURJUiAqZHA7CglzdHJ1Y3QgZGlyZW50ICpkZTsKCglDSEVDS19F
UlIobWtkaXIoImRpciIsIDA3NzcpKTsKCUNIRUNLX0VSUihta25vZCgiZGlyL2ZvbyIsIDA2NjYs
IDApKTsKCUNIRUNLX0VSUihta25vZCgiZGlyL2JhciIsIDA2NjYsIDApKTsKCWRmZCA9IENIRUNL
X0VSUihvcGVuKCJkaXIiLCBPX1JET05MWSkpOwoJZHAgPSBDSEVDS19OVUxMKGZkb3BlbmRpcihk
ZmQpKTsKCWRvIHsKCQlkZSA9IENIRUNLX05VTEwocmVhZGRpcihkcCkpOwoJfSB3aGlsZSAoZGUt
PmRfbmFtZVswXSA9PSAnLicpOwoJQ0hFQ0tfRVJSKGxzZWVrKGRmZCwgZGUtPmRfb2ZmLCBTRUVL
X1NFVCkpOyAvKiBsaW5rcyBjdXJzb3IgYmV0d2VlbiBmb28gYW5kIGJhciAqLwoJQ0hFQ0tfRVJS
KHVubGluaygiZGlyL2ZvbyIpKTsKCUNIRUNLX0VSUih1bmxpbmsoImRpci9iYXIiKSk7CglDSEVD
S19FUlIobHNlZWsoZGZkLCAwLCBTRUVLX1NFVCkpOyAvKiByZW1vdmVzIGN1cnNvciAqLwoJQ0hF
Q0tfRVJSKGNsb3NlZGlyKGRwKSk7CglDSEVDS19FUlIocm1kaXIoImRpciIpKTsKfQo=
--000000000000eb44720658aff3f2--
