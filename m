From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Fri, 9 Aug 2013 00:12:41 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
 <CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:45472 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966748Ab3HIAMw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 20:12:52 -0400
In-Reply-To: <CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: =?iso-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

> 
> Yes the procedure didn't change.
> 
> If you're on debian I could also sent your prebuilt .deb for blktap
> and for a patched xen version that includes userspace RBD support.
> 
> If you have any issue, I can be found on ceph's IRC under 'tnt' nick.
> 

I've had a few occasions where tapdisk has segfaulted:

tapdisk[9180]: segfault at 7f7e3a5c8c10 ip 00007f7e387532d4 sp 00007f7e3a5c8c10 error 4 in libpthread-2.13.so[7f7e38748000+17000]
tapdisk:9180 blocked for more than 120 seconds.
tapdisk         D ffff88043fc13540     0  9180      1 0x00000000

and then like:

end_request: I/O error, dev tdc, sector 472008

I can't be sure but I suspect that when this happened either one OSD was offline, or the cluster lost quorum briefly.

James


