Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C12D7386
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566331; cv=pass; b=F0DAxKsHIUVge3smOBAOZhHa7LlGCLWly7xgM8+H44FawQ52kSvLYvm3kFOf/p3AS2PpnpQ0qZ9JvgVY0TIFAwQFc5DfHYMyczBZtYd+Lt2Ia/mUZ9T7V2UIzjU6FcI6qJ6ddtyN0lKBgf60fzh7p7z8z5IZCGM3XJoi/qwvECY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566331; c=relaxed/simple;
	bh=se4EsqaoWCTuGDoOyDSp60WyC62rTuFHN4jzbuRskr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG28pWqz4CQePpW/SG0+9Fq1rC2A06q4N7K26MDxXSkQZX5q5ZCQtf94BTGZJFxit6PQlYWkvIrjwBxa+VydhhZGc/q1qXSoKifi1YCN6+0nAQiilJ8HWE6W0tVaHS3hbMTEDyksfBLT3pbO2C2UPlkDH21OfQpa1kSMMLIazHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NYSDGkyO; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NYSDGkyO"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2074710751so6346166b.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786566327; cv=none;
        d=google.com; s=arc-20260327;
        b=ElYJfk45vKEkNgIr97ArfhFnsAPr9NOz4oLA8HVa5itQK5dQtnGSXuNah1jacihj+6
         YKKNgjwOVND8Nb7Wk6EyzKG1JRouf0EIesnSBumyh5vlm1NyKgW76tzRE/XasOEDgf3f
         CTHFExur9HuUBUmEaP3B4TllHRHnvjxKszYZ67NRsGtDDud9J5BbHKeNMg3WMeERCwW2
         9uBhHoFw9B0RgreEAO649+IsAge/x0Ja5M0YnvqhQAlSi701YNxmfXNYF3Wf/NWftxOl
         A89YMdDh/fhY2+xIyHpmd97VD7W8tBcy1rY7g9WDvtQLA6XBxCn2Zm9iJ50KjA+/VYm4
         9ptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=se4EsqaoWCTuGDoOyDSp60WyC62rTuFHN4jzbuRskr0=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=N3zGhzDTjBBGEep+5l8qg58Jd8vn4KMyW89ZDxXtUHWx1QUGTYBQm1iTs7a5ZeA9Sv
         rHws9By+WetNUMVJFrFUeS9eg9RUL4g7MYwpjZcVIYcN6cK30yR6I/VOrPhdti8SPimQ
         4Rp/1SMFxyA8oFtEOeKUTlM1ugCXFzsP7yxiaMlDeEGFKYgSBGqLIkMUEFr0bX5LJXc2
         nWdGPnghwcTspnMqM58rJ332fqfqyeqUcGU7tdjZza2u8wicucWWy241Qg3oazLr5/Qq
         VadSK3dLsuLx3NjPG56sCeHXL/fGWQtArRjANxVHLDPW2gZ2Y66oFAqgyvcJ5GNTDly4
         U2yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566327; x=1787171127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=se4EsqaoWCTuGDoOyDSp60WyC62rTuFHN4jzbuRskr0=;
        b=NYSDGkyO0SdjQKcIW+3T8uAX+ET5gVb9Pl4Ci7z/jQRToBZIelvWXZBW+9xYsi9ekr
         ijdSpx4zPhKhOOQ/nCraag5+w1b5N0VcOgWmUxri95co2Q33oC2x5BnpjrDu0whZs+Bz
         hd/BTOhbSbjOOXtXeLS9gWzx7AAx8vTXx1tP6eUbGme8k0ICfx9hC6/K57oPS062jSUB
         9hrICewAK0hzm6y7u30fU3vcTE6wbvrQtCXDROX7lcmbyFZ7yBGkzpRSiMVx3i6rG/nM
         BzwsaMbDEm+jy6vnDXKVhLRH8bUAANy/s83zWTx2SBQv/GNTM81HD+5joF/KUALuEbWV
         gyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566327; x=1787171127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=se4EsqaoWCTuGDoOyDSp60WyC62rTuFHN4jzbuRskr0=;
        b=By+615Lk0k9Ye8zzs5wxOXb2SCa+vpS/iQMzYb56YCZzJJxtlnLUgluVBAntugF2BF
         IwyTaA2hdnp038eNrTy5eFvEPJ0C8z55u29z6rZVua6pt1PY6+dtdYeU7nCzRXjy7ZNV
         P6tzuEgm+v0gC9aCWk5u9MqosUUP8YhEUYp05KkinPjiyZQ2bYV8+/kYMsE6UZPopmOw
         Ov1A8Es5grC+JSnvuYCCuhsHXdrXHCm6XTZTxy6gmxafyygfoYbzibA6p4U0YhrcfpWF
         eB+/8Ht0uVTJ0SsvZbz6cFaHsKXQsxiWBzdyXqrBNXz55KpEKZ31ayjxxdvOPKVKesRt
         XQiA==
