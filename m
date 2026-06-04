Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22A495500
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604634; cv=pass; b=uuwGne2boObLThNvb8BPscTDiNUN5ZlJBN/IfbPBkCOnl9EmsmA8hwjjkwf+vn1K8ZLK1j6rqqSkGyr//EET+EUk4Z66mdjD0E3X+keIQ8ZVcw1b142UmFJjSWyguRg8H3U0Cmprx+Hv9bwKrThpH/oTuN2dERTA6SrUdNMrI6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604634; c=relaxed/simple;
	bh=tnpt1plxHUlxE6Y/7qEKlbnRQrIj6DMGK/q07Qv8qzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeMcLYikpwny/7u2SZcBmhEzuYeFzxYaAvlCzVlBCtyxlFz+zk8QYbdpA0jiCkK4CTo3QttgxuB5FvqgFkb9IOsSpcggDjCm4E/s3/+C04YqcJgQnzqr0CIGPgdbZ5bGJQ9SgKStiUXurCy3QSa1G8QEIxoA2yxuX2GaQbnEb4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iprGVKtp; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iprGVKtp"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e10f91425fso8887277b3.0
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 13:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780604632; cv=none;
        d=google.com; s=arc-20240605;
        b=kT9cGzdmYqSEbvxA38XtPbrj4MsYdX+R0D2GGX5ydyONk0MGz8SuQlgvfFEi4nC85o
         IH7yjQRfv1m0BulYj0eb5K4S4W9Xq0ScMfjwaNd4P6FIBGEtXmKFiJCpe0CGosHTJknz
         ykGiYqVmcwC1bANLTg2FbLl9hGYx9SM5F3M98u8UrSgNQ6FzdQthdauVScQQyE3kQD1X
         6exNZ/M6NekUuJ7s+MKlcc3egh6Wgz5hk98XmZCY8Yfqk5QVbEiVAmGZjCF5fv70aQDx
         ftSZ0nULv9VqsG3WMPfjp8r9653rR4mbPOMCcUAFToyQygQelg6H93Ev3pDG14jUW5b5
         KHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tnpt1plxHUlxE6Y/7qEKlbnRQrIj6DMGK/q07Qv8qzU=;
        fh=fZkmhxjZsIk3A+D1Ob6udQMcN8HMwYcnxsdzkpxnhT0=;
        b=L59Vv8Zt81Wb1hUcRDki+KQzBZ2w59kU9wwg8f1U8st3kf2Zdp2pV8n+jiuOYrpIuJ
         4Kahy7QyqBc5fwXqHty3hbyEjzarHt+xMbW/qjYlpA8mCY7xufZpoNVxPnAoLqHy9Unx
         wRAuBWE7nZ9IkQ+XirKnd7X7e+T3dCcr/Z2sCMobns//jxRzt5+gspgl00V0wjVy54M6
         ORAYPqsoNhewXBSfAPLyMou+R2nwcYubJdTeT0snmbnIoYOzMHoeWTtEryzu7IcTrKR+
         PDzb6MKUL4OFWo7NOelqIholht0am8QHsoXuytAhjSAgUNIInP1LiXlAFwdRd0CvDqlr
         Fp0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780604632; x=1781209432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tnpt1plxHUlxE6Y/7qEKlbnRQrIj6DMGK/q07Qv8qzU=;
        b=iprGVKtpPI7DxhMSQ4AWC33skyRkxMjEMzYlq99AB815dbjfHvR5ZwYQFG4eUhiw/X
         e8qr0iPG/6EjMf4sgjps5WwpkyHNexlApU2ZyxYDI8+VQj4AAbKaHFh1PEpk9neXVrcC
         +/Ijqf5zWU0Xa0p/mpin3g5KEFdIcK5hypcCuG3dOcWAl01dDeT6dILGC2dENXWsMEA0
         IUPG26QJuEvOTv0XXfdhBbcTB/T8OzK77gng6holclUOOQSB9dDkJx7r1qj68fX5Txb+
         LYnVEbifnGt4AW8ZiTNosJk793ZksAuCJxF8mO+uhUZfw+EdKsZ2fyq/mJD9vFXDRV7W
         D6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780604632; x=1781209432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnpt1plxHUlxE6Y/7qEKlbnRQrIj6DMGK/q07Qv8qzU=;
        b=naPz+MtZGvgiKzGG5ms5r4cLtedvjaX9KG39dMugikh5N/dN4atFaRnBcFkVaGjvnB
         BA+uHmR015PQhabayzUeyBa3Z3USvOU36/4oxBHrcq2i4rMJbzccJZZhwf1aps4UCIVj
         hD/QA9Puk09pgbUcxAG1Qc1Hdgack1tus9uXkE2cqv9ymYth4In/TMFPAddYjpl0lxtS
         usLP6EruVNAhlAm1XqM34ISc9TzawH3HQLWAPXpqPaKP4OHDhf4uGzbhdepN3sv8hYRX
         7eVCsYZcCM4LwDx5l/pxG5CGlJDjrjC4ngUPTu86qVkm2dZRVPMMPffV77ktEQIT5nqH
         DVQw==
