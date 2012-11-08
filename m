From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: unexpected problem with radosgw fcgi
Date: Thu, 8 Nov 2012 23:01:59 +0100
Message-ID: <152029521091470467@unknownmsgid>
References: <CAMwB3TiJUmnr6H2QVancmDxSuF1M9KmWW0rTwxJxvLWk80WUyA@mail.gmail.com>
 <CAC-hyiG27TiUAi5suRiOveRyecBZvFaHYaCAgoYfb4KQFRZYXA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39966 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098Ab2KHWCF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 17:02:05 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so2187011qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 14:02:04 -0800 (PST)
In-Reply-To: <CAC-hyiG27TiUAi5suRiOveRyecBZvFaHYaCAgoYfb4KQFRZYXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok, i will digg in nginx, thanks.

Dnia 8 lis 2012 o godz. 22:48 Yehuda Sadeh <yehuda@inktank.com> napisa=C5=
=82(a):

> On Wed, Nov 7, 2012 at 6:16 AM, S=C5=82awomir Skowron <szibis@gmail.c=
om> wrote:
>> I have realize that requests from fastcgi in nginx from radosgw retu=
rning:
>>
>> HTTP/1.1 200, not a HTTP/1.1 200 OK
>>
>> Any other cgi that i run, for example php via fastcgi return this li=
ke
>> RFC says, with OK.
>>
>> Is someone experience this problem ??
>
> I have seen a similar issue in the past with nginx. It doesn't happen
> with apache. My guess is that it's either something with the way ngin=
x
> is configured, or some difference in the fastcgi module
> implementation.
>
>>
>> I see in code:
>>
>> ./src/rgw/rgw_rest.cc line 36
>>
>> const static struct rgw_html_errors RGW_HTML_ERRORS[] =3D {
>>    { 0, 200, "" },
>> ....
>>
>> What if i change this into:
>>
>> { 0, 200, "OK" },
>
> The third field there specifies the error code embedded in the
> returned XML with S3, so it wouldn't fix anything.
>
>
> Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
