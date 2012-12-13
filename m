From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [ceph-commit] [ceph/ceph] e6a154: osx: compile on OSX
Date: Thu, 13 Dec 2012 03:43:14 -0500
Message-ID: <20121213084314.GA26817@infradead.org>
References: <50c4cd4dabe04_4126fc8af02216d@sh2.rs.github.com.mail>
 <4685D39E3A8A4352B08C753D91FC4A5A@inktank.com>
 <sfid-H20121209-182244-+035.50-1@marduk.tchpc.tcd.ie>
 <CA+Hcz5-z4=aYGaTb3tU28B0Qanb=a+iR+yq_RKqc9EVsJZ-GAQ@mail.gmail.com>
 <C29C365E-91F0-46D8-8559-99BF78E0B098@tchpc.tcd.ie>
 <alpine.DEB.2.00.1212100901110.17288@cobra.newdream.net>
 <50C617D0.30005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:60721
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750829Ab2LMInT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 Dec 2012 03:43:19 -0500
Content-Disposition: inline
In-Reply-To: <50C617D0.30005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Jimmy Tang <jtang@tchpc.tcd.ie>, Noah Watkins <noah.watkins@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Mon, Dec 10, 2012 at 07:11:44AM -1000, Sam Lang wrote:
> >>Is libaio really needed to build ceph-fuse? I use macports on my system
> >>and the last time I tried to make a change set to let ceph/ceph-fuse
> >>build on my laptop failed as I didn't have libaio, though I could just
> >>write a port for it.
> >
> >libaio is only used by ceph-osd.  Not needed by fuse.
> 
> An alternative on OSX could be aio-lite:
> https://trac.mcs.anl.gov/projects/aio-lite
> 
> It might perform better on linux as well because of the request
> serialization there, although that library was implemented a few
> years ago, and the linux implementation may have improved
> significantly since then.  It also wouldn't be hard to do something
> similar with ceph thread structures instead of depending on an
> external library like this one.

libaio is the library the provides the kernel AIO API, which is very
different from Posix AIO.

