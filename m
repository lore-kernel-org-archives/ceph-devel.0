From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: Some osd cannot boot after a host down
Date: Thu, 13 Dec 2012 19:51:17 +0800
Message-ID: <CAJiejCRwknhquNGAbV8u92Qb0fSe3viKERQv9dr5+kz94tOJ9g@mail.gmail.com>
References: <CAJiejCR1S1NLfYW0G=e5AYwnW+vp-dRD1QkGALknDe7OWK=wYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44008 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab2LMLvi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 06:51:38 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1507152pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 03:51:37 -0800 (PST)
In-Reply-To: <CAJiejCR1S1NLfYW0G=e5AYwnW+vp-dRD1QkGALknDe7OWK=wYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux <ceph-devel@vger.kernel.org>

It looks related to bug: http://tracker.newdream.net/issues/2843 .
Is there any workaround? I'm not sure that recreate the osd node works =
:-(

2012/12/12 Drunkard Zhang <gongfan193@gmail.com>:
> Some osd node can not boot on a host of my cluster, the reason from
> osd.log maybe different, looks like journal broken.
>
> logs attached, I can attach gziped core dump if needed.
>
> BTW, is ceph has a fsck.* like tool to check the filesystem
> consistency by hand ?



--
=E5=BC=A0=E7=BB=8D=E6=96=87
gongfan193@gmail.com
zhangsw@gwbnsh.net.cn
18601633785
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
