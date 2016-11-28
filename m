From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Is Ceph-FreeBSD package building information wanted in the Ceph tree?
Date: Mon, 28 Nov 2016 11:21:05 +0100
Message-ID: <bd20aaaa-93a3-2f7e-482f-b544a4aaf80e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:60451 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754175AbcK1KVM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 28 Nov 2016 05:21:12 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id E16EF286BD
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2016 11:21:07 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

The Ceph package build config is almost ready for submission to the
FreeBSD Ports system.
Now the question is, is a copy of this also wanted in the Ceph-tree?

Note that the FreeBSD ports are already publicly available in SVN, and
completely trackable there.

Advantage is that all FreeBSD items are in the tree.
Disadvantage would probably be:
 -  There ia absolutely no way to test this
 -  it is not going to be used by users from the tree, but from
	/usr/ports
 -  The version in the Ceph tree will always lagg, if only because
	changes will be submitted after acceptance by the Ceph
	developers.

In my personal opinion it does have value, because it will inform
porters to other systems that there is already infrastructure for BSD.

But the reason for asking is that I'm bivalent about this.

Thanx,
--WjW
