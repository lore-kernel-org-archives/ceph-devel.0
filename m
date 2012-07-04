From: Mitsue Acosta Murakami <mitsue@webcenter.com.br>
Subject: Ceph for email storage
Date: Wed, 04 Jul 2012 15:29:48 -0300
Message-ID: <4FF48B9C.3010803@webcenter.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smarthost-smtp.wcenter.net.br ([23.23.183.176]:41311 "EHLO
	smtp.wcenter.net.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755651Ab2GDShk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 14:37:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

We are examining Ceph to use as email storage. In our current system, 
several clients servers with different services (imap, smtp, etc) access 
a NFS storage server. The mailboxes are stored in Maildir format, with 
many small files. We use Amazon AWS EC2 for clients and storage server. 
In this scenario, we have some questions about Ceph:

1. Is Ceph recommended for heavy write/read of small files?

2. Is there any problem in installing Ceph on Amazon instances?

3. Does Ceph already support quota?

4. What File System would you encourage us to use?


Thanks in advance,

-- 
Mitsue Acosta Murakami


