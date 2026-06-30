Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD145107D
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835872; cv=pass; b=c1Iyzi6SqWzTU7gD8hOvZsMSegRkJfYQLNnHepaLRYy30Cdh/Dx2kecm/6QvCBJVU2JnLA9+iacUAdd+29DsE1bW3/ua7G4GIf6Ociaj2UD93HrDhNtA9XUxUblaaTw/F5TISNey3hzbRtUaymcsSVRctAv9wmvbJ8STowxONoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835872; c=relaxed/simple;
	bh=/0UdbC6NCQGAaR4/hYt7obpujkItylThGaIcVjOkrR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+TRYv9UFgwF5XqtHQuMKGiqMkEKzpoojn0nNlphVKYjhrZdTP/wsPk5FNsMIkWGfoB/+BzuohmnffHKwQldVWZNNvtEmu943HDEsRv5SU0YtnOWW8FMc5qEul+YG1tsu4ZJ86jO+rk4y3dURd4EEzTrM2Dnr7x2fnmUxzh/ies=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TLjHv+kk; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TLjHv+kk"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso486983166b.0
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782835869; cv=none;
        d=google.com; s=arc-20260327;
        b=qG3yOn8hBDlJWXf43kyACuiG0gJ0fUJ1ao6o+6zdQCfeMQVucPObABoRZMfhdxHZQq
         7c+4ZIXXW6crHxU1A0hdNwjgiYzrRAJgdlSAEbT3ph7mxpUO3ZYYqK5z1xP0TxU1lPxk
         P+ZFOzphqlETa5SHXhEgWphiQdcWF/wzYNp3400K9N9HggeD4zIhMuw2Prll2MsQSCj3
         1VOuN28tE0wENtOn55buZaASuPswuIvSisNVgX+7oPsFD90r1Srjq9ANCrqxS64o7qxb
         Yhvvm+8DM8+9VF5vjx/WcV9+m4v2QlJbVl918Yyvg70cR1Vx2m0GEZh1Rvkj0uqmgHS7
         6TbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0UdbC6NCQGAaR4/hYt7obpujkItylThGaIcVjOkrR8=;
        fh=/BLJiQEyjFMg0xwmr1BQV8BKgAw5mDs+eZu2Sf6X1ns=;
        b=mINKxF5XTVUnFvn+N17GziQJLoii09B8N7jWzdcUXEbTD20pRtGuWOD3xvPFgMUtbp
         qjt94jupGMnNniJp+tXJl56lYWTGg996ztl9DQtKnjfkH2H16GS+r136Q+F70QHrlKv+
         fJp7pGMHEQyvrfo5Bb097LnxKcoL1p+ATkZX/i8L/ILZe6oiikKKsenl+DSnJfs17nj/
         RqjgFf2u/4rxSaBkoRuhcZqZoPd6QFN5b/KeRQ1/5r1RWLmU7ZQRrJOOiQOpLy0VshV6
         WDkyyW6qu8G8iC3SbcqLRmdWGdB0CER5TYecaAIZ4JK8COyB9CDrzBjhB0gg/DHdjMRf
         zM3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782835869; x=1783440669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0UdbC6NCQGAaR4/hYt7obpujkItylThGaIcVjOkrR8=;
        b=TLjHv+kkyvt6buF3FWmB9YbXay5ZoHIAVU/DlL6nRHDwbQcmCn6Qf83hD5JVPLhtv5
         Y+5dqmsH5HmEdsDEMMhnfakdWL0+gOwsJiLhbCNqDO9a4wS/IPm26heiGutltATZltyj
         Z86BhK1Q0ZNP5Gp05COznjqYaHBKGhwinyIpL5acZYGnNy86gfwyKjcOhLLN1lwYLcfW
         tZeJBPtsDS+uUv97w94T2xsclxYOW/7wVG1QmfTnadrCbFzdy9acznWipZVhxtU6WmtL
         z5VE4+mBmvXqbL+FjLatx0LFHrz4rxg216boz2jHMqfJBwlDuza8CFu1IqlF/QzViJfE
         PJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835869; x=1783440669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0UdbC6NCQGAaR4/hYt7obpujkItylThGaIcVjOkrR8=;
        b=UcB1qL07AzZWOM77yJlQegXYtJgBOH7KVSlUNl452iKU0LIzrSm7e6D86kKg71Q14P
         iQfRuhi1MkSIsbgr/fkyqeKvJLFm2EVHg0FZJN8VdYzS02pHaYJRjh3WFvTAHgZL9hWI
         bfJJBmA+jgcJmNWhx5A32mATaO91umU1iEMkm9GUsj3ris4Ng7OfN7bdw62h/2K/xsPE
         uCCjfpr4QT15NCl0kLTAPCuNo1Wtq9EUF+FGkMRM4OicKkMacQrtF9yQccwypUlMT/A2
         06zylDI7VZG+VFYyEBjTi2CeFbK3HGUxBgneaBUgw8F/LunG/EYBmv688Kb4QyCRI2rX
         qq+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrBmK24QiXY1MKuY+vqJis+xWSJdZHiMEu0sdtEpwGUX1goiaoI4iQC/26BBRKKYDhulx3RlBCGfmy5@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVqTGMi6bS+XZCQzOjMFvH6dt12OoZCbADPzeGPa20VjTp0+D
	+Nqae3nq99vi1G+6BOag66rw3MxHasCpCABPqW4XFzIiQy72+oMSMf1DsP5m1iWIWQ0W2h+Cnpj
	wVka3EjbNk+QalmOihEjDnTMPvn2KWF1LMQ8R26Ni0g==
