From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: building test cluster : missing /etc/ceph/client.admin.keyring, need help
Date: Wed, 30 May 2012 09:20:14 +0200 (CEST)
Message-ID: <bd085420-d72b-48db-9544-47458d83d173@mailpro>
References: <4FC5BCA2.90404@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:39999 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996Ab2E3HUg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 03:20:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 7746F18063BC8
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 09:20:19 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3OpNaDqhFurz for <ceph-devel@vger.kernel.org>;
	Wed, 30 May 2012 09:20:14 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 1F32F18028888
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 09:20:14 +0200 (CEST)
In-Reply-To: <4FC5BCA2.90404@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi, 
I'm building my rados test cluster, 


3 servers,with on each server : 1 mon - 5 osd

mon daemon and osd are started, but when i use ceph command, it's missing client.admin.keyring

root@cephtest1:/etc/ceph# ceph -w
2012-05-30 09:05:35.255619 7fd1e9cfa760 -1 auth: failed to open keyring from /etc/ceph/client.admin.keyring
2012-05-30 09:05:35.255631 7fd1e9cfa760 -1 monclient(hunting): failed to open keyring: (2) No such file or directory
2012-05-30 09:05:35.255693 7fd1e9cfa760 -1 ceph_tool_common_init failed.


root@cephtest1:/etc/ceph# ls /etc/ceph/
ceph.conf  osd.0.keyring  osd.1.keyring  osd.2.keyring  osd.3.keyring  osd.4.keyring

Do I need to generate a keyring ? how can I do it ? 






/etc/ceph.conf 


[global] 
; use cephx or none 
auth supported = cephx 
keyring = /etc/ceph/$name.keyring 


[mon] 
mon data = /srv/mon.$id 


[mds] 


[osd] 
osd data = /srv/osd.$id 
osd journal = /srv/osd.$id.journal 
osd journal size = 1000 
; uncomment the following line if you are mounting with ext4 
; filestore xattr use omap = true 


[mon.a] 
host = cephtest1 
mon addr = 10.3.94.27:6789 


[mon.b] 
host = cephtest2 
mon addr = 10.3.94.28:6789 


[mon.c] 
host = cephtest3 
mon addr = 10.3.94.29:6789 


[osd.0] 
host = cephtest1 
addr = 10.3.94.27 


[osd.1] 
host = cephtest1 
addr = 10.3.94.27 


[osd.2] 
host = cephtest1 
addr = 10.3.94.27 


[osd.3] 
host = cephtest1 
addr = 10.3.94.27 


[osd.4] 
host = cephtest1 
addr = 10.3.94.27 


[osd.5] 
host = cephtest2 
addr = 10.3.94.28 


[osd.6] 
host = cephtest2 
addr = 10.3.94.28 


[osd.7] 
host = cephtest2 
addr = 10.3.94.28 


[osd.8] 
host = cephtest2 
addr = 10.3.94.28 


[osd.9] 
host = cephtest2 
addr = 10.3.94.28 


[osd.10] 
host = cephtest3 
addr = 10.3.94.29 

[osd.11] 
host = cephtest3 
addr = 10.3.94.29 


[osd.12] 
host = cephtest3 
addr = 10.3.94.29 


[osd.13] 
host = cephtest3 
addr = 10.3.94.29 


[osd.14] 
host = cephtest3 
addr = 10.3.94.29 

