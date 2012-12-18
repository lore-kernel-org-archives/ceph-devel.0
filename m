From: Chris Dunlop <chris@onthe.net.au>
Subject: kernel rbd format=2
Date: Tue, 18 Dec 2012 11:10:54 +1100
Message-ID: <20121218001054.GA17186@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:41352 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab2LRASW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 19:18:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id D5A9C60E3C
	for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 11:10:56 +1100 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJOX1VbYGQ4Z for <ceph-devel@vger.kernel.org>;
	Tue, 18 Dec 2012 11:10:55 +1100 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id EC09460F4E
	for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 11:10:54 +1100 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id 4F3EA2AB682
	for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 11:11:04 +1100 (EST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Format 2 images (and attendant layering support) are not yet
supported by the kernel rbd client, according to:

http://ceph.com/docs/master/rbd/rbd-snapshot/#layering

When might this support be available?

Cheers,

Chris