X-Forwarded-Encrypted: i=1; AFNElJ9K7oH3XAC4uu88uWnDHdQAmTuqYGDHls9TmOMcJwhHEERRqQWYjFPFkFT2GMqHqMmNfdyDRspiSUFb@vger.kernel.org
X-Gm-Message-State: AOJu0YxZp9DO5kGfwl8rT0qbksIqZiTI34axE4vKOMSwSjhTZ74/wR5j
	p3dDWqe8LOphlSCwIk7MdmNezMKoEaG6KK2puNllKXdbvGk2SfJ8LZyr9VD4WCMLD+NfBQBut9p
	8L+XoqdUqaYlrPrkqQzrr+ZMtE8ULfHKo0PKzsfU=
X-Gm-Gg: Acq92OHgOsnltTpPer+/sfu/2qxsN0K2HMIAAAUqRY1MiWzAnm5nRliJDTcrNl/JJZX
	rZa3ZgIPBsyKR3RXVSZW9cnkWGokvjAhJhRQ5lcJ9qvMccqOUBIWlf8qYr/PbnKoM/gMh4ihKco
	n3QMVqWi/8XmHaMFwSGwHL7YpxIDDYzHx8cMPnc49XCXigcr5LiKL2QzZzbLLhQwcXPyiINo/sW
	d776BTOkMgZPceq5hgMCYlZ8QHEyBH++lssh+Z52zDRHa/vw/MFUELsN7K/b/6aZ+n31Mh5e52n
	jqw9tiYPT6oc4lwqd0yaO3fWThLcJ7HszhJdyao9zKqYB8E=
X-Received: by 2002:a05:690c:930a:b0:7bf:ff7:eabf with SMTP id
 00721157ae682-7eb8d3a7688mr31161327b3.24.1780604632315; Thu, 04 Jun 2026
 13:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780596023.git.michael.bommarito@gmail.com>
 <4ac3b57dcf0fba1dc5cc08bfb9a453be55cc465d.1780596023.git.michael.bommarito@gmail.com>
 <7b8422920ac092593e811b6cc2a11350622521b7.camel@dubeyko.com>
In-Reply-To: <7b8422920ac092593e811b6cc2a11350622521b7.camel@dubeyko.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 4 Jun 2026 16:23:40 -0400
X-Gm-Features: AVVi8CeBmQiMIUO3Ml0m_qo2s69epKzrMVOBD3GWQi0c7NuelSLYc5QpBWKFxpk
Message-ID: <CAJJ9bXxCQQJHWJDp1m_tGs5WZgT-edzMcdk7HV_U7siWm7mgUw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ceph: bound num_export_targets array for mds info v2/v3
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We extract the num_export_targets from the message. What if the
> num_export_targets is huge enough? I assume we could potentially have
> overflow during the multiplication. What do you think?

Good catch, we definitely need a v2 to address that with size_mul

Thanks,
Mike
