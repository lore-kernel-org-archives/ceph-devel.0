From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: RBD operations, pinging client that serves lingering tid
Date: Wed, 30 May 2012 15:54:32 +0200
Message-ID: <1909768.2JBkbXqQse@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:37381 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab2E3OFl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 May 2012 10:05:41 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id EA6AB10C877
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 15:54:35 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Whenever I'm doing any operations on rbd volumes (like import, copy) using the 
rbd command line client, I'm getting these messages every couple of seconds:

2012-05-30 15:53:08.010326 7f027aa47700  0 client.4159.objecter  pinging osd 
that serves lingering tid 1 (osd.2)
2012-05-30 15:53:08.010344 7f027aa47700  0 client.4159.objecter  pinging osd 
that serves lingering tid 2 (osd.0)

What does this mean? Is that anything to worry about?

Yesterday, these messages were only mentioning osd.2, not osd.0...

	Guido
