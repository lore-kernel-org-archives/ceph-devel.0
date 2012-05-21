From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: ceph 0.47 libs3 install problem
Date: Mon, 21 May 2012 13:29:21 -0700
Message-ID: <CAC-hyiFTXoxU9xsveM=GMMAkFXC9FzzQs5Gm8FmTQ=Bcr+D7uw@mail.gmail.com>
References: <CAPud5_7UKKe-=GNfWnJEut179Nz6oBdegrKX5Xoyo4Vj7oL4cw@mail.gmail.com>
	<CADvuQRG5EGBq2DB3L71RHKahT8z40mZ=sSPkEaPf2gPTgki+Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62247 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758415Ab2EUU3W convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:29:22 -0400
Received: by bkcji2 with SMTP id ji2so4341685bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 13:29:21 -0700 (PDT)
In-Reply-To: <CADvuQRG5EGBq2DB3L71RHKahT8z40mZ=sSPkEaPf2gPTgki+Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Nick Bartos <nick@pistoncloud.com>, ceph-devel@vger.kernel.org

On Mon, May 21, 2012 at 1:22 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, May 21, 2012 at 1:14 PM, Nick Bartos <nick@pistoncloud.com> w=
rote:
>> I'm trying to install ceph 0.47, but --prefix isn't getting passed t=
o
>> the bundled libs3. =A0I installed libs3 separately, but even when us=
ing
>> --with-system-libs3 (as ./configure suggests) or
>> --with-system-libs3=3Dyes (just for the hell of it), it still instal=
ls
>> libs3, and outside of the prefix it was given.
>>
>> Anyone know of a way to either get ceph's libs3 to be installed in
>> --prefix, or to get it to use the system one instead?
>
> Hmm. I just noticed this: src/Makefile.am has
>
> SUBDIRS =3D ocf libs3
> ...
> if WITH_SYSTEM_LIBS3
> rest_bench_LDADD +=3D -ls3
> else
> rest_bench_LDADD +=3D libs3/build/lib/libs3.a -lcurl -lxml2
> rest_bench_CXXFLAGS +=3D -I$(top_srcdir)/src/libs3/inc
> SUBDIRS +=3D libs3
> endif
>
> I'm guessing the top SUBDIRS assignment should not have libs3 there,
> and that's the source of your trouble. Yehuda, can you confirm &
> commit a fix?

It does look like a possible suspect. I'll verify that.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
