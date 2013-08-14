From: Frederik Thuysbaert <frederik.thuysbaert@gmail.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Wed, 14 Aug 2013 10:43:37 +0200
Message-ID: <520B4339.6090209@gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com> <20130419064524.GQ11427@reaktio.net> <6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au> <CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au> <CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B62F433FE@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B62F43442@BITCOM1.int.sbss.com.au> <CAF6-1L502OZGbPHp37vWzEU3H-wsK5z904ZtS7SEUmuM-GhLyA@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B63891798@BITCOM1.int.sbss.com.au> <CAF6-1L4=rY7AJpHGB33KPMk6LfX7q8CHphPzh9amdqwbYzg3dQ@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B6389552A@BITCOM1.int.sbss.com.au> <CAF
 6-1L6jJvYuHN+BoucU2RNzv2R9dpMhbD1UVF96mBPO25FM5g@mail.gmail.com> <520A4945.1030907@gmail.com> <CAF6-1L5mcB=Qs3=XpmFC_S2cPWHFaKChYP77ZhLh0+uvWhR3eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50826 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759410Ab3HNInl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 04:43:41 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so3441255wgh.3
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 01:43:40 -0700 (PDT)
In-Reply-To: <CAF6-1L5mcB=Qs3=XpmFC_S2cPWHFaKChYP77ZhLh0+uvWhR3eQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: James Harper <james.harper@bendigoit.com.au>, =?ISO-8859-1?Q?Pasi_K?= =?ISO-8859-1?Q?=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 13-08-13 17:39, Sylvain Munaut wrote:
> Hi,
>
>> I have been testing this a while now, and just finished testing your
>> untested patch. The rbd caching problem still persists.
> Yes, I wouldn't expect to change anything for caching. But I still
> don't understand why caching would change anything at all ... all of
> it should be handled within the librbd lib.
>
>
> Note that I would recommend against caching anyway. The blktap layer
> doesn't pass through the FLUSH commands and so this make it completely
> unsafe because the VM will think things are commited to disk durably
> even though they are not ...
>
>
>
>> I will give the error messages of both dom0 and domU before and after I
>> applied the patch.
> It's actually strange that it changes anything at all.
>
> Can you try adding a ERROR("HERE\n");  in that error path processing
> and check syslog to see if it's triggered at all ?
I did this, and can confirm that it is not triggered.
>
> A traceback would be great if you can get a core file. And possibly
> compile tapdisk with debug symbols.
I'm not quite sure what u mean, can u give some more information on how 
I do this? I compiled tapdisk with ./configure CFLAGS=-g, but I'm not 
sure this is what u meant.
>
> Cheers,
>
>      Sylvain
Regards

- Frederik
