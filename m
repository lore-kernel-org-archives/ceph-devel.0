From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: projects
Date: Tue, 30 Aug 2011 10:04:51 -0700
Message-ID: <CA+qbEUPpoxeNGSd795EpjWPes8tfKkiY0hXQPh4Bo5NZ1iVd1w@mail.gmail.com>
References: <Pine.LNX.4.64.1108291206370.14548@cobra.newdream.net>
	<CAFtEh-dZbDiF7sfXpVfpcrJKy2=E+Moo+grzU1Lh_AFCkATz1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46267 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab1H3REx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Aug 2011 13:04:53 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DD25EC067
	for <ceph-devel@vger.kernel.org>; Tue, 30 Aug 2011 10:08:02 -0700 (PDT)
Received: from mail-fx0-f46.google.com (mail-fx0-f46.google.com [209.85.161.46])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 8DC81C063
	for <ceph-devel@vger.kernel.org>; Tue, 30 Aug 2011 10:08:02 -0700 (PDT)
Received: by fxh19 with SMTP id 19so5525211fxh.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Aug 2011 10:04:51 -0700 (PDT)
In-Reply-To: <CAFtEh-dZbDiF7sfXpVfpcrJKy2=E+Moo+grzU1Lh_AFCkATz1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Aug 30, 2011 at 6:07 AM, Damien Churchill <damoxc@gmail.com> wr=
ote:
> On 29 August 2011 20:08, Sage Weil <sage@newdream.net> wrote:
>> I started to make a list of smallish projects that are reasonably ea=
sy for
>> new developers to approach. =A0The list is at
>>
>> http://ceph.newdream.net/wiki/Projects
>>
>> Any other ideas?
>>
>> sage
>>
>
> I've been working on some alternative python bindings [0], using
> Cython instead of ctypes to wrap the libraries. It's still early days
> but they're in a reasonably usable state. When I have the time I'm
> going to look at wrapping the C++ headers instead of the C ones. I
> started it as there weren't any py bindings for librbd and figured ma=
y
> as well wrap the others whilst I'm at it. No idea if it'll be useful
> for anyone else.
>
> [0] http://github.com/ukplc/pyceph
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Cython is an interesting project.

C++ makes a big deal out of being source-compatible with C. But
really, source compatibility with C is not required to have a
well-integrated system with high-level and low-level components. All
you need is the ability to link with C code and interact with it
without the hassle of something like JNI or SWIG.

=46or example, GCC now allows you to compile half of your project in C
and the other half in Golang. You can't mix the two in the same object
file, but they can interact pretty seamlessly.

There seems to be a trend lately to give dynamic languages a small
amount of static typing, just to give them some much-needed
performance. Javascript recently got typed arrays, and apparently it
was a huge performance boost. However, one thing that is notably
lacking in Cython is any discussion of removing the global interpreter
lock (GIL.) Unless that ever gets tackled, you'll effectively be
limited to the performance of a single core, which is a rapidly
shrinking percentage of the actual system resources. I can see there
are some workarounds in Cython like manually dropping the GIL inside a
certain section.

If you get a chance, you should check out Golang. It allows you to use
something very much like duck typing, but also get the benefits of
static typing. There are no header files, class hierarchies, or
tedious boilerplate.  It also has a great concurrency mechanism that
is better than threads and yes, does use all the cores. :)

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
