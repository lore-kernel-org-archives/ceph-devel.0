From: Samuel Just <sjust@redhat.com>
Subject: Re: throttling PG removal
Date: Wed, 29 Jun 2016 13:55:33 -0700
Message-ID: <CAN=+7FW9P7frBHShpojUHbOyT9c_KrUi=h-qLXFRo1eq5-ky4Q@mail.gmail.com>
References: <CABZ+qqnisScrzXiR=zbtaC291TnYxEPd=on5Ey1Ad89-02M+CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:32811 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbcF2U5G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 16:57:06 -0400
Received: by mail-qk0-f175.google.com with SMTP id q79so110874562qke.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 13:55:34 -0700 (PDT)
In-Reply-To: <CABZ+qqnisScrzXiR=zbtaC291TnYxEPd=on5Ey1Ad89-02M+CA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Seems reasonable for a short term fix.  Longer term, I'd like to dump
it into the OpWQ with a super low priority.  Not sure about the
osd_target_transaction_size, you'd have to see what else it's used
for.
-Sam

On Wed, Jun 29, 2016 at 9:40 AM, Dan van der Ster <dan@vanderster.com> wrote:
> Hi all,
>
> We're deleting a large pool with lots of 4MB objects, and it's turning
> out to be rather disruptive: >50 loadavg on osd machines, osd's
> flapping, peering mess for the other pools.
>
> In general, I'd like to be able to throttle this way back so that the
> deleted PG objects slowly disappear without affecting IO to other
> pools. And AFAICT there's no way to achieve that in current jewel or
> master.
>
> Here is the timing of the RemoveWQ on one of these OSDs:
>
> 2016-06-29 18:28:06.388530 7fee8a2e5700 12 OSD::disk_tp worker wq
> OSD::RemoveWQ start processing 0x1 (1 active)
> 2016-06-29 18:28:07.954758 7fee8a2e5700 15 OSD::disk_tp worker wq
> OSD::RemoveWQ done processing 0x1 (0 active)
> 2016-06-29 18:28:07.954766 7fee8a2e5700 12 OSD::disk_tp worker wq
> OSD::RemoveWQ start processing 0x1 (1 active)
> 2016-06-29 18:28:10.599542 7fee8a2e5700 15 OSD::disk_tp worker wq
> OSD::RemoveWQ done processing 0x1 (0 active)
>
> I'd like to add a configurable osd_pg_remove_sleep, probably at the
> top of OSD::RemoveWQ::_process ? Should that have the desired effect?
>
> Moreover, it would be nice to be able to decrease the number of
> objects removed per instance of the worker. It's currently limited to
> osd_target_transaction_size (shared by build_past_intervals_parallel,
> remove_dir, and handle_osd_map). Should it be safe to decrease that
> (to, say, 5) or would it be better to introduce something specific to
> remove_dir?
>
> Thanks,
>
> Dan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
