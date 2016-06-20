From: Igor Fedotov <ifedotov@mirantis.com>
Subject: zero length write fro store_test to bluestore
Date: Mon, 20 Jun 2016 16:50:47 +0300
Message-ID: <e175ac33-0398-2154-6edd-6ee932509c8c@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33309 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbcFTN6a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 09:58:30 -0400
Received: by mail-lf0-f47.google.com with SMTP id f6so38296851lfg.0
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jun 2016 06:56:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Hi All,

I'm hitting the following issue while running Synthetic test case (from 
store_test.cc) against bluestore:

store_test asserts on read data mismatch when read happens after the 
zero-length write above object boundary.

Test case assumes all the data between the old and new object boundaries 
are filled with zeros. But current bluestore write path implementation 
simply discards zero-length writes and hence doesn't raise object size. 
As a result subsequent read doesn't return anything above the old boundary.

The question is what's the proper fix for that:

1) Ignore zero-length writes in the test case and do not increase object 
size/fill content on them.

or

2) Increase object content size on such writes in the bluestore.

Thanks,

Igor








