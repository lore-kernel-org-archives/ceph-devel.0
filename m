Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F903806B6
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566653; cv=pass; b=QMuvKzMksCccTLdBjbVzZdfk/Rk3VSgkTWY6KWOVytQoNr4qBjkWxV3JQT9yQmbuVh0iMKQ7euuIptp6z8G6VnquVzmHCzO3FE5PwCmZOHQL4XAlD8ZwOogSVk2tqGByGTOXrB9DtGoD917Sif2gYvehrclfogSgX8uEewBpDe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566653; c=relaxed/simple;
	bh=ogH9rhV3qlOL8vf/EkieN9j2gAQvMmD1s/h0v+i5+6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYCJUJAb1vfva5OVsjh/xtgHO+Pf6CwYF1Ocw/sD9h8pp5lDCDK8p4qi85oEsf/Y7blkz25T7mhMNyokI6Sg9hLi5gQJdHd4NykeucZabAORajmmSAwQ5a2+L1G9W5lXBUVQkGbMt0V+vS7/8P8olHMp3um9fkrFkI0pLbzDMXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IQxdUMiy; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IQxdUMiy"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2074710751so7227866b.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786566650; cv=none;
        d=google.com; s=arc-20260327;
        b=gGHJulCzxy6OaDyY2F1gVxl0glMoIBw1/Gg0oAJYfNCagXCW87gRvYAUIFAnBQNQaa
         WjsANIBb6hE9pl0kKmV6TxnNBV2KPaA5EA+a7eGoZj42cCnWgxbnkczCaGCOWMEH9gRL
         AM2b68MetJIMvMGSi2ZUs/TFY9ZCcEwViBszf5YmzjuWaUZ8NX4Fs01QHcQTbjqpBHWX
         OrJM1JmazzptD+QxklFoADtv3bkWYC80qeF2CoHbQ3z8BKME3cC4ImkbwBInYn8kTZpT
         pLSMaPVKkX4ihA/jj+ZP43O2wj+AOCtY35uLnvOxjrCKsMLm3/Dzq3hG9ruwf74Zp+QJ
         9SNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogH9rhV3qlOL8vf/EkieN9j2gAQvMmD1s/h0v+i5+6E=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=e9bc1s2rbTTpbn2VEzWBxbVLEOGycU3a/mRNO+O1C/HAIYxYRfwuZ+wfYvWtBr1Dsw
         GSEIyCFUKPfrW8wsqbR89+N7mHlk8QqswDsJwdaXy577bzFPc7x22Oi9RDzEizRvJ3ok
         dWrdYNpnnFHxR9Ip8liHC24fDHorlGLS+oEX4APFJdDvvchFU3JruuAxGyWw8ire2dPu
         h+gwVttxfSOv3Lx1Zc9ush/zrcIMAOyLUr3znsRh47wKNGUmyZE/KOnxkrKdauAK2qqf
         /ia2555MHNEuASUBTQpL37sQ+dPCnW0/VjrYwVTMsKn8tfsMtelkGfMDYbTf2Rm2vt0d
         O2Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566650; x=1787171450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ogH9rhV3qlOL8vf/EkieN9j2gAQvMmD1s/h0v+i5+6E=;
        b=IQxdUMiy9Lxq6cBUjMK6HrkXB0XmqYzGX0/noT2cGGCS3F+nzObV/6zsB+6A1eanrt
         sFXFgQ3gpZNT1rcLx7WOOCPJomNlEF9t6pRon/ARtJy5bOzKR9PZqrXrOWfOZRuyOHYh
         mXUP24wxTQ8mr3/4LH7rS7DdLJZ7C4kLBvhHthd7JHWmCJCXdW2D5mhBPem4epB47nqj
         N28hTO+xX+D2wqTvTQUZQCx6h38zzIi6Yl5iTjFt7UV8QGre7kaTEzsHJ98kqUpKSJHb
         IY1+lFJquF3flqYW9J30ZWemMAko917Yte4rt4zzTxreuChN1YX3Q2guPKQwk4hzvEf7
         cjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566650; x=1787171450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ogH9rhV3qlOL8vf/EkieN9j2gAQvMmD1s/h0v+i5+6E=;
        b=DxO4m4ZMuQ/3V01jLnNyQzJlJG7mC/RS0HLW6KvFgo3QbTAPFmWAuV+nvrCMDsnXuA
         1K1oDX1YtW4AO50qccSaYEeLPROgJQ3jB9xH3MN0zpgIiUExyL07sDnBFFwy20jKUYv+
         mp/9W6zbAvejPyrngFWmP9m3VqONWsFBH8LrGkHgk11fnpReqn64qBN6JPenHhR+G5av
         rGwAlJSFNYTtKQPmmdS4LLPLlpqx6kM8O98YI6NYl7SBMw96E90ByEw8JBaqaEfvoG6I
         A7yp/fR7K534vWIEoYdD7IKkf8qoYZMDg07MMzxUMZvnD3n1aU501mDH7V3Ij9QGrS8g
         YzjA==
X-Gm-Message-State: AOJu0YwxMMlTtcq2Pp7yIFrNJ5gGVNTM80mqOp/EibSNVyVe6mXezQ2j
	EsTNeOizeJrTzcegd9WvpfgTSdX1aOZm+X5odpIlKC9f4q8/VbZSGdEkf0wg/q3LwBVhfghUULG
	uYpjZtLMnJJvIJ8mAeJeK5P+youLtns17DTEY/j+yPnxTdvWxTYutpBM=
X-Gm-Gg: AR+sD13Cp+g7jZsxZJMCQ/V0c96uMroJgwqveml3tMlaAYy9EjZYftJXIASyg17Lqg2
	KnXuOgNNhKKNcbY9zj9KJnvmYYGHlRnmkaTsvGFho7l0feHX6EYIbszSZrsxgM/MMHg2AyWuI1x
	damSEsfdDx+fxJGgcnAxDmuVeZkDdCDCzTrGz8b7Ze59/NtqTUhVct43a+1AJfz/YnfM5yCFv6v
	GKrW3/sH2Vuij8ux9Nm2LO+kBGu1g8zafhTgPWW/K5n47yiF7lGX5qw/azoWsWihn9qBy4RwB9W
	jPJAHqbDG5A1UZ5s/oA02i8xy1ZpegYe5bWd2sfwx5CzGOoDYvC+0xQGkAcSGqBSJnbim7mMgg=
	=
X-Received: by 2002:a17:907:9451:b0:c1c:4858:251a with SMTP id
 a640c23a62f3a-c2108f1d2c1mr36838966b.8.1786566649958; Wed, 12 Aug 2026
 13:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612165204.86137-1-max.kellermann@ionos.com> <20260811142032.2700096-1-amarkuze@redhat.com>
In-Reply-To: <20260811142032.2700096-1-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 12 Aug 2026 22:30:38 +0200
X-Gm-Features: AUfX_mzzknaKMyG0Cgdjqhev-GDnmPY2XIqyaAVaR1BtVQTqwaAGyrYCAD0JjGA
Message-ID: <CAKPOu+_egqW7jsascwk8AK0k6hJqjapzVXW9gPzrZEV921=vYQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] fs/ceph: optimize struct layouts
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:20=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> Could you rebase and resend?

Done, sent v3. (Note that you replied to v1, but I had already posted
v2 a while ago.)

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
