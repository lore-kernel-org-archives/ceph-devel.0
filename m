From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Fri, 9 Aug 2013 11:21:52 +0200
Message-ID: <CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:58033 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965452Ab3HIJVx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 05:21:53 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so332127pdj.2
        for <ceph-devel@vger.kernel.org>; Fri, 09 Aug 2013 02:21:53 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

Hi,

> I've had a few occasions where tapdisk has segfaulted:
>
> tapdisk[9180]: segfault at 7f7e3a5c8c10 ip 00007f7e387532d4 sp 00007f7e3a5c8c10 error 4 in libpthread-2.13.so[7f7e38748000+17000]
> tapdisk:9180 blocked for more than 120 seconds.
> tapdisk         D ffff88043fc13540     0  9180      1 0x00000000
>
> and then like:
>
> end_request: I/O error, dev tdc, sector 472008
>
> I can't be sure but I suspect that when this happened either one OSD was offline, or the cluster lost quorum briefly.

Interesting. There might be an issue if a request ends in error, I'll
have to check that.
I'll have a look on monday.

Cheers,

    Sylvain
