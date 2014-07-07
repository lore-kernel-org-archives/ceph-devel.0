From: Gregory Farnum <greg@inktank.com>
Subject: Re: A log bug in OSD.cc
Date: Mon, 7 Jul 2014 12:46:38 -0700
Message-ID: <CAPYLRzhm2mkFPUdGLp=vVbYvKJgnZ=huyoWxebugi7uxobh13g@mail.gmail.com>
References: <CAPS90kg8BrzB_mt1AUjdTAx1nioaBkW-fe7SVVWA_Lxa_E9O6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:43513 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaGGTqi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 15:46:38 -0400
Received: by mail-qg0-f50.google.com with SMTP id j5so4133268qga.23
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 12:46:38 -0700 (PDT)
In-Reply-To: <CAPS90kg8BrzB_mt1AUjdTAx1nioaBkW-fe7SVVWA_Lxa_E9O6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5p2O5rKb5Lym?= <lpl6338236@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks! I've fixed this up in master.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Fri, Jul 4, 2014 at 11:41 PM, =E6=9D=8E=E6=B2=9B=E4=BC=A6 <lpl633823=
6@gmail.com> wrote:
> It seems that the 2 log sentences
> OSD.cc:1220 dout(10) << "init creating/touching snapmapper object" <<=
 dendl;
> OSD.cc:1230  dout(10) << "init creating/touching infos object" << den=
dl;
> need to be exchanged to agree with the operations following them(info
> and snapmapper ).
> --
> Li Peilun (=E6=9D=8E=E6=B2=9B=E4=BC=A6)
> Yao Class J10
> Institute for Interdisciplinary Information Sciences
> Tsinghua University
> Beijing,100084
> P.R.China
> Tel:86-18810671857
> E-mail: lpl6338236@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
