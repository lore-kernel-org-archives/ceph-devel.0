From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: deleting snapshots in batches?
Date: Tue, 10 Oct 2017 08:46:00 -0400
Message-ID: <CAGbvivL8SKGgVVDoxCQKTdcewEwSbk=gxHGjVsdr-0VpJNsRZA@mail.gmail.com>
References: <CAGbvivLpWC=WUgmPA0q5Tt5wXF=1bx3kcAWP7drnYWfznBBUBg@mail.gmail.com>
 <CAAM7YAm08zrKjFvKRZamJYDSDHd1Z3aacXJxyiEpqTcPW-RiTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:53041 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdJJMqC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Oct 2017 08:46:02 -0400
Received: by mail-lf0-f49.google.com with SMTP id b190so5574680lfg.9
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 05:46:02 -0700 (PDT)
In-Reply-To: <CAAM7YAm08zrKjFvKRZamJYDSDHd1Z3aacXJxyiEpqTcPW-RiTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

The "rmdir" command takes seconds.

However, the resulting storm of activity on the cluster AFTER the
deletion is bringing our cluster down completely.   The blocked
requests count goes into the thousands.  The individual OSD processes
begin taking up all of the memory that they can grab which causes the
kernel to kill them off, which further throws the cluster into
disarray due to down/out OSDs.  It takes multiple DAYS to completely
recover from deleting 1 snapshot and constant monitoring to make sure
OSDs come up and stay up after they get killed for eating too much
memory.  This is a serious issue that we have been fighting with for
over a month now.  The obvious solution is to destroy the cephfs
entirely, but that would mean we have to then recover about 40TB of
data, which could take a very long time and we'd prefer not to do
that.

For example:
2521055 ceph      20   0 16.908g 0.013t  29172 S  28.4 10.6  36:39.52
ceph-osd
2507582 ceph      20   0 22.919g 0.019t  42076 S  17.6 15.5  58:48.00
ceph-osd
2501393 ceph      20   0 22.024g 0.018t  39648 S  14.7 14.9  79:05.28
ceph-osd
2547090 ceph      20   0 21.316g 0.017t  26584 S   7.8 14.0  18:14.76
ceph-osd
2455703 ceph      20   0 20.872g 0.017t  19784 S   4.9 13.8 111:02.06
ceph-osd
 246368 ceph      20   0 22.657g 0.018t  37416 S   3.9 14.5 462:31.79
ceph-osd




On Tue, Oct 10, 2017 at 12:03 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Tue, Oct 10, 2017 at 12:13 AM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>> We have a cluster (10.2.9 based) with a cephfs filesytem that has
>> 4800+ snapshots. We want to delete most of the very old ones to get it
>> to a more manageable number (such as 0).  However, deleting even 1
>> snapshot right now takes up to a full 24 hours due to their age and
>> size. It would literally take 13 years to delete all of them at the
>> current pace.
>>
>> Here is one snapshot directory statistics:
>>
>> # file: cephfs/.snap/snapshot.2017-02-24_22_17_01-1487992621
>> ceph.dir.entries="3"
>> ceph.dir.files="0"
>> ceph.dir.rbytes="30500769204664"
>> ceph.dir.rctime="1504695439.09966088000"
>> ceph.dir.rentries="7802785"
>> ceph.dir.rfiles="7758691"
>> ceph.dir.rsubdirs="44094"
>> ceph.dir.subdirs="3"
>>
>> There is a bug filed with details here: http://tracker.ceph.com/issues/21412
>>
>> Im wondering if there is a faster, undocumented, "backdoor" way to
>> clean up our snapshot mess without destroying the entire filesystem
>> and recreating it.
>
> deleting snapshot in cephfs is a simple operation, it should complete
> in seconds. something must  go wrong If 'rmdir .snap/xxx' tooks hours.
> please set debug_mds to 10, retry deleting a snapshot and send us the
> log. (it's better to stop all other fs activities while deleting
> snapshot)
>
> Regards
> Yan, Zheng
>
>>
>> -Wyllys Ingersoll
>>  Keeper Technology, LLC
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
