Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250C3F39C2
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839308; cv=pass; b=kyTMZEme6FVGfxs0Bbs39hWu0lMG/trW8uBIzQMlEdfummUTx8V1izzBLuD1PPJ/x7zYjJh6DWOXQJDf729aUxADHgEAbwzm9OzrUNhnhc2Lyps7IBMAwjA75wBNMulsQDTDsvAOMKmmdzlw4lCQbrnwCJAbH/K41/o+9WqlieI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839308; c=relaxed/simple;
	bh=Uqon8sTuYJL8ETi6rLp5By4GKuvLaOKh2jdTdpLgy1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obPn90P5FnzsvCZtC91OWE3Fe6yFA0XMzE384kdMdYBuZ+CjcX/amfdRX7hD7cKHAjk5QdRLMaTkIMB7tV2pAqhI0CegAnN/aUnAvc/ISJIjk84/pbixIsZ7m43xN4QURY09Zyvai3Rrq1xnvM3QVT+U1Xmu2O7hK2nb6G1XqFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlYfGUKi; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlYfGUKi"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-74a9ac9cda6so537235137.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 13:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784839303; cv=none;
        d=google.com; s=arc-20260327;
        b=Fy6UEZboav6BT5Hl2MlG1K1RsZ9PzBJZLFHLQNmFha6qzuAnEiVvfHtsdIDHf9MlwW
         kWTOcuD8OplJhiAPqr9z8hq9ZvnPLvMTGHxEOvHlg4ECH+xB6i8voG0ymtL4ye4PFQWV
         y17aX22dw4bbFoEtQNzkdcqpJLDgfUs9FbyQEl4mdW5OSu0iBajB/nnmmLBOCwUq0xr9
         yS04evu1pUFv2vivuyhDtxtDasSppVVeF3Zl2derMuDxT76VvpIX1MGUce05kQQC1k9o
         Y1f3kkOmjbnYEUvTgterct2loUyvprfnkQbCWdjUgeSuw11J3JsyJ472Gv0o34AYki8n
         n4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+8yGdNc6/w9mNw42jgJa7vB4Jo3ufnMN7VqnXuoDKk=;
        fh=GV/WnNUe4LqJZWX5sG2UcV2gomLNmSKwAjeVGJGZDew=;
        b=bbmQVpzkhjH8gyBCxmVGk6C9KE5yFbE95O7TtWRJ5BM4Sv+qiky5GDNw8HbNI1rJFW
         3wYDCd44G45pSeRvIFqdcTuoQBmyEmqQmT8fJMZeNK5BSVB26qv21wBMjhpXG7wkz/S2
         wr9VIsaPn3qHYdfjSXFkZSPstbcHESpV+mRuIJ0rLhMhE3FTyVvDV2PS4hFpBSREqIi4
         MUC7EGQoPQUytaY+dmp7pH43lySQP/pHsG0F4HiHP6fyBCo8osHyLNRNMPCrZFrRZ6Cw
         kcfiEdOwwELU/+o5NgEs/DIaVT/XuSQ5mNeAkcoBK+2SQafVWbgiqhSvCwATW0nuUhqT
         HF4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784839303; x=1785444103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z+8yGdNc6/w9mNw42jgJa7vB4Jo3ufnMN7VqnXuoDKk=;
        b=dlYfGUKiAQZkZFh2kbbhFCVRxJSrmNY6qDalXBHoiFCzgiuY9J1/uq0MNeoDibVp3Z
         W0T0ZD7c+0gU2TaDMJ/WGS/8gA5dQSkqPJl270kDyjEJXyIGxn2fHQCxK3IjVor8qjdn
         jWgVULs8fa9yjgC+4ViaNEFt8S6xV0IiYZm5YiFhe9hoIlR+/sqZatS6R/hoTg1CXpmk
         a66icIMUjF8UIqYTh/vQAc2Kjcg/YN4BDsSIEtTYGfLIKe5LPjHo10upYUCUr57RiOkT
         q48zRJ0EYv72DG3ShOUTxFB7/M+PdKHDGGXUjqzW4w73RK2vAuOnxbPsS7r6Alp5kcl+
         Oc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839303; x=1785444103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z+8yGdNc6/w9mNw42jgJa7vB4Jo3ufnMN7VqnXuoDKk=;
        b=TLeFyGZLoQSw5BP4lTY8rz4cl1v20rZIpc3rvQYYqcasl9MfsurgqomFqRjrKDNXCe
         5Rk7dg5hacysFIkOOywZDnf5V7/w9B++eYksZ8pn2EtM0DpwNJAzAaxp6oeQFewgKcDo
         LWAH6DlKPtadYcqfEPY1fbUHBb/vOf8CGCIt4gq2fxU2WVFHlSA13WNwXWfLe51rVBjY
         tXpVNtG7V3EY5VraQWnLqiMb31/+7NO9K/Av141jnLjc/OTxCmG3yFnVTI38zyU202GK
         aAJ9RwI082oFPsZYjHOTZHnE/J0RTovPjrWGpi7ha/hF1tt2dTPbpIfGZ5S0g2O2Bo5J
         nWlg==
