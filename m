Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF231E840
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540055; cv=pass; b=cBye+/BB7vqe7X7kpIBfa74nG6orkSIAlDmCZLw0S+di03lQ19n1eMwB//2NGLED4os4yCKr5gnmfaHiSquOICpf/XaCsSdv9ctLJAM0/Ky+IOQ0spCEATMlH+K02M7JgybdxYrzzqHI/pce8j3pMwE5Lys3GFq6E7l5CvS0GF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540055; c=relaxed/simple;
	bh=SgWJJw/fkYsfoofTWyw5pzd5vJC8XNotWAsiXbt0LNc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=N5mlRSKWOV5N5AlvPqIHApWEtXeJqQIeS9WQjCJAFwXteXrgrjMVqY/oZlDsXgp6yNbt+XTMScWGDDTRBkmScDZZLr9cgFMhRcVpqfIQRLuWX7a4hvBBuhD6M/BxFyWPKC1Jb5v5FipSIRx42UvhaeVegGGooZwU2PR0kXHbCdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=qEEJ41+O; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="qEEJ41+O"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15b1da6b82so98009266b.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 06:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786540051; cv=none;
        d=google.com; s=arc-20260327;
        b=KHFESSWurmInja96p2Y/xpEy3Ilj51/qX/ZhCagz2D3s3YWhxL9wC/hzYpiIVvFKX6
         olLQdY272047FOaBhN9255mngfMvdIV5dN9yT9VtbxHvnwedfnNIAV9n+dU+p+AL8Orh
         q0lQTJftvKoaoOriPm5yP8o7YOkKEYulbndti4+R5pA1zIFsWzt7SXXEEJa1qfHdKQbB
         CxEn7Z0rvNGuplMe/KqSIOGFwiK0dP4KcGiyxNQuCKBbTZsywmPeFxFMSzn7rYRLOnvZ
         ygkZ09smZvBOasni+4AD17/RFLZzzOM4dHMi5n4akeEtAXdFjvdHt5wH3MNphJptpMpe
         ER/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SgWJJw/fkYsfoofTWyw5pzd5vJC8XNotWAsiXbt0LNc=;
        fh=LNJNR5ICo5uOGaOH5IHK231F+IwcXr6qA+0GHCjB3J4=;
        b=L8L5KNKQapv+7OAjZDwOA3yp9GAh/kBSkuJZpL1cl4x4E2EKMCK5+tCtH7buXgwYCs
         1GjZDijXqDIbCpcIbUsympnZK4a6ZzGK/Hak2o5gFqcrre4pTz+ir+JPhwhQEnIe1U7w
         jqmZndmbWOvCsKBj++spBny/cG0Yvy2gjQglt1GpY1D7PnOUraBQPaaOwp6rHwNUTyk3
         Cp9oGJ6fQyFV8+y5qp2hpeTEKuUgsUe55wv86iUiyyVBMrLx886rcBIkK5QBCAcxCS1C
         WcDp3Qb4epuLFkh/J69piro14/MLKIK8Y0Nl82CSiyir3ajXDGvOHYbKGdJoixl+h+ed
         yjvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786540051; x=1787144851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgWJJw/fkYsfoofTWyw5pzd5vJC8XNotWAsiXbt0LNc=;
        b=qEEJ41+Oqp611j8aY4+lBcRwd7dmBCBGAubh/v8zmFazjRl9skNtq6BsJ/Ay62niMg
         /wXAjMO8o0HBcGeEa9+WaHftWcLkSEIrEDna09yVaC6Qw5kazXMOZdPgHnyzFkDkoATB
         6mvDb0U6AjMrjUHp861CjiEH21/hgaYzGeOKsOe8Jlyuy0gpNpE0BofGUiJ5KzUaZ+2a
         Jx+ECfBIUl5pVo8zQVA92UiP3FmTr1+AWeyaztv7rfiZugeULDlN4jHwUxHP7jNZFb/1
         LM74mIHDGTq0kZzEb+pqcXJiix16/QjI7BaXSYGZ0d5hd9ahsrPzdqouH2RAJ71A5Yj0
         PyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540051; x=1787144851;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SgWJJw/fkYsfoofTWyw5pzd5vJC8XNotWAsiXbt0LNc=;
        b=Kvanwr+2qp/QravfNRFigRPsGXaKmf+0YiC9/mkidaAotiynKqki8Jt2VGFkwAIFXv
         ALeP3nlVH8TX16v3d4L0TlUtjhajEd1x8Dp5m8IE5aMuMIF9l1+5FmwdbzuSihSF5b0F
         9oK/7pJD0safFxTvAYq5ZazneDcadWjKaVHrK+fIvqfD1O/sj98fu+/tsg/yPYs11gaL
         e45Q1E8POiYh9DuhB3oW2oXsIJFSkIs8333lm2+Qi6xVPT/czBqUX2vaShcljIqNKE4E
         NkKP7GtJjT/AY+8fSpISnEqoMTY2Vjx02OGZY9u7xd2O6WKgH3SqHbO9nAzr19tdzUz8
         sDbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq47Ap6/eRmCBq3nSy1FtUjubLEXYdXp2ziUw0YGPMyJwhXAFq6eYTYSMWN9MMWjpFxnh8QPNkhfviW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20v/b3OH85Ek+FKt0cVR6fr7SGaMmw3Dzti0S3yg7mjiTTUWC
	WJsDZlJQnoz9MjB/+6ZYH28JfcI0DDJ7V1b7tdBpEihPf5uu8pp1VCtitIQgGLsvmt16YqXoizQ
	Qf4OoWCNm7F02p2zWCo8HBvdBpXNcn/DgKiZ0g7ATwg==
