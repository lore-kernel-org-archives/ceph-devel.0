From: Gregory Farnum <gfarnum@redhat.com>
Subject: =?UTF-8?Q?Re=3A_why_clog_can_redirect_to_mon=EF=BC=9F?=
Date: Mon, 8 Aug 2016 18:33:22 -0700
Message-ID: <CAJ4mKGY-SaefbVaohEZLOGBppL9f1kXi-+k81Hr=yU1yU9LcWg@mail.gmail.com>
References: <CAKZcxgc95-dGB=CCnvXe__rz9SpWzDGUkpR327x-OgnKExKZ2w@mail.gmail.com>
 <CAJ4mKGZiAVp1S4O+ggstc_Lxh7Eda_Gi9_7Zuv-DJ1bQZZhsUw@mail.gmail.com> <CAKZcxgcRz2YdceKy1bSSKA4+dSvg-Jw28sniJjQemL-mwYp_xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:33186 "EHLO
	mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbcHIBdY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2016 21:33:24 -0400
Received: by mail-ua0-f181.google.com with SMTP id 74so95632373uau.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Aug 2016 18:33:23 -0700 (PDT)
In-Reply-To: <CAKZcxgcRz2YdceKy1bSSKA4+dSvg-Jw28sniJjQemL-mwYp_xA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

[ Re-adding list. ]

On Mon, Aug 8, 2016 at 6:31 PM, Jaze Lee <jazeltq@gmail.com> wrote:
> 2016-08-09 7:28 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>> On Mon, Aug 8, 2016 at 6:35 AM, Jaze Lee <jazeltq@gmail.com> wrote:
>>> Hi all，
>>>
>>>       I found that clog default send message to mon. But i do not know why it
>>> sends to mon? Can someone explian more about why we do that ?
>>
>> The purpose of the "central log" is to send log messages to a central
>> location for sharing. The mon is what we've got right now; it collects
>> the messages, writes them to a local file, and spits them out to
>> anybody running "ceph -w" (technically, anybody with a log
>> subscription).
>> -Greg
>
> Thanks Greg. One more question.
>
> The central log is used to monitor cluster status, so if i make
> clog_to_monitors = false, then
> i could not get the change of cluster status. Does it？

You'll still get information about OSDs going up and down, and other
things which the monitors check for directly. But you won't get so
many per-daemon messages about weird-looking things. I wouldn't turn
off clog_to_monitors unless you have a very specific reason for it.
-Greg
