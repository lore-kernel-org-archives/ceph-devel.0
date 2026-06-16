Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831B4508F2
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625800; cv=pass; b=TMLecxwyvKBylquG9MGhxDxAxxmcQjplV1UBWdDfKgKiKI6BLpT6qoWlSSYdj+gUIBmLx+aw+82By8mMayoGsvcmqY26gssYIijzLZ+B55eg118wHkdyyvIPajbSg4cUA+gzMS8KCTGSeD90DSVAstFuZB12yOQiypjCL2aeizM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625800; c=relaxed/simple;
	bh=t+swykvqyJO2HMKRiFLDV2DeakAze+aOMxdg22CLth0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SXcSWhk9nt+1+7UUnNPs/0uidmJmuMLQW0/ppnxZl9sZBORAzi8wwuTr8qz9FfmXqgPG40Jw9fw2a7OCk13rY6L6xdPGZ8pqGN/i/93MxI+IcTWiq15vLMlqAhccKFkPj4pYRZWYXmFgexv5YGBSYLsZyHUCz6D5OY/F4jjk5Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QWuqesbZ; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QWuqesbZ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec450b950dso681647766b.2
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2026 09:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781625797; cv=none;
        d=google.com; s=arc-20240605;
        b=k8kGlFXBSRGJy+8iPt9wqj2HFY2XGRMI6Js5W+WBkG4S0w3ygF+D9gP1wqt9Qddj8r
         IHs9o9kcfS+mygUOYhVsYDKm/pF+BUUbkYsIQ/YuCUjYyM+UIVW1u+DMXeO8rgd5wJFA
         d37ROiERmuUQq7kI3K28+m6XKEEIrHJyV8RhEqqiiRIJXJ3b/uzuEbK23r4z5xeconzK
         HmJ/3V0LcjoH5KsAEJyY3nozAY4alaXl6FZQjlOQ7IisTlr47F7Oa2bR+mUN41nMiS5j
         rWLgG5ZhNDTYLtRaG0wHfkSb2LLPEQFjsZorYN0lS8WT6FDU4+Qqr166NbyaCO7RMEgr
         wKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nwNbyalYY6VvhSHOu7o9n4a2zJN291WlrYb6S1B22XY=;
        fh=nOLRziuLvw+Ny7g2CXRgc8UlZN3Yw88OPku+zppOR9Q=;
        b=h1gW4WUCIny5BUgMv1B1MeMyW+OIjGI1sa+V0bByy2x7w9i1qy7aTlUAKfJNf9JKrF
         HiIvR3rd23+DQfZYuoY1jVyEzSwxFeAuHGSJBIuebPgKFJ/TMrDp+3xQPv1X6D0BG8/Z
         x8CyfQemzkTsQcTvIKlLWFH3J/PRUYFpkmyA6Jy0nEgLz2fp2FtgihBkRxdHcMGB3VzH
         JHqvFX90wCiud3UgQ9GjUXtEP6/d6PsPZ8C6U6Rq2vrxMLsBPKKjOaP2Q+2SeCqGRw4x
         aAqK4ekAp5RWBfqZz9DXEyNleHDGPD6MP0ZmqxwGtNEkJFX/Va59gAk4qjILqrybL/qw
         wd0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781625797; x=1782230597; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwNbyalYY6VvhSHOu7o9n4a2zJN291WlrYb6S1B22XY=;
        b=QWuqesbZ+QWNBvvU0h2shzn2Mmoh4W/+bEmhVTsZKifL+4QyiExmVYhKSZ/UsnDAQw
         1dmGg5tJz1dnyMgWXyvEVs6NbeldjjA/8sPpKWc6D07fwSinE0tnVafOLaU8fkhk5rnH
         zEdbLINcs0Zbo+yo31ytKBxH8IbixiKkpvLcxHOKgOw61IrgFpyjbGAtVCv3EEpL63pF
         YTCzjWNJ+WrjQA9L6RLi2KTSPX16CTV8LYvUk+UI51Gv0Uxo+A6NXQTWxOWPXNPNtXju
         DaD/FU9ywWVyYyEZdpOBxyVPBzfH1elL0nTNyh+GBkwMf4mCtWzmFjdGC8eIvlMexSux
         7gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625797; x=1782230597;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwNbyalYY6VvhSHOu7o9n4a2zJN291WlrYb6S1B22XY=;
        b=Uq5sQHFoFETOEjaxIn1WHvlcCG7TUokWGu/cn3avuRI5IjKEuK3btF+d16V1RzmPCr
         hMK02sBo4Iytxu0SVSVDWbnLG11hIprn5tF8gTuXaItvecU7EknmyClhZS4Yc0kDN070
         OYsme1fySiG5pHKT+aErtEJTMkAasLwZpu9j6c+uP5QXhuSZ1QnrF1tWcILCNVV16yIX
         VOj16fuK5PyRPKmIcX91di3H3ES1lCVgm5sz4sHguQMmjSwcqHb/9U+sAVJfHQjgwoFR
         GhJADZLJQ9pvyv+q30HzCHPpcSZMPSVrmDdsoS6yQZA9wJ3ywrsd0BiDXXE+HaaMirx9
         2GPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uwFKRCeqBFNasbsBUcUQdsC0SdliTFBW1eEdatHNmLv64I3Nas+vSdCBdIbVkJ6SnsSY5j1AJGbVl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5IH6bh06J9YhvM7dzkSfXXAcR6C3KCRPd0nBmEphQu1DWvqu
	KIOPYlzg3pe2nkMnVTYS6LnGIMM54K9MI0cq+3z7KE4ZgpNB/s26Hx27RZ18UHF4zx7OdMp0712
	yR54CGzh2h7YjaDTckjw/hwNmcVzwc0dFTJoB4Xk/kw==
