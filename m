From: =?UTF-8?B?5p2O5rKb5Lym?= <lpl6338236@gmail.com>
Subject: A log bug in OSD.cc
Date: Sat, 5 Jul 2014 14:41:12 +0800
Message-ID: <CAPS90kg8BrzB_mt1AUjdTAx1nioaBkW-fe7SVVWA_Lxa_E9O6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:45234 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaGEGlN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jul 2014 02:41:13 -0400
Received: by mail-ie0-f181.google.com with SMTP id y20so2088460ier.40
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jul 2014 23:41:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It seems that the 2 log sentences
OSD.cc:1220 dout(10) << "init creating/touching snapmapper object" << d=
endl;
OSD.cc:1230  dout(10) << "init creating/touching infos object" << dendl=
;
need to be exchanged to agree with the operations following them(info
and snapmapper ).
--=20
Li Peilun (=E6=9D=8E=E6=B2=9B=E4=BC=A6)
Yao Class J10
Institute for Interdisciplinary Information Sciences
Tsinghua University
Beijing,100084
P.R.China
Tel:86-18810671857
E-mail: lpl6338236@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
