From: Takuya ASADA <syuu@dokukino.com>
Subject: RADOS Java binding & RADOS for Eucalyptus Walrus(S3 interface)
Date: Tue, 10 Aug 2010 00:36:22 +0900
Message-ID: <AANLkTikt9FfcGqwHmrBS==OxLVQcwPUkSEdTmmGM9bYt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58125 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab0HIPgo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Aug 2010 11:36:44 -0400
Received: by wwj40 with SMTP id 40so11700513wwj.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Aug 2010 08:36:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm considering to use RADOS for Eucalyptus Walrus backend to make it
more scaleable, and I just implemented experimental code for it.
At the beginning I tried to figure out the way to use radosgw instead
of Walrus for S3 interface, but it's looks bit difficult to fill the
gap of authorization code between Eucalyptus and radosgw, therefore I
implemented RADOS Java binding and RADOS interface for Walrus.

It's not so well tested, but at least S3 client(s3cmd) and
euca-upload-bundle worked on it.
If the project has interest on it, I'm very happy to contribute the
code and work on it continuously.

Currently the code are on github.com:
http://github.com/syuu1228/rados4j
http://github.com/syuu1228/RADOS4Eucalyptus

Thanks,
syuu
