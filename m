From: Sage Weil <sage@newdream.net>
Subject: Re: async+direct IO in osd journal write
Date: Fri, 19 Aug 2011 21:03:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108192101160.17629@cobra.newdream.net>
References: <CABAwU-bcnVUn3d3HytywkEYdzZySxtBFT6=-nXOGA+ppNhCg0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44553 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab1HTD6O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2011 23:58:14 -0400
In-Reply-To: <CABAwU-bcnVUn3d3HytywkEYdzZySxtBFT6=-nXOGA+ppNhCg0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 20 Aug 2011, huang jun wrote:
> hi,all
> Recently,we have a test to compare  async i/o and sync i/o in OSD.
> The osd jounral was written in sync + direct io mode now, that heavily
> infuluenced the write performance.
> we use linux aio API. test file size is 40MB,and disk isn't busy.
> here is the test result:
>           type                  ext3
> sync write+direct io      4.441s
> 
> async write +direct io   0.462s
> 
> we are glad to see that, so we want to affirm that :
> 1) can we use async+direct io to achieve better write performance if
> we used osd journal?

Do you mean changing the writes in os/FileJournal.cc to be async?  As long 
as the journal does not acknowledge a write until it is stable on disk, 
that is fine.  Async IO would be a nice improvement here; I think 
currently it's a single sync O_DIRECT io in flight at a time.

The test is to write a 40MB file via which interface?  Via a kernel client 
mount?

Thanks-
sage


> 2) does this  bring some problems?
> 
> thank you in advance!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
