From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: librbd: error finding header
Date: Mon, 09 Jul 2012 15:12:13 +0930
Message-ID: <4FFA6F35.4040102@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:34244 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab2GIFmu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 01:42:50 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q695gDYw001336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 9 Jul 2012 15:12:15 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I just hit this error:

error opening image sip.logics.net.au: (2) No such file or directory
2012-07-09 15:03:59.935835 7ffbe0673780 -1 librbd: error finding header: 
(2) No such file or directory

Googled around and found that Oliver Francke had similar issue back in 
March. Read your responses but still unclear where to start to dig. Just 
upgraded from 0.47.3 to 0.48, done rolling upgrade and all RBD images 
are OK with exception of this one. Notably as upgrade was done while VM 
was up it continued to run unaffected (ie all data inside of VM was 
written and read as nothing happened). It makes me think that there no 
data loss but mere broken header.

Of course I have a backup of VM and can pull it back in no time but I am 
really interested (and I am sure other ceph users) how to recover from 
such failures?

Regards,
Vladimir
