From: Marcel Lauhoff <ml@irq0.org>
Subject: Re: Article about the OSD Journal
Date: Thu, 26 Mar 2015 10:53:44 +0100
Message-ID: <87k2y484pj.fsf@irq0.org>
References: <87mw3283ri.fsf@irq0.org> <659248388.5725609.1427268133773.JavaMail.zimbra@oxygem.tv> <88565551.5725616.1427268146452.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cpu0.net ([37.187.2.217]:43947 "EHLO cpu0.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbbCZJxI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Mar 2015 05:53:08 -0400
Received: from janelane.irq0.org (x5d8266b1.dyn.telefonica.de [93.130.102.177])
	by ks3366964.kimsufi.com (Postfix) with ESMTPSA id A6DDB8031A
	for <ceph-devel@vger.kernel.org>; Thu, 26 Mar 2015 09:53:06 +0000 (UTC)
In-reply-to: <88565551.5725616.1427268146452.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Hi,

Alexandre DERUMIER <aderumier@odiso.com> writes:

> Hi,
>
> I didn't known about "nojournal" feature.
> Does it make sense for full ssd setup ? or is it only a test/debug option ?

To the best of my knowledge, no, "nojournal" isn't an alternative.

In nojournal mode transaction commit acknowledgements are fired after a
sync of the data disk. Meaning every 0.01 - 5 seconds in bulk.

~marcedl

--
Marcel Lauhoff
Mail/XMPP: ml@irq0.org
http://irq0.org
