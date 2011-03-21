From: Steena Monteiro <steena.m@aggiemail.usu.edu>
Subject: Re: Building the Ceph client on Lucid Lynx
Date: Mon, 21 Mar 2011 12:36:07 -0600
Message-ID: <2AB74ECC-67E7-4396-B781-C339AAE5D4CF@aggiemail.usu.edu>
References: <loom.20110318T232227-447@post.gmane.org> <20110318224516.GA5086@dreamer> <AFA905E8B6AC4E459A4E2913D853BE3B@gmail.com> <5981E16F90B045E8BEA32AF41BEA2E80@gmail.com> <Pine.LNX.4.64.1103181641090.16804@cobra.newdream.net> <AANLkTi=NS-w0sMV9nSg2UR_urce_kfsXfYbqRhQJYuV1@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52711 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab1CUSgS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 14:36:18 -0400
Received: by ywj3 with SMTP id 3so2554488ywj.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 11:36:17 -0700 (PDT)
In-Reply-To: <AANLkTi=NS-w0sMV9nSg2UR_urce_kfsXfYbqRhQJYuV1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Thanks!

I reverted the commits (master~10 and master~11). The filesystem's now mounted.

~Steena


On Mar 21, 2011, at 1:58 AM, Henry Chang wrote:

>> I think the problem is that particular change hasn't been backported yet.
>> The most recent backport fixes have been done by Henry.  I'm not sure if
>> they've done this one too?
> 
> No, we worked around it by reverting the following two commits (which
> leverage the new workqueue mechanism of latest kernel):
> 
> c59cb6f net/ceph: make ceph_msgr_wq non-reentrant
> 6b40e7f ceph: fsc->*_wq's aren't used in memory reclaim path
> 
> -- 
> Henry

Steena D. Monteiro
http://www.steenamonteiro.com





