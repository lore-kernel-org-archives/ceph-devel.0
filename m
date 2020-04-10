From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] stable CephFS backports
Date: Fri, 10 Apr 2020 11:14:10 +0200
Message-ID: <20200410091410.GF1691838@kroah.com>
References: <20200408105844.21840-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgDJJOM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:14:12 -0400
Content-Disposition: inline
In-Reply-To: <20200408105844.21840-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, stable@vger.kernel.org

On Wed, Apr 08, 2020 at 11:58:38AM +0100, Luis Henriques wrote:
> Hi!
> 
> Please pick the backports for the following upstream commits:
> 
>   4fbc0c711b24 "ceph: remove the extra slashes in the server path"
>   b27a939e8376 "ceph: canonicalize server path in place"
> 
> They fix an ancient bug that can be reproduced in kernels as old as 4.9 (I
> couldn't reproduced it with 4.4).

All now queued up, including for 5.5.y, thanks.

greg k-h
