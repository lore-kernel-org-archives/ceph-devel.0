From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: how to mount a specific pool in cephs
Date: Mon, 30 Apr 2012 16:16:11 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf2.mach.net.au ([115.165.172.4]:49840 "EHLO mf2.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab2D3GpY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 02:45:24 -0400
Received: from exch10.ad.mach.net.au (exch10.ad.mach.net.au [115.165.169.4])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mf2.mach.net.au (Postfix) with ESMTP id 15F8C27FCB
	for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 16:16:13 +1000 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all

Running Ceph version 0.45-1precise on 12.04 x64.

I cannot find the right syntax to mount a specific pool created, that has a customised replica level set, which is different to the default "data" pool (i.e. we have an additional pool called "backup"). Can somebody please advise the right syntax??

I tried the following per: http://ceph.newdream.net/docs/master/man/8/mount.ceph/
    mount -t ceph 10.32.0.10:6789:/backup /mnt/ceph -vv -o name=admin,secret=ThisIsNotTheRealSecret==
And it hard-hung the server, and needed a hard power restart (ouch!).

The following works fine, but it is not connecting to the "backup" pool (with no pool name specified, it is going to pool0 called "data"):
    mount -t ceph 10.32.0.10:6789:/ /mnt/ceph -vv -o name=admin,secret=ThisIsNotTheRealSecret==

Very many thanks

Paul



