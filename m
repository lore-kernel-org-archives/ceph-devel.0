From: Chuanyu Tsai <chuanyu@cs.nctu.edu.tw>
Subject: RBD using problem
Date: Tue, 11 Dec 2012 14:00:12 +0800
Message-ID: <20121211060012.GA16722@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:48622 "EHLO
	csmailer.cs.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab2LKGJ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 01:09:57 -0500
Received: from csmailer.cs.nctu.edu.tw (localhost [127.0.0.1])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id 93D18423
	for <ceph-devel@vger.kernel.org>; Tue, 11 Dec 2012 14:00:12 +0800 (CST)
Received: from linux3.cs.nctu.edu.tw (linux3.cs.nctu.edu.tw [140.113.235.153])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id 85181422
	for <ceph-devel@vger.kernel.org>; Tue, 11 Dec 2012 14:00:12 +0800 (CST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi cephers,

I know that we can setup cluster addr and public addr to let OSDs 
listen on different subnet for different purpose, however, I don't 
have so much public IPs to give all my OSDs an IP per OSD.

So my question is, if I follow the link:
http://www.spinics.net/lists/ceph-devel/msg10941.html
to set all my pools using the ssd-primary rule or 
something like that, than I bind public IP on every 
ceph-osd-ssd-server-* 
(it means all my primary osd have public IP, right?), 
can this method make me using RBD correctly?

Or do we have some method to let public network clients use RBD 
and no need to let all OSDs have public IP?

Regards,
Chuanyu.
