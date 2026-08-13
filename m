Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E623955EB
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622957; cv=none; b=dmor5RceL2/raEEtvryqrdc0dr3mdKlc4jqX/PP1D5oQLKzDIPLQO2oEgqJcLf7pEJkuhppA7Vpa5E1nwTghqY1OQqQde8VZN+pUa7I7jYZGGfMdDuAQzxhYYtOGhl2yKzUvr5ERQ4mNcfzV+syN9mx8hIjg951qRABYScplB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622957; c=relaxed/simple;
	bh=k3IC6C+v80+urc1rLa9+YdhwIPKFI0rbL/DRVYPakg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf76m4FVOlSCjbNpMj4zZCAF3trd8AhNP/JYBo1vPjAkJHDL+JvpHlAimqK5ZIbgJyPE5PZ76RfnsSfO1Iku4VggtPMtlzAhGZgJbcZJ9gZrUeK+mObLwsnADO3Ytf4lOnHm6DcnCNq4xllcIhoeeVgRlMAtX4XdrC9nGuzHy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5Q+r9Iq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7B/sAvJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5Q+r9Iq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7B/sAvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786622955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3IC6C+v80+urc1rLa9+YdhwIPKFI0rbL/DRVYPakg0=;
	b=V5Q+r9IqRJltbLAArsJgvWki3Xaj7kJK3fKbTPhrupFTdFwni6ZRRsXZfZIkkRR4lGPA6K
	uZcDkHQcfP4rK8eD1GBcuzosxzemKwXGrSxpEsZULT++pVHEOKomiUs38KkRDnEn5BBpJN
	Ak6NDQSxPIDDi/Y5xnO0y79Wy/Jybno=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-QuO5O-3zM6KAYH-9DiOtrw-1; Thu, 13 Aug 2026 08:09:13 -0400
X-MC-Unique: QuO5O-3zM6KAYH-9DiOtrw-1
X-Mimecast-MFC-AGG-ID: QuO5O-3zM6KAYH-9DiOtrw_1786622953
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1f74261f67so198862366b.2
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786622953; x=1787227753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3IC6C+v80+urc1rLa9+YdhwIPKFI0rbL/DRVYPakg0=;
        b=a7B/sAvJQsEhBsGzmbMzpqQTv60ZXGbWjrEaoSqZuwEu4Wq3vG4eaoSdIEdsevyK8o
         EwbXTmG0PxUmPeexSzpgZDRAph9ib4c6ZFJXDdwc4ckuygsl4UlDs44lZF7NJPqnYKzK
         mR6a5UfLfsgK2awj9hLs2IAqdoCGAIZrc2SYumBvhOXxFG0hx2XpVXwAaQEOKdlJfbzn
         HSXhl+gjyXPE/XWjG3ljHP3xa4dBnARUA5aHSzQnrCCOxpfvEcJ8tUahoMIpib/upU+r
         lNgdA8o2DstGh9uUssx4YH0tSpTANKdtFxa2gOfexyKTK4Jk/rq9jF1wzYhQNNfNlujA
         NTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786622953; x=1787227753;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3IC6C+v80+urc1rLa9+YdhwIPKFI0rbL/DRVYPakg0=;
        b=PG6eDC3oYhCQv/8LVQ+/1dvdh9qI408tLnF2u2zpq0hDtn77KPkyYoMyhHLldspTgn
         1//NGzqKKDwC9U5pmAHxUlS+FjfnQ/kiz7NFTncohYjr8MogAxkRug0kmGmB/qmtzcgq
         e4iEiTFLHgCGjsY39HezTFudIfNSk1TaSNaEekI9oDsBcQqqwGwFPJ18X/8AfVITf0Bd
         RMnthDlpeu3KR6fKUuAOha8RuhNKREZmzz29qOUCHDH5KzTyt36c4Mi4yI0oLaimqE13
         nWkmhnz003okWpDRIC0TqAnLsxYKSoIW3PgsC62eLe+EhNFUkbzrPNZozFCCfXW1EaJe
         VTWQ==
X-Gm-Message-State: AOJu0Yz2H2/xITAkUY+75VQmHr11PhB8m/nyQnmRf+ezTyXlQ9LxzKFB
	y6vFSJS8DD5HxM1yYmqUG0CqPLn1NWX9PGKK2Q8+TZPaCR3pfAfCPKmfdzOjX+Gqx8W+09ZjURf
	kvxqjfNSDSgZSQydylI26wj0U553SSS+VWnr3IIWHrFtDLlGBW63YEZ/Hu39u68L48QjpMg0mDg
	==
X-Gm-Gg: AR+sD13EJ16HRQy5TbaqJgY1Pd+dINpRiSGQ6CgyQEvhp6ByY3EzJ/lcjs0CQs6Mz6P
	iKrxQXt0JCiG9KS2NQkwfGbkyJ0TKnduNPp3ZjAklhoHKXcTpsO+GkMrZTKR9JGzdPeh8uS93Az
	ETawLRI2V867k0Qcf9WjSpxp9qcvzB53STEnphinHo9IElcJKRj8RE7xakYMoiGKBPpWjWudSa/
	5XLneyxP7O7Aiq9f4Z1VMOFDn56MHD4iynbKI8J16aoElaaNAUjJ+DqYbludOhZCqt6GrDVnnKV
	T5htTySb1Pdybnyns/Psv2oLS4ezruQb2Xq1tR87niSUjOqEL4l1QB+P3UajgxfxGdgqwk4+Iwa
	hiOrmXJTD6vZfluAbZoyu90GZTekUzU+cKA==
X-Received: by 2002:a17:906:c143:b0:c1f:97f3:7225 with SMTP id a640c23a62f3a-c2108e1ae37mr286122566b.6.1786622952667;
        Thu, 13 Aug 2026 05:09:12 -0700 (PDT)
X-Received: by 2002:a17:906:c143:b0:c1f:97f3:7225 with SMTP id a640c23a62f3a-c2108e1ae37mr286118966b.6.1786622952195;
        Thu, 13 Aug 2026 05:09:12 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a37f8cddf8sm777950a12.28.2026.08.13.05.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:09:11 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: xiubo.li@clyso.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph: parallelize object copy in ceph_do_objects_copy()
Date: Thu, 13 Aug 2026 12:09:10 +0000
Message-Id: <20260813120910.4001650-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720-b4-ceph-copyfrom-v1-1-9a4c229df6e2@clyso.com>
References: <20260720-b4-ceph-copyfrom-v1-1-9a4c229df6e2@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the patch, the idea is sound but there are a few correctness
issues that need fixing:

The drain loop walks past the valid window on error — it dereferences
request pointers beyond the tail of the in-flight window, which are
either freed or uninitialized depending on where the failure occurred.

The window size is read from copyfrom_max_inflight on every iteration.
A concurrent sysfs write can change it mid-flight, causing the loop
bounds to shift while requests are already in-flight.

If a request allocation fails partway through, the error return masks
any I/O errors that were already recorded for earlier in-flight
requests.

There's also a design issue for mid-file copies: parallel writes can
modify the destination beyond the position implied by a short source
count before the short is detected.

Could you respin with these fixed?

--
Alex Markuze

