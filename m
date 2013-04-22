From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: poor write performance
Date: Mon, 22 Apr 2013 10:34:48 +0200
Message-ID: <CAF6-1L5aindF_41=d6JKvut5cBzXx_1btGw-EteGmijoma616A@mail.gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
	<516FF893.1030309@inktank.com>
	<6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
	<517159C3.5030100@inktank.com>
	<6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
	<CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:35020 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab3DVIeu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 04:34:50 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1309530bkc.30
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 01:34:48 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,


> Correct, but that's the theoretical maximum I was referring to. If I calculate that I should be able to get 50MB/second then 30MB/second is acceptable but 500KB/second is not :)

I have written a small benchmark for RBD :

https://gist.github.com/smunaut/5433222

It uses the librbd API directly without kernel client and queue
requests long in advance and this should give an "upper" bound to what
you can get at best.
It reads and writes the whole image, so I usually just create a 1 or 2
G image for testing.

Using two OSDs on two distinct recent 7200rpm drives (with journal on
the same disk as data), I get :

Read: 89.52 Mb/s (2147483648 bytes in 22877 ms)
Write: 10.62 Mb/s (2147483648 bytes in 192874 ms)


The raw disk do about 45 Mo/s when written by 1M chunk. But when
written by 4k chunk, this falls to ~500 ko/s ...

# dd if=/dev/zero of=/dev/xen-disks/test bs=1M oflag=direct
2049+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 49.3943 s, 43.5 MB/s

# dd if=/dev/zero of=/dev/xen-disks/test bs=4k oflag=direct
^C61667+0 records in
61667+0 records out
252588032 bytes (253 MB) copied, 539.123 s, 469 kB/s


Cheers,

    Sylvain
