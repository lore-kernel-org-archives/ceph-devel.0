From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph + -lssl
Date: Thu, 3 Mar 2016 13:55:42 +0100
Message-ID: <56D8344E.6060507@digiware.nl>
References: <20160224050912.GA6585@degu.b.linuxbox.com>
 <CADRKj5Shu=S4aHX+bz-yw8zuXgGPWE2YE_au5x1HYExwer6HTw@mail.gmail.com>
 <20160227075001.GA21701@degu.b.linuxbox.com> <56D19B44.9080005@digiware.nl>
 <20160301013102.GB25207@degu.b.linuxbox.com>
 <CAFMfnwqfOs-VSUdS6kd=DM7TREi8GQze0nnv2SbSVM0ZEfU+Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:41073 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512AbcCCM5Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Mar 2016 07:57:24 -0500
In-Reply-To: <CAFMfnwqfOs-VSUdS6kd=DM7TREi8GQze0nnv2SbSVM0ZEfU+Mg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>, Marcus Watts <mwatts@redhat.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 2-3-2016 23:58, Kyle Bader wrote:
>> I looked at libressl a bit.  It still has the same license emcumbrances
>> as openssl.  So no real win there.  And, since it's not packaged as part
>> of many linux distributions, the gpl/ssleay license incompatibility issue
>> becomes a real problem here.  Hopefully a future version of libressl will
>> adopt a plain bsd license.  I know they were working hard to discard
>> the crufty openssl build system, a good thing.  When I worked with an
>> earlier version of openssl (adding a new hash or encryption algorithm,
>> I don't remember which today), I remember being disappointed at finding
>> internal interfaces that just assumed various max sizes of things.  I hope
>> the libressl folks work on making those things better too.
>>
>> I'm not familiar with google's "boringSSL".  Do you have some references
>> for it?  I won't have the time to look at it right now - but I don't mind
>> learning at least a bit more about it.  I see from wikipedia that it's
>> yet another fork of openssl - will they fix the license issue?
>>
>> I did look (mostly superficially) at,
>>         botan libressl gnutls matrixssl mbed wolfssl cryptlib nss
>>         & apple's "secure transport"
>> It was mostly superficial because my first question was "are there
>> a lot of other people using this" aka "am I going to be debugging
>> and supporting this myself"?
> 
> BoringSSL
> 
> https://boringssl.googlesource.com/boringssl/
> 
> This might also be worth a look:
> 
> https://github.com/awslabs/s2n

I myself have spoken to one of the people that works on integration of
LibreSSL in FreeBSD ports (he lives in town here). And yes he tells me
that it is a lot of work, but mainly because of the "liberties" that
openssl allows. And even though LibreSSL attempts to be a plugin
replacement, it are these edge corners which do work, but according the
API should not, that create the porting pain.

So that would be another argument of trying to see if you can hook this
in. I'm sure you will find odd bits and pieces that do not work as
expected. But in the end it will improve you code quality. Same feeling
I have trying to port to FreeBSD. 99,9% is compatible, and sometimes
Linuxisms creep in where the do not have to because POSIX is good enough.

But you are right, on occassion you will hit a wall and damage you nose.
On the other hand, I'm upgrading openssl in all environments I maintain
for the 3 or 4th time in 2 years, because of major bugs in openssl.
Doesn't say there are no bugs in the other implementations.

But it was just a things I was wondering when I saw the implementation
come by. And any implementation is beter than none. So thanx for doing
the work.

--WjW