X-Gm-Message-State: AOJu0Yzn36rno8Q7f/CqoelZRxcgd+XmfCxiCZ8L3FbLl4mbeP5pIG2H
	vEyA4iRn1BC6oEZvFpXEXM1tMT2N5OT+GxH91j0u6QHoiEAH3rVSW4MEc3FogkFdrA4yeQg6gBH
	X7DQqdL1jOQ1cqs0GuUBOILWoBY6SWhwPIDNXIDZZZnrG/Mf+rht6Y/o=
X-Gm-Gg: AR+sD10t4IVZyzGSwA92pl5nVfbXie9RIEWsP87c0vSYo7Zjx2+LfIJLgrFnjlccm6q
	Vi+2PtjviGk0ONSzHZTqP2q7uOzkHS09yp3d60tp6vO9pZlpJwlz9W7NbfaoJdniPRYcF5P4aIo
	hxQxNqAAzn1iIzkp+4RV4Pq+8UW9LScsaz/QaGhtoi6kpiA8u7o3TRPmwcGJ49xMbuzh6YBG5uv
	t5Q7tF7Mu/+yHiKyVr4R03s+/6i+cjow9RPpfAp+vE8MBaucLrgxt8j9TMoEpNCRdkTz0ZNlKhd
	RUk8qzRHCO8W10WP/3nhgSyxHHEmjd2g2pPsyoh0yDvcHGcjLay0jwLxWRTxe880rfUO11Sjn0r
	D5f73l1CA
X-Received: by 2002:a17:907:1c08:b0:c20:31d1:a89f with SMTP id
 a640c23a62f3a-c21090d8ae3mr37658966b.24.1786566327388; Wed, 12 Aug 2026
 13:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707213659.8939-1-max.kellermann@ionos.com> <20260811142302.2700578-1-amarkuze@redhat.com>
In-Reply-To: <20260811142302.2700578-1-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 12 Aug 2026 22:25:15 +0200
X-Gm-Features: AUfX_mw1zWVUQmUAJj2_9R1xuyMAeG8LRcs0lYpHXDYmew081LTPdaZA4l4bZOA
Message-ID: <CAKPOu+_PE76JKOR_GMa3YaAjyg7d6iDmesbXOL4CUbGSL0Dotg@mail.gmail.com>
Subject: Re: [PATCH] ceph: force a cap message when a deferred revoke can't be
 acked immediately
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:23=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> There's a bug in the new clear_bit() call in ceph_check_caps() =E2=80=94
> clear_bit(CEPH_I_FLUSH_FORCE, &ci->i_ceph_flags) passes the mask
> (1 << 15 =3D 32768) as the bit number instead of the bit index.

Aye, thanks for catching this bug. This went wrong when I
forward-ported this from the 6.18 LTS branch we're using; 6.18 doesn't
use bit ops.

You refactored this to use bit ops in e120e2b666851 ("ceph: convert
inode flags to named bit positions and atomic bitops"), but I didn't
understand why. It seemed like i_ceph_flags was already protected by
i_ceph_lock. (Unfortunately, locking in Ceph is mostly undocumented,
so I can't be sure.)

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
