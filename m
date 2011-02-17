From: cclien <cclien@gmail.com>
Subject: Re: [PATCH] rgw: Lighttpd compatibity.
Date: Fri, 18 Feb 2011 03:36:15 +0800
Message-ID: <AANLkTikjD_y+hinSi31LFYQp+AyqtGrcK-7gBPCQy6NK@mail.gmail.com>
References: <AANLkTikEd8UUyy3ncf2DiDqR1Aa0UNDy3AVVGnVSyCxK@mail.gmail.com>
	<AANLkTi=RR4soH3Be1fz+sYC=iTK=CRSG2KvZCaQBUs6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64459 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab1BQTgQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 14:36:16 -0500
Received: by vws16 with SMTP id 16so1358109vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 Feb 2011 11:36:16 -0800 (PST)
In-Reply-To: <AANLkTi=RR4soH3Be1fz+sYC=iTK=CRSG2KvZCaQBUs6c@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Yehuda

Thanks for the advice.

Actually the existing code did the job (filter the query string out).

In rgw_rest.cc:
636   s->path_name_url =3D FCGX_GetParam("REQUEST_URI", s->fcgx->envp);
637   int pos =3D s->path_name_url.find('?');
638   if (pos >=3D 0)
639     s->path_name_url =3D s->path_name_url.substr(0, pos);

And my workaround uses the filtered REQUEST_URI (s->path_name_url). It
should be much closer to SCRIPT_NAME.

Anyway, I will back to check Lighttpd. :D

Best Regards,
CC


On Fri, Feb 18, 2011 at 3:13 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Thu, Feb 17, 2011 at 3:20 AM, cclien <cclien@gmail.com> wrote:
>> Hi all
>>
>> I just tried to deploy a rados gateway with Lighttpd.
>> But it have some trouble parsing object names.
>>
>> Here's what I found in debug log on the non-working copy:
>> =A0 =A0RADOS S3 Gateway: SCRIPT_NAME=3D/mybucket
>> =A0 =A0RADOS S3 Gateway: REQUEST_URI=3D/mybucket/ceph.tgz
>
> That doesn't look right. May be some lighttpd configuration tweaking =
issue?
>
>>
>> I think it will be better to retrive user's request from REQUEST_URI=
=2E
>>
>
> The problem with REQUEST_URI is that it'll consist the entire line,
> including any parameters added. So using it requires some extra work
> to check for that (pretty trivial, but you should also take care of
> that).
>
> Thanks,
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
