Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5E392C2B
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052433; cv=pass; b=Ie4F8CzPMCKs4E40JoZg4NxdsH9MswV4vcwiz9nzgQ/W1RPgNp/4vKAxleVQRc5E5VojH9V9gEqUhaKmw0bujGpb916Zx2ZMZvgSFUVJ4dUdYNJ3K7Hkx7bUAn5ZT0VsIgTZKShaXpoAvUxlIPNUUucSPopk4sOmimQdX2kwd6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052433; c=relaxed/simple;
	bh=aEcBezC4m06MWgP66H9TyeW8O9FHbwGzBlacl6Fbki4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJ2ZiCrYHK61UePFuvLYWk0/vts7L/gYs2HN/iyJlcBc8TU8WLWayhqaMT6/Ytk0cCKSQkzivO2ufQ7Pj3hRY6RwQB4UKO3TiLc03O/bNZ/0h+kZPlNY3+3v+3t3SfqrXt0qUb8CZ3znLZWhp3mPLTXrxCZPhQuB4jFOp7sdNUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/2KYaYi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTXGqhV9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/2KYaYi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTXGqhV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773052431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omvXpZsgd5W6jLMzC7gOcWlLPR1tdgISZpvzCzXZ5+U=;
	b=f/2KYaYidXqP2b6XySVSqjDJX+2X9Hseoggr0XZ149wp60PizvzK1PRWp2QFcvmPA1lyvE
	XKPxMVqJW9dVtMZIzVLnukrl43CtJEwF6/94fsuoX44Hyx3yomrjEM+GvqVWgUYJp1pnil
	u2/fWYoeV7kxcjlSJtGbqWY13WeGFKs=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-FaQBA-PPPCa0H0CfpFjIIQ-1; Mon, 09 Mar 2026 06:33:50 -0400
X-MC-Unique: FaQBA-PPPCa0H0CfpFjIIQ-1
X-Mimecast-MFC-AGG-ID: FaQBA-PPPCa0H0CfpFjIIQ_1773052429
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94e4b6c8cd5so9084001241.2
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2026 03:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052429; cv=none;
        d=google.com; s=arc-20240605;
        b=j/4/9k4A9FsOITHaerDqnpdYd4QvoByVRtkzE2jDwR2spudJGOFb9y06/+xEm/S2Hv
         iei2vxwSB5j4qEiKzbWvD9aRbhuGZFuIyn33dK8UrM16ZPOP+kzKyfA7zMeTdnnq6ZqA
         hWPi+yEDfkXj91s0kfZmvAMX/N0uYzZkbdZLNkbJnHHe7L19MwFrqURCYvM5TShO2tg8
         bqcqGfmy+qAGUIFOYKUwQAbhsiQkv9C6athnan/U/3hVNS+oGMhJSWF5b+ic/SEj6fgV
         /C8Iu+VB2odt/HaQBjr6u/LSHU5aJY55VJRr0LHbIJo6T9fqTmuyW5qIRL72Z7ydpK39
         cM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=omvXpZsgd5W6jLMzC7gOcWlLPR1tdgISZpvzCzXZ5+U=;
        fh=ZcmlDZpZepjW29Sxcrl50L6zCHgByB1p5N5PPmHMTSA=;
        b=jV3bHMjVRrIufAIcg9wiV6SZW8JFr0LRJF4ZsKKNabm1FCAtCMyTZELFDYGDm0OQQv
         y5LpIOoLbZr6zyneOsSVLV3WSnDnaNlmLKjxH/nzuYB9I1fxeIHVJ5FsytZWNJRNYmAW
         wEObqCdPiZhTLzJLD+MnCAeyw5/d1d3yG83J0bSjdp2qCexRHpfGeCk7UKWk9Wkhxn8M
         sUdmDaeX7vjy2wDbNmKxYBwkisymOhKW5IbFeqF6XpA8wuwW1YS4EBiPrQO3UtpPg/y0
         SjZJsJqIQuh93HCNJgtFqvGsoVm1SU/zU+DFnU7TbGIsYv+jRj9I0NCzF+PfJGPAxh8K
         BLJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773052429; x=1773657229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omvXpZsgd5W6jLMzC7gOcWlLPR1tdgISZpvzCzXZ5+U=;
        b=FTXGqhV99EtN55+G841w5dZrVqXXnZMAxYLfv6Kk+BOsjVoaMjPI7u2SmN2VnUWJpz
         XTZTz2LES+LTmcpK5WDBHNwkwfXPeYfVK7kx+oQlfbyAtwd2z5sYtSsgSnW956Co3Fn3
         l8NTrTIsG0p+NX/8wZ4cro8UQOBaypOlxvJJruZpD51ds3ursGKZ7lGzZB+NjFccus+V
         P1M+FkwxJku99vrw7m0+mWim6SGuyev7eIGnT1hTQVYtRvdd2iCVaeRwRcrNAOQwiJAH
         Ai0M1CD/WOTc0pVbynk1VNS8NWhDL+2b9HEx071eNhxTkc0wSCFirAfOXrBAazZ+sR7V
         g2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052429; x=1773657229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=omvXpZsgd5W6jLMzC7gOcWlLPR1tdgISZpvzCzXZ5+U=;
        b=L3S+T1zEcMBG0ZzSNn/qa1FhU/AkfeuwzDuB6o3gIQ8b9qBjAuNN3ecKhJwUpUsX1u
         /oIBWstmHCIWevihv4DPGTH0p9lKawo2JE7/fOOAeYnEpPFF4viRiq2su/HLGUQnv9tw
         ykpHjk8FplD7pR8v+87W8LdiATlGD+7TKYmv12K5OlwijUUAOOnkiKmfDUfPemSRUEPX
         frmd/5Utcc8uvO8BH8e/f/2ngUTNHTJG6EUKSHgH37VHiYzIr653+qxoLl/XcHAMzpoT
         N5cmsO95QNG2pdd3Q0/okjlcwQySUwwP53/xnSATvCwzBNKOshlnMOKn8Tt56ombBdyN
         5CUA==
