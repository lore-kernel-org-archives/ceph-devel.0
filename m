From: Ken Dreyer <kdreyer@redhat.com>
Subject: packaging compressor plugins
Date: Thu, 25 Feb 2016 12:25:50 -0700
Message-ID: <CALqRxCzD9kQKFGJeHYYU+Fvk0_BxNx3k1292mO_P5onngO5Rzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37204 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933579AbcBYTZv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 14:25:51 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so42017472wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 11:25:51 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

There are some compressor plugins in Jewel. Should these plugins (eg.
libceph_example.so, libceph_zlib.so, libceph_snappy.so) go into the
ceph-osd package, or the ceph-base package, or the ceph-test package?

I'm not sure what they are used for?

- Ken
