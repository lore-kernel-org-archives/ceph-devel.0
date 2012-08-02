From: Christoph Hellwig <hch@infradead.org>
Subject: Re: TIER: combine SSDs and HDDs into a single block device
Date: Thu, 2 Aug 2012 13:57:00 -0400
Message-ID: <20120802175700.GA16693@infradead.org>
References: <CADvuQRExAsO2yKo6pT+MMfj8Gwt7a7SGkkOgm-0kjQ+nRzU75g@mail.gmail.com>
 <501AB2B4.2010406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:38165
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755038Ab2HBR5B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 13:57:01 -0400
Content-Disposition: inline
In-Reply-To: <501AB2B4.2010406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

On Thu, Aug 02, 2012 at 12:02:44PM -0500, Mark Nelson wrote:
> Alex is also trying to bug the XFS guys (and Sage bugged the BTRFS
> guys) about ways to put metadata on SSD while keeping data on
> spinning disk. It sounds like there is a hack for XFS that would let
> us keep inodes in the lower portion of a volume up to some
> configurable boundary and then we could use lvm to assign that
> portion of the volume to an SSD.  The BTRFS guys have a SOC project
> in the works to separate out metadata onto another disk.

Also with XFS you can use the realtime device for data and the main
device for all metadata.

