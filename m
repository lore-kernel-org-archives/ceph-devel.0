From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Mon, 12 Aug 2013 16:13:55 +0200
Message-ID: <CAF6-1L502OZGbPHp37vWzEU3H-wsK5z904ZtS7SEUmuM-GhLyA@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au>
	<CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62F433FE@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B62F43442@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:62982 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756611Ab3HLON4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Aug 2013 10:13:56 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so3479711pdj.22
        for <ceph-devel@vger.kernel.org>; Mon, 12 Aug 2013 07:13:56 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B62F43442@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

Hi,

>> > > tapdisk[9180]: segfault at 7f7e3a5c8c10 ip 00007f7e387532d4 sp
>> > 00007f7e3a5c8c10 error 4 in libpthread-2.13.so[7f7e38748000+17000]
>> > > tapdisk:9180 blocked for more than 120 seconds.
>> > > tapdisk         D ffff88043fc13540     0  9180      1 0x00000000

You can try generating a core file by changing the ulimit on the running process

http://superuser.com/questions/404239/setting-ulimit-on-a-running-process

A backtrace would be useful :)


> Actually maybe not. What I was reading only applies for large number of bytes written to the pipe, and even then I got confused by the double negatives. Sorry for the noise.

Yes, as you discovered but size < PIPE_BUF, they should be atomic even
in non-blocking mode. But I could still add assert() there to make
sure it is.


I did find a bug where it could "leak" requests which may lead to
hang. But it shouldn't crash ...

Here's an (untested yet) patch in the rbd error path:


diff --git a/drivers/block-rbd.c b/drivers/block-rbd.c
index 68fbed7..ab2d2c5 100644
--- a/drivers/block-rbd.c
+++ b/drivers/block-rbd.c
@@ -560,6 +560,9 @@ err:
        if (c)
                rbd_aio_release(c);

+       list_move(&req->queue, &prv->reqs_free);
+       prv->reqs_free_count++;
+
        return rv;
 }


Cheers,

     Sylvain
