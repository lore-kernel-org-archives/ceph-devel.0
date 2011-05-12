From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: [PATCH] mds: issue caps on file update finish if no client cap specified
Date: Thu, 12 May 2011 09:30:38 +0800
Message-ID: <BANLkTi=9FbsQCKwgLT-o3arAXr9b0wzhJA@mail.gmail.com>
References: <1305110696-2688-1-git-send-email-henry.cy.chang@gmail.com>
	<Pine.LNX.4.64.1105111033310.17222@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50540 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab1ELBaj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 21:30:39 -0400
Received: by fxm17 with SMTP id 17so765355fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 18:30:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105111033310.17222@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

> This one I'm not sure about. =C2=A0Do you have an MDS log for this ca=
se? =C2=A0I
> would expect the cap issue to happen when we drop_locks(mut) and the =
lock
> state changes.
>

OK. I'll try to reproduce it with debug log on.

Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
