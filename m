From: Marcus Sorensen <shadowsor@gmail.com>
Subject: [RFC] rados perl bindings
Date: Thu, 1 Sep 2011 21:22:33 -0600
Message-ID: <CALFpzo6ioZYdY3cu2LhaKtywvQPt25-cOCmc2kbpW8f_2_ktHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41324 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758091Ab1IBDWe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Sep 2011 23:22:34 -0400
Received: by wyh22 with SMTP id 22so1625361wyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Sep 2011 20:22:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

As mentioned earlier, I'm working on gluing perl onto the back of
librados (or at least giving it a good duct-taping). As part of
registering the namespace for the module in CPAN, I just need to get
some feedback and show that others involved with Ceph development are
aware and are ok with the namespace being used.  I was going to try to
register "Ceph::RADOS", not quite sure if it would fit under
"Filesys::Ceph::RADOS" as it's not really anything to do with
manipulating the filesystem per se, and did not see any other root
namespaces that would be an obvious fit. Let me know what you think.
