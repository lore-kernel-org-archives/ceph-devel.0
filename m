From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: ceph + -lssl
Date: Wed, 2 Mar 2016 14:58:13 -0800
Message-ID: <CAFMfnwqfOs-VSUdS6kd=DM7TREi8GQze0nnv2SbSVM0ZEfU+Mg@mail.gmail.com>
References: <20160224050912.GA6585@degu.b.linuxbox.com>
	<CADRKj5Shu=S4aHX+bz-yw8zuXgGPWE2YE_au5x1HYExwer6HTw@mail.gmail.com>
	<20160227075001.GA21701@degu.b.linuxbox.com>
	<56D19B44.9080005@digiware.nl>
	<20160301013102.GB25207@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34047 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbcCBW6O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 17:58:14 -0500
Received: by mail-yw0-f177.google.com with SMTP id h129so3782434ywb.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 14:58:14 -0800 (PST)
In-Reply-To: <20160301013102.GB25207@degu.b.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

> I looked at libressl a bit.  It still has the same license emcumbrances
> as openssl.  So no real win there.  And, since it's not packaged as part
> of many linux distributions, the gpl/ssleay license incompatibility issue
> becomes a real problem here.  Hopefully a future version of libressl will
> adopt a plain bsd license.  I know they were working hard to discard
> the crufty openssl build system, a good thing.  When I worked with an
> earlier version of openssl (adding a new hash or encryption algorithm,
> I don't remember which today), I remember being disappointed at finding
> internal interfaces that just assumed various max sizes of things.  I hope
> the libressl folks work on making those things better too.
>
> I'm not familiar with google's "boringSSL".  Do you have some references
> for it?  I won't have the time to look at it right now - but I don't mind
> learning at least a bit more about it.  I see from wikipedia that it's
> yet another fork of openssl - will they fix the license issue?
>
> I did look (mostly superficially) at,
>         botan libressl gnutls matrixssl mbed wolfssl cryptlib nss
>         & apple's "secure transport"
> It was mostly superficial because my first question was "are there
> a lot of other people using this" aka "am I going to be debugging
> and supporting this myself"?

BoringSSL

https://boringssl.googlesource.com/boringssl/

This might also be worth a look:

https://github.com/awslabs/s2n

-- 

Kyle Bader
