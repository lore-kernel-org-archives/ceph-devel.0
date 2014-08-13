From: Viral Mehta <viral.vkm@gmail.com>
Subject: size and depth of Tree Bucket
Date: Wed, 13 Aug 2014 16:39:31 +0530
Message-ID: <CANX6DakEDhAjfSTcb4vtRbW-yX_TnV7Vd=VCWHuBQE=Cbu-cDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:51957 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaHMLJc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Aug 2014 07:09:32 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so12393942pde.25
        for <ceph-devel@vger.kernel.org>; Wed, 13 Aug 2014 04:09:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was looking at ceph/crush/builder.c crush_make_tree_bucket() function,

I would like to understand what "size" argument refers to ? Generally speaking
Tree Size is Total Number of the nodes. And this would be the same as number of
items.

But, crush.h mentions that it is NOT true. Can someone shed some light ?
--
