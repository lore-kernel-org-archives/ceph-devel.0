From: Ugis <ugis22@gmail.com>
Subject: Re: very slow backfill on Luminous + Bluestore
Date: Fri, 15 Sep 2017 13:17:27 +0300
Message-ID: <CAE63xUNPSTOmFfB+wZQ3n4o1LTPFHBA1R2q0ASf+c3vhvkeRYg@mail.gmail.com>
References: <CAEYCsV+eUcNKAa5s6X9tZKjJ+off2WXR6o_Ayggv0ZW_E6obVw@mail.gmail.com>
 <alpine.DEB.2.11.1709081528560.16664@piezo.novalocal> <CAEYCsVJEiFra_gun33a=ROvQhosmPLZtYr04w+q5TcCU8C+6MQ@mail.gmail.com>
 <f60827b0-fc54-b72e-adec-a2df6a822b04@redhat.com> <CAEYCsVJ+pVs6=GkWq-SNiDoQQURRumWo=K0EVcuvquvs7+X2zw@mail.gmail.com>
 <CAJ4mKGZY86teMTbg-RC-kt9KUYCk1y66wy23-OYypVdGeWO99w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:49512 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOKR2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 06:17:28 -0400
Received: by mail-io0-f179.google.com with SMTP id 21so7212616iof.6
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 03:17:28 -0700 (PDT)
In-Reply-To: <CAJ4mKGZY86teMTbg-RC-kt9KUYCk1y66wy23-OYypVdGeWO99w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Resending without HTML, sorry for duplicates.

Similar issue here, describing steps taken, hope it unveals some clues.

Had 33 filestore OSDs, healthy cluster. Did replace 1 OSD with
bluestore according to instruction on ceph site.

During emtying OSD neighbouring OSDs in the same host were hitting
backfillfull margin(90%) so I periodically did reweighting down "ceph
osd reweight" and "ceph osd crush reweight" for those. After while I
noticed that despite backfill hitted backfillfull for a while overall
backfill(emptying) continued and usage % on neighbour OSDs was
floating around backfillfull margin.

When OSD was emtied I reformatted it with bluestore and it started
backfill. Initially recovery traffic was good (~150MB/s). On recovery
start I had 1 OSD in backfill_full state and 2 in backfill_full
warning state(OSDs on same host). Then at some point (bluestore OSD
had ~700GB/5.5TB usage) recovery speed dropped to  ~"20057 kB/s, 4
objects/s" and is hanging there.

Bluestore OSD is sata hdd, currently iostat on it:
Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdf               0.00     0.00    0.00   70.00     0.00 26692.00
762.63     1.10   14.51    0.00   14.51   5.60  39.20

Let me know if/how I can gather some data that can help with problem
investigation.

There is a feeling that recovery is throttling and it is not HW limit.

Ugis


2017-09-08 20:11 GMT+03:00 Gregory Farnum <gfarnum@redhat.com>:
> On Fri, Sep 8, 2017 at 8:59 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>> CPU and Disk are fairly idle.
>> I didnt use gdbprof but enable debug log seems it is not hanging. Also
>> "gdb thread apply all bt" shows nothing intresting , all threads are
>> waiting on condition for job.
>
>
> Which cond are they waiting on? Sounds like the backfill is being
> deliberately throttled but it's not immediately obvious what is doing
> it.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
