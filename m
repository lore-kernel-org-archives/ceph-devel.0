Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793642741;
	b=scC5Wh7yPxuC0L4ENSoE7EheucBYsDBR/hN8jB2xT3Uj1sxsFVa7oCVzGuHhaNmBXB+R
	 uNYFkBusQfJ9Otr9qRhSPLkaA9UoHN7t2sars9jv4jIlwD88USEPcWV1zRcGgZ17fqq/a
	 RrWgZ5TSWDtfieqdw/0a17s2W3oYbFTQcvuiqle/yqznlJxUJLmdvEUNx5Xue6xOYWHv+
	 zTLXlSARJV1iP2+usQpApTopwfvo4CmC89kZ7Hd5zPN5GBxYw2GvGtBi9pearImTPRlpe
	 ffN91nQfaM+koGlrLE58q/Qi2iyJcZ86OSqI3Dq4xcirDALIyeTEYf+KK96IwWSHM9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+GllYd+7C84J1wvCKUhTS+5FI7nZxQxUhK7SGVJUPs8=;
	b=bC+LHIGpL5Ovc/UShQQ/MdhJL+Zn0HacyK72X2n5O/oZJIPrgMkWGRSnzN9Gr4lWHYpx
	 XbtWsMutEFjlxB5Ad4l76Q1rjgJScNWyHbYZEcgpZEXZR+Sf73FZIb09BpdKN1jzci1Bx
	 DVwwlvOpUHcApVlx92CqAay+3C622aHKsSsaNSsUo0xsP3hEjgNyfhe7SiwxSy0NeeaZq
	 bTG0wGCMEUG6pnENlPqtHjrL8tpF/Pcxj5X3Roz0krr2QLWLHBl2ref5hT00lMpGY12T9
	 o9zDcdHyYKcFhM2JrmnRfY5nat/3wK5Tkye1tgWVH1wZ0EzNNHQokLK1PGLpmFmkvTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=SlXLL06H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D2606A5BC
	for <ceph-devel@vger.kernel.org>; Mon,  2 Nov 2026 18:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E4D2606A5BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=SlXLL06H
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so3478660a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2026 10:05:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793642734; cv=none;
        d=google.com; s=arc-20260327;
        b=Fi9mytP4a48hkDK02yYYuy2GflZpoiOFxOvH7Sm1xTPLO7vbgTRqpLL/L7Vhfgb0pd
         IXVv/csbNbagMFIYbv77ZjrpKRJ2rg8C877SBaxTMK9300CNjlMTEUMuW/djRH22+SJX
         tyJBo9VACTuBXSVhoh3ELynxMCyKXmj0hmYNiBFL/I6ovAYuoc6N9FYiWFG/3FQV83O2
         85McH/X016WvBFzUKKTLnkBXA2mjzljKJAV1WJ7SVyAJ/ZSoSmIEdH27vDR/X//7H9a4
         81tp7t14vJbs8/THiZoO72lZzzzf69B7K4a9QGfEHe9bCuSnKf/KI4GnYzvFSanTI7n/
         eKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+GllYd+7C84J1wvCKUhTS+5FI7nZxQxUhK7SGVJUPs8=;
        fh=cd3jEwuYMb7SPTCIjJEqDErWPvy4eg7kz98RABIsIOc=;
        b=UTuU+uPfse66j8RdoiYGhIwmPlYoFJRZPQSxbu4S2bME3bPRYnSiQJJZtsuDk9vprR
         iDfIfJkThRUiAOS+/3ikzehWQD/6AVvhq5hm6cwtSoyUM/UvlGt9jiia/J1eqAhjfAFh
         2jJCceyoxGkpf0dhUwkPKUw9lsE2AUVRIR7XfldWKD69GFpFXrrnWSKh9Xk564YSC2Zo
         VgVDmnfJ0J9tDXKG4hAJfSd2lgVXuKSPhAh6dtPMOZB/jmLRNgdbuCx9yai5r2szk1Yf
         EcNAxH+OtSWFrm5Jo2XC3zWyW8KoUAz3s+bXunNCM4E1ETdZk9X8qnAGnRgcJuzqnd7G
         ncfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793642734; x=1794247534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+GllYd+7C84J1wvCKUhTS+5FI7nZxQxUhK7SGVJUPs8=;
        b=SlXLL06HMdi8BGyw666hcl5KRHcJivsV9lCQixaZLuTBQmaUykjBYcoxx/6uBP8tBA
         mDeKQDvIGREZWFJSAxYNFyHU3uBskL3mhSA7R6oUdbCwtfdsxrB8govh/RaEnWeOif/8
         lKVidAv6antuKycIfCWRpRr3qpPLvRMGDFKwxIuqnCXybJfQuTHLQMN7OXtevGlpACgg
         EUvbaxYfDuF6iCQOsi0kJnbGG0d3OzV+mzIaxeK7qgFAgo+aRqMN0jMyKWV8vKl2Hk63
         kY8Q9CPujTEou9Fhr5Hj5KWym22LrcdhJi26SgZ64982ge9dvZrfH2dIkO9NZVubacuh
         J0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642734; x=1794247534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GllYd+7C84J1wvCKUhTS+5FI7nZxQxUhK7SGVJUPs8=;
        b=HvRAUaB5IIs7RrRYP7+0VnS5qJjjeN1RiWlhl7zaN80+EmWIYb8fpDTtizXKQU5gHD
         73g/rsa5Hh0RIKx2Pmb6T+VvJ6jqpGN05EW7NJqEEFLcGeaj+s961IyPwNGx6IVIoPtV
         VqMtMTkgHEyMYxKtCl9kkXSai2Pt4I0u5hOU9QNTwcUwCICPCpylvdBUzVI76t/4ZjTn
         2ml3mS/a7L3D2BmqrwbGHTj3Db7uF0WPxxwB/rrFlxo5oxiHVLi389p4aGvywX30jnFH
         APTexlsEDheP+km0x/rX7onVbwMdwsikISpZFO2TJmA9b9B8n6XNvpKYUvmDsXarp7dR
         Aleg==
