From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: using discard from qemu guest when snapshot exist, fill the rbd
 layer with zeroes and use more space
Date: Fri, 17 Jun 2016 11:10:54 +0200 (CEST)
Message-ID: <1498621012.13671278.1466154654173.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:35577 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbcFQJK4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 05:10:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 8D78457FE1E67
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 11:10:54 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bPujDOhTeg4v for <ceph-devel@vger.kernel.org>;
	Fri, 17 Jun 2016 11:10:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 6AAFD57FE1E6A
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 11:10:54 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y0KT53AN8tlz for <ceph-devel@vger.kernel.org>;
	Fri, 17 Jun 2016 11:10:54 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id 4AED757FE1E67
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 11:10:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm using fstrim inside my qemu guests to remove unused space from the rbd storage.

This is working fine, but I just notice that if a snapshot exist,

It just do the reverse, it's filling the snasphot with zeroes, and the total cluster space is growing.

It's is possible to avoid that ?


Regards,

Alexandre
