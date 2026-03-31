Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB3341ADD
	for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977604; cv=pass; b=VtS8tUE0GOGCNjdCGz63tfVTNRvSI6MQi8pmlOMJ5BcwHKiN63/K+NvHMwH5qN2HF0/wPGZvnz3O6Prv9A/9UkqQGY0+5LBWZY+2o/xuwiqCq+znjsYEK01io63bOZ99cnQkS9JlGlINFN8JdcfBb7pnY4GpCuR0MhYbWaBDfJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977604; c=relaxed/simple;
	bh=c0q53cbxfhJuvBfcU7htPjnilULXhgbxhMvrTcE4QJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byRyWbLqQCwAgoBRejk9M3wq3lMe9YQ4l/KuSzjHNjbcs6KTbDk7pnhgPIQ/jxG58BUu31gHAjrACzxta+CO29/Ue7qExFKy3SjeAbp71LF6ZsBbbaF8gff8M2HmHqaEQDe+ZNmTeVITYRGKqet/hlpWS2iQrjAYDzEaOuF7/H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeSZ4aMx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qyBaKuqJ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeSZ4aMx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qyBaKuqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774977602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrBN3V+DSQLEXWfimteYshVegi2Bew2j0eFoo1rjUJY=;
	b=ZeSZ4aMxj7GJwXGSRQfAldFXR5ASnQZ8eDeL8u47ls4WPTk3AV/AAzLhb5jSaXgdD6hK79
	dM7DZDYQX2vn61Ec2V6qHiQU66p2RHSd2bbrKzd9OsuaL5Q5mFq93xPuRKAW6V8BVWXEFY
	F8gYyFsbMoaLv3gP7L2YD3mp48pg1CQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-6W8ofsdhMKaSuBmSywxIxw-1; Tue, 31 Mar 2026 13:20:00 -0400
X-MC-Unique: 6W8ofsdhMKaSuBmSywxIxw-1
X-Mimecast-MFC-AGG-ID: 6W8ofsdhMKaSuBmSywxIxw_1774977600
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-953cd6f6ebaso766864241.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2026 10:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977600; cv=none;
        d=google.com; s=arc-20240605;
        b=Ha1VLI/7O7BtOCJ57tpsTMIrrwCePQfnv5yBShQ3avIOmieW22j7R27crU7zK9xn+m
         H342WF9eyrHBWIXZNkgsNo3VdW7DX7pKNwrsasg3UEEHU7In4njqvOBWQ/9/kCkMHOhY
         txZKXdhPzHrIg9JhYDjKdRnUVRFDmcZ4K41JsXAqCDgb0SlzaA6d/iIcLaFTl66oTUjw
         W97ziuyOHfDZRtkiAodgwHQBAhwdoAox2qOIIToPgR5UoQJOl0ciUOl9+Jyf7dxMufiU
         KMdBh2e+MvF5PPomDKX+kgJVhi4NcxxVflkSi9mAN1qoyxxzQWm/csZg1oJQN2AslRWT
         IEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CrBN3V+DSQLEXWfimteYshVegi2Bew2j0eFoo1rjUJY=;
        fh=LKRHAg7dtKWY+nxMSNv+f1/sd6zzT0kX+XPzG6r8gsk=;
        b=N4bZt22Yzm0z2s+NqcDV7rxUcQkh+X62jF252Xgb/N9vF92d+FZMj0lHGHscRFpwJa
         qWO3fLHuIzyxYeum2VUnbMS9NkM7o6XN55rBitm8UdprDpEtXNu3fDgpnfzReaRSbEUx
         OT3lYFB+4aohwr+RycOF/y/OwY0udlvKWFUpncchFkITnLzeKESqhE/sJXGGpQjpgrmv
         4mfGbEr26i4apQ26O3Xk2cikpvJvmJumK1jvSfkWiZvJjpaxYVYuvLwmFoAjiF28EBRP
         JeZZCADHv4ZDWVtGKcDl++5VDjgiW/jNaoOugAh99J5gnYcEaFqavIBTNxbIP/47Bc+Z
         E9Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774977600; x=1775582400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrBN3V+DSQLEXWfimteYshVegi2Bew2j0eFoo1rjUJY=;
        b=qyBaKuqJeRaOgqHxMv7z0x8KOPxALqGXtWY4svTvsC+DsLIa/7JHiHl7fmpnoZ0RTU
         4E0gXWQBeUiCAXtO5A95aCQb63Nxb6rPmeqfKwKJsotkic4+r4FDdg/QOQQH7ESq/K7z
         +kgZ9XtIVvzUvpXdkj2HeqX6v2dFgJzN2Kd4UPz91aNflyWkXkoF/Fc5xLisYZTPVUJj
         +mIKnTIBcmv3mObFlG4UBQsOdPZuqpqAxLSwn9yEjzgXPaTU4kfSkzO4rnF772ex/VBW
         Ege+KPsWBbimtzOtDeDH9XFMPgx0S5rD7frLaYUhIqjCeORzfI6zsnoOVwgy/uLFPEMI
         pJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977600; x=1775582400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CrBN3V+DSQLEXWfimteYshVegi2Bew2j0eFoo1rjUJY=;
        b=WTETEkk8wiw8eS2sbNw2x4qIDhQ++RxgjjBg51/cVU7ltnYmSyqwXsfN57tjDf2K4h
         1E2WUMbjWbhvsYCs0BKYq2Hu1aN1fYEBfS61n+VzJiCc2a3aak0CIBKgz1TxAl6Arfev
         yECUTHq6a0UeqUDSXwD5i8W3N5vleJc+LF6Kc9QeXYk+67l6yKASmKQrE9JdfK8ug4e8
         i07KmnpE+nt73BvjI4XsjtQeN3k8JY19jTfGy+wBbD1taHun7PqKOl3eRkOqVoVH++U/
         sKlkt7IjAUsguOsx6kw+bYDOTUbF8ch8+BMYIepyM50j6eTA0RHyv8mJ5BByMn+nJ/V4
         1HwQ==
