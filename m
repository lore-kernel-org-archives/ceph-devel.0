From: Svein-Erik Lund <sel@selund.se>
Subject: Feature request regarding size and min_size on pools
Date: Tue, 10 Sep 2013 16:21:27 +0400 (MSD)
Message-ID: <750758449.922.1378815687370.JavaMail.root@mail>
References: <1712504592.851.1378813557601.JavaMail.root@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp-gw11.han.skanova.net ([81.236.55.20]:35012 "EHLO
	smtp-gw11.han.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab3IJM1m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Sep 2013 08:27:42 -0400
Received: from mail.home.org (90.231.29.72) by smtp-gw11.han.skanova.net (8.5.133)
        id 516D05D203249616 for ceph-devel@vger.kernel.org; Tue, 10 Sep 2013 14:21:29 +0200
Received: from mail.home.org (mail.home.org [192.168.9.3])
	by mail.home.org (Postfix) with ESMTP id A0137BBD21
	for <ceph-devel@vger.kernel.org>; Tue, 10 Sep 2013 16:21:27 +0400 (MSK)
In-Reply-To: <1712504592.851.1378813557601.JavaMail.root@mail>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

We are implementing ceph as storage backend for some systems. 
Unfortunately we have to use a posix filesystem for storing the data.

To accomplish this we have implemented a solution quite similar to what Sebastien Han has described on his blog here http://www.sebastien-han.fr/blog/2012/07/06/nfs-over-rbd/

Now to our problem. We want to be sure that a write is replicated before we get a ack. Therefor we have set pg size to 2, and min_size to 2 as we have seen that a sudden removal of one osd can lead to data loss with min_size set to 1.

The problem now is that if one osd goes down some pg's will end up incomplete, and no io operations will be allowed to the rbd. 

This problem could be solved a couple of ways

1) An option could be set so that writes always is done to the number of replicas as size before the write is acknowledged.
2) If a situation where one a pg ends up in a incomplete state ceph tries to resolv the situation by doing a recovery of the pg's in question.

For us adding a third replica isn't a feasible solution, 1) we have our data in two locations 2) The cost would be to high.
