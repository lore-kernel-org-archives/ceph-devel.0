From: Calvin Morrow <calvin.morrow@gmail.com>
Subject: Re: TIER: combine SSDs and HDDs into a single block device
Date: Thu, 2 Aug 2012 11:32:45 -0600
Message-ID: <CADxhoDQCH-=MRKKcpTO2deHxGS-GyOEoK8GfNNw8gmNoxrsH7A@mail.gmail.com>
References: <CADvuQRExAsO2yKo6pT+MMfj8Gwt7a7SGkkOgm-0kjQ+nRzU75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41117 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab2HBRcr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 13:32:47 -0400
Received: by ghrr11 with SMTP id r11so2527072ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 10:32:46 -0700 (PDT)
In-Reply-To: <CADvuQRExAsO2yKo6pT+MMfj8Gwt7a7SGkkOgm-0kjQ+nRzU75g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

I played with TIER about a week ago.  Definitely a decent
implementation of HSM and seems to work well from my testing.
Assuming a three tier setup (we'll say SSD, 15K SAS, 7K SATA), the
code drops sequential I/O on tier 2 (the 15K) first, moving it down as
tier 2 fills up and/or blocks are unused.  If you do a lot of I/O on a
particular segment, it moves it up to the faster tiers.

Kent Overstreet (the bcache developer) also took a look at the code
and weighed in.  He said it was impressive what TIER managed to do in
~3K lines of code, although expressed his concern that TIER uses a lot
of rb trees which would limit random read I/O performance.

Current caveats:  TIER devices can't be expanded.  TIER devices also
can't have additional TIERs added after setup.  The developer said
he's working on adding those features and hopes to have them in the
next 2-3 months.

Calvin

On Thu, Aug 2, 2012 at 10:13 AM, Tommi Virtanen <tv@inktank.com> wrote:
> Sounds like bcache in writeback mode. Assumes all underlying block
> devices are RAIDed, or losing one will mean losing data; that is, for
> example RAID1(SSD+SSD) & RAID5(8*HDD).
>
> http://www.lessfs.com/wordpress/?p=776
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
