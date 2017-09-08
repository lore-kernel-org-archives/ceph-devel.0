From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: very slow backfill on Luminous + Bluestore
Date: Fri, 8 Sep 2017 10:11:51 -0700
Message-ID: <CAJ4mKGZY86teMTbg-RC-kt9KUYCk1y66wy23-OYypVdGeWO99w@mail.gmail.com>
References: <CAEYCsV+eUcNKAa5s6X9tZKjJ+off2WXR6o_Ayggv0ZW_E6obVw@mail.gmail.com>
 <alpine.DEB.2.11.1709081528560.16664@piezo.novalocal> <CAEYCsVJEiFra_gun33a=ROvQhosmPLZtYr04w+q5TcCU8C+6MQ@mail.gmail.com>
 <f60827b0-fc54-b72e-adec-a2df6a822b04@redhat.com> <CAEYCsVJ+pVs6=GkWq-SNiDoQQURRumWo=K0EVcuvquvs7+X2zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:46416 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbdIHRLx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Sep 2017 13:11:53 -0400
Received: by mail-it0-f46.google.com with SMTP id 6so3068052itl.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Sep 2017 10:11:52 -0700 (PDT)
In-Reply-To: <CAEYCsVJ+pVs6=GkWq-SNiDoQQURRumWo=K0EVcuvquvs7+X2zw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Sep 8, 2017 at 8:59 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> CPU and Disk are fairly idle.
> I didnt use gdbprof but enable debug log seems it is not hanging. Also
> "gdb thread apply all bt" shows nothing intresting , all threads are
> waiting on condition for job.


Which cond are they waiting on? Sounds like the backfill is being
deliberately throttled but it's not immediately obvious what is doing
it.
