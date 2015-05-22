From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: rados bench : multiple parralel bench increase total iops results ?
Date: Fri, 22 May 2015 09:35:06 +0200 (CEST)
Message-ID: <797273899.89295271.1432280106396.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38163 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbEVHfJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 03:35:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 2B13044E2DC95
	for <ceph-devel@vger.kernel.org>; Fri, 22 May 2015 09:35:07 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id V7KFsGmIETG1 for <ceph-devel@vger.kernel.org>;
	Fri, 22 May 2015 09:35:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id F2DD244DF779C
	for <ceph-devel@vger.kernel.org>; Fri, 22 May 2015 09:35:06 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v3PyBgsBpqv6 for <ceph-devel@vger.kernel.org>;
	Fri, 22 May 2015 09:35:06 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id CC68C40034B85
	for <ceph-devel@vger.kernel.org>; Fri, 22 May 2015 09:35:06 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm currently compare results of "rados bench" vs fio-librbd,

and I notice that with rados bench (4k randread, 1osd)

"rados bench -p pooltest 300 rand -t 128"

Bandwidth (MB/sec):   284
Average IOPS:         72750

Increasing threads number don't improve results after 128 threads


but launching the same rados bench twice in parallel, give me

rados bench1:
Bandwidth (MB/sec):   247
Average IOPS:         63203

rados bench2:
Bandwidth (MB/sec):   251
Average IOPS:         64175

Is it expected ?


If I compare with fio, it seem like that threads number is related to iodepth in fio

with fio, I got around 
  70000 iops with 1 job iodepth=128
  121000 iops with 2 jobs iodepth=128



Could it be possible to improve rados bench to run it multiple time in parallel and aggregate results ?
It could be usefull to compare with fio.

Regards,

Alexandre

