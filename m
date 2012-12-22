From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Bobtail vs Argonaut Performance Preview
Date: Sat, 22 Dec 2012 14:46:06 -0500
Message-ID: <20121222194606.GA21058@infradead.org>
References: <CAP8Oy=J6kazDvT6woLZZ3v+XVrzhKbHgO1wgyoTU8OCKq2qDEg@mail.gmail.com>
 <20121222083200.GA1977@infradead.org>
 <50D5B769.4090104@inktank.com>
 <20121222184508.GA32567@infradead.org>
 <50D60D8F.6020708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:47837
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751034Ab2LVTqH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 22 Dec 2012 14:46:07 -0500
Content-Disposition: inline
In-Reply-To: <50D60D8F.6020708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Christoph Hellwig <hch@infradead.org>, Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>

On Sat, Dec 22, 2012 at 01:44:15PM -0600, Mark Nelson wrote:
> Is inode64 typically faster than inode32?  I thought I remembered
> dchinner saying that the situation wasn't always particularly clear
> and it depended on the workload.  Having said that, I can't really
> see it not being a good thing for Ceph to spread metadata out over
> all of the AGs, especially in the multi-disk raid config.  I'll use
> it for the next set of tests.

Not for all workloads, but for the vast majority.  Especially in the
case where you have an inode for every 4MB of OSD data you'd much rather
have the inode close to the actual file data.