X-Gm-Gg: AR+sD13t+eiWabgQ+jj48RyrXJpc52fClfYTm/HcQLfpx6Id6lm/2Lkk3Ej68MEXcfu
	+tQugLua5d7AVSgu2n3FVIZezQLMfAE06KEAqZiej8YookIp42NMl17eKzx9i2kpty8yo1mBH1F
	OMFpaLQT27PrP2eJaDfOq1p5N2VW70ObzgC7vBHVFCKvTY6Kq7iCpRYxTONoj+skyr4+qFAuRVT
	+lTxWFv0toimbnEbiA/tEnvAIx2JdfbgxPOdJ1BF6GCm9pPbZK+l8vCsDYnkERwPuagtxsev59X
	4IevXx8pAHf5iQGw1l/Kug7GnD7SzCZiRQu57mdulOkOjg==
X-Received: by 2002:a17:907:d18:b0:c15:f4bb:e663 with SMTP id
 a640c23a62f3a-c20f2eaca5amr246672466b.10.1786540051047; Wed, 12 Aug 2026
 06:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 12 Aug 2026 06:07:16 -0700
X-Gm-Features: AUfX_mz7bXvKhJ3uCSXxsBG8r2iumugwo2KvXhHHdEEVo_v2u2VhzR88knE31Jc
Message-ID: <CAOJNxRKEvZ4eTGv_-_VL7=G3DSs08zzmnrpyJiUhYp6aSi2qCg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix leaked inode reference on writeback abort at umount
To: matthew@bargrove.com
Cc: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, linux-kernel@vger.kernel.org, 
	Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"

> Only the locked_pages loop is changed here. The preceding fbatch loop is > deliberately left alone...

The refcounting analysis and the fix look correct to me. In
particular, the claim needs to be dropped before
redirty_page_for_writepage(), otherwise ceph_dirty_folio() can observe
an already-claimed folio and create an extra wrbuffer reference
without taking another inode reference.

One thing I'd like to clarify is why the locked_pages entries are
guaranteed to own the claim being undone, while the entries handled
through fbatch may still belong to another in-flight write. This seems
to be the key distinction for why ceph_process_folio_batch() is
intentionally left unchanged. Assuming that ownership distinction is
guaranteed by the locking/state transitions, the fix looks good to me.

Thanks
Xiubo Li
