From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: question about the data structure of crush_map
Date: Mon, 2 Dec 2013 11:31:07 +0800
Message-ID: <CAMm-wcKBvJ4F5hBo_+4FyXEuumePHwz8EtOsPo=aYUBXwB+NiA@mail.gmail.com>
References: <CAJqA8gvBkq7F=nJBvSaVjwXJQYguHQjp4zQOPSgpvYbwOza=kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:42646 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab3LBDbI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Dec 2013 22:31:08 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq4so4133517wib.3
        for <ceph-devel@vger.kernel.org>; Sun, 01 Dec 2013 19:31:07 -0800 (PST)
In-Reply-To: <CAJqA8gvBkq7F=nJBvSaVjwXJQYguHQjp4zQOPSgpvYbwOza=kA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lipeng Wan <lipengwan86@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

If my memory serves me well, negative id means buckets (root, room,
rack, cabinet, etc.), well positive means osds.

On 2 December 2013 11:20, Lipeng Wan <lipengwan86@gmail.com> wrote:
> Hi guys,
>
> I am reading the source code of ceph and trying to understand the data
> structure of crush_map. Now I am confused by the use of "struct
> crush_bucket **buckets" in function "int crush_do_rule(...)" in
> src/crush/mapper.c. It seems that the index of array "map->buckets[]"
> could be negative (see line 551, src/crush/mapper.c). I was wondering
> if anyone could explain why the index of this array can be negative
> and how those buckets were added into this array. Thanks.
>
> Best,
> L. Wan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
