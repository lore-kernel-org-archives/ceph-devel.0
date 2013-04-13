From: proguest <proguest1942@hotmail.com>
Subject: ceph radosgw cannot work
Date: Sat, 13 Apr 2013 15:20:54 +0000 (UTC)
Message-ID: <loom.20130413T170940-905@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60513 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab3DMPZH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 13 Apr 2013 11:25:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UR2K6-00016S-Ny
	for ceph-devel@vger.kernel.org; Sat, 13 Apr 2013 17:25:03 +0200
Received: from 114-44-224-186.dynamic.hinet.net ([114.44.224.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 13 Apr 2013 17:25:02 +0200
Received: from proguest1942 by 114-44-224-186.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 13 Apr 2013 17:25:02 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi, I'm working with ceph for a while.
I just follow by the ceph.com step by step,
but it still not work with restful.
There're a few problem with it.

here is my ceph.conf 
[client.radosgw.gateway]
        host = node71
        keyring = /etc/ceph/keyring.radosgw.gateway
        rgw socket path = /tmp/radosgw.sock
        log file = /var/log/ceph/radosgw.log
and all other conf are all the same with website

http://ceph.com/docs/master/radosgw/config/

by the way , what's the fqdn mean? I just set it the same with 
hostname(node71)

first I use the cmd
#radosgw
it reply 
radosgw: must specify 'rgw socket path' to run as a daemon
but the rgw socket path is already have and set

second I don't understand how to get in ceph radosgw with swift
i use the cmd 
swift -A http://node71 -U richard -K 
8ni1ubMgQ\/Jxgnh9z\/QurcZ9v2EUpGoSWEk9wIT9 post test

it just client to apache server 

then i tried to use

swift -A http://node76:6789/auth -U richard -K 
8ni1ubMgQ\/Jxgnh9z\/QurcZ9v2EUpGoSWEk9wIT9 post test

node76 is my mon node

and it can not reach by this cmd

how can I let my radosgw works?
i really need to fix this problem as soon as possible.

please help me to solve the problems.
thx



