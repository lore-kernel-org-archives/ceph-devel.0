From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: The cache problem of re-export NFS test
Date: Thu, 14 Apr 2011 23:19:58 +0800
Message-ID: <BANLkTimykUG5zx7o8pYaZnkyNz6X7FLujg@mail.gmail.com>
References: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
	<Pine.LNX.4.64.1104120834100.12198@cobra.newdream.net>
	<BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
	<BANLkTincrGv4gzxsT0P+5o=h8rLqZGBN+A@mail.gmail.com>
	<BANLkTik5aTanEEeH+QphZQLhfsqxuz+zAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54724 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1DNPT7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 11:19:59 -0400
Received: by fxm17 with SMTP id 17so1246635fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 08:19:58 -0700 (PDT)
In-Reply-To: <BANLkTik5aTanEEeH+QphZQLhfsqxuz+zAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: Brian Chrisman <brchrisman@gmail.com>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Have you tried the option no_wdelay with sync? Perhaps that's what you
want since it minimizes the cache effect.

2011/4/14 Sylar Shen <kimulaaa@gmail.com>:
> Yes, after testing I found that "sync" will still do the cache in mem=
ory.
> But what I want to know =C2=A0is the real speed to write data into th=
e disks.
> I know it may not be safe without using memory and the speed may go v=
ery slow.
> However, that's what I am trying to find out.
> Thanks~~^^
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
