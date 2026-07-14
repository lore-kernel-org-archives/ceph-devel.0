Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00C125AA;
	Tue, 14 Jul 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014429; cv=none; b=oFDGu5py91kzXBhyr5y+gqslvhXuMTjnZ/49Wc4/+piy+HYdqU3p9z83yZbeNNxLjYWmjsy2OIkMpgZo80PA8NFqmEvRXgjvF58e5AxZgmm2FzbqSGJ+VXq/NtBzBS7rC66w8lA7MG6LymgbwV8NJHQGGN+mWGC0FkB5/hJdzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014429; c=relaxed/simple;
	bh=5sFLzjVg3/3Ur9xUDRCAPnOGK3vuVyo/t8PTF8bN4N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CX2G5VK6QiU4dOKBLlSCKBdNl7Nmz2+uv96PWdPWkJm/8u7RomNUiuc+PYrAZi5Npzw7ejTFbxT71ewlwwLJcOpkQ6DU1Zwurtf/lj433VIKAZLyFtYEVbOZa6I1MYRd10xdNpvUXyrIpNKDCCbiv+8TR1tEgR6YNU21NxhalNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hZiFRzRN; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hZiFRzRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784014407; x=1784619207; i=markus.elfring@web.de;
	bh=85qE3Kchsh70a2/0rrIr8Q1Ar+DD8lFotLQBFTihFl4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hZiFRzRNAZ4IGPg+GxpgfN/xpicCnsty3axuYdu34UvDWcfzENjg2lb0KOq7zzSK
	 E70FUOMmtv9wAlZRHiLl6WYPd5e4KhpC6X0T5xJChTrVEggj3RprvP9g5R6MmZb3u
	 myippvWNzkIZlJEPi8h1B6QZxe+sim1zz2qOb57PRCb52njcnCH+CKgjQa8Ga5JTE
	 T+jT421cZWa+rq8uEtXSp/LrU07OLvGSvP+p1IJANV7Bhurso3i9dQ77nsdoKbSOk
	 xjF5vQnfyDAhjKfOu4xZmHiJjjE9Ss0TJ0LkuFQtcdDngqW9Hbtc/pF44qebA3lXs
	 pvQDxlh1xCOkBMM/rA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjEJ-1wVQTw346B-00UKK9; Tue, 14
 Jul 2026 09:33:27 +0200
Message-ID: <9a9f104b-5c9b-4268-9622-706829e67a6d@web.de>
Date: Tue, 14 Jul 2026 09:33:18 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ceph: Move a variable assignment behind a condition check in
 __ceph_remove_cap()
To: Dan Carpenter <error27@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>, Helge Deller <deller@gmx.de>,
 Ilya Dryomov <idryomov@gmail.com>, Kees Cook <kees@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <5010d7d4-e321-4999-aca6-1caa040f3037@web.de>
 <bd15b4d5ccdcf01a8730380c4d974afaab2c782a.camel@dubeyko.com>
 <alXi78mFuDLaVQ4b@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alXi78mFuDLaVQ4b@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oDkva4Afp0k8AboJ4l+Etu3dd+G9/nsseSY3jzkZrcn8ryWOpsX
 fE6umDOmbZRoBf0I0t26rntKbn4+unLvqwr+4xd8InP00+YtMmIyAMt8WNa7SGzWrLwMfje
 iT55uqP2CaN1/9MFOPNp2Qn2HJ76X/7Ond532g/Nr7A96+yVCkThIzD7sQYTB9gMQXkOZCj
 7d4PaEOLxWTkYUOHI5vcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4iKB1Nzjmi8=;K/mi93wK0GwJ9z1yfVaZ0SAN7H6
 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
 Fx/cmV3mXppOoPamSVm7SfDSFmBStxzWqlH8DR1

>>> The address of a data structure member was determined before
>>> a corresponding null pointer check in the implementation of
>>> the function =E2=80=9C__ceph_remove_cap=E2=80=9D.
>>>
>>> Thus avoid the risk for undefined behaviour by moving the assignment
>>> for the variable =E2=80=9Cinode=E2=80=9D behind a condition check.
>>>
>>> This issue was detected by using the Coccinelle software.
>>>
>>> Fixes: 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ("ceph: print cluster
>>> fsid and client global_id in all debug logs")
=E2=80=A6
> I have explained to Markus many times that these are not dereferences,
> they are just pointer math.

How does it help to repeat such a questionable development view?


>                              So the original code works fine and does
> not need a Fixes tag or a CC to stable.
>=20
> And then Markus responds, "the C standard says we are not allowed to
> dereference NULL pointers"...  Which is true, but again, it's not a
> dereference.
Why did you get special difficulties with adhering to standard specificati=
ons
also in the discussed case?

Regards,
Markus
