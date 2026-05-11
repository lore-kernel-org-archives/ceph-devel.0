Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0843D4FA
	for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528283; cv=pass; b=nnF/jhFGaE+yrc1kmTVFaGQQ/unLnIq9KdlyLWPcE7+9O3Oxqx2wJ7XN2/4PbY0oj8l5KEmh0BPLGPgBLtJUVPIXPbHoVVHl/9sInYU4WYTjfPW/wYmHxgXwPAvoETslIUBeu2VRjmbPogEeu2weVg2AVVfDiXpIazp4j17qygc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528283; c=relaxed/simple;
	bh=Kf8ASw7c6TSjvkbupbDPMcm2+Q5ekYTObzCiqDCd/ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyHZdk2feHJWCJiCdbdjqqj99bnU9a6UQMSH1hod8e/cTdgECkE1r+CfaE0yybIUrpiIUExS82bZT7dwDjjBjpZB63cdjSBfF4uMPLJ1OIfb3cwVq/38v4rBpNBTpn2NrIZxV+lBbX5TVOWSTyrp5W5vRGpcte6eMcQq9EDdoFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlGd0SNt; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlGd0SNt"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-632e479586aso1244509137.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 12:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778528281; cv=none;
        d=google.com; s=arc-20240605;
        b=dRt9xDfovGI/PNbe26RAPgXvVCZejAdJl+U1DeixX9WpVWD1M9h/itFXY3Z5c7107J
         0ZSJw9cfZqLdPq0Ovi05LMN/pFxS5Tlf7iMwKEJ8QI7IEfl+uvoxbqha5rCPixUUntxf
         XmRJL9gtNeDIEDUvAEfC6FEFtMEN00HB5AQbZVsg6xnZVY9QQ5QsbdD9sLr+WGsYwVC+
         kOc6JUIqt6vwMT/zyBSxopCTN+kj/16QIaHexQGDLCUmVsdMlnMucxFHlSm0fHyE1N5Q
         x2CCu2/ppow4mgnGA7QJD5adXLkqx34Wqs70DBaiqviYNR+VSZet2B3Vd+/LT/3krIQR
         z04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K7grrXc6EkBlTMWDA+FMiibEnmYiFgT7YFiIxmGlKu8=;
        fh=NtyYXZX+HOSJGO73qTCjf1ir11meRH4PNh2iMycVshk=;
        b=bI4ihnSVsTH9A+yjuh41gFWNQHdz13346dXoaXmo6EuFhMplOPcFlDs7OS+jiOpOwq
         t4r6tHObXDJmUm06CDSrO7kuiZ3fe8fi12UskBpHXCIi6p37ERQ4hO0RLpd2Hb4gKlqy
         IWut1/omAntCHOmevRw2GSjcmNQWtRYFAKaNfT3Q9PnhHprKkhPPnrp24Hi1PB9RJLQG
         Cwp0+zDij5RturoHMHtiUMmeBScrmgeVwg6leR084mBBHEHDV1KwGGmy1O5zyVyqbPUe
         uE/kmQi9p81Ss7adwAUN/tPSClKjapHIfm96CMnDC8Ot2pU3XhJRwqicz44TJdiKKK0w
         GWeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778528281; x=1779133081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7grrXc6EkBlTMWDA+FMiibEnmYiFgT7YFiIxmGlKu8=;
        b=rlGd0SNtAnWrXoD5Yx0qEoD8ljN/m5XqzPO73I9Q6EbV6/u/0XXFuSMkb3VaeNMFFP
         yqbqeSC6WLEscOhCxEdGp+zVy2vS0xYBFP3W1gPggH1kCIv2LLjuu7Lf7ZT7gR50arKm
         K5+Qow54EB9uy0SGnFypFbQUun8GAhhWAnkAmTgFzcf9M4Bp12diekRDfMoTHTo2ZP+b
         1BcekZ/jDO4L7VCIUWTs4BmzBz0JIs6RTFqj7ktUyUgm5ZbtnGdknemnjZvBl6ZBHdAQ
         prSvvCW2lFxDW4IFxfv1qPgWRDelARL5jG/qLYI+7bblm3XzkofajhfibSRqj+PYyh1l
         llng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778528281; x=1779133081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7grrXc6EkBlTMWDA+FMiibEnmYiFgT7YFiIxmGlKu8=;
        b=ednIyx7qQcrfUgZReHT1o9IOxUsn6ZCT35It9pz3kCVvpveRQ5KR8DqZZWmEx15YEg
         iT//ma3vwnoM/H4nr18ZJuaFOAftKfVk8Oky0tDgKMSd2+Fzaq4qPd6VT0npfOvg2hTM
         brastLCr4jSh1svMNErCmqC07Jp28ROyVk4Fl/Zq18JnHQn7CcoLm6bpCC/nPdkQdzyG
         e6sfGKV4WuoFRCPLcuuE3TQiTHyWnhJKSf2LNFR3Vu4bDjk6reUuYE39camLJ6+ZLaiA
         1JxGvBC1vcY+gG/PTUtWAyCTNGHd0O4la+xaxLITMKrJTzBowKSVKF6PAnpzUO5Yb4Li
         uU/g==
