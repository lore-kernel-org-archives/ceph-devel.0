Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED43E3DB9
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850442; cv=pass; b=jVv7wkElHt9iDX3LgnaC46NMjSLZibqAwIZBqFHhgJ+RVRpg3z5hIgiD4FGw9UYp7JIJTi6dLq/idOYITa/qs1nfj94Tr0y9u28lIqkpwdyPAgXXD6X15saotQYsh+jcUYb/wxo/58juaV87X+P1rTvJvWIdqcbFXJG3Gq0tceA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850442; c=relaxed/simple;
	bh=kVta56J/kj/i8ihfhxNQ40v/cFYr4PWhL1CyrebRWXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ID5yDe9h5Fi1Sp4fptphez0xAV2RhaFEwma8QULyz0CTprOJPGJiS0j8pk2esib2gvMFlxF7Ju4TKXvK2jhSDZBi9KmzSfv75+Iw7+AQ8kMnK8uAvPM1q1HBTz8PyGhXY5CPsv6mFDWyhjkoephmyVOJxmtuNUIXeNlD9HHcIBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBPDgjcH; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBPDgjcH"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128e3125372so896327c88.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 09:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773850436; cv=none;
        d=google.com; s=arc-20240605;
        b=U+SjmjVyBXNQ+Py6OllyWaqwpmRwQyA1s0lkfL44+fibhv/HaE1VruM2Ndqnzatx1n
         I8F8P6wbsHy4GJxHY0d7sMnVntL0mC4Sk6oBxqn+8B3P1YoKo0q8/Jsh3j7GCdQYg83B
         umSLPmV+lLUk+hiS6hc0DZmLfOeBDKcVYvUynUiwlRgnOifY/L3S7/Xlz2A4J/PxsgDl
         028tqgNJKRMYn7yahybSccCA6GuHvzFwHwDcXogI87NsIWtb0vUUDgWHrDF1YhEDtpwr
         eVvhVJbDPVqC1GU5+qY2/4GNK5iiqJ+ycut/8NopXg+Rpukxfay9pQdltv2ZOT+/bpVw
         scRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OxDZEvyofzmCha6yHATsaA49A3TsDlfEJ9RT3ahmucM=;
        fh=sv9nOH44uvbqDXHBH7hBnVY/cnXBSoEy7JVBYRQ+owI=;
        b=lCHWCEpx0buFm7p+YAEv9dQ2pbw3h/4VmS8YijfKZtTT5lZluHLsw+IXeLlc02WiLQ
         JWtK/t2AUU7CsXJuaev5p9ismZis91yGHiW7Rsev6SrT9TDDSBnbvEfwkljue/DpVydZ
         GVJSyt/HbKmiLs7TRBNqVXv9RgFMGrN86PEMlLQuNvl68B1+LKxSwUi7OLyE+VqWW3U5
         lhayYvyYC2geSA1PctvwV5xQjikeMvquzubtKFipXmQx5ny9D1ndpU5B6KhAzA5MwmMr
         mbDCoJH6tjVWx8sN5aDopQZyiycKpbpmTB+++gK32hm5k4Y3ZjwOCSs4XQJMsZvCMPpH
         hVOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850436; x=1774455236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxDZEvyofzmCha6yHATsaA49A3TsDlfEJ9RT3ahmucM=;
        b=FBPDgjcHn9KoaLAqqLQKG8OERvRjzghl5aQ/gScXFn02e0EkZb0vyMGx/2rghssVH6
         XPe1JUfMgIQK1+TxpafS+Y8vDeSLLHmItxBK7TmrXXepiSv3vMqCzGnumPAoShZ7E1w+
         Jk7VoAlbEsoZ3GOJxzUGUKMCr8HjJgKsbvWFNPjTRhDPBuCuZrH+xEe+BVT+333T3BsP
         U5Qgz8i4nUxPP10JchzMc4Sozj1oGsht6bb14DpPD/kkhlcitUNDPLIb7FvjFnhnhWJ/
         DZFANOWICcmsN1ps9PIWt0QiZWmCLE+42nBouIUv7rVtZ4/HFaQh3YSQPxeSiXidQRyk
         3hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850436; x=1774455236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OxDZEvyofzmCha6yHATsaA49A3TsDlfEJ9RT3ahmucM=;
        b=tQpdEnhHJgmvn7YR1nekZo9Syq2s51FBqOE/tTg1RBLKMTTObOj2wNVNwo9nxYfXnD
         Ppygdhuf+EX1BkF78B/AxJH4H/zR72UD6loL2C7vMPxHY+ym4eUZYDDLnH3AvOurup7h
         olygRVtebgQlwwPfIo8aACdM5qwMCEcf1DTBng9yFAbvlRB2QE2gVhHuWUu6sWRgDjTr
         z7iNCxir5X4EksOcuqwNDsG2Uj4GBmWFkE20UeuTDVnaWGxIvmgaENilvoYmR2VsRd8L
         RWT+ZNS+m9EWyKtRptebSBkX3VczVwiJZMy09IUoBGFXlGE7M9mJzzp/TadmkR/4aJ+X
         efgA==
