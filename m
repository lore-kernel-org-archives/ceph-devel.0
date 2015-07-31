From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Cluster Network & Public Network w.r.t XIO ?
Date: Thu, 30 Jul 2015 20:21:06 -0700
Message-ID: <CAFkUHxddmOdyZHcjzCoEJYu_YkkUZ=3aq_FZ4QfJNqdKJ_xO3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34005 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbGaDVH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 23:21:07 -0400
Received: by pacan13 with SMTP id an13so33869846pac.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jul 2015 20:21:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: vu@mellanox.com, raju.kurunkad@sandisk.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Vu, Raju,

I am trying to bring up ceph cluster on a powerful dell server with
two 40Gbe ROCEv2 NIC.

I have assigned one as my cluster network (would prefer all osd
communications happen on that) and have assigned one as my public n/w.
this works fine for simple messenger case. (ofcourse no rdma)

but when I try to bring this up on XIO, this gets very complicated, as
in how do I specify two RDMA_LOCAL  ? one for cluster n/w and other
for public ? can choose XIO for client to osd communication and simple
for cluster n/w ?

any thoughts ?

Thanks,
Neo
