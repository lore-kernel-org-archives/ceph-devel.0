From: biyan chen <riby.chen@gmail.com>
Subject: File only read, can't write, problem
Date: Tue, 24 May 2011 12:44:27 +0800
Message-ID: <BANLkTi=2KDBCNxyrr9Nnhx=FBH0yrPY7XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:57955 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab1EXEo2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 00:44:28 -0400
Received: by yia27 with SMTP id 27so2423369yia.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 21:44:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs -k
/usr/local/etc/ceph/keyring.bin
/etc/init.d/ceph -a start

Startup ceph



mount -t ceph 192.168.0.211:6789:/ /1 -vv

This command  File only read, can't write!!

cfuse -m  ceph_mon0:6789 /1 -c /usr/local/etc/ceph/ceph.conf
Can read could write
