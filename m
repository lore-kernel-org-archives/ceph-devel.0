From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: question about ceph messaging protocol
Date: Wed, 4 May 2011 17:10:55 +0800
Message-ID: <BANLkTi=L=6s2FCYgXdSnS4b7UTkFrdLWZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36093 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1EDJK4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 05:10:56 -0400
Received: by fxm17 with SMTP id 17so662917fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 May 2011 02:10:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I have a question about ceph's messaging protocol:

According to the documentation
(http://ceph.newdream.net/wiki/Messaging_protocol), the acceptor
replies with the RETRY tag when it thinks this connecting attempt is
an old one or the initiator did not get the READY message. So, the
acceptor sends its own connect_seq to the initiator and waits for it
to retry.

However, when the initiator re-connects with the acceptor's
connect_seq (WITHOUT +1), the acceptor will think this is a connection
race because (peer_connect_seq == existing.connect_seq). Is this the
desired behavior or just I misunderstood the protocol?

Thanks,
-- 
Henry
