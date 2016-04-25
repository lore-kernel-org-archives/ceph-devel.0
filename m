From: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Subject: Re: BlueStore SMR Support
Date: Mon, 25 Apr 2016 00:19:30 -0400
Message-ID: <CAPLK-i8Wd4a8+3-g87mK912L=Dgx1xtvrOcJ7GW=ChYvnEKt3g@mail.gmail.com>
References: <18953d92.593c.1544b6abe34.Coremail.ustcxjy@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36761 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcDYETb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Apr 2016 00:19:31 -0400
Received: by mail-yw0-f173.google.com with SMTP id o66so186956386ywc.3
        for <ceph-devel@vger.kernel.org>; Sun, 24 Apr 2016 21:19:30 -0700 (PDT)
In-Reply-To: <18953d92.593c.1544b6abe34.Coremail.ustcxjy@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Jab5p2w55Gc?= <ustcxjy@163.com>
Cc: sage@redhat.com, ceph-devel@vger.kernel.org

Hi Zhijian,

A GSoC proposal for Bluestore SMR support has been approved. The
initial proposal can be viewed here:

http://tracker.ceph.com/projects/ceph/wiki/BlueStore_SMR_Support

>Can I run some benchmarks on BlueStore only(without building up a clus=
ter),in other words, only to test BlueStore's interfaces from ObjectSto=
re(queue_transactions and other read functions)?

I will get back to you with details on this soon.

Thanks,

On Sun, Apr 24, 2016 at 11:16 PM, =E8=96=9B=E6=9D=B0=E7=91=9C <ustcxjy@=
163.com> wrote:
> Hi all,
>         :)
>         I'm a student of Institute of Computing Technology Chinese Ac=
ademy of Science.
>         I am interested in working on the SMR for Bluestore file syst=
em.I am currently going through source code of BlueStore. Our lab has d=
one some optimizations on SMR.
>         I have some questions about BlueStore:
>                  Are you planning to do some works about SMR on BlueS=
tore?
>                  Can I run some benchmarks on BlueStore only(without =
building up a cluster),in other words, only to test BlueStore's interfa=
ces from ObjectStore(queue_transactions and other read functions)?
>
>
>
>
> Regards,
> ----------
> zhijian



--=20
Shehbaz Jaffer
=46irst Year Graduate Student
Sir Edward S Rogers Sr Department of Electrical and Computer Engineerin=
g
University of Toronto
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
