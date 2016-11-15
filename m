From: Samuel Just <sjust@redhat.com>
Subject: Re: Question about choose_acting
Date: Tue, 15 Nov 2016 09:37:03 -0800
Message-ID: <CAN=+7FVbSvT=GNzijte4voyHA672BU0MU-uXTanthqtSs0EUFg@mail.gmail.com>
References: <1ea9e16b.939b.15866dcba02.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36296 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbcKORhF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2016 12:37:05 -0500
Received: by mail-qk0-f169.google.com with SMTP id n21so144118291qka.3
        for <ceph-devel@vger.kernel.org>; Tue, 15 Nov 2016 09:37:04 -0800 (PST)
In-Reply-To: <1ea9e16b.939b.15866dcba02.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You are looking at the compat_mode branch.  Old versions of the code
could indeed only backfill one osd at a time.  I suggest you trace
back that variable to understand when it's set.
-Sam

On Mon, Nov 14, 2016 at 11:21 PM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
>
> Hi, everyone.
>
>
> When I read the source code of PG::calc_replicated_acting method, I found the following code really confusing:
>
>
>
>                 // select replicas that have log contiguity with primary.
>         // prefer up, then acting, then any peer_info osds
>         for (vector<int>::const_iterator i = up.begin(); i != up.end(); ++i) {
>                 pg_shard_t up_cand = pg_shard_t(*i, shard_id_t::NO_SHARD);
>                 if (up_cand == primary->first)
>                         continue;
>                 const pg_info_t &cur_info = all_info.find(up_cand)->second;
>                 if (cur_info.is_incomplete() ||
>                 cur_info.last_update < MIN(
>                                 primary->second.log_tail,
>                                 auth_log_shard->second.log_tail)) {
>                         /* We include auth_log_shard->second.log_tail because in GetLog,
>                          * we will request logs back to the min last_update over our
>                          * acting_backfill set, which will result in our log being extended
>                          * as far backwards as necessary to pick up any peers which can
>                          * be log recovered by auth_log_shard's log */
>                         ss << " shard " << up_cand << " (up) backfill " << cur_info
>                                         << std::endl;
>                         if (compat_mode) {
>                                 if (backfill->empty()) {
>                                         backfill->insert(up_cand);
>                                         want->push_back(*i);
>                                         acting_backfill->insert(up_cand);
>                                 }
>                         } else {
>                                 backfill->insert(up_cand);
>                                 acting_backfill->insert(up_cand);
>                         }
>                 } else {
>                         want->push_back(*i);
>                         acting_backfill->insert(up_cand);
>                         usable++;
>                         ss << " osd." << *i << " (up) accepted " << cur_info << std::endl;
>                 }
>         }
>
>
> It seems that only when the "backfill" set is empty will an OSD in up set whose pg log can not be linked up with the pg log of auth_log_shard or primary be added into "backfill" set, which means only one OSD can be "backfilled".
> What if there are two or more OSD in up set that needs to be "backfilled"?
>
>
> Please help me. Thank you.
