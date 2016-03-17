From: John Hunter <zhjwpku@gmail.com>
Subject: Wrong index of the documentation on the website.
Date: Thu, 17 Mar 2016 23:13:56 +0800
Message-ID: <CAEG8a3K9QenaLZZJQON=L-x+M+OTiADdmkB+sGtNJ+p1tebJrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34810 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031279AbcCQPN6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2016 11:13:58 -0400
Received: by mail-vk0-f47.google.com with SMTP id e185so105763053vkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2016 08:13:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I am not very sure this is a mistake, but

when we got this page:
[1]
http://docs.ceph.com/docs/master/install/install-ceph-gateway/
if we click the 'next' lable, I think we should get to the link:
http://docs.ceph.com/docs/master/install/install-vm-cloud/
but not:
http://docs.ceph.com/docs/master/radosgw/config/

[2]
http://docs.ceph.com/docs/master/rados/deployment/ceph-deploy-mds/
the next should be:
http://docs.ceph.com/docs/master/rados/deployment/ceph-deploy-purge/
not:
http://docs.ceph.com/docs/master/cephfs/mds-config-ref/

[3]
http://docs.ceph.com/docs/master/rados/troubleshooting/community/
the next should be:
http://docs.ceph.com/docs/master/rados/troubleshooting/troubleshooting-mon/
not:
http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/

[4]
http://docs.ceph.com/docs/master/rados/troubleshooting/troubleshooting-pg/
next should be:
http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/
not:
http://docs.ceph.com/docs/master/rados/troubleshooting/memory-profiling/
...

I really think this is not friendly to the users we read the documents
step by step,
I can't spot how to modify this kind links. Can anybody help?

If I am wrong, please ignore this email.