X-Forwarded-Encrypted: i=1; AJvYcCUckUkkbZKEsZ663T1l6IkcnKuHFO9tbCx60stICvXGlXeIiBoBizhRJfaNoKIQXIeV+QufqXtjXO2a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CKFkbTANANuOmPTXW6xClLOfGV2836U7pPzeS5bDtUIyp8Re
	2vqL8lH1I4SA8tF1qCk8MzAvxErrOM7/MI3DLODKPnQbxQRgziM7x/GiYJcBFz62C5ep90hPxbH
	ebZFO7WZ/zDnFp2RapGKW8Ha8dtNhFmc=
X-Gm-Gg: ATEYQzwqenub86x7zmAaZ/ORG/Anbb58SeGnIAbRgS9I7B/Qxo0MD81t/vrFX9RqaAP
	oGr7+Z4GE78zZxtfwLSCM5rCYX3Lkf9bMZMSVl8p+qWTP7pmpEY9bo9WgHhhWLn0Vo7IyHV9KsI
	NPLvEmYnzS0hIiWCcU9rzfidZAtXI3Wsg7pq+x8sVchGB6P4IQNokGZzXHcuXaEmF6ZJ6GGl8Cy
	hi7HhX5Eeb2tYGd8boyBmFRZ7hyaudQBZ/RaI4Hq0liI7Lv+VMOtw73F/21XnSMLSTyUK2EUB6i
	SB8fA0Y=
X-Received: by 2002:a05:7022:6609:b0:123:2f12:60b4 with SMTP id
 a92af1059eb24-12a6858588emr69326c88.20.1773850435591; Wed, 18 Mar 2026
 09:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318113256.810478-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260318113256.810478-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 18 Mar 2026 17:13:43 +0100
X-Gm-Features: AaiRm52lxSYXtxPA0WCG5CWYeukSOoyRMX4MDMXKFDeRIr_Bjy54gEMZ3lsMYvU
Message-ID: <CAOi1vP-Cpwi7=KnU4UwjOnAYNSWCw3sisM=tCc6UQ2aVxoVsvQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:33=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> If a message of type CEPH_MSG_AUTH_REPLY contains a zero value for both
> protocol and result, this is currently not treated as an error. In case
> of ac->negotiating =3D=3D true and ac->protocol > 0, this leads to settin=
g
> ac->protocol =3D 0 and ac->ops =3D NULL. Thereafter, the check for
> ac->protocol !=3D protocol returns false, and init_protocol() is not
> called. Subsequently, ac->ops->handle_reply() is called, which leads to
> a null pointer dereference, because ac->ops is still NULL.
>
> This patch adds an additional check to the logic for auth protocol
> negotiation in ceph_handle_auth_reply(), that treats a
> CEPH_MSG_AUTH_REPLY message with protocol set to zero as invalid if the
> result code is >=3D 0.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/auth.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> index 901b93530b21..d97f50d38022 100644
> --- a/net/ceph/auth.c
> +++ b/net/ceph/auth.c
> @@ -238,6 +238,9 @@ int ceph_handle_auth_reply(struct ceph_auth_client *a=
c,
>                 if (!protocol && result < 0) {
>                         ret =3D result;
>                         goto out;
> +               } else if (!protocol) {
> +                       /* protocol unknown, but no error given? */
> +                       goto bad;

Hi Raphael,

Jumping to bad would emit "failed to decode auth msg" error, which
seems somewhat misleading since this isn't a classic decoding error
like a short buffer or similar.  How about changing

    if (ac->protocol !=3D protocol) {

to

    if (!ac->ops) {

instead?  This way "bad auth protocol ..." error would be emitted.

Thanks,

                Ilya
