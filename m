From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw segfault in 0.56
Date: Mon, 7 Jan 2013 17:06:01 +0200
Message-ID: <CAC-hyiGiOvSy8y3nxi73rsMkO__omfKwLMJSvG5a=OWqooBEOg@mail.gmail.com>
References: <CAF6-1L5mV+nRt0yFu1CCZKH7rXiZPfxDYLi-ukmYWTSokQQbdQ@mail.gmail.com>
	<CAPHxCcQe3ghwv_QPoVp=9jtCoprYcWFUprhxKzhg4eOmTzKeRA@mail.gmail.com>
	<CAF6-1L4eYaVD5_MMdgX+pOOBzq1aZ==S9E9zO+HXrG-SDqnerw@mail.gmail.com>
	<CAF6-1L6ojT6LciLN3x8wTPXJ7gxGvpYucPdM7jY6gP728P-j=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41528 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab3AGPNW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 10:13:22 -0500
Received: by mail-ie0-f169.google.com with SMTP id c14so24111751ieb.28
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 07:13:21 -0800 (PST)
In-Reply-To: <CAF6-1L6ojT6LciLN3x8wTPXJ7gxGvpYucPdM7jY6gP728P-j=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 7, 2013 at 1:04 PM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Ok, I tracked this down ...
>
> I'm using lighttpd as a FastCGI front end and it doesn't set
> SCRIPT_URI environment.
>
>
> So the line 1123 in rgw/rgw_rest.cc :
>
> s->script_uri = s->env->get("SCRIPT_URI");
>
> Tries to assign NULL to s->script_uri  which crashes with the
> particularly unhelpful stack trace I pasted above ...

Yeah, it's missing a guard here. Strange, I remember fixing this and
others, but I can't find any trace of that. I think setting it to
empty string is ok, though we may want to explore other fixes
(configurable?) -- it affects the Location field in S3 POST response.

Yehuda
