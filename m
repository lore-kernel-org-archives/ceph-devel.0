From: Shinobu Kinjo <skinjo@redhat.com>
Subject: ./src/vstart.sh
Date: Mon, 21 Sep 2015 00:01:03 -0400 (EDT)
Message-ID: <1540172490.19046862.1442808063693.JavaMail.zimbra@redhat.com>
References: <545828772.19046223.1442807824240.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:39620 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbbIUEBE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Sep 2015 00:01:04 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t8L413F4055497
	for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2015 00:01:03 -0400
In-Reply-To: <545828772.19046223.1442807824240.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Whenever I run vstart.sh, there are always 2 [global] sections in ./src/ceph.conf.
First one makes sense but second one is just empty.

Is it supposed to be? If so what's the purpose of second one?

  $ grep global /data/ceph/src/ceph.conf
   [global]
   [global]

Shinobu
