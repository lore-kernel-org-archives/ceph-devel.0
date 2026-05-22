Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54A362137
	for <ceph-devel@vger.kernel.org>; Fri, 22 May 2026 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491106; cv=none; b=dCyS9ssLU4Uv9n3Xt36NVCXnJiy8ZyiOV4OTmZ0cBAqwRLdSi2Fpiv8+2h+60BQGVA0QxiyNzsVLnvAmoivnIiC1U1bu7crtw9Pi84lSvj3McNNw87U9D9Yj9Tncgirijsvx2o1bEU19KTMGdGri8WeOx9LCKL4A+WXH92X2WEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491106; c=relaxed/simple;
	bh=eYKPagsi7R/keg3Al7Cflew0A+wejnpoajrQVwu+upc=;
	h=References:In-Reply-To:From:To:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=V9YKaFXFB8BmhJUvOPg5c1t1m9oc4Mwv8gyEz50eLk1ZFcOSryg5sCbDoTqiZ/lxF6ay4uGp71Z2AVJjFkPbktJeeqUUr6YqJCL/FvcJI0M4yp0UyM5ilSZ88Zra58atGoXPMv8L2+iAzF+KrfUKUAssWiIqy2rZWlb/sArFMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=weblinkconsultant.com; spf=pass smtp.mailfrom=weblinkconsultant.com; dkim=pass (2048-bit key) header.d=weblinkconsultant-com.20251104.gappssmtp.com header.i=@weblinkconsultant-com.20251104.gappssmtp.com header.b=P0nP6m2P; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=weblinkconsultant.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weblinkconsultant.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weblinkconsultant-com.20251104.gappssmtp.com header.i=@weblinkconsultant-com.20251104.gappssmtp.com header.b="P0nP6m2P"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516d78df76aso13094041cf.3
        for <ceph-devel@vger.kernel.org>; Fri, 22 May 2026 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=weblinkconsultant-com.20251104.gappssmtp.com; s=20251104; t=1779491104; x=1780095904; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject:to
         :from:in-reply-to:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYKPagsi7R/keg3Al7Cflew0A+wejnpoajrQVwu+upc=;
        b=P0nP6m2PZxL/01ekxs6K95ddUzppm363SscaX0JRHOsdWylG/WKQpM+njRwnKVbRJb
         sYu5/5wDExotIx0PAPfAdwBNqhTfll3jNbO3nhqecm/oRDrXJKcPurG0rjFBIzjvU9BW
         FyQPUiqOkMKSo0bXFlad/x2zuhhCr4bCcNX2yBiQ7BszvUKbSTg7rvk3sTihSPZnT1qx
         31EJzBrTEtC/AiX7BGs1Kfu31rG1DW5D3IBqxVzytX2ednNibPFUvmFVBksPTrchrhLh
         rQ9+F1gds9Ti5ojRT7rlTC8o4nMIPTF5SOR7nOwWU1NK0ZFQyDplIm9T2C2PgKZAcK6r
         Y4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779491104; x=1780095904;
        h=mime-version:date:content-transfer-encoding:message-id:subject:to
         :from:in-reply-to:references:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYKPagsi7R/keg3Al7Cflew0A+wejnpoajrQVwu+upc=;
        b=rQ5QTtzfK5fHKjNJ9wSwo7fjbmvQvQasmizpIk5Yf2vrzq+xWpAyEr1YEwnoia/ihb
         iZPH5UtQDDQiIVuzFxKuJ+6bRbRA7/xKcvTiAkoRUycyRQ4BJLW168votr8meX4R5iXe
         B6QDmtyztBxThCQo5v/CUOghyqD1oGcnJp4Xcph1a8bnqWhwRvj7lQpgYEF9BObjssKV
         YHGO/+ul9FgbKjtlEWcAcGrQz2irSNW/1zPYnCe5UHlkU5LJHjUzfwDsEghqYW/3ff7F
         0vZJTuoEGLqHwNl70PuhEQ7YB395J3L265XNbm5TsnQBtHqQWPNFbalMvd0NKUq5lM4T
         0zcw==
