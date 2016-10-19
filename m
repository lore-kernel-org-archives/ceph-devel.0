From: Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>
Subject: Ceph_rpm_build
Date: Wed, 19 Oct 2016 21:04:41 +0530
Message-ID: <CAMDPVREFbyVXQhen24o0uQSpFW7Ajb6NwL9sTThReHV+50jUMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36411 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938866AbcJSPen (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Oct 2016 11:34:43 -0400
Received: by mail-oi0-f44.google.com with SMTP id m72so34731146oik.3
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2016 08:34:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
To run my CEPH cluster from newly built CEPH source containing
instrumented debugs, I have done following steps.

1)Downloaded CEPH source from
http://download.ceph.com/tarballs/ceph_10.2.2.orig.tar.gz , and added
debugs to CEPH source.
2)Created "ceph-10.2.2.tar.gz" file from the source, and copied it to
"/root/rpmbuild/SOURCE" directory.
3)Copied ceph.spec file to "/root/rpmbuild/SPEC/" directory and ran as below.
    $rpmbuild -ba ~/rpmbuild/SPECS/ceph.spec
4)Copied newly generated "*.rpm" files to all ceph nodes and installed.

Now added some more debugs again,is it needed to follow the above
steps 2,3,4 every time when I add new debugs, since it is taking more
time?

Thanks & Regards,
Vijay Kumar.
