From: Wido den Hollander <wido@widodh.nl>
Subject: Re: radosgw segfault in 0.56
Date: Mon, 07 Jan 2013 12:08:03 +0100
Message-ID: <50EAAC93.3070308@widodh.nl>
References: <CAF6-1L5mV+nRt0yFu1CCZKH7rXiZPfxDYLi-ukmYWTSokQQbdQ@mail.gmail.com> <CAPHxCcQe3ghwv_QPoVp=9jtCoprYcWFUprhxKzhg4eOmTzKeRA@mail.gmail.com> <CAF6-1L4eYaVD5_MMdgX+pOOBzq1aZ==S9E9zO+HXrG-SDqnerw@mail.gmail.com> <CAF6-1L6ojT6LciLN3x8wTPXJ7gxGvpYucPdM7jY6gP728P-j=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:55984 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3AGLIB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 06:08:01 -0500
In-Reply-To: <CAF6-1L6ojT6LciLN3x8wTPXJ7gxGvpYucPdM7jY6gP728P-j=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On 01/07/2013 12:04 PM, Sylvain Munaut wrote:
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
>

As far as I know relying on SCRIPT_URI is rather dangerous since it's 
not always there.

There better should be an if/else-satement surrounding that code having 
it defaulting to something else if SCRIPT_URI isn't available.

That's what I still remember from my PHP-days where SCRIPT_URI was 
always a hit-and-miss.

Wido

>
> Cheers,
>
>      Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

