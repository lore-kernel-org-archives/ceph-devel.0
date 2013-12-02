From: Sage Weil <sage@inktank.com>
Subject: Re: question about the data structure of crush_map
Date: Sun, 1 Dec 2013 20:55:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312012054060.20405@cobra.newdream.net>
References: <CAJqA8gvBkq7F=nJBvSaVjwXJQYguHQjp4zQOPSgpvYbwOza=kA@mail.gmail.com> <CAMm-wcKBvJ4F5hBo_+4FyXEuumePHwz8EtOsPo=aYUBXwB+NiA@mail.gmail.com> <CAJqA8gvo7AndWL6RacmTVs+Q+jAsS8H=uOWnnCc=LSbx6RwFNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48235 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab3LBEzB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Dec 2013 23:55:01 -0500
In-Reply-To: <CAJqA8gvo7AndWL6RacmTVs+Q+jAsS8H=uOWnnCc=LSbx6RwFNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lipeng Wan <lipengwan86@gmail.com>
Cc: Dong Yuan <yuandong1222@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 1 Dec 2013, Lipeng Wan wrote:
> Hi Dong,
> 
> Thanks for your reply. Then is it valid to access the memory space
> specified by that negative id?

You'll notice that every time we index the bucket array, the index is 
something like

	-1 - id

so that -1 maps to the first item, -2 to the second, etc.  This is safe 
because it's always preceded by some check that id is < 0 (i.e., a bucket 
id).

sage

> 
> L Wan
> 
> On Sun, Dec 1, 2013 at 10:31 PM, Dong Yuan <yuandong1222@gmail.com> wrote:
> > If my memory serves me well, negative id means buckets (root, room,
> > rack, cabinet, etc.), well positive means osds.
> >
> > On 2 December 2013 11:20, Lipeng Wan <lipengwan86@gmail.com> wrote:
> >> Hi guys,
> >>
> >> I am reading the source code of ceph and trying to understand the data
> >> structure of crush_map. Now I am confused by the use of "struct
> >> crush_bucket **buckets" in function "int crush_do_rule(...)" in
> >> src/crush/mapper.c. It seems that the index of array "map->buckets[]"
> >> could be negative (see line 551, src/crush/mapper.c). I was wondering
> >> if anyone could explain why the index of this array can be negative
> >> and how those buckets were added into this array. Thanks.
> >>
> >> Best,
> >> L. Wan
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Dong Yuan
> > Email:yuandong1222@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
