From: Sage Weil <sweil@redhat.com>
Subject: denc nullptr issue
Date: Tue, 7 Mar 2017 22:48:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703072243100.24356@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756039AbdCGW4O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Mar 2017 17:56:14 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8DBB80F8D
        for <ceph-devel@vger.kernel.org>; Tue,  7 Mar 2017 22:48:30 +0000 (UTC)
Received: from ovpn-112-22.rdu2.redhat.com (ovpn-112-22.rdu2.redhat.com [10.10.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F7202D654
        for <ceph-devel@vger.kernel.org>; Tue,  7 Mar 2017 22:48:30 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We have three competing PRs to address the crashes when -O0 is used:

lixiaoy1	https://github.com/ceph/ceph/pull/12796
kefu		https://github.com/ceph/ceph/pull/13819
adam		https://github.com/ceph/ceph/pull/12931

Adam's is appealing because it will ensure the bounded encodes are in fact 
constant at compile time.  Unfortunately, it requires you to define DENC 
twice, like so:

-  DENC_FEATURED(bar_t, v, p, f) {
+  DENC_FEATURED_BOUNDED(bar_t, v, p, f) {
     ::denc(v.a, p, f);
     ::denc(v.b, p, f);
   }
+  DENC_FEATURED_BOUND_ENCODE(bar_t, p, f) {
+    DENC_START(1, 1, p);
+    ::denc(bounded_t<decltype(bar_t::a)>{}, p, f);
+    ::denc(bounded_t<decltype(bar_t::b)>{}, p, f);
+    DENC_FINISH(p);
+  }

which feels like a deal-killer to me... I think I'd rather just drop the 
check entirely and rely on the developer to be careful.

The other two PRs fix up the handful of type(s) that were actually causing 
failures to manually define bound (again making the single DENC macro 
unusable).

What about instead changing all of the instances of

      denc(*(const T*)nullptr, elem_size);

with a macro that will either do the above "*(const T*)nullptr" -or-, if 
it looks like this is a debug build or compiler optimizations are off or 
some other compiler environment indicates it won't work, replace it with 
"T()"?  That avoids crashes in the -O0 case, but still lets us keep some 
safeguard for other builds?

Any other ideas?

sage

