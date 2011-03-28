From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: The stability of OSD
Date: Mon, 28 Mar 2011 17:11:56 +0800
Message-ID: <AANLkTi=q+YmoMeMkjCh0Zgdqm+LEmL-sf8HfxkV5i4ck@mail.gmail.com>
References: <AANLkTinCNSuWXPQVaSOD82eXaRCtT5FKA=-0JFFTc51p@mail.gmail.com>
	<Pine.LNX.4.64.1103272132240.6107@cobra.newdream.net>
	<AANLkTinNko9h-qkQ8PgpSrJ1aXn=OhUyrZR5tDAQZukK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55060 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab1C1JL6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 05:11:58 -0400
Received: by fxm17 with SMTP id 17so2462652fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 02:11:56 -0700 (PDT)
In-Reply-To: <AANLkTinNko9h-qkQ8PgpSrJ1aXn=OhUyrZR5tDAQZukK@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

2011/3/28 Sylar Shen <kimulaaa@gmail.com>:
> Hi Sage,
> Thanks for your information and let me know at least my hardwares are OK...:)
> I will upgrade my ceph version to the latest one and see what I can find.
>
> By the way, could you tell me how to set "osd heartbeat grace" ?
> Because I can't find how to do it in the ceph wiki.

It is a configuration option (default to 20). You can change it by
adding a line to the osd section of your ceph configuration file:

[osd]
osd heartbeat grace = 30

----
Henry