X-Gm-Message-State: AOJu0YyPnXAANYS7BdWQOatuOiSO583Fm4OJe0Rb7t8EbCOmbeRQWXNd
	x188E2b3uB9uqLXdoNh1/2LdwN68awv8zlDCH75wvRB547MMlWS5p18thzqPuHQ61vDn3Cy+xIE
	rOv+23uM+RA==
X-Gm-Gg: Acq92OFGp+DxYI/Vo7oiqzC6/boNfpDj+32+vmn4RiopGLRmP5RJWqU2LowgmqrrQA1
	iGxw5Kq75yPIP6+1+0sR+V0+S4vsuouy3LhP1e0bwD90G4o5g61crPhnTywa2gK58Upjp6XUSQu
	A08OF4d6DFHDPlnI4+QSYuNn3uWT8+wRjMZPo8Ys77TVOSC97z5MLzWkKqy7xadoNhQGHFXBe4P
	zd8gNH/5PwQCCEzYz0YM5indsBk0A1VB27fi9jNwkQdMpNDCz72TGLB2ZIfXWtXf5nSsmUGQlg+
	OzKtSMyKQ8BxBZFjpzzwbq3JOm0RQl8sO62kfC2CTKB2M4curRiR4xbaOlqiTb0B/BMM7tuzjV/
	UKwPBJfsSy9LqsobBHl4w8UDRodRZMbqzaJ+1Pa8TCjY67z98sIjR6MUquQOwOLifK4fPnfvhKT
	1gIjTYRsk1ez3aPLBPOCW+v06aVYZxn6FN2WfIZ6EX5RLXAjuGQJy6+Ltjg3eWTiBfQuHBOwBKP
	m+8hUSpDUBVw8E=
X-Received: by 2002:a05:622a:3cb:b0:516:d73d:2a3d with SMTP id d75a77b69052e-516d73d2d76mr62394481cf.14.1779491103939;
        Fri, 22 May 2026 16:05:03 -0700 (PDT)
Received: from [127.0.0.1] (ec2-3-95-250-151.compute-1.amazonaws.com. [3.95.250.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8c91a66sm26157101cf.15.2026.05.22.16.05.03
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:05:03 -0700 (PDT)
References: <6584ea0f-269e-95d4-7839-139b36c3f67c@weblinkconsultant.com>
In-Reply-To: <6584ea0f-269e-95d4-7839-139b36c3f67c@weblinkconsultant.com>
From: Ruth J <ruth@weblinkconsultant.com>
To: ceph-devel@vger.kernel.org
Subject: Partnership Inquiry - Link Insertion & Guest Post Rates for
 ceph.io
Message-ID: <29e8a9b7-84a3-0bca-c4fa-381bc02469d3@weblinkconsultant.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:05:02 +0000
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi again,


Quick checking in on my earlier email regarding niche edit and =
contributor opportunities on ceph.io.


I understand you're swamped, so =
I&rsquo;ll be brief. We're currently wrapping up our partner network and =
would be happy to include ceph.io if the pricing align for us both.


Would you mind sending over:


1. Link insertion: $?
2. Guest post: $?
3. Link validity: Permanent or time-limited?
4. Link type: Dofollow or =
nofollow?
5. Sponsored marking: Yes or no?
6. Guidelines: Any restrictions?
7. Grey niches: Yes or no?
8. TAT: Estimated days to publish?


Even a short breakdown works.


Hope to hear from you soon.


Thank you,
Ruth J



P.S. Need immediate help or have quick questions? Message us =
directly on Telegram @ArchSeoSG - we respond fast.


P.P.S. For every reply&mdash;yes or no&mdash;we donate a pack of dog food =
to a local shelter. Even a &ldquo;not interested&rdquo; can help a furry =
friend.
