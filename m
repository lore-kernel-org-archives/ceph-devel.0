From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: Detect memory leaks in ceph
Date: Wed, 28 Sep 2016 06:16:57 +0000
Message-ID: <MWHPR02MB263918AA0649AA223323EFD0E2CF0@MWHPR02MB2639.namprd02.prod.outlook.com>
References: <CAA8xDw295OV5LoR4wwGixofoNmrTfgOsjbpw1RzyKMGRmqk=ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0074.outbound.protection.outlook.com ([104.47.42.74]:64809
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750775AbcI1GuT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Sep 2016 02:50:19 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Valgrind(memcheck & massif) can help you in finding the leaks. If you
are using tcmalloc, you can use heap profiler
to see the current allocations and find out the culprit. You can refer
http://docs.ceph.com/docs/jewel/rados/troubleshooting/memory-profiling/

Varada


On Wednesday 28 September 2016 10:51 AM, Elita Lobo wrote:
> Hi,
>
> I am using ceph for a research project and was trying to implement a
> new jerasure plugin. The code works perfectly when I try to put small
> objects ( 16Mb files) in a single pg but breaks when I am trying to
> put some really large object in a cluster having multiple pgs. I am
> pretty sure its a memory leak but not sure how to detect it.
>
> Can someone please suggest some tools that would help me  detect
> memory leaks in ceph?
>
> Thanking you,
> Yours sincerely,
> Elita Lobo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