X-Forwarded-Encrypted: i=1; AHgh+RrBes3CkPUrjviru3Cs/RQqH7qrnFo8bRaGgYASgB1Qb6RxaB1jlbdUD0P6w8R+cu94tjLHTEmT+TqL@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHG5EMWjUJ82GlHH8o2Ap02VnMQoMSFCWM0FPfRJXCvNSjqhS
	5jUcndw0DeDdz2q6Xt+5JuP/NM60fT++4Q3KO+k9R3McJgZqIeOUY4sy1I0cLq/5wcT9ymj/dVk
	27nH8rwZ+4wN+YbaFEI30jgydPLCezm1mhFXb
X-Gm-Gg: AR+sD12Cw0MLt0B7qs84jxUzGaF37QINeX50NCbD5+cnebenqwj0Lsv0LK/nTqQ4mQV
	PnY9I9Tg71ee7OCoFlf8KPIY8M+R49MC4TOAWvAH5Wer4M3BQJ49Uw9nQpEse1RT1UaNRVxG8NJ
	EiM7qmwh4BrBjWABGdZHkSweDEDIiwpDJKBvNe/7XGLynYaZAuktIDiQaEmgIGLOwVJKfWgn2vO
	2a9Tw04g1e8slJBX7ZBCccofPP7PWvGRkPeYJa1YxjWmTmIfeG4PKNtBABB+sj3bWu+5xzaVe0S
	ogbxzGLkc69gcTJ0La4=
X-Received: by 2002:a05:6102:26d5:b0:74c:540:8f4a with SMTP id
 ada2fe7eead31-74d60a1fe20mr2531623137.26.1784839303153; Thu, 23 Jul 2026
 13:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519110130.2189287-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260519110130.2189287-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 23 Jul 2026 22:41:31 +0200
X-Gm-Features: AUfX_mws_mkBR250KtG-i01Sk9DtKPJh5jCwWpeupo8TXE6FdFX6sw1zqyY6glg
Message-ID: <CAOi1vP_6WjqQp-7a_g6g=U9100cW54G-1jSjWRH3ieh4u9u-bA@mail.gmail.com>
Subject: Re: [PATCH v3] libceph: Fix multiplication overflow in __decode_pg_upmap_items()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:01=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A message of type CEPH_MSG_OSD_MAP holds an OSD map, which typically
> contains a pg_upmap part at its end. When decoding this part in
> __decode_pg_upmap_items(), a len value is decoded from the message to
> determine the number of items and the size of the allocation needed for
> them. If the len value is greater than or equal to 2^31, an overflow
> occurs in the multiplication that is performed to determine the needed
> size of the incoming buffer to decode, as well as for the length of the
> allocation for the ceph_pg_mapping struct. Subsequently, this results in
> out-of-bounds writes (and reads) when decoding the incoming message
> fields into the ceph_pg_mapping struct.
>
> This patch fixes the issue by splitting the computation into multiple
> parts and storing the results in local variables of type size_t. This
> prevents the overflow by performing the multiplication in the
> appropriate data type and ensures that the result is calculated only
> once.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a0cf..076763420b1d 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1615,13 +1615,16 @@ static struct ceph_pg_mapping *__decode_pg_upmap_=
items(void **p, void *end,
>  {
>         struct ceph_pg_mapping *pg;
>         u32 len, i;
> +       const size_t item_size =3D 2 * sizeof(u32);
> +       size_t payload_len;
>
>         ceph_decode_32_safe(p, end, len, e_inval);
> -       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
> +       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / item_size)

Hi Raphael,

I think this can be just len > CEPH_PG_MAX_SIZE.  I have folded the
corresponding fixup into someone else's patch that originally did that
only for __decode_pg_temp():

https://github.com/ceph/ceph-client/commit/9f00f9cf2be293efe899db67dc5272e3=
a9c62717

If you agree, we can retire this patch.

Thanks,

                Ilya
