Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267930C62D
	for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910390; cv=none; b=sawDuTLtU1okoIsU3yIhBYRMhdkoK/F+Vci87E5mieWruVES3UHQqoZzCQg3ZtfhU+a29r7FHtNYpRBQh3SpW9e5miE++TAJvveF2FeF03B41fClsaEgn8EznvL4LyoPjMO14nkf6gszV7UN75M4Zmf+6c0BBgsfU8/e65PmtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910390; c=relaxed/simple;
	bh=4fPcKPIkeUHtdpiFSsZvZ74s5LFmLbW2+JZAnJdgJho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEnNT47MUyjMKH2qThUVSPAtQLkxgF5NHdSMPNgqmdfBZPRqKi+FsjDjWBdEXOx1mv7ErouPhy+n9NPGzwvr91dtR/3VuAA2wSq+Zzrcz5Bzm6e2pQSocKg7KSXXJ+R9fxPet/pReLbFT3oIg8vZ+OErMMHnwGYSQj3mMg1L+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkqbrDrH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkqbrDrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CC01F00ACA
	for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 02:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910387;
	bh=G4X/G9+3fNMwSNtcRhFS5Z9eItDJqgBVCll3I6QiQ0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IkqbrDrHVuIvkyxO7HB9yC3IrHSKMdRR7twj21xc5C2U+zKVqCQ2M/VCqu5/WKj9H
	 E5LhfE4LrVyT8Q29XDxxZfnKBNb8DkpczKE1rHTqFia+MJ6xF8bu5sSaq/Xhavurrc
	 jWD0W62Lg7sKKV+vsHqOrC5jr8Ht9T+AsGoX163GiqwVHPHV6TxvSxlbYDQrHOanA/
	 wJTPySGKgPAs6d3bQhgcrJDUbhgY0tb9rEqK+rRNIbPyGuCP0OpoRmE7fw/5LQN1lz
	 N1oSRb3Kjve6rISx0pLWIPauZVqBglSkF78IkLb8QJqsqnm2/eFt+Vh1P2wduMZEQq
	 /vqQEeyBkmkpw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39b51882d71so20871671fa.2
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jul 2026 19:39:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpoVjqIbE0XcxsklBq4DJzHtcRPp63NEsQ5QKIX/snkVVEu3jXoqjjLlvv0PYulofpAfvcuDQ5h0AOe@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaO6GjEmOLqczbnAI28Ao1EnmHVWE3npTLKftd19Q6w83ujXq
	VqILmEwUdTT1UyftAsMRiRS6YLPtoICIqmjdv1lMW47ID7E1sr2MQ+97WsLM+aj1jcEsPWk+wRe
	25h111bo0qNWxZKDDilVAJ4hYafW870c=
X-Received: by 2002:a19:ee1a:0:b0:5ae:b015:3f35 with SMTP id
 2adb3069b0e04-5b0236be0e4mr1246237e87.56.1783910386012; Sun, 12 Jul 2026
 19:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708204022.263578-1-max.kellermann@ionos.com>
In-Reply-To: <20260708204022.263578-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Mon, 13 Jul 2026 10:39:33 +0800
X-Gmail-Original-Message-ID: <CAOuZWzw_=jQgM=T0P+wTHqNDm415gOqX4=SnCAx9eY8G3ZSzxw@mail.gmail.com>
X-Gm-Features: AUfX_myqwTjg4L0UzIDUwrev9krXs210JrCWD-QBZveOxs9zq5Hn_U-KNVdMfBI
Message-ID: <CAOuZWzw_=jQgM=T0P+wTHqNDm415gOqX4=SnCAx9eY8G3ZSzxw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: drop mdsc->mutex before decoding the
 MDS reply
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Max

Nice catch and nice improvement. LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

Max Kellermann <max.kellermann@ionos.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=889=
=E6=97=A5=E5=91=A8=E5=9B=9B 04:40=E5=86=99=E9=81=93=EF=BC=9A
>
> handle_reply() held `mdsc->mutex` across parse_reply_info(),
> i.e. across the full decode of the reply message.  For large replies
> (a big readdir allocates and parses many dir_entries), this can take a
> while and blocks ceph_mdsc_submit_request() calls meanwhile.
>
> The decode does not need `mdsc->mutex`: parse_reply_info() mostly
> fills the request's `r_reply_info`.  Create replies may also add
> delegated inode numbers to the session xarray, but that xarray is
> protected by its own lock and is not serialized by `mdsc->mutex`
> today.  By the time we reach parse_reply_info(), all
> `mdsc->mutex`-protected state has already been updated under the lock
> (the request has either been unregistered (safe reply) or added to the
> session's unsafe list (unsafe reply)) and the request is pinned by the
> reference taken in lookup_get_request().
>
> Drop `mdsc->mutex` before calling parse_reply_info() so reply decoding
> no longer blocks request submission.  This only widens the existing
> unlocked window that already covers the heavier ceph_fill_trace() /
> ceph_readdir_prepopulate() processing, so no new races are introduced.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/mds_client.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 853bf698b356..bb8570d31208 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4089,13 +4089,19 @@ static void handle_reply(struct ceph_mds_session =
*session, struct ceph_msg *msg)
>                 list_add_tail(&req->r_unsafe_item, &req->r_session->s_uns=
afe);
>         }
>
> +       /*
> +        * Now that all mutex-protected state has been updated above
> +        * (the request has been unregistered or added to the
> +        * session's unsafe list), we can unlock it.
> +        */
> +       mutex_unlock(&mdsc->mutex);
> +
>         doutc(cl, "tid %lld result %d\n", tid, result);
>         if (test_bit(CEPHFS_FEATURE_REPLY_ENCODING, &session->s_features)=
)
>                 err =3D parse_reply_info(session, msg, req, (u64)-1);
>         else
>                 err =3D parse_reply_info(session, msg, req,
>                                        session->s_con.peer_features);
> -       mutex_unlock(&mdsc->mutex);
>
>         /* Must find target inode outside of mutexes to avoid deadlocks *=
/
>         rinfo =3D &req->r_reply_info;
> --
> 2.47.3
>
>
