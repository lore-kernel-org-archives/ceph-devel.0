From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: ceph 0.47 libs3 install problem
Date: Mon, 21 May 2012 14:31:21 -0700
Message-ID: <CAC-hyiGgk8WmYtgn45giA3nsscOrhvbwS2iQOWcLCY7vqr+KJw@mail.gmail.com>
References: <CAPud5_7UKKe-=GNfWnJEut179Nz6oBdegrKX5Xoyo4Vj7oL4cw@mail.gmail.com>
	<CADvuQRG5EGBq2DB3L71RHKahT8z40mZ=sSPkEaPf2gPTgki+Xg@mail.gmail.com>
	<CAC-hyiFTXoxU9xsveM=GMMAkFXC9FzzQs5Gm8FmTQ=Bcr+D7uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45293 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab2EUVbW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 17:31:22 -0400
Received: by bkcji2 with SMTP id ji2so4383758bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 14:31:21 -0700 (PDT)
In-Reply-To: <CAC-hyiFTXoxU9xsveM=GMMAkFXC9FzzQs5Gm8FmTQ=Bcr+D7uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

On Mon, May 21, 2012 at 1:29 PM, Yehuda Sadeh <yehuda@inktank.com> wrot=
e:
> On Mon, May 21, 2012 at 1:22 PM, Tommi Virtanen <tv@inktank.com> wrot=
e:
>> On Mon, May 21, 2012 at 1:14 PM, Nick Bartos <nick@pistoncloud.com> =
wrote:
>>> I'm trying to install ceph 0.47, but --prefix isn't getting passed =
to
>>> the bundled libs3. =A0I installed libs3 separately, but even when u=
sing
>>> --with-system-libs3 (as ./configure suggests) or
>>> --with-system-libs3=3Dyes (just for the hell of it), it still insta=
lls
>>> libs3, and outside of the prefix it was given.
>>>
>>> Anyone know of a way to either get ceph's libs3 to be installed in
>>> --prefix, or to get it to use the system one instead?
>>
>> Hmm. I just noticed this: src/Makefile.am has
>>
>> SUBDIRS =3D ocf libs3
>> ...
>> if WITH_SYSTEM_LIBS3
>> rest_bench_LDADD +=3D -ls3
>> else
>> rest_bench_LDADD +=3D libs3/build/lib/libs3.a -lcurl -lxml2
>> rest_bench_CXXFLAGS +=3D -I$(top_srcdir)/src/libs3/inc
>> SUBDIRS +=3D libs3
>> endif
>>
>> I'm guessing the top SUBDIRS assignment should not have libs3 there,
>> and that's the source of your trouble. Yehuda, can you confirm &
>> commit a fix?
>
> It does look like a possible suspect. I'll verify that.
>

This is the culprit, however, it doesn't solve the case where we
actually need libs3 (when rest-bench is enabled). We don't really need
to make install anyway, as we link statically to that library.

I pushed two fixes, one to ceph.git
(3a2dc969fffe6ee6f3a51583444998aba6449b7a) that removes the
unconditional appending of libs3 to SUBDIRS, and the second one to
libs3.git (9dc3a9c683385abfe4ad92b7c6ff30719acc3c13) that overrides
the install rule.

Yehuda

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
