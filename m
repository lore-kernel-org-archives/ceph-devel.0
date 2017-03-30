From: Vincent Godin <vince.mlist@gmail.com>
Subject: Idea for optimize an OSD rebuild
Date: Thu, 30 Mar 2017 11:47:55 +0200
Message-ID: <CAL2-6bJLntQ3MzYffw3_tFQXjizErDLDY5RoBG5-DyZUoCAhnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33876 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932728AbdC3Jr5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Mar 2017 05:47:57 -0400
Received: by mail-qk0-f169.google.com with SMTP id d10so34964833qke.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Mar 2017 02:47:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When you replace a failed osd, it has to recover all of its pgs and so
it is pretty busy. Is it possible to tell this OSD to not become
primary for any of its already synchronized pgs till every pgs (of the
OSD) have recovered ? It should accelerate the rebuild process because
this OSD won't have to serve client's read requests but just sync the
writes request from the OSDs owning the primary pgs and recover. Is
there something wrong with this idea ?
