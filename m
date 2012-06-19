From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: bad performance fio random write - rados bench random write to compare?
Date: Tue, 19 Jun 2012 16:05:53 +0200 (CEST)
Message-ID: <5b71e1e3-b1be-4c12-897d-0bffbbcf8d33@mailpro>
References: <4FE07B2A.7080209@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50161 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab2FSOGQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 10:06:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 7F3E718030A3E
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 16:05:58 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D7cv7O3g7h0r for <ceph-devel@vger.kernel.org>;
	Tue, 19 Jun 2012 16:05:53 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 25B42180464FB
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 16:05:53 +0200 (CEST)
In-Reply-To: <4FE07B2A.7080209@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
Is it possible to do random write bench with rados bench command ?

I have very base random write performance with 4K block size inside qemu-kvm,
1000 iops/s max with 3 nodes with 3x 5 disk 15k
(Maybe it's related to my constant disk writes, like datas are not flushed sequentially to disk)

seekwatcher movie of 1 osd here :
http://odisoweb1.odiso.net/random-write-4k.mpg

I would like to do tests on kvm host with rados command to compare.
(I don't have rbd module in my kvm host kernel,so I can't use fio on the host)

Regards,

Alexandre
