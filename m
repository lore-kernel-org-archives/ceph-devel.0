Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762C3B83E0
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596765; cv=pass; b=dy6GxqiH1eO3yWmxw/ge333FZRZDd/EHcNkaEnYp58nNd00wUJ3UNSRrMFzSZ9NmdlEGON7yXkoYT6ynx5FbZ0K3oOFIa1Wo5uDkEq8f7OTfOZODx6ugmDfBRERJltuixIlq2Panf9DNp+RXn3hLCzIHIgqnkWG+qcpUbQcwpKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596765; c=relaxed/simple;
	bh=GUYf/XI9OYUhjYFylt8gnKcDSw4oZpBfJ6ZK0RPEIvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7eNzUd9CNWjB34NaIwKVj9bCtD2OVSliA+65WOaR5Pa8hiI4AUPrU7oOb61z9Q33jCEXBZRzVe+NeMau8WgTgocrjAtsiu7kzv1Tm3vA1C+sphBre1s8Eppmx6hpnJ6Ya3dOUjc4cOvWsX4ZIel0XtfglvpOwlvH3tKbCkS8AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHSUKY8y; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHSUKY8y"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-63319183a49so882431137.2
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 07:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596761; cv=none;
        d=google.com; s=arc-20240605;
        b=Ayi9O5F90ScoIXkBbimmLzrgaZnQqI8fyn6k7e7f/Kov73TsxbV9vXGxS8jP5a7xjt
         FZGAfMY2fTvSN/2mQNVmB4k/wAumOqz58Cd6nHbp5o9OjPiDF6AtRTk9ZYwLMrS8oujC
         nz+pQtn5TZYwNsvWdNwrv00IRuLzmPGkZ7zEPiKNX2ZjJulnVwXBQN0WUn80bLki33Bf
         Udp0N+nEcw613LUMvF3hw+ArGDgSN3FvYDm+9QtKtrgSH8IhJhvYrSbF94fC8yssum1O
         mynu3w1WuhQJsYOttAcUiY9z1dk/5oZ+FGw1l7QEh3jWh5xs/A/5bK5041WgWWA9dHqC
         Ld4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nsG0SEYKuGRvXtPAOYb56/ff3PDw9OPmdn6WM7nxiRg=;
        fh=e9XBH7Lu+UVBFzNOmJsotg3F0kKy9eAjVFaXoIQs0yU=;
        b=J/BMkhVqAkxKp5I5eDMbE66cdxyCN/+RlbQZCAxqTLTwFipC8+em/q1AebsZIGWtc6
         zcZ9jXwOa0s/YWhZUDQ+Z1w3/mwnSavwrQz/RdOkEGakdgya8sHDzFtTiXY0A4oHHjmO
         P1UZch+lXheTGOvQL89koJevavW+XzY94d8W6tCXuoIcgnFhMY1m4wbZA2R+kNbT+yvD
         sgS3HrAfGIxuQJnVmczyzok2Ne0Y80GX6Xsk+qAZI94CqPGgHbxo5pczLO25kAHbY+jT
         G1LzZyLuxVzK0yKYUQevpEQ+b59ey10AP4+u5ixtv2jnEJ/h0veNwVO0pYUu79SmKckm
         23mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596761; x=1779201561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsG0SEYKuGRvXtPAOYb56/ff3PDw9OPmdn6WM7nxiRg=;
        b=XHSUKY8yOUoFaP+5Lt9kBkpqzcduSdTH54D3s5srUHGfPha6fWh/QmEh21AHnZkyI/
         FdpexH2nfjdW0t8l4zXQRkynH39Wh3yHXitx5JiJ9ztVkQfoj8Y6/HWepv4+UeDb8Obk
         QzIbkqae9rftGjh9RYkc2xAdBkkO2Da0NYOg2THmjhdiy3a/+HUU2+ZiTLhkkxY5PTed
         qUOmT8Oy1eSXfd8TWy0O/nvZSTDnloxyFYdS5hjH+O9zXyjkrli98iVK94egXAdV/go8
         bv5jY7vjTjQeGIR4bmeCIErIwahODlydqWUB5DCJbOX1rYqwBPuWq7XUkDGI5jSle+3I
         cNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596761; x=1779201561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsG0SEYKuGRvXtPAOYb56/ff3PDw9OPmdn6WM7nxiRg=;
        b=a/lWupWIJ7g5qpb0FEPZpQOKaFuQdA5CJ6h7kt8tSEQbxdPo3QyRSiDufigJxJFgZO
         qF7ypCYQLogzWTMpE9tBeIg7L419MK7tOJQx5TzceMK5c4gues8MT32T6072SLBF9DL5
         JUTtZitFThHBDMgbNAtFmyBQZWQO9XH8C3LRD7oT+3q44wcz+TVLyJcCgbQTzOYTPys5
         jFHnScmqAALuZPjxUr28hmrIdv16a9BOzzhgBqcemtQCd4on6P4Sh1/WSwxalpadpGDW
         4XpJDawWUf8ku2Z5raoav6P15+K60KUhVMgocLQNh00lG1HbosM5gJdynG9f17MBb1ym
         vw5A==
