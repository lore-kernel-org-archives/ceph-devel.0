From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: [PATCH] crushtool: fix args parsing
Date: Fri, 23 Sep 2011 13:07:07 +0800
Message-ID: <CANExM-N58pk1EtjD26ANBwUfbE3YfCa0yF-d9j2vO0ExXFZLfw@mail.gmail.com>
References: <1316709560-6521-1-git-send-email-henry.cy.chang@gmail.com>
	<Pine.LNX.4.64.1109220943590.17520@cobra.newdream.net>
	<CANExM-OrCz8S5R6XAkwERoNDcqBVPc6VU_OhyJ1hqjq8_eFhdg@mail.gmail.com>
	<Pine.LNX.4.64.1109222139590.8663@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33715 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab1IWFHI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 01:07:08 -0400
Received: by iaqq3 with SMTP id q3so3523883iaq.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2011 22:07:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1109222139590.8663@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

> Yep, those were both broken. =C2=A0Fixed it in the stable branch, and=
 added a
> simple unit test to make sure it stays that way. =C2=A0Please let me =
know it if
> gives you any further problems.
>

I can't see your commit on github. Have you pushed it on?

Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
