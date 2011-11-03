From: Christoph Hellwig <hch@infradead.org>
Subject: Re: ceph-mon blocked error
Date: Thu, 3 Nov 2011 17:20:24 -0400
Message-ID: <20111103212024.GA1587@infradead.org>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
 <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
 <CAORUGqB+oS5WupMZURbkenNop68u2jf2VrY3_tktBk4=b-jS8w@mail.gmail.com>
 <CA+jddaO2NqLTNbS2zBnQW4MCA7=BYDC-GHx_H01hqSq9RvOgBw@mail.gmail.com>
 <CAORUGqC3ZG-7NG7xACFoHP0kY=gDDgMG=i+99MV1hmM1XpL9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:59281
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751381Ab1KCVU1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 17:20:27 -0400
Content-Disposition: inline
In-Reply-To: <CAORUGqC3ZG-7NG7xACFoHP0kY=gDDgMG=i+99MV1hmM1XpL9bw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Mandell Degerness <mandell@pistoncloud.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Nov 03, 2011 at 02:15:25PM -0700, Tommi Virtanen wrote:
> If it's reproducible, I'm sure the XFS developers would appreciate if
> you straced what ceph-mon does to get to the hang, tried to do similar
> actions to reproduce it outside of ceph (e.g. "every time I write to
> this file, it hangs"), and then give them a good bug report with a
> dump of the filesystem, to figure out what really happened.

XFS is just waiting for I/O to complete - xfs_bwrite is a very simple
funtion that synchronously submits I/O, and xfs_buf_iowait is called
to wait for the completion.   This is a typical symptom for a broken
I/O subsystem.  What kind of setup do you use?  Especially hardware
RAID controllers tends to produce these kinds of issues.

