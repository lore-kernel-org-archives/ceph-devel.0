From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: CephFS mount delay
Date: Thu, 30 Aug 2012 11:50:19 -0700
Message-ID: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55716 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2H3SuU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 14:50:20 -0400
Received: by ialo24 with SMTP id o24so3681643ial.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 11:50:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'm experiencing delays of around 4-5 seconds when mounting the cephfs
client. The setup is both client and servers are on a local machine
which is otherwise idle, with the stock ceph.conf generated from
./vstart.sh. Is this length of delay expected, or do I have some
configuration out of whack? I'm not sure its relevant, but I'm using
'admin' as the 'id' parameter to ceph_create.

Thanks,
Noah
