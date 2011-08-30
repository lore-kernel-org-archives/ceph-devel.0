From: Damien Churchill <damoxc@gmail.com>
Subject: Re: projects
Date: Tue, 30 Aug 2011 18:55:14 +0100
Message-ID: <CAFtEh-eSHZPCTB2rv4_6gksNxE=DWG7gdTBK+7QHB-ftBLus1Q@mail.gmail.com>
References: <Pine.LNX.4.64.1108291206370.14548@cobra.newdream.net>
	<CAFtEh-dZbDiF7sfXpVfpcrJKy2=E+Moo+grzU1Lh_AFCkATz1A@mail.gmail.com>
	<CA+qbEUPpoxeNGSd795EpjWPes8tfKkiY0hXQPh4Bo5NZ1iVd1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61321 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab1H3RzO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Aug 2011 13:55:14 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so5846763gxk.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Aug 2011 10:55:14 -0700 (PDT)
In-Reply-To: <CA+qbEUPpoxeNGSd795EpjWPes8tfKkiY0hXQPh4Bo5NZ1iVd1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 30 August 2011 18:04, Colin Patrick McCabe
<colin.mccabe@dreamhost.com> wrote:
> On Tue, Aug 30, 2011 at 6:07 AM, Damien Churchill <damoxc@gmail.com> =
wrote:
>> On 29 August 2011 20:08, Sage Weil <sage@newdream.net> wrote:
>>> I started to make a list of smallish projects that are reasonably e=
asy for
>>> new developers to approach. =C2=A0The list is at
>>>
>>> http://ceph.newdream.net/wiki/Projects
>>>
>>> Any other ideas?
>>>
>>> sage
>>>
>>
>> I've been working on some alternative python bindings [0], using
>> Cython instead of ctypes to wrap the libraries. It's still early day=
s
>> but they're in a reasonably usable state. When I have the time I'm
>> going to look at wrapping the C++ headers instead of the C ones. I
>> started it as there weren't any py bindings for librbd and figured m=
ay
>> as well wrap the others whilst I'm at it. No idea if it'll be useful
>> for anyone else.
>>
>> [0] http://github.com/ukplc/pyceph
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
> Cython is an interesting project.
>
> C++ makes a big deal out of being source-compatible with C. But
> really, source compatibility with C is not required to have a
> well-integrated system with high-level and low-level components. All
> you need is the ability to link with C code and interact with it
> without the hassle of something like JNI or SWIG.
>
> For example, GCC now allows you to compile half of your project in C
> and the other half in Golang. You can't mix the two in the same objec=
t
> file, but they can interact pretty seamlessly.
>
> There seems to be a trend lately to give dynamic languages a small
> amount of static typing, just to give them some much-needed
> performance. Javascript recently got typed arrays, and apparently it
> was a huge performance boost. However, one thing that is notably
> lacking in Cython is any discussion of removing the global interprete=
r
> lock (GIL.) Unless that ever gets tackled, you'll effectively be
> limited to the performance of a single core, which is a rapidly
> shrinking percentage of the actual system resources. I can see there
> are some workarounds in Cython like manually dropping the GIL inside =
a
> certain section.

Yes, you can add "nogil" to method signatures (I have yet to do so)
which will release the GIL when executing that method. You of course
have to not be touching any python stuff whilst running that method
but it means you are able to delve into using multiple cores for C
code. So for something like bindings it works fine as there shouldn't
be too much computation going on in the python side of things.

> If you get a chance, you should check out Golang. It allows you to us=
e
> something very much like duck typing, but also get the benefits of
> static typing. There are no header files, class hierarchies, or
> tedious boilerplate. =C2=A0It also has a great concurrency mechanism =
that
> is better than threads and yes, does use all the cores. :)
>

Already have been experimenting with it, quite enjoying it as well.
The concurrency is a dream indeed :-) Python does have greenlet but
goroutines are far more elegant.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
