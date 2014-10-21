From: Nicheal <zay11022@gmail.com>
Subject: Re: [ceph-users] why the erasure code pool not support random write?
Date: Tue, 21 Oct 2014 15:46:57 +0800
Message-ID: <CALZt5jxTaW99uDivEVxBk=-s1hq3K01_rEEmmY2bZbEwN7mFHg@mail.gmail.com>
References: <CANE=7sU+NoAsOTOUxfQkDMsk8MWZUUMGKUYKWmXSSUAyYJtHeA@mail.gmail.com>
	<54451EA0.10104@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:39145 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbaJUHq5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Oct 2014 03:46:57 -0400
Received: by mail-oi0-f53.google.com with SMTP id v63so490165oia.40
        for <ceph-devel@vger.kernel.org>; Tue, 21 Oct 2014 00:46:57 -0700 (PDT)
In-Reply-To: <54451EA0.10104@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Gregory Farnum <greg@inktank.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

2014-10-20 22:39 GMT+08:00 Wido den Hollander <wido@42on.com>:
> On 10/20/2014 03:25 PM, =E6=B1=A0=E4=BF=A1=E6=B3=BD wrote:
>> hi, cephers:
>>
>>       When I look into the ceph source code, I found the erasure cod=
e pool
>> not support
>> the random write, it only support the append write. Why? Is that ran=
dom
>> write of is erasure code high cost and the performance of the deep s=
crub is
>> very poor?
>>
>
> To modify a EC object you need to read all chunks in order to compute
> the parity again.
>
> So that would involve a lot of reads for what might be just a very sm=
all
> write.
>
> That's also why EC can't be used for RBD images.
>
But for RBD cases, the smallest write will be 4k and the largest will
be 512k, which is determined by the block device driver. Currently, if
we use cache-tiering, one 4k random write may promote the whole 4M
object into the hot pool even though just serveral 4Ks in this object
is hot. So this is unreasonable. Furthermore, for the hot pool, it can
be a common replicated pool, and even, we can use kv-store for hot
pool. In kv-store, the content will be stripped to 1k =3D 1024 byte as
default. So is that possible to make use of this feature to realize
the model, if miss 4k, we just promote 4k data to the hot pool  and
saving it into kv-store?  Expecting haomai Wang's input

Nicheal,
Regards

>>  Thanks.
>>
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
>
> --
> Wido den Hollander
> Ceph consultant and trainer
> 42on B.V.
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