X-Forwarded-Encrypted: i=1; AFNElJ9cPFY155MALcgVVDdgpTPg8UzJWtfbxQfWEDezcmw5zmf5FC31vbrBsjG/zyKSDHTsI78zDlwYRwjD@vger.kernel.org
X-Gm-Message-State: AOJu0YwHoxYUC9TMgtdJQpzlYDFUDN4Li+GUnAHKgwUcv/A4k8PSH8sa
	BCEtrCt+Od9mMs+Qx+NSn+dwWiemqpkn3GMJZFVjQompLXDAOZeUU09WcNgEQq030mKlJWYC9Z3
	DDQ5Oll+mugWeUrAkHEWpb9F31wzMoFlA5f7O
X-Gm-Gg: Acq92OEXdXvLHkrNpovdxwjyYJOhdq37SnErnIUjAOqzdg8EdJNkEoF6RxOApoNT5sA
	JxAlzy5PHyHIDfiiZrsZFww7h3MHsBz7PlPIjNMpAFw7BoaijS1pa5lrkHgpOWtZ2e/0qarLrL5
	0iNv52ugEps5ahVafK+4krsu1Oh0lGnpVoovolXWcDSbo90vW+Km94qD+vXYFw84ClFvoJL2XIv
	UHrCSasgGEx8gNy5OVMtbIrfADEu0gJ+rOhXbWQ8MkDcBICVJJf2IiAPlznxV4lTqH5H6u5KZXG
	02fEzIQ=
X-Received: by 2002:a05:6102:4a8d:b0:607:95f4:53b5 with SMTP id
 ada2fe7eead31-631d91da8a1mr5396046137.4.1778528280720; Mon, 11 May 2026
 12:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511144024.1267287-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260511144024.1267287-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 11 May 2026 21:37:48 +0200
X-Gm-Features: AVHnY4LQLAu9w4NUg4aVeJp1uUypwxYm5MX-a1WIOhM528qt-uIGzRV_K2ShQFw
Message-ID: <CAOi1vP_ms5n2jcyqx7DwaDi3KMZnm=E_bJOuX8Rzu5pQfqzwtw@mail.gmail.com>
Subject: Re: [PATCH] libceph: Use non-asserting rbtree insertion function in decode_choose_args()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 4:41=E2=80=AFPM Raphael Zimmer
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
> insertion function and rejecting the message as invalid if the insertion
> fails.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 2095e73ccf6c..d160c7663aca 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -392,7 +392,8 @@ static int decode_choose_args(void **p, void *end, st=
ruct crush_map *c)
>                                 goto e_inval;
>                 }
>
> -               insert_choose_arg_map(&c->choose_args, arg_map);
> +               if (!__insert_choose_arg_map(&c->choose_args, arg_map))
> +                       goto e_inval;

Hi Raphael,

Really minor, but I think it would be nicer to reject with EEXIST for
consistency with __decode_pools() or decode_crush_names().

Thanks,

                Ilya
