From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: ceph 0.86 : rbd_cache=true, iops a lot slower on randread 4K
Date: Mon, 20 Oct 2014 08:02:01 +0200 (CEST)
Message-ID: <56238ae2-2d74-4514-98cc-872ee6df0100@mailpro>
References: <6525d3a1-dd42-4655-a418-4e24c5e41f8e@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55611 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaJTGCJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Oct 2014 02:02:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id E435A18035370
	for <ceph-devel@vger.kernel.org>; Mon, 20 Oct 2014 08:02:07 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDQ4tgyc5SEz for <ceph-devel@vger.kernel.org>;
	Mon, 20 Oct 2014 08:02:02 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id F0B251802B55A
	for <ceph-devel@vger.kernel.org>; Mon, 20 Oct 2014 08:02:01 +0200 (CEST)
In-Reply-To: <6525d3a1-dd42-4655-a418-4e24c5e41f8e@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm not sure it's related to this bug
http://tracker.ceph.com/issues/9513

But, when with this fio-rbd benchmark 

[global]
ioengine=rbd
clientname=admin
pool=test
rbdname=test
invalidate=0  
rw=randread
bs=4k
direct=1
numjobs=8
group_reporting=1
size=10G

[rbd_iodepth32]
iodepth=32



I have around 

40000iops (cpu bound on client) with rbd_cache=false

vs

13000iops (40%cpu usage on client) with rbd_cache=true


(Note that it should be direct ios, so It should bypass the cache).
Seem to be a lock or something like that, as the cpu usage is a lot lower too.

Is it the expected behavior ?
