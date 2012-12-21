From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: reference to global_context.h in dout.h
Date: Fri, 21 Dec 2012 14:58:00 +0100
Message-ID: <CAN04cT6SRaMiJj=dvDN1DiK21-odR=EdLVbk6d+9wioMZgdhvQ@mail.gmail.com>
References: <CAN04cT7m4umbZ_bBszWR0Q4STyjmgv5Lx4HBy=-QgZPVZAj=FQ@mail.gmail.com>
	<6C8FBDB1-C946-438E-A902-83658BEE33BE@inktank.com>
	<alpine.DEB.2.00.1212201043170.16508@cobra.newdream.net>
	<CAN04cT71j-01w_aG-_OYUA5ycGkruHG4PuTSytGyZepixsf6tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:53278 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab2LUN6A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Dec 2012 08:58:00 -0500
Received: by mail-vb0-f51.google.com with SMTP id fq11so5021043vbb.24
        for <ceph-devel@vger.kernel.org>; Fri, 21 Dec 2012 05:58:00 -0800 (PST)
In-Reply-To: <CAN04cT71j-01w_aG-_OYUA5ycGkruHG4PuTSytGyZepixsf6tw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry, just realized you're in a different timezone and that the
fix/cleanup is actually quite easy and done before you will read this
message :-)

I've sent a pull request on github.

Roald

On Fri, Dec 21, 2012 at 12:01 PM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> I see.
>
> I always thought it was already fully seperated because of the comment
> in common/debug.h, saying "Global version of the stuff in
> common/dout.h" (although I don't understand why that file is in
> common).
>
> Are there by any chance some docs on how this "ideal world" was
> originally designed, so I can help with some of it? It's really
> bugging me and stopping me from other things I'm toying with (e.g. the
> config thingie), because librados.so won't link.
>
> Thanks!
>
> Roald
>
>
> On Thu, Dec 20, 2012 at 7:44 PM, Sage Weil <sage@inktank.com> wrote:
>> On Thu, 20 Dec 2012, Dan Mick wrote:
>>> dout/err and ldout/err rely on CeohContext being available. It's
>>> possible the includes should be separated; i'd have to look more closely
>>> to have a real judgment.  But the macros really do need a cct to work at
>>> all.
>>
>> Right.
>>
>> In an ideal world, things that link in g_ceph_context would have a
>> separate #include and other code wouldn't see the declaration, but we
>> didn't get that far when this was cleaned up a while back.  Instead, you
>> get a linker error if you, say, do dout(...) instead of ldout(...) in
>> something that doesn't link the globals.
>>
>> sage
>>
>>
>>  >
>>> On Dec 20, 2012, at 6:52 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
>>>
>>> > Hi ceph devs,
>>> >
>>> > I was wondering. In common/dout.h is an #include of
>>> > global/ceph_context.h, but it is not used there (I stumbled upon it
>>> > because while playing around in the codebase, I noticed librados would
>>> > not link because of an undefined reference to g_ceph_context). I have
>>> > no idea why this include is in dout.h, but it seems that a lot of
>>> > different sources fail to compile (because g_ceph_context definition
>>> > is missing) when I remove the include from dout.h.
>>> >
>>> > So it seems like it's used as some sort of forward include (because
>>> > dout.h is almost always included through include/Context.h) to make
>>> > sure g_ceph_context is defined in most places.
>>> >
>>> > What is the rationale of having this here? Isn't it better to try to
>>> > split global and common as much as possible?
>>> >
>>> > Ciao,
>>> >
>>> > Roald
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
