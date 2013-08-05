From: George Dunlap <George.Dunlap@eu.citrix.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Mon, 5 Aug 2013 14:35:36 +0100
Message-ID: <CAFLBxZYT8aOJdKv9qY5HPrk3W6+BFvxpT6Ra6RYuB=rYxJ6uMQ@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E7E7E4@BITCOM1.int.sbss.com.au>
	<CAF6-1L6OrfOQssCWFqQL7KXTvMy+SyCd1XNrfme80p_7EEHj=Q@mail.gmail.com>
	<20130805111213.GM2924@reaktio.net>
	<CAF6-1L4vZeu69GVVoi4yg6irRVSPFZ-oeX=rQaMkmqy-09=Emg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33260 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab3HENfh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 09:35:37 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so1468727wib.4
        for <ceph-devel@vger.kernel.org>; Mon, 05 Aug 2013 06:35:36 -0700 (PDT)
In-Reply-To: <CAF6-1L4vZeu69GVVoi4yg6irRVSPFZ-oeX=rQaMkmqy-09=Emg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, James Harper <james.harper@bendigoit.com.au>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Mon, Aug 5, 2013 at 1:03 PM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
>> I think I saw an announcement recently on xen-devel that blktap3 development has been stopped..
>
> Oh :(
>
> In the mail it speaks about QEMU but is it possible to use the QEMU
> driver model when booting PV domains ? (and not PVHVM).

Yes; qemu knows how to be a Xen PV block back-end.

One of the reasons for stopping work on blktap3 (AIUI) was that it
should in theory have performance characteristics similar to blktap3,
and tends to get newer protocols like ceph "for free" (i.e.,
implemented by someone else).

 -George
