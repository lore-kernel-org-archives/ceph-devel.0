Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559441C84A2
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784004347; cv=none; b=b2BsgOT942a3PV4vTHOjTOU7diDRx4iH3N9IZUdFBiQt8fPWkGmsKXUfHrgtjUr5kImeAusi3/YE0VrlcYQtkU7WNsTTwq/gfGoBG1lKllCQAOckcIPYqWEEOtUGMK+qcOscwPzv6CkWgyKYIRbw3ilKPM98Ys7ljezugJ2TUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784004347; c=relaxed/simple;
	bh=5iDtD715gaLVmZi8vt6gT9Hz6PHgT+pd9IcVApvXk3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWAzoLpV19jy6IgNtfNfdol4cc1O7trUg61ZQZxaVN4dSLbsfPLwjNor/hEOtO379MDv89OSuce6WNLzXnrBfA3asW1tjF67sdU8MhGxMcxejzrNqgr/Q2ugywWcEnRPPm1IdNkxEURCTRpqQ9gnrD4liur+MFMdegozRfIWagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbrxAWdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbrxAWdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166E11F00A3F
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 04:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784004346;
	bh=ffvtdR9pbnnzcAH3bEQ+saJaSCKbU85xxgZgRMw8cH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LbrxAWdZl30zDr8TF8c2mu8EQQMpABJchv8UNjwW8A2rTP+m5Yzh3NcoueHWBBLTI
	 96o6nGB88/MQ9vWRhNHkEL7S7Y3l7vPFlJkXLfO45HUBpgbZoHivOqx9aPzZheDq41
	 E24vL058LOE/YyASxYdnG7RZHl77tKrptUi5gmkEuH5YNNr4vRkYxyd07d3kdkg/wU
	 pWSJKoMvODKFx9kcQ22jHv4fWN7xYSgcrKxPC3AWU5BXrTpXe2Be+MlKfe6RFlvxvP
	 4+ViMeAgxnJynxBmLcIQbU4l4N4yZVOSHJAhTku8QLn2+YeAYXZuLwNfPLKuBDb+my
	 mbJlRk2OTvufg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c9452243cso6751661fa.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 21:45:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RralJVLfyv2fpeqZdlAYkd8NHZAcF5Tb1IlNfzZaS6JxBcaYQ2lF4S9BpF0Qal8Jh/bZbus4r5EzaYT@vger.kernel.org
X-Gm-Message-State: AOJu0YxE7BkkXDHDmFe6vErqDNrAZESUaDE0gTCjLkUKSS+BqzzBFBQj
	J/4M6vDBk3wfJtprgb7gLc49eQzjhwcQay4Ehniq3UdcrIUz0gFFaUKqCcMmL4TOOcFDK0D6SsO
	IbQUppTGFoGKMzF8WtO7U6sKkNm7bjOg=
X-Received: by 2002:a05:6512:1390:b0:5ae:bb4b:ff48 with SMTP id
 2adb3069b0e04-5b023563365mr3086325e87.3.1784004344797; Mon, 13 Jul 2026
 21:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709104856.900685-1-max.kellermann@ionos.com>
In-Reply-To: <20260709104856.900685-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Tue, 14 Jul 2026 12:45:32 +0800
X-Gmail-Original-Message-ID: <CAOuZWzzyDo0jbpHnKj5AsL-DTg+UCscW5RQ61msj6Mrdbw4e8w@mail.gmail.com>
X-Gm-Features: AUfX_mwSLULgw1ZEq6pEhjF56KLGm3S52CxNwTl-_rpFU7CLQoai19Kvv2bUg6Q
Message-ID: <CAOuZWzzyDo0jbpHnKj5AsL-DTg+UCscW5RQ61msj6Mrdbw4e8w@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: use detach_cap_releases() in ceph_send_cap_releases()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Max Kellermann <max.kellermann@ionos.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=889=
=E6=97=A5=E5=91=A8=E5=9B=9B 18:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Eliminate some redundant code.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/mds_client.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 853bf698b356..578c1909e18f 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1799,16 +1799,19 @@ static void __open_export_target_sessions(struct =
ceph_mds_client *mdsc,
>   * session caps
>   */
>
> -static void detach_cap_releases(struct ceph_mds_session *session,
> -                               struct list_head *target)
> +static int detach_cap_releases(struct ceph_mds_session *session,
> +                              struct list_head *target)
>  {
>         struct ceph_client *cl =3D session->s_mdsc->fsc->client;
> +       const int num_cap_releases =3D session->s_num_cap_releases;
>
>         lockdep_assert_held(&session->s_cap_lock);
>
>         list_splice_init(&session->s_cap_releases, target);
>         session->s_num_cap_releases =3D 0;
>         doutc(cl, "mds%d\n", session->s_mds);
> +
> +       return num_cap_releases;
>  }
>
>  static void dispose_cap_releases(struct ceph_mds_client *mdsc,
> @@ -2464,9 +2467,7 @@ static void ceph_send_cap_releases(struct ceph_mds_=
client *mdsc,
>
>         spin_lock(&session->s_cap_lock);
>  again:
> -       list_splice_init(&session->s_cap_releases, &tmp_list);
> -       num_cap_releases =3D session->s_num_cap_releases;
> -       session->s_num_cap_releases =3D 0;
> +       num_cap_releases =3D detach_cap_releases(session, &tmp_list);
>         spin_unlock(&session->s_cap_lock);
>
>         while (!list_empty(&tmp_list)) {
> --
> 2.47.3
>
>
