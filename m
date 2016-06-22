From: Yang X <yx888sd@gmail.com>
Subject: Quick question: Use of legacy bobtail tunables and potential
 performance impact to "jewel"?
Date: Wed, 22 Jun 2016 11:29:59 -0700
Message-ID: <CADhmVNWHx4UoYiadt1fTPKYRO==_oOizAKyW015M0RHsCRUprg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34018 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbcFVSaA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 14:30:00 -0400
Received: by mail-qk0-f170.google.com with SMTP id t127so76992169qkf.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 11:30:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I think my quick question can only be addressed by developers who have insight
into how CRUSH works in "jewel".


Our ceph client is using bobtail legacy tunable and in particular,
"chooseleaf_vary_r" is set to 0.

My question is how it would impact CRUSH and hence performance in deploying
"jewel" on the server side and also the experimental "bluestore" backend.

Does it only affect data placement or would it actually not find mapping
for certain objects and thus cause error?

Thanks in advance,

Yang
