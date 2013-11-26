From: Christoph Hellwig <hch@infradead.org>
Subject: Re: os recommendations
Date: Tue, 26 Nov 2013 06:22:43 -0800
Message-ID: <20131126142243.GA7360@infradead.org>
References: <CAMNMNTz+whZWk55qCxx_8JCRWAruoHYz+stHYS93gBiU3qz3SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39955 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947Ab3KZOWn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 09:22:43 -0500
Content-Disposition: inline
In-Reply-To: <CAMNMNTz+whZWk55qCxx_8JCRWAruoHYz+stHYS93gBiU3qz3SQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dominik Mostowiec <dominikmostowiec@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Tue, Nov 26, 2013 at 11:43:07AM +0100, Dominik Mostowiec wrote:
> Hi,
> I found in doc: http://ceph.com/docs/master/start/os-recommendations/
> "Putting multiple ceph-osd daemons using XFS or ext4 on the same host
> will not perform as well as they could."
> 
> For now recommended filesystem is XFS.
> This means that for the best performance setup should be 1 OSD per host?

Btw, could anyone clarify where that stance comes from, that is numbers
to back it up.

