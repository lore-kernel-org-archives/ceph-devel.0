From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RADOSGW internals ?
Date: Thu, 2 Aug 2012 15:49:57 +0200
Message-ID: <CAF6-1L6Yu-eFnV0uytwNoYBj1W7=MGJvOHvEwve4fCXGQx==dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37042 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab2HBNt6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 09:49:58 -0400
Received: by vcbfk26 with SMTP id fk26so8210171vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 06:49:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


Is there a document explaining how radosgw maps things to rados ?

My situation is that I'm currently running various failure scenarios
to see how to recover. One of them includes the complete loss of a
placement group and in my case this lead into a weirdly inconsistent
bucket. I could still add and get object from it, but I couldn't do
list or delete ... ( tracing the error, the cls_head call was failing
in rgw_rados ).

I also tried starting from scratch by stopping radosgw and deleting
all .rgw .rgw.control .rgw.buckets pools ... and when I restarted, a
's3 -u list' _still_ showed the previous buckets names ?!?


Cheers,

     Sylvain
