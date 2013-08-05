From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Mon, 5 Aug 2013 09:45:28 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B62E7E7E4@BITCOM1.int.sbss.com.au>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
 <CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:56007 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab3HEJpw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 05:45:52 -0400
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

It's working great so far. I just pulled the source and built it then copied blktap in.

For some reason I already had a tapdisk in /usr/sbin, as well as the one in /usr/bin, which confused the issue for a while. I must have installed something manually but I don't remember what.

Xen also includes tap-ctl:

blktap-utils: /usr/sbin/tap-ctl
xen-utils-4.1: /usr/lib/xen-4.1/bin/tap-ctl

and I removed the one from xen and linked it to the one in /usr/sbin. I did that before I found the other tapdisk in /usr/sbin so I'm not sure if that step was necessary.

Any chance this will be rolled into the main blktap sources?

> If you have any issue, I can be found on ceph's IRC under 'tnt' nick.
> 

Even though I have been on the internet since 94, I never got the hang of IRC... always found the stream of information a little overwhelming.

Thanks

James

