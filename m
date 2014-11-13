From: Samuel Just <sam.just@inktank.com>
Subject: Re: PG down
Date: Thu, 13 Nov 2014 09:06:27 -0800
Message-ID: <CA+4uBUZzJ_VQcJVD9eECnPZ3jGQOdKRGohR=CXVurmFzPxQ5jA@mail.gmail.com>
References: <BLU175-W3A509068439286AE88D0EDF8F0@phx.gbl>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:57489 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaKMRG2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 12:06:28 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so12671179lbj.27
        for <ceph-devel@vger.kernel.org>; Thu, 13 Nov 2014 09:06:27 -0800 (PST)
In-Reply-To: <BLU175-W3A509068439286AE88D0EDF8F0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It looks like the acting set went down to the min allowable size and
went active with osd 8.  At that point you needed every member of that
acting set to go active later on to avoiding loosing writes.  You can
prevent this by setting a min_size above the number of data chunks.
-Sam

On Thu, Nov 13, 2014 at 4:15 AM, GuangYang <yguang11@outlook.com> wrote:
> Hi Sam,
> Yesterday there was one PG down in our cluster and I am confused by the PG state, I am not sure if it is a bug (or an issue has been fixed as I see a couple of related fixes in giant), it would be nice you can help to take a look.
>
> Here is what happened:
>
> We are using EC pool with 8 data chunks and 3 code chunks, saying the PG has up/acting set as [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], there was one OSD in the set down and up, so that it triggered PG recovering. However, when doing recover, the primary OSD crash as due to a corrupted file chunk, then another OSD become primary, start recover and crashed, and so on so forth until there are 4 OSDs down in the set and the PG is marked down.
>
> After that, we left the OSD having corrupted data down and started all other crashed OSDs, we expected the PG could become active, however, the PG is still down with the following query information:
>
> { "state": "down+remapped+inconsistent+peering",
>   "epoch": 4469,
>   "up": [
>         377,
>         107,
>         328,
>         263,
>         395,
>         467,
>         352,
>         475,
>         333,
>         37,
>         380],
>   "acting": [
>         2147483647,
>         107,
>         328,
>         263,
>         395,
>         2147483647,
>         352,
>         475,
>         333,
>         37,
>         380],
> ...
>                 377]}],
>           "probing_osds": [
>                 "37(9)",
>                 "107(1)",
>                 "263(3)",
>                 "328(2)",
>                 "333(8)",
>                 "352(6)",
>                 "377(0)",
>                 "380(10)",
>                 "395(4)",
>                 "467(5)",
>                 "475(7)"],
>           "blocked": "peering is blocked due to down osds",
>           "down_osds_we_would_probe": [
>                 8],
>           "peering_blocked_by": [
>                 { "osd": 8,
>                   "current_lost_at": 0,
>                   "comment": "starting or marking this osd lost may let us proceed"}]},
>         { "name": "Started",
>           "enter_time": "2014-11-12 10:12:23.067369"}],
> }
>
> Here osd.8 is the one having corrupted data.
>
> The way we worked around this issue is to set norecover and start osd.8, get that PG active and then removed the object (via rados), unset norecover and things become clean again. But the most confusing part is that even we only left osd.8 down, the PG couldn't become active.
>
> We are using firefly v0.80.4.
>
> Thanks,
> Guang
