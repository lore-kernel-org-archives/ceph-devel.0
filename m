From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: radosgw segfault in 0.56
Date: Mon, 7 Jan 2013 12:04:24 +0100
Message-ID: <CAF6-1L6ojT6LciLN3x8wTPXJ7gxGvpYucPdM7jY6gP728P-j=w@mail.gmail.com>
References: <CAF6-1L5mV+nRt0yFu1CCZKH7rXiZPfxDYLi-ukmYWTSokQQbdQ@mail.gmail.com>
	<CAPHxCcQe3ghwv_QPoVp=9jtCoprYcWFUprhxKzhg4eOmTzKeRA@mail.gmail.com>
	<CAF6-1L4eYaVD5_MMdgX+pOOBzq1aZ==S9E9zO+HXrG-SDqnerw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:65212 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3AGLEY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 06:04:24 -0500
Received: by mail-oa0-f47.google.com with SMTP id h1so17355136oag.20
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 03:04:24 -0800 (PST)
In-Reply-To: <CAF6-1L4eYaVD5_MMdgX+pOOBzq1aZ==S9E9zO+HXrG-SDqnerw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ok, I tracked this down ...

I'm using lighttpd as a FastCGI front end and it doesn't set
SCRIPT_URI environment.


So the line 1123 in rgw/rgw_rest.cc :

s->script_uri = s->env->get("SCRIPT_URI");

Tries to assign NULL to s->script_uri  which crashes with the
particularly unhelpful stack trace I pasted above ...


Cheers,

    Sylvain
