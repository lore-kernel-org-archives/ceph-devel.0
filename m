From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: unexpected problem with radosgw fcgi
Date: Thu, 8 Nov 2012 13:48:19 -0800
Message-ID: <CAC-hyiG27TiUAi5suRiOveRyecBZvFaHYaCAgoYfb4KQFRZYXA@mail.gmail.com>
References: <CAMwB3TiJUmnr6H2QVancmDxSuF1M9KmWW0rTwxJxvLWk80WUyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46479 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757171Ab2KHVsV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 16:48:21 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so1403170bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 13:48:20 -0800 (PST)
In-Reply-To: <CAMwB3TiJUmnr6H2QVancmDxSuF1M9KmWW0rTwxJxvLWk80WUyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 7, 2012 at 6:16 AM, S=C5=82awomir Skowron <szibis@gmail.com=
> wrote:
> I have realize that requests from fastcgi in nginx from radosgw retur=
ning:
>
> HTTP/1.1 200, not a HTTP/1.1 200 OK
>
> Any other cgi that i run, for example php via fastcgi return this lik=
e
> RFC says, with OK.
>
> Is someone experience this problem ??

I have seen a similar issue in the past with nginx. It doesn't happen
with apache. My guess is that it's either something with the way nginx
is configured, or some difference in the fastcgi module
implementation.

>
> I see in code:
>
> ./src/rgw/rgw_rest.cc line 36
>
> const static struct rgw_html_errors RGW_HTML_ERRORS[] =3D {
>     { 0, 200, "" },
> ....
>
> What if i change this into:
>
> { 0, 200, "OK" },

The third field there specifies the error code embedded in the
returned XML with S3, so it wouldn't fix anything.


Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
