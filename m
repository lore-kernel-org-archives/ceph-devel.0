From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Tue, 13 Aug 2013 17:39:52 +0200
Message-ID: <CAF6-1L5mcB=Qs3=XpmFC_S2cPWHFaKChYP77ZhLh0+uvWhR3eQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54203 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296Ab3HMPjx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 11:39:53 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so4460737pab.36
        for <ceph-devel@vger.kernel.org>; Tue, 13 Aug 2013 08:39:52 -0700 (PDT)
In-Reply-To: <520A4945.1030907@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Frederik Thuysbaert <frederik.thuysbaert@gmail.com>
Cc: James Harper <james.harper@bendigoit.com.au>, =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

Hi,

> I have been testing this a while now, and just finished testing your
> untested patch. The rbd caching problem still persists.

Yes, I wouldn't expect to change anything for caching. But I still
don't understand why caching would change anything at all ... all of
it should be handled within the librbd lib.


Note that I would recommend against caching anyway. The blktap layer
doesn't pass through the FLUSH commands and so this make it completely
unsafe because the VM will think things are commited to disk durably
even though they are not ...



> I will give the error messages of both dom0 and domU before and after I
> applied the patch.

It's actually strange that it changes anything at all.

Can you try adding a ERROR("HERE\n");  in that error path processing
and check syslog to see if it's triggered at all ?

A traceback would be great if you can get a core file. And possibly
compile tapdisk with debug symbols.


Cheers,

    Sylvain
