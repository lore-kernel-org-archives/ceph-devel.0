From: Samuel Just <sam.just@inktank.com>
Subject: Re: Supporting partial writes for EC backend
Date: Fri, 30 Jan 2015 10:49:39 -0800
Message-ID: <CA+4uBUbzpHKF0ATmgUztZ4hzGm3XhkR1caB8Cd=k73FZeNLNnw@mail.gmail.com>
References: <BLU436-SMTP14889EB55A90A7C338308A9A7310@phx.gbl>
	<CA+4uBUZWqWqy=gddVB=sWT7PsLsvq4mYVMn8_-tjM3sUL50Qsw@mail.gmail.com>
	<BLU436-SMTP163B80C7054F010E6535A1EA7310@phx.gbl>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:37894 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbA3Stk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 13:49:40 -0500
Received: by mail-la0-f52.google.com with SMTP id ge10so25318724lab.11
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 10:49:39 -0800 (PST)
In-Reply-To: <BLU436-SMTP163B80C7054F010E6535A1EA7310@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <bassamtabbara@hotmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This would need to be a new backend, and it's going to be a massive
amount of work.  You want to start by reading and understanding all of
the docs in osd_internals.  I also suspect you'll get a lot of what
you need from using a replicated cache in front of an EC pool.
-Sam

On Fri, Jan 30, 2015 at 10:00 AM, Bassam Tabbara
<bassamtabbara@hotmail.com> wrote:
> I=E2=80=99d like to explore adding a new EC pool type as you suggest.=
 The idea is to have RBD sit on-top of a fully functional EC backend. J=
ust as with RAID6 arrays today some applications are aware of the read-=
modify-write penalty and they could optimize for it.
>
> I=E2=80=99m new to ceph, so if you can point me in the right directio=
n I would appreciate it. Do you think this is something that could be i=
mplemented as a modification to the existing ECBackend or is this a new=
 backend. I=E2=80=99m happy to jump on a quick call if it makes things =
easier.
>
>> On Jan 30, 2015, at 8:59 AM, Samuel Just <sam.just@inktank.com> wrot=
e:
>>
>> Basically, it's an architectural choice:
>>
>> https://github.com/ceph/ceph/blob/master/doc/dev/osd_internals/erasu=
re_coding/pgbackend.rst#client-writes
>>
>> If we wanted to support partial writes, we'd probably want to
>> introduce a second EC pool type with different tradeoffs.  Note, you
>> can get slow partial writes on an EC pool by placing a replicated
>> cache in front.
>> -Sam
>>
>> On Fri, Jan 30, 2015 at 8:36 AM, Bassam Tabbara
>> <bassamtabbara@hotmail.com> wrote:
>>> Hello,
>>>
>>> I realize that the EC Backend does not support all operations like =
partial writes, truncate, and others. I=E2=80=99d like to understand wh=
ether adding the missing operations is something that is architecturall=
y possible, or if this is a limitation of the architecture / approach. =
Can someone shed some light on this?
>>>
>>> I realize that partial writes are going to be slow/inefficient on a=
n EC backend compared to a replicated backend.
>>>
>>> Thanks!
>>> Bassam--
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
