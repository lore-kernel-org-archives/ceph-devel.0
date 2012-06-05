From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: mount: 10.0.6.10:/: can't read superblock
Date: Tue, 05 Jun 2012 14:07:11 -0400 (EDT)
Message-ID: <bf905afe-88fc-4185-aa06-febe1d08e4f4@mail.linserv.se>
References: <01f629d2-41bc-4266-acb7-1aeff803c38f@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:34568 "EHLO
	mail.linserv.se" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab2FESHh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 14:07:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 32805E7F2
	for <ceph-devel@vger.kernel.org>; Tue,  5 Jun 2012 14:07:13 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id blbzApi-twro for <ceph-devel@vger.kernel.org>;
	Tue,  5 Jun 2012 14:07:11 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 3C71CE7EE
	for <ceph-devel@vger.kernel.org>; Tue,  5 Jun 2012 14:07:11 -0400 (EDT)
In-Reply-To: <01f629d2-41bc-4266-acb7-1aeff803c38f@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello

Is there a way to recover this error.

mount -t ceph 10.0.6.10:/ /mnt -vv -o name=admin,secret=XXXXXXXXXXXXXXXXXXXXXXX
[  506.640433] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
[  506.650594] ceph: loaded (mds proto 32)
[  506.652353] libceph: client0 fsid a9d5f9e1-4bb9-4fab-b79b-ba4457631b01
[  506.670876] Intel AES-NI instructions are not detected.
[  506.678861] libceph: mon0 10.0.6.10:6789 session established
mount: 10.0.6.10:/: can't read superblock

One of my mds logs has 24G of data. 

I have some rbd devices that I would like to keep.

/Regards Martin




