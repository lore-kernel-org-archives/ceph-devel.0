From: Samuel Just <sjust@redhat.com>
Subject: Re: OSD::do_mon_report - do we need holding osd_lock
Date: Tue, 18 Aug 2015 08:42:04 -0700
Message-ID: <CAN=+7FXJ3m9=fjOeNbPY3_EJg_LmtRUdk7Y1DQ1zOvqQL06eUA@mail.gmail.com>
References: <BLU175-W2D3E7CFB5B9535A1E5AAFDF780@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36235 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbbHRPmF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Aug 2015 11:42:05 -0400
Received: by iodv127 with SMTP id v127so178085267iod.3
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2015 08:42:04 -0700 (PDT)
In-Reply-To: <BLU175-W2D3E7CFB5B9535A1E5AAFDF780@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Probably!  A quick glance at do_mon_report doesn't seem to turn up
anything I'd expect to be really hard to refactor.  You do need to
break out the required data (into OSDService, I'd think) so that the
lock is not necessary.
-Sam

On Mon, Aug 17, 2015 at 6:10 PM, GuangYang <yguang11@outlook.com> wrote:
> Hi Sam,
> Today I noticed a scenario that monitor marked OSD down since it did not receive the PG stats from the OSD, further investigation showed that the reason why OSD didn't report stats because it failed to acquire the osd_lock, what happened was:
>   1. one PG is undergoing long-run peering (search for missing objects)
>   2. An OP hold the osd_lock and try to acquire the PG lock, which is being held by 1).
>   3. OSD tick thread failed to acquire osd_lock and stuck for 10 minutes, thus failed to update to monitor its stats
>   4. monitor mark it down
>
> After looking at the code, we found several assertions (that osd_lock should be held) around OSD::do_mon_report, is that required? Any chance to overcome the problem described above by refactoring the locking there?
>
> Thanks,
> Guang
