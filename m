From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: Building the Ceph client on Lucid Lynx
Date: Mon, 21 Mar 2011 15:58:36 +0800
Message-ID: <AANLkTi=NS-w0sMV9nSg2UR_urce_kfsXfYbqRhQJYuV1@mail.gmail.com>
References: <loom.20110318T232227-447@post.gmane.org>
	<20110318224516.GA5086@dreamer>
	<AFA905E8B6AC4E459A4E2913D853BE3B@gmail.com>
	<5981E16F90B045E8BEA32AF41BEA2E80@gmail.com>
	<Pine.LNX.4.64.1103181641090.16804@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1CUH6h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 03:58:37 -0400
Received: by fxm17 with SMTP id 17so5229228fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 00:58:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1103181641090.16804@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Steena Monteiro <steena.m@aggiemail.usu.edu>, ceph-devel@vger.kernel.org

> I think the problem is that particular change hasn't been backported =
yet.
> The most recent backport fixes have been done by Henry. =C2=A0I'm not=
 sure if
> they've done this one too?

No, we worked around it by reverting the following two commits (which
leverage the new workqueue mechanism of latest kernel):

c59cb6f net/ceph: make ceph_msgr_wq non-reentrant
6b40e7f ceph: fsc->*_wq's aren't used in memory reclaim path

--=20
Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
