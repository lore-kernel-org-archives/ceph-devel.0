From: Guang Yang <guangyy@gmail.com>
Subject: Newly added monitor infinitely sync store
Date: Fri, 13 Nov 2015 15:50:37 -0800
Message-ID: <CAKtk8hdHfR8eAMD0dMS+kETmg4rHxLCXp_p_DW_HTzjr-FhASg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34708 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbbKMXui (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Nov 2015 18:50:38 -0500
Received: by ykfs79 with SMTP id s79so174164003ykf.1
        for <ceph-devel@vger.kernel.org>; Fri, 13 Nov 2015 15:50:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>
Cc: joao@suse.de

I was wrong the previous analysis, it was not the iterator got reset,
the problem I can see now, is that during the syncing, a new round of
election kicked off and thus it needs to probe the newly added
monitor, however, since it hasn't been synced yet, it will restart the
syncing from there.

Hi Sage and Joao,
Is there a way to freeze the election by some tunable to let the sync finish?

Thanks,
Guang

On Fri, Nov 13, 2015 at 9:00 AM, Guang Yang <guangyy@gmail.com> wrote:
> Hi Joao,
> We have a problem when trying to add new monitors to the cluster on an
> unhealthy cluster, which I would like ask for your suggestion.
>
> After adding the new monitor, it  started syncing the store and went
> into an infinite loop:
>
> 2015-11-12 21:02:23.499510 7f1e8030e700 10
> mon.mon04c011@2(synchronizing) e5 handle_sync_chunk mon_sync(chunk
> cookie 4513071120 lc 14697737 bl 929616 bytes last_key
> osdmap,full_22530) v2
> 2015-11-12 21:02:23.712944 7f1e8030e700 10
> mon.mon04c011@2(synchronizing) e5 handle_sync_chunk mon_sync(chunk
> cookie 4513071120 lc 14697737 bl 799897 bytes last_key
> osdmap,full_3259) v2
>
>
> We talked early in the morning on IRC, and at the time I thought it
> was because the osdmap epoch was increasing, which lead to this
> infinite loop.
>
> I then set those nobackfill/norecovery flags and the osdmap epoch
> freezed, however, the problem is still there.
>
> While the osdmap epoch is 22531, the switch always happened at
> osdmap.full_22530 (as showed by the above log).
>
> Looking at the code at both sides, it looks this check
> (https://github.com/ceph/ceph/blob/master/src/mon/Monitor.cc#L1389)
> always true, and I can confirm from the log that (sp.last_commited <
> paxos->get_version()) was false, so the chance is that the
> sp.synchronizer always has next chunk?
>
> Does this look familiar to you? Or any other trouble shoot I can try?
> Thanks very much.
>
> Thanks,
> Guang
