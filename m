From: Sage Weil <sweil@redhat.com>
Subject: Re: BlueStore::fsck() during mkfs()
Date: Wed, 31 Aug 2016 21:21:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608312120040.24099@piezo.us.to>
References: <BL2PR02MB211583CCF7ABCA3F4C0CABF7F4E30@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753618AbcHaVVE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 17:21:04 -0400
In-Reply-To: <BL2PR02MB211583CCF7ABCA3F4C0CABF7F4E30@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 31 Aug 2016, Somnath Roy wrote:
> Sage,
> I saw with recent master we have introduced fsck() (and it is 'on' by default) during mkfs() , wondering what is the use case of fsck() during mkfs() ?
> This is making cluster creation terribly slow for BlueStore.

I recently fixed a bug where mkfs was creating a store that failed 
fsck.  I would expect it to be fast, though, if it's empty...

Oh, is this because of the big in-memory bitmap for allocation?
sage

