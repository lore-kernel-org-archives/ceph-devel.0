From: Sam Lang <sam.lang@inktank.com>
Subject: Re: page allocation failures on osd nodes
Date: Tue, 29 Jan 2013 14:30:56 -0600
Message-ID: <CAKMAVE_GPpAacHqFMnQS==Q9Gja2=RGJy1q_DffFpxubdZoc=w@mail.gmail.com>
References: <CABYiri-9QoO1PdbyN29MrwsEg10XTD_HDpamaiNGSCuYDNnULg@mail.gmail.com>
	<CABYiri-RToE33ESDw7jmiL=de3oggE0Q9YWU9csLDSvRmVQieg@mail.gmail.com>
	<CAKMAVE80tW5ewwBVxeS-ZbaRuBY-Msg5i2a_Px_F+PaS_4jpHw@mail.gmail.com>
	<CABYiri-BxsBCdvTdO74K=htTL++hvLsgMxpoVi6Mx-D8RXdASQ@mail.gmail.com>
	<CABYiri8RdxnappbKOER0qAja99HSUoh1rvtGwTXzG6JJDsFLuQ@mail.gmail.com>
	<CAKMAVE9ZMGnnv07d90W3YoXo8A6v5n9AjczzdFJUS8x4MC5QvQ@mail.gmail.com>
	<CABYiri8Tgup=FnSbg7H00BW-R=W=Bd8AwT85R4RkESsr_T3xVg@mail.gmail.com>
	<CABYiri_WxAQZ+OhX+Bj4QQdp3mkxXECQJ4wYj=p_V2ET1jW-sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:57817 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab3A2Ua5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 15:30:57 -0500
Received: by mail-ob0-f172.google.com with SMTP id tb18so887026obb.31
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 12:30:56 -0800 (PST)
In-Reply-To: <CABYiri_WxAQZ+OhX+Bj4QQdp3mkxXECQJ4wYj=p_V2ET1jW-sw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jan 29, 2013 at 2:21 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
> On Mon, Jan 28, 2013 at 8:55 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> On Mon, Jan 28, 2013 at 5:48 PM, Sam Lang <sam.lang@inktank.com> wrote:
>>> On Sun, Jan 27, 2013 at 2:52 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>>>
>>>> Ahem. once on almost empty node same trace produced by qemu
>>>> process(which was actually pinned to the specific numa node), so seems
>>>> that`s generally is a some scheduler/mm bug, not directly related to
>>>> the osd processes. In other words, the less percentage of memory
>>>> actually is an RSS, the more is a probability of such allocation
>>>> failure.
>>>
>>> This might be a known bug in xen for your kernel?  The xen users list
>>> might be able to help.
>>> -sam
>>
>> It is vanilla-3.4, I really wonder from where comes paravirt bits in the trace.
>
> Bug exposed only in 3.4 and really harmless, at least in ways I have
> tested that. Ceph-osd memory allocation behavior more likely to
> trigger those messages than most other applications in ``same''
> conditions.

Good to know.  Thanks!
-sam
