From: Sugang Li <sugangli@winlab.rutgers.edu>
Subject: Symbol not define at runtime
Date: Tue, 12 Jul 2016 11:46:08 -0400
Message-ID: <CAG0Lszko_3inDgHxGbGwZgLrgnKEGv1LgQGnRoOLXnrP-m-T3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34260 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbcGLPqJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 11:46:09 -0400
Received: by mail-qk0-f181.google.com with SMTP id o67so17570259qke.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2016 08:46:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

I am adding some new function to librados, but run into symbol not
found error in runtime showing as below:

Starting program: /home/ubuntu/share/ceph/src/.libs/rados bench -p
scbench 1 write --no-cleanup
/home/ubuntu/share/ceph/src/.libs/rados: symbol lookup error:
/home/ubuntu/share/ceph/src/.libs/rados: undefined symbol:
_ZN8librados5IoCtx20aio_operate_parallelERKSsPNS_13AioCompletionEPNS_20ObjectWriteOperationE


I can compile it without any problem, do I need to add my function in
some sort of configuration file?

Thanks,

Sugang
