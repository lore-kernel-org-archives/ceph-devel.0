From: Michael Wyraz <michael@wyraz.de>
Subject: mount.cephfs with domain name and multiple ip addresses
Date: Wed, 22 Jun 2016 07:31:41 +0200
Message-ID: <576A22BD.1000901@wyraz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vpsprod2.wyraz.de ([188.68.49.93]:53361 "EHLO mail.wyraz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbcFVFzU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jun 2016 01:55:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.wyraz.de (Postfix) with ESMTP id F184B8EE64
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 07:31:41 +0200 (CEST)
Received: from mail.wyraz.de ([127.0.0.1])
	by localhost (mail.wyraz.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J0SilXCjJ0jc for <ceph-devel@vger.kernel.org>;
	Wed, 22 Jun 2016 07:31:41 +0200 (CEST)
Received: from [192.168.10.10] (p50992bfa.dip0.t-ipconnect.de [80.153.43.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.wyraz.de (Postfix) with ESMTPSA
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 07:31:41 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I have multiple ceph monitor nodes and one domain name that has an a
record for each node. I use this record in my fstab, e.g.:

    mon.mycephcluster.com:6789:/ /backups/ ceph _netdev

In /proc/mounts, I can see all IPs for mon.mycephcluster.com, e.g.:

    1.1.1.1:6789,2.2.2.2:6789,2.2.2.2:6789:/ /backups ceph
    rw,relatime,acl 0 0

This works perfect and is a really good thing because it makes
adding/removing nodes much more easy. What I'd like to know is if this
is intended behaviour (in this case it should be documented in the
manpage) or if this could have unexpected side effects.

Kind regards,
Michael.

