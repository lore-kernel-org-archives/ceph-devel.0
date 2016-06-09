From: Noah Watkins <noahwatkins@gmail.com>
Subject: libcephfs-java bindings built but not showing up in debian repository
Date: Thu, 9 Jun 2016 16:29:20 -0700
Message-ID: <CAB2gnbXwbVghGQac9N_s820iG+M19xucvLi7DJOAaZrNjhoCyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36672 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcFIX3V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2016 19:29:21 -0400
Received: by mail-io0-f174.google.com with SMTP id n127so51942732iof.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jun 2016 16:29:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Dan Mick <dmick@redhat.com>, mozes@ksu.edu

I'm trying to track down why the Java Debian packages are not showing
up in the Jewel repository:

Looking in the repository for jewel I see the JNI bindings deb:

   http://download.ceph.com/debian-jewel/pool/main/c/ceph/
   libcephfs-jni_10.2.1-1trusty_amd64.deb 13-May-2016 23:53 20368086

but not the deb file containing the Java bits (libcephfs-java).
However, it looks like the gitbuilder is producing them:

   http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/ref/jewel/pool/main/c/ceph/
   ===> libcephfs-java_10.2.1-135-g50143ed-1trusty_all.deb2016-06-09 15:191.0M
   libcephfs-jni_10.2.1-135-g50143ed-1trusty_amd64.deb2016-06-09 15:1919M

I grepped around the autobuilders and don't see any special cases for
Java. Any clues?

Thanks,
Noah
