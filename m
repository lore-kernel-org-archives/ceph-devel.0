From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Wed, 14 Aug 2013 01:43:31 +0200
Message-ID: <CAF6-1L6_GFvOq3nyQ-n20uiZHC4pAQm88_G3RFG2QjujoYGLpA@mail.gmail.com>
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
	<6035A0D088A63A46850C3988ED045A4B63896A4D@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56864 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab3HMXnc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 19:43:32 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so7546826pbb.34
        for <ceph-devel@vger.kernel.org>; Tue, 13 Aug 2013 16:43:31 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B63896A4D@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: Frederik Thuysbaert <frederik.thuysbaert@gmail.com>, =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Wed, Aug 14, 2013 at 1:39 AM, James Harper
<james.harper@bendigoit.com.au> wrote:
> I think I have a separate problem too - tapdisk will segfault almost immediately upon starting but seemingly only for Linux PV DomU's. Once it has started doing this I have to wait a few hours to a day before it starts working again. My Windows DomU's appear to be able to start normally though.

What about other blktap driver ? like using blktap raw driver, does
that work without issue ?

Cheers,

    Sylvain
