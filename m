From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Wed, 14 Aug 2013 17:03:39 +0200
Message-ID: <CAF6-1L43p76keEosc+RfP0yzGfFFn==b9FTUKwYSU5xski4pTw@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au>
	<CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62F433FE@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B62F43442@BITCOM1.int.sbss.com.au>
	<CAF6-1L502OZGbPHp37vWzEU3H-wsK5z904ZtS7SEUmuM-GhLyA@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B63891798@BITCOM1.int.sbss.com.au>
	<CAF6-1L4=rY7AJpHGB33KPMk6LfX7q8CHphPzh9amdqwbYzg3dQ@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B6389552A@BITCOM1.int.sbss.com.au>
	<CAF6-1L6jJvYuHN+BoucU2RNzv2R9dpMhbD1UVF96mBPO25FM5g@mail.gmail.com>
	<520A4945.1030907@gmail.com>
	<CAF6-1L5mcB=Qs3=XpmFC_S2cPWHFaKChYP77ZhLh0+uvWhR3eQ@mail.gmail.com>
	<520B4339.6090209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63986 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932404Ab3HNPDk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 11:03:40 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so923994pad.28
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 08:03:39 -0700 (PDT)
In-Reply-To: <520B4339.6090209@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Frederik Thuysbaert <frederik.thuysbaert@gmail.com>
Cc: James Harper <james.harper@bendigoit.com.au>, =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

Hi Frederik,

>> A traceback would be great if you can get a core file. And possibly
>> compile tapdisk with debug symbols.
>
> I'm not quite sure what u mean, can u give some more information on how I do
> this? I compiled tapdisk with ./configure CFLAGS=-g, but I'm not sure this
> is what u meant.

Yes, ./configure CFLAGS=-g LDFLAGS=-g  is a good start.

Then when it crashes, if will leave a 'core' time somewhere. (not sure
where, maybe in / or in /tmp)
If it doesn't you may have to enable it. When the process is running,
use this on the tapdisk PID :

http://superuser.com/questions/404239/setting-ulimit-on-a-running-process

Then once you have a core file, you can use gdb along with the tapdisk
executable to generate a meaningful backtrace of where the crash
happenned :

See for ex http://publib.boulder.ibm.com/httpserv/ihsdiag/get_backtrace.html
for how to do it.


> When halting the domU after the errors, I get the following in dom0 syslog:

It's not really unexpected. If tapdisk crashes the IO ring is going to
be left hanging and god knows what weird behaviour will happen ...


Cheers,

    Sylvain