X-Gm-Gg: Acq92OGCsu7h2CbrKUAk7jPggv9BgPnvz/m6fRIXFimia+ktpLJTfeKk6Ka9iP6LGSZ
	Sjw1xAQJgO6z4bYJkMMmZTl6ZQuHEK8Dz+DtlilGAMuzWKRHOy5jPI7+gqNS49rxwmA3EaKdCxK
	BV6FmKt1ddfdC+b7GrOgGewbjs7mpZPvQWM8LZlEIsGcgaWs+Em37LLI4cf3LdDXw8nAQca+iof
	wQTZebhs1MR3xm9Xs+4IkrdxLxGY6PD1iDXreVWDMdkKEE7lJ2WZgzZv2q1Jevg7IViMyYwy0AU
	qb4Th9cN/nIOhr8e7ENb4JbpQeQilw/rufHMOvxbs3RdCs8=
X-Received: by 2002:a17:906:6a22:b0:beb:133d:d2dc with SMTP id
 a640c23a62f3a-c05a204a013mr25687366b.1.1781625797240; Tue, 16 Jun 2026
 09:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612170537.92970-1-max.kellermann@ionos.com> <20260612170537.92970-2-max.kellermann@ionos.com>
In-Reply-To: <20260612170537.92970-2-max.kellermann@ionos.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 16 Jun 2026 18:03:05 +0200
X-Gm-Features: AVVi8Ce0t9_n3CdSrAob-vHibJ1stEtBwlKpwhK6a_BkgLak9ydvT3pDii69ip4
Message-ID: <CAKPOu+8q9wsr1Z+eQMv-yBVnFEELZoeqpfqjGOtDR-Jyg4ffsg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs/ceph/caps: mark cap remove with RB_CLEAR_NODE()
 instead of ci=NULL
To: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 7:05=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> @@ -1142,6 +1142,7 @@ static void __ceph_remove_cap(struct ceph_cap *cap,=
 bool queue_release)
>
>         /* remove from inode's cap rbtree, and clear auth cap */
>         rb_erase(&cap->ci_node, &ci->i_caps);
> +       RB_CLEAR_NODE(&cap->ci_node);
>         if (ci->i_auth_cap =3D=3D cap)
>                 ci->i_auth_cap =3D NULL;
>
> @@ -1158,8 +1159,6 @@ static void __ceph_remove_cap(struct ceph_cap *cap,=
 bool queue_release)
>                 cap->session =3D NULL;
>                 removed =3D 1;
>         }
> -       /* protect backpointer with s_cap_lock: see iterate_session_caps =
*/
> -       cap->ci =3D NULL;

Don't merge this patch; while writing follow-up optimizations, I found
out that this causes a data race because clearing cap->ci_node is no
longer protected by s_cap_lock.

Modifying this "cap removed" marker requires holding BOTH
ci->i_ceph_lock and session->s_cap_lock. The existing code comment
(which I ignored & removed, ugh!) is not sufficient.
(And setting the marker is really only necessary if
session->s_cap_iterator=3D=3Dcap.)

I will eventually post v2 without this bug. And with more
documentation on the locking semantics.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