X-Gm-Message-State: AOJu0Yycm6yKdqHMqmMG0Qs364vQ8Zl8FaxIB1wwutDCIyGIY3YlRjf9
	RGB3LgnUTc8piO6rpAkLkBg88yVEw1AYJ7WYxfkyoo6bV/MHx1OaDdGVu9N6o3oRrYEVECZxqNJ
	0/gS7FrLR75WFNlJQ+/GOYQkOnNoxXPVUT1jJnZiBpYwvH2czPu2nDo7W9cPs7n4oKST+fsOW/4
	934dTMoLXKh4hrkDb50P5MTOxHBBpcZ73VPeCh8w==
X-Gm-Gg: ATEYQzxQiKRsoNRS1Iw+ggEjs4Y2rW7F0t16bJ5agKx5zoYa7gycGihiQOxSkEtPpEQ
	hmBUnfPlmvNyzDThRNgNt5gcFo249hoNaSTGmy0HcREAS4HLLtuf8LmG7Zv3MIVg4s0SV2Meb37
	tQwmSXIMdH8DSOyy4MOQE64E6f7XdFWlYt8LAOHAFU9XLraS5PcDxFTEYd+9+E4cRiiw20jCEWg
	VMNiw==
X-Received: by 2002:a05:6122:3228:b0:56b:a673:27bb with SMTP id 71dfb90a1353d-56d8a887e41mr241676e0c.8.1774977599872;
        Tue, 31 Mar 2026 10:19:59 -0700 (PDT)
X-Received: by 2002:a05:6122:3228:b0:56b:a673:27bb with SMTP id
 71dfb90a1353d-56d8a887e41mr241656e0c.8.1774977599402; Tue, 31 Mar 2026
 10:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330204652.178736-2-slava@dubeyko.com>
In-Reply-To: <20260330204652.178736-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 31 Mar 2026 20:19:48 +0300
X-Gm-Features: AQROBzA0ADhVNU5gWCrhYjeh5zsBIAfYuCyerBZ4ft42U9w2lIPsvt4SpoKC2j4
Message-ID: <CAO8a2ShjuZaizXGptVMnZ2NKS1vixNpGRN5LT8cyGO5b1ktuag@mail.gmail.com>
Subject: Re: [PATCH] libceph: cleanup in crush_do_rule() method
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, dan.carpenter@linaro.org, idryomov@gmail.com, 
	pdonnell@redhat.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good, but here are a couple of nits:

  1. The subject prefix uses libceph: but the file changed is
net/ceph/crush/mapper.c. The conventional prefix for CRUSH code is
crush: (which is also what the original commit you reference in the
Fixes tag uses). Something like crush: remove
   dead variable j from crush_do_rule() would be more accurate.
  2. Small typo in the commit message: "This patch simply remove the
dead code" =E2=86=92 "removes".


  Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Mon, Mar 30, 2026 at 11:47=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> Commit 41ebcc0907c5 ("crush: remove forcefeed functionality") from
> May 7, 2012 (linux-next), leads to the following Smatch static
> checker warning:
>
>         net/ceph/crush/mapper.c:1015 crush_do_rule()
>         warn: iterator 'j' not incremented
>
> Before commit 41ebcc0907c5 ("crush: remove forcefeed functionality"),
> we had this logic:
>
>   j =3D 0;
>   if (osize =3D=3D 0 && force_pos >=3D 0) {
>       o[osize] =3D force_context[force_pos];
>       if (recurse_to_leaf)
>           c[osize] =3D force_context[0];
>       j++;           /* <-- this was the only increment, now gone */
>       force_pos--;
>   }
>   /* then crush_choose_*(..., o+osize, j, ...) */
>
> Now, the variable j is dead code =E2=80=94 a variable that is set
> and never meaningfully varied. This patch simply remove
> the dead code.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 41ebcc0907c5 ("crush: remove forcefeed functionality")
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  net/ceph/crush/mapper.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
> index 3a5bd1cd1e99..17b041779fb9 100644
> --- a/net/ceph/crush/mapper.c
> +++ b/net/ceph/crush/mapper.c
> @@ -911,7 +911,7 @@ int crush_do_rule(const struct crush_map *map,
>         int osize;
>         const struct crush_rule *rule;
>         __u32 step;
> -       int i, j;
> +       int i;
>         int numrep;
>         int out_size;
>         /*
> @@ -1012,7 +1012,6 @@ int crush_do_rule(const struct crush_map *map,
>                                         if (numrep <=3D 0)
>                                                 continue;
>                                 }
> -                               j =3D 0;
>                                 /* make sure bucket id is valid */
>                                 bno =3D -1 - w[i];
>                                 if (bno < 0 || bno >=3D map->max_buckets)=
 {
> @@ -1036,7 +1035,7 @@ int crush_do_rule(const struct crush_map *map,
>                                                 weight, weight_max,
>                                                 x, numrep,
>                                                 curstep->arg2,
> -                                               o+osize, j,
> +                                               o+osize, 0,
>                                                 result_max-osize,
>                                                 choose_tries,
>                                                 recurse_tries,
> @@ -1058,7 +1057,7 @@ int crush_do_rule(const struct crush_map *map,
>                                                 weight, weight_max,
>                                                 x, out_size, numrep,
>                                                 curstep->arg2,
> -                                               o+osize, j,
> +                                               o+osize, 0,
>                                                 choose_tries,
>                                                 choose_leaf_tries ?
>                                                    choose_leaf_tries : 1,
> --
> 2.53.0
>

