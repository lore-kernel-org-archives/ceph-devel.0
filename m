From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Mon, 5 Aug 2013 13:01:35 +0200
Message-ID: <CAF6-1L6OrfOQssCWFqQL7KXTvMy+SyCd1XNrfme80p_7EEHj=Q@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E7E7E4@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:64301 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab3HELBf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 07:01:35 -0400
Received: by mail-pd0-f169.google.com with SMTP id y11so3131384pdj.28
        for <ceph-devel@vger.kernel.org>; Mon, 05 Aug 2013 04:01:35 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B62E7E7E4@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

Hi,


> It's working great so far. I just pulled the source and built it then copied blktap in.

Good to hear :)

I've been using it more and more recently and it'll been good for me
too, even with live migrations.


> For some reason I already had a tapdisk in /usr/sbin, as well as the one in /usr/bin, which confused the issue for a while. I must have installed something manually but I don't remember what.

What distribution are you using ?


> Any chance this will be rolled into the main blktap sources?

I'd like to ... but I ave no idea how or even who to contact for that
... blktap is so fragmented ...

You have blktap2 which is in the man Xen tree. But that's not what's
used in debian (it's not installed / compiled)

You have the so called blktap2.5 which is what's on github and what I
have based my stuff on. It's also what's shipped with debian as
blktap-utils I think.
I also think Citrix have their own version based off blktap2.5 as well.

And soon there will be blktap3 in the official Xen tree.

I want to at least get it merged in blktap3 but since that code is not
ready (or even merged) yet, it's a bit early for that. That's also
probably Xen 4.4 or Xen 4.5 stuff and so won't hit debian for a while.


Cheers,

   Sylvain
