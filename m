From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: page allocation failures on osd nodes
Date: Mon, 28 Jan 2013 19:55:48 +0300
Message-ID: <CABYiri8Tgup=FnSbg7H00BW-R=W=Bd8AwT85R4RkESsr_T3xVg@mail.gmail.com>
References: <CABYiri-9QoO1PdbyN29MrwsEg10XTD_HDpamaiNGSCuYDNnULg@mail.gmail.com>
 <CABYiri-RToE33ESDw7jmiL=de3oggE0Q9YWU9csLDSvRmVQieg@mail.gmail.com>
 <CAKMAVE80tW5ewwBVxeS-ZbaRuBY-Msg5i2a_Px_F+PaS_4jpHw@mail.gmail.com>
 <CABYiri-BxsBCdvTdO74K=htTL++hvLsgMxpoVi6Mx-D8RXdASQ@mail.gmail.com>
 <CABYiri8RdxnappbKOER0qAja99HSUoh1rvtGwTXzG6JJDsFLuQ@mail.gmail.com> <CAKMAVE9ZMGnnv07d90W3YoXo8A6v5n9AjczzdFJUS8x4MC5QvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59868 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab3A1Q4K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 11:56:10 -0500
Received: by mail-oa0-f46.google.com with SMTP id l13so1302182oag.33
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 08:56:09 -0800 (PST)
In-Reply-To: <CAKMAVE9ZMGnnv07d90W3YoXo8A6v5n9AjczzdFJUS8x4MC5QvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jan 28, 2013 at 5:48 PM, Sam Lang <sam.lang@inktank.com> wrote:
> On Sun, Jan 27, 2013 at 2:52 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>
>> Ahem. once on almost empty node same trace produced by qemu
>> process(which was actually pinned to the specific numa node), so seems
>> that`s generally is a some scheduler/mm bug, not directly related to
>> the osd processes. In other words, the less percentage of memory
>> actually is an RSS, the more is a probability of such allocation
>> failure.
>
> This might be a known bug in xen for your kernel?  The xen users list
> might be able to help.
> -sam

It is vanilla-3.4, I really wonder from where comes paravirt bits in the trace.