X-Gm-Message-State: AOJu0YyCjOw1NhEdk8SKFq4JUWlRUPSiVma8FCKcJJ9fgulJEx6ePj2x
	68+VT12ZbBEYw0ecFY0XRZ3hBnQsxx46cqkRnxLlyi8KmAEcKN/+Sxqj2P9KFYJt01gp076BX+G
	CWOg/XUYvLHXA5jEasPNKBdlKf7mdFcWkh9y0i4qvi40utyaX9WyMsAB+X9NDcGjuxfBLPaVP2f
	ty9mPCyrpmXEOjp9h5xU+sRlkDn1LXiE+AYw2CSw==
X-Gm-Gg: ATEYQzww1nKBBtZTmCHLehUyXQGjVSmbH8WCJCV5XVRKCxrreGgiDpQKpYonVGGZeCg
	87SMvqcSgxN9ajKP2ryAwnWb9+25hGKJidnRWlKL1L04Bxc1b6T5XhDeIvHjt6IMzRb0WfbfC3j
	aHVDyRcj9xlXt7NDX7sQdmKcFqWsj/saomN9v85G7BL8m9pyjcAgJUiZeV9WuiOQo0n4eMLqbQh
	t/9SA==
X-Received: by 2002:a05:6102:292a:b0:5ff:188a:f8ff with SMTP id ada2fe7eead31-5ffe63440e6mr3124984137.37.1773052429369;
        Mon, 09 Mar 2026 03:33:49 -0700 (PDT)
X-Received: by 2002:a05:6102:292a:b0:5ff:188a:f8ff with SMTP id
 ada2fe7eead31-5ffe63440e6mr3124977137.37.1773052428967; Mon, 09 Mar 2026
 03:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308220942.694505-1-idryomov@gmail.com>
In-Reply-To: <20260308220942.694505-1-idryomov@gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 9 Mar 2026 12:33:37 +0200
X-Gm-Features: AaiRm507k1Y46E-nv6K_azSstZHv-9QA7fTNVexUGVLnq6aVOAEpSCc0Bn2toXk
Message-ID: <CAO8a2SiZxnUjqC_A8mm+p0ugRmStQuXdAp4iNKrz3NAqv=KtKA@mail.gmail.com>
Subject: Re: [PATCH] libceph: admit message frames only in CEPH_CON_S_OPEN state
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Mon, Mar 9, 2026 at 12:10=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> Similar checks are performed for all control frames, but an early check
> for message frames was missing.  process_message() is already set up to
> terminate the loop in case the state changes while con->ops->dispatch()
> handler is being executed.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  net/ceph/messenger_v2.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> index ed618435d33a..c4ddf7911f7d 100644
> --- a/net/ceph/messenger_v2.c
> +++ b/net/ceph/messenger_v2.c
> @@ -2905,6 +2905,11 @@ static int __handle_control(struct ceph_connection=
 *con, void *p)
>         if (con->v2.in_desc.fd_tag !=3D FRAME_TAG_MESSAGE)
>                 return process_control(con, p, end);
>
> +       if (con->state !=3D CEPH_CON_S_OPEN) {
> +               con->error_msg =3D "protocol error, unexpected message";
> +               return -EINVAL;
> +       }
> +
>         ret =3D process_message_header(con, p, end);
>         if (ret < 0)
>                 return ret;
> --
> 2.53.0
>

