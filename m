From: Sage Weil <sweil@redhat.com>
Subject: Re: msgr2 protocol
Date: Fri, 3 Jun 2016 09:24:59 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com> <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com> <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com>
 <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43614 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbcFCNYg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Jun 2016 09:24:36 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C2165CB
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jun 2016 13:24:35 +0000 (UTC)
In-Reply-To: <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mwatts@redhat.com
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I updated the PR with an additional commit that simplifies the 
confounder.  It seems like we only need the confoudner at teh beginning of 
the session, not for every message, since the signature and encryption 
state is chained from the previous frame.  Is that right?

	https://github.com/ceph/ceph/pull/9461/commits/45766fed1864733c5216a7b50f11cce256338170

Full PR:

	https://github.com/ceph/ceph/pull/9461

--

Also, I just realized that now might be a good time to address the ability 
to multiplex different endpoints (sessions) into the same connection.  We 
could add it later with the msgr feature bits, but it'll probably be 
simpler not to have to support two variants of the protocol.  On the other 
hand, it's a lot more complicated.  :(

Initial thoughts:

 - make a clearer distinction between connection (as in tcp) and a 
session (as in an exchange between two entities, one that may or may not 
have a lifecycle independent of the connection.
 - the auth exchange is no longer always at the beginning of the 
connection.  new entities might appear in the same endpoint.

sage
