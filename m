From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: radosgw segfault in 0.56
Date: Mon, 7 Jan 2013 16:12:57 +0100
Message-ID: <CAF6-1L6pfCjEHXdax01qcrLiV+=ZyqtqiQRAn69W_d46DjYfKA@mail.gmail.com>
References: <CAF6-1L5mV+nRt0yFu1CCZKH7rXiZPfxDYLi-ukmYWTSokQQbdQ@mail.gmail.com>
	<CAPHxCcQe3ghwv_QPoVp=9jtCoprYcWFUprhxKzhg4eOmTzKeRA@mail.gmail.com>
	<CAF6-1L4eYaVD5_MMdgX+pOOBzq1aZ==S9E9zO+HXrG-SDqnerw@mail.gmail.com>
	<CAF6-1L6ojT6LciLN3x8wTPXJ7gxGvpYucPdM7jY6gP728P-j=w@mail.gmail.com>
	<CAC-hyiGiOvSy8y3nxi73rsMkO__omfKwLMJSvG5a=OWqooBEOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:62659 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3AGPM6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 10:12:58 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so17712996obc.29
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 07:12:57 -0800 (PST)
In-Reply-To: <CAC-hyiGiOvSy8y3nxi73rsMkO__omfKwLMJSvG5a=OWqooBEOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> Yeah, it's missing a guard here. Strange, I remember fixing this and
> others, but I can't find any trace of that. I think setting it to
> empty string is ok, though we may want to explore other fixes
> (configurable?) -- it affects the Location field in S3 POST response.

Yes, I've seen it's used there. Since we have dedicated gw machines,
they're at the root / so doesn't matter.

BTW, do you know why the stack trace sucks so much ? I mean, it looks
especially unhelpful, the function where the crash happen isn't even
listed in there at all ...

Cheers,

    Sylvain
