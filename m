From: Mrugesh Karnik <mkarnik@redhat.com>
Subject: Introducing Tendrl
Date: Tue, 20 Sep 2016 12:40:08 +0530
Message-ID: <CAOLAhP0dQo1_Dw-6TUxPXh+R+trxjQnLYWh+ax9E4iyV47tCiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33207 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbcITHKa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 03:10:30 -0400
Received: by mail-lf0-f43.google.com with SMTP id h127so5539994lfh.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 00:10:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

I'd like to introduce the Tendrl project. Tendrl aims to build a
management interface for Ceph. We've pushed some documentation to the
documentation repository[1]. The documentation should provide an
understanding of the architecture and the components therein. This is
still a work in progress. So please feel free to ask questions and
make suggestions via the mailing list[2] and Github Issues[3]. There's
an IRC channel[4] as well.

Martin Bukatovic had earlier initiated a discussion around Ceph
Manager on this list. I'd like to address that here. Currently, we've
repurposed Calamari codebase as the Ceph Bridge. We're also tracking
the development of Ceph Manager. We'll be setting up a test bed to
check the Ceph Manager functionality and respond to the list with
feedback and queries.

Thanks.

[1] https://github.com/Tendrl/documentation
[2] https://www.redhat.com/mailman/listinfo/tendrl-devel
[3] https://github.com/Tendrl/documentation/issues
[4] #tendrl-devel on Freenode

-- 
Mrugesh