X-Gm-Gg: AfdE7clFPM73FashoQgOVUrhokgUZ7FTsFa3chPt4oGTaDeC+w6yIZUia06AQmJ7UYb
	dmx2uPdjU0exCjHyG7RRVIP/3FtlB3W3Oyd5qrq4vmuvyn0/ZiMsgaoT8PbUdLmUT4P7OIlSO+a
	UUDDRoYD02FTSRYuoP2cRo0s/Awh3fOysc8zaBK8kobkYlmosM5tsp4FDl/cW8MidL6oTdsqYkw
	n1YjiL2VBX+w5n8evMmqgDOiQkkJexu0r7Q0oGTXuMNjVr3M7X/14TODsBucJAGovPXNkrWIYvW
	eS6kksjsIJ5hA/8FJw1yMQhTCA==
X-Received: by 2002:a17:907:94d2:b0:bee:dce5:739d with SMTP id
 a640c23a62f3a-c12873eb7a5mr208766066b.49.1782835869055; Tue, 30 Jun 2026
 09:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612165204.86137-1-max.kellermann@ionos.com>
 <20260612165204.86137-3-max.kellermann@ionos.com> <59c115f6df6f3ec1c9660363958f173f722834f6.camel@dubeyko.com>
In-Reply-To: <59c115f6df6f3ec1c9660363958f173f722834f6.camel@dubeyko.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 30 Jun 2026 18:10:57 +0200
X-Gm-Features: AVVi8Cf8OSxZvc9QThFfPFWBY0gsGyi3qExhPb6wopK_bt4_VRBnYsL0I-qSUCM
Message-ID: <CAKPOu+9_9uXyCOcDmB3MbVrFHh3j9Gc9sb5MA1L5eF8weiScFg@mail.gmail.com>
Subject: Re: [PATCH 02/12] fs/ceph/super: make field `i_truncate_pagecache_size`
 optional
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 6:01=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
> Maybe, I am missing something. But where CONFIG_CEPH_FS_SNAPSHOTS is
> defined?

No, I was missing something, I pasted the wrong macro name; it should
have been CONFIG_FS_ENCRYPTION. I was about to send v2 today with the
fix (but got distracted).

(The CONFIG_CEPH_FS_SNAPSHOTS is from another draft patch I was
experimenting with that would allow shrinking the structs further for
people who were not interested in using Ceph snapshots.)

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