X-Forwarded-Encrypted: i=1; AKwUvBz6QYc20Qf/0LwDlFEIUHK/bf7shNj8qdxjTB2KVohjOCp7Tr4uZ/Twz97l4CyIhkEpkeA/Hk+il+AZ@vger.kernel.org
X-Gm-Message-State: AFq9FYKACYTUfwq8nkQks+7lO2SA7D7frifE29BB/rtVi6HgV1xiXet+
	nbWjmViGDZ2dieVnj8+/SqdGS0YmaD9HJpD6UyV8WApyRzginejrFpPrcYT6aRdwniVi4gy0ha9
	NWiesbijuUgEvcptqkMgKPvIIw5TOyYN12C/I6wwVZQ==
X-Gm-Gg: AYBFou0PsrqJjRHZFs1ns+mHkH9zbI/w2sHyfE750HKH089U7MnrEA2c4rg57+AcGQk
	PzYemxecZDGCPSY1foEPmOKoX1QwFfMRo8AWJuxtWV5qOZilUQNvDki+7ehXcvI+a5phasJOj9z
	4EXz/acMvXahmebGBf1KnTis+LrJHgtJNV8kPOW/zaZvoxqqxwTFFodw6b28VfTLVs/vZwK7SiE
	Gp2P81dQRyFd2TxQSUmJ7FQsgMW4p+bwZeB6u45p2dYk7CeNB+Wx5syKNkMMe3Mp8JAzdUWeIPv
	BIwf+yyJIYKAVu5jAnMGUWmeiFJT0fby8cLHZ1NC/U7xTbOoEh/cK21GGMpmooLRMwbSQ9469Ba
	+GLoJIPBTNmbXi2kzhVqrj4UFn7JV5I1j+465vrdGJWY2/KS1I01+V58iZxEDHV0bhsM=
X-Received: by 2002:a17:907:97c7:b0:c2b:f3d5:2090 with SMTP id
 a640c23a62f3a-c4ca7a672e6mr908823366b.27.1793642733627; Mon, 02 Nov 2026
 10:05:33 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260824184159.240821-1-max.kellermann@ionos.com>
 <20260824184159.240821-8-max.kellermann@ionos.com> <CAOi1vP9nBoxBD9VTmMm5KnWj4zp0mdeXxTkzLR5tdBrmKrQ73w@mail.gmail.com>
In-Reply-To: <CAOi1vP9nBoxBD9VTmMm5KnWj4zp0mdeXxTkzLR5tdBrmKrQ73w@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 2 Nov 2026 19:05:22 +0100
X-Gm-Features: AclHuK_5nzajoV3_feYrYc2C6tm7ff2fX0xCsItzaAOSpfM1GHNpLYSclkLwZHo
Message-ID: <CAKPOu+9C5rWF4mn6t660C5YxrcGHWvTFFEMkHeXWba0L4Ca=Rg@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] fs/ceph: remove i_truncate_mutex, use
 i_fragtree_mutex for both
To: Ilya Dryomov <idryomov@gmail.com>
Cc: amarkuze@redhat.com, xiubo.li@clyso.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:35=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
> Only 8 bytes?  struct mutex has got to be at least two if not three
> times larger than that.

You're right, it's 32 bytes indeed.

This simple patch set saves ~ 3 GB RAM on each of our servers. Much
more memory savings would be possible with some effort.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
