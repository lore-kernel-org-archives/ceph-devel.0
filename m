From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: very slow backfill on Luminous + Bluestore
Date: Fri, 8 Sep 2017 23:59:48 +0800
Message-ID: <CAEYCsVJ+pVs6=GkWq-SNiDoQQURRumWo=K0EVcuvquvs7+X2zw@mail.gmail.com>
References: <CAEYCsV+eUcNKAa5s6X9tZKjJ+off2WXR6o_Ayggv0ZW_E6obVw@mail.gmail.com>
 <alpine.DEB.2.11.1709081528560.16664@piezo.novalocal> <CAEYCsVJEiFra_gun33a=ROvQhosmPLZtYr04w+q5TcCU8C+6MQ@mail.gmail.com>
 <f60827b0-fc54-b72e-adec-a2df6a822b04@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33854 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdIHP7u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Sep 2017 11:59:50 -0400
Received: by mail-oi0-f52.google.com with SMTP id l74so12890377oih.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Sep 2017 08:59:50 -0700 (PDT)
In-Reply-To: <f60827b0-fc54-b72e-adec-a2df6a822b04@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

CPU and Disk are fairly idle.
I didnt use gdbprof but enable debug log seems it is not hanging. Also
"gdb thread apply all bt" shows nothing intresting , all threads are
waiting on condition for job.
