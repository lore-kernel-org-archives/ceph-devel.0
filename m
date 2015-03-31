From: Wido den Hollander <wido@42on.com>
Subject: RADOS backend for Dovecot mail storage
Date: Tue, 31 Mar 2015 13:14:10 +0200
Message-ID: <551A8182.9020406@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:60919 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212AbbCaLON (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Mar 2015 07:14:13 -0400
Received: from [10.15.72.62] (unknown [62.140.132.30])
	by websrv.42on.com (Postfix) with ESMTPSA id BBB8FBFADA
	for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2015 13:14:10 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Recently Dovecot merged with OpenXchange as announced here:
http://www.dovecot.fi/open-xchange-and-dovecot-announce-merger-to-create-worlds-leading-open-source-messaging-software-provider/

In the past few years I've contacted Dovecot a couple of times because
it would be very, very cool to have your e-mail stored via native RADOS.

They thought it was a very cool idea, but since they had closed source
Object Store plugins for Dovecot like Scality they couldn't allow RADOS
to be implemented for Object Mail storage.

My idea is basically: Dovecot -> libmailrados -> librados -> Ceph

Now that OpenXchange acquired Dovecot it might be that this possibility
opens up!

Just wanted to get this out there. I currently won't be able to look
into this, but it would be very cool if this happens.

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
