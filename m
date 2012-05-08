From: Tim Flavin <tim.flavin@gmail.com>
Subject: (unknown)
Date: Mon, 7 May 2012 20:54:07 -0400
Message-ID: <CAEj+kbnJ6yHBw3zPA9OivmKwv7BTg32ze4q82dZH2Y74Gk6arw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:47986 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757891Ab2EHAyI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 May 2012 20:54:08 -0400
Received: by qabj40 with SMTP id j40so157843qab.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 May 2012 17:54:08 -0700 (PDT)
Subject: 
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The new site is great!  I like the Ceph documentation, however I found
a couple of typos.  Is this the best place address them?  (Some of the
apparent typos may be my not understanding what is going on.)



http://ceph.com/docs/master/config-cluster/ceph-conf/

The  "Hardware Recommendations" link near the bottom of the page gives
a 404.  Did you want to point to
http://ceph.com/docs/master/install/hardware-recommendations/ ?


http://ceph.com/docs/master/config-ref/osd-config

For  "osd client message size cap"  The default value is 500 MB but
the description lists it a 200 MB.


http://ceph.com/docs/master/api/librbdpy/

The line of code: "size = 4 * 1024 * 1024  # 4 GiB" appears to be
missing a * 1024, and the next line
 is "rbd_inst.create('myimage', 4)" when it probably should be
"rbd_inst.create('myimage', size)" This is repeated several times.
