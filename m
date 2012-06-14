From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph next branch: error creating empty object store in /srv/osd.10:
 (22) Invalid argument
Date: Thu, 14 Jun 2012 14:04:54 +0200
Message-ID: <4FD9D366.3060305@profihost.ag>
References: <4FD9D187.8030601@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57623 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab2FNMFB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 08:05:01 -0400
In-Reply-To: <4FD9D187.8030601@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I got this fixed by deleting all content in /srv/osd.X. But now i get 
with the next branch this one:

=== osd.32 ===
pushing conf and monmap to ssdstor002:/tmp/mkfs.ceph.4885
2012-06-14 14:02:09.333309 7f815cd26780 -1 journal FileJournal::_open: 
unable to open journal: open() failed: (2) No such file or directory
2012-06-14 14:02:09.690097 7f815cd26780 -1 filestore(/srv/osd.32) could 
not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or 
directory
2012-06-14 14:02:09.758456 7f815cd26780 -1 created object store 
/srv/osd.32 journal /journal/osd.32.journal for osd.32 fsid 
308b2ada-5c2a-4b54-b094-b7035413d247
creating private key for osd.32 keyring /etc/ceph/osd.32.keyring
creating /etc/ceph/osd.32.keyring
collecting osd.32 key

Stefan