X-Forwarded-Encrypted: i=1; AFNElJ/ZIXxOT0kHz6/Xuv4cTDnsDs2FE1xxn+nOb5RbR3CT9E+a9r/uXw6sEb/Yo5zNa3Nqr7F8u1ZLy1Uq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcf+sYBkVxxrHIazL0p4ChuhTBGKQTQtovSYlXomi0M5Upplzv
	8D13/4C/H41MKDLx7Q/CmBVXr0PHuFcTcAB87HMZ1B8/F55HWWjUQKoz/Peg7B2gfdepHNMEgfY
	pB3ECDu9ha0FZQb1S1xiTEUcJfMRIXGA=
X-Gm-Gg: Acq92OFS9YgjACi2b+0ubixRmaEC64KpUmW6LHtn+mXVPYrtoDdfOrESpWvWow1uCwr
	JRNuRCAMALn3ESAyGN0HTWN2x9ypmMDmvZUjlRJFecG98aqGyVvlvKnxJ4nyQjrwTBkKX7KlIz/
	Si9BXVrPwtC4ZE9NGE4P9uS6gDg+a9nRbpo0KTZ5R+/e5kWSxKqg9EX2A2DVzEAR7AVMCiGLpcE
	pXb22QowkrAMUr+QBDavM/Iq4jlR80V/NsxWSsQiaQPqSGmU4tBdk/KRiyY+ogTpcQkPOHO1YVX
	Fk0lkPE=
X-Received: by 2002:a05:6102:6449:b0:636:c0c:4d91 with SMTP id
 ada2fe7eead31-636186d8a65mr1492237137.28.1778596760992; Tue, 12 May 2026
 07:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512072930.1366034-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260512072930.1366034-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 12 May 2026 16:39:08 +0200
X-Gm-Features: AVHnY4IVKc-I-cQTOvS-k1tkD2ZJI6lPK0bl2whpU2WFRIWdSP0ZqXih_-8JJd0
Message-ID: <CAOi1vP_29qgFP90kqQEV0jBnTWbWQ3shQRrvE5vMdjQxmx489g@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Use non-asserting rbtree insertion function
 in decode_choose_args()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 9:29=E2=80=AFAM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A message of type CEPH_MSG_OSD_MAP contains an OSD map that itself
> contains a CRUSH map. The received CRUSH map may optionally contain
> choose_args that get decoded in decode_choose_args(). In this function,
> num_choose_arg_maps is read from the message, and a corresponding number
> of crush_choose_arg_maps gets decoded afterwards. Each
> crush_choose_arg_map has a choose_args_index, which serves as the key
> when inserting it into the choose_args rbtree of the decoded crush_map.
> If a (potentially corrupted) message contains two crush_choose_arg_maps
> with the same index, the assertion in insert_choose_arg_map() triggers a
> kernel BUG when trying to insert the second crush_choose_arg_map.
>
> This patch fixes the issue by switching to the non-asserting rbtree
> insertion function and rejecting the message if the insertion fails.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 2095e73ccf6c..0752a3808b91 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -392,7 +392,10 @@ static int decode_choose_args(void **p, void *end, s=
truct crush_map *c)
>                                 goto e_inval;
>                 }
>
> -               insert_choose_arg_map(&c->choose_args, arg_map);
> +               if (!__insert_choose_arg_map(&c->choose_args, arg_map)) {
> +                       ret =3D -EEXIST;
> +                       goto fail;
> +               }
>         }
>
>         return 0;
> --
> 2.47.3
>

Applied.

Thanks,

                Ilya
