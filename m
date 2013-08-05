From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Mon, 5 Aug 2013 15:55:30 +0200
Message-ID: <CAF6-1L6BJh3OMsCXocuTd_VV0orD2sUgP7KqD1hZhRyMeRO17A@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E7E7E4@BITCOM1.int.sbss.com.au>
	<CAF6-1L6OrfOQssCWFqQL7KXTvMy+SyCd1XNrfme80p_7EEHj=Q@mail.gmail.com>
	<20130805111213.GM2924@reaktio.net>
	<CAF6-1L4vZeu69GVVoi4yg6irRVSPFZ-oeX=rQaMkmqy-09=Emg@mail.gmail.com>
	<CAFLBxZYT8aOJdKv9qY5HPrk3W6+BFvxpT6Ra6RYuB=rYxJ6uMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51556 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab3HENzb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 09:55:31 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so3297897pab.20
        for <ceph-devel@vger.kernel.org>; Mon, 05 Aug 2013 06:55:30 -0700 (PDT)
In-Reply-To: <CAFLBxZYT8aOJdKv9qY5HPrk3W6+BFvxpT6Ra6RYuB=rYxJ6uMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: George Dunlap <George.Dunlap@eu.citrix.com>
Cc: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, James Harper <james.harper@bendigoit.com.au>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

Hi George,


> Yes; qemu knows how to be a Xen PV block back-end.

Very interesting. Is there documentation about this somewhere ?
I had a look some time ago and it was really not very clear.

Things like what Xen version support this. And with which features (
indirect descriptors, persistent grants, discard, flush, ...) and/or
which limitation.


> One of the reasons for stopping work on blktap3 (AIUI) was that it
> should in theory have performance characteristics similar to blktap3,

And did anyone check the theory currently ? :)


> and tends to get newer protocols like ceph "for free" (i.e.,
> implemented by someone else).

Yes I can definitely see the appeal.


Cheers,

    Sylvain
