From: huang jun <hjwsm1989@gmail.com>
Subject: Re: how to debug librados/librbd in logfile
Date: Thu, 28 Jan 2016 23:06:04 +0800
Message-ID: <CABAwU-bLWx8BKw_3-W0upjNKOOVA_Jv6mke8xC+ByZoZiz6PAQ@mail.gmail.com>
References: <CABAwU-YLhiSdD8cbZWHC=8cBeNi_UM2rp3XpJefwWsiszwv6ww@mail.gmail.com>
	<56AA288E.1010205@42on.com>
	<CABAwU-Zhxz1j5jgZ2po34PD_D5qC6=h0oVo0jD-38gh014Qs0Q@mail.gmail.com>
	<CACJqLyZXhTBWqrX0cMeDLxQ7e_kD-unsqJ-Q8gMw5AUkzo6OSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34676 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbcA1PGF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 10:06:05 -0500
Received: by mail-lb0-f179.google.com with SMTP id cl12so24973512lbc.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jan 2016 07:06:04 -0800 (PST)
In-Reply-To: <CACJqLyZXhTBWqrX0cMeDLxQ7e_kD-unsqJ-Q8gMw5AUkzo6OSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

thanks, lttng should be a good option, i'll try it.

2016-01-28 22:50 GMT+08:00 Haomai Wang <haomai@xsky.com>:
> On Thu, Jan 28, 2016 at 10:45 PM, huang jun <hjwsm1989@gmail.com> wrote:
>> we run ceph version 0.94.5, and use the root.
>> The use case is tgt + librbd,
>> i want to record all operations used by tgt during format, write, read, delete.
>
> actually you can use lttng + rbd-replay to get it
>
>>
>>
>> 2016-01-28 22:41 GMT+08:00 Wido den Hollander <wido@42on.com>:
>>>
>>>
>>> On 28-01-16 15:33, huang jun wrote:
>>>> hi,all
>>>> I want to get debug log when using librados/librbd,
>>>> set client section in ceph.conf:
>>>> [client]
>>>> debug_rbd = 20
>>>> debug_objecter = 20
>>>> log_file = /var/log/ceph/ceph.rbd.log
>>>>
>>>> that not work, file "/var/log/ceph/ceph.rbd.log" does not exist at all.
>>>> Any ideas?
>>>>
>>>
>>> Does the user under which you run the client have access to /var/log/ceph?
>>>
>>> You might want to try /tmp for a test.
>>>
>>> Wido
>>
>>
>>
>> --
>> thanks
>> huangjun
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
thanks
huangjun
