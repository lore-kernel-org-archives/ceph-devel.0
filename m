From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: question about ceph messaging protocol
Date: Fri, 6 May 2011 11:45:04 +0800
Message-ID: <BANLkTin+KZmHGhBxQRQLDvBag2K3LDD_cA@mail.gmail.com>
References: <BANLkTi=L=6s2FCYgXdSnS4b7UTkFrdLWZg@mail.gmail.com>
	<Pine.LNX.4.64.1105051219440.26811@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64711 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab1EFDpG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 23:45:06 -0400
Received: by fxm17 with SMTP id 17so1955506fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2011 20:45:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105051219440.26811@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

> It may be we didn't anticipate a situation where your acceptor has th=
e
> connection but it is idle/closed and doesn't notice. =C2=A0Maybe send=
ing a
> keepalive in this situation is what is needed?
>
> How are you hitting this situation?

Sorry I should have made it clear. I did not hit this. I was just
reading the messenger source code (and the wiki page) and wondering in
what circumstance the initiator would get the RETRY tag.

The comment in the acceptor says it could be "// old attempt, or we
accepted and they didn't get the READY message". I don't know if it
would happen at all. However, once it happened, I suspect whether the
initiator should take the peer's connect_seq and INCREMENT one.
Otherwise, when the initiator reconnects, the acceptor would think
it's the case of connection race instead of reconnecting and leads to
unexpected result.

--=20
Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
