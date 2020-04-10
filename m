From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH 0/2] stable CephFS backports
Date: Fri, 10 Apr 2020 11:20:59 +0100
Message-ID: <20200410102059.GA18283@suse.com>
References: <20200408105844.21840-1-lhenriques@suse.com>
 <20200410091410.GF1691838@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDJKUk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:20:40 -0400
Content-Disposition: inline
In-Reply-To: <20200410091410.GF1691838@kroah.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, stable@vger.kernel.org

On Fri, Apr 10, 2020 at 11:14:10AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 08, 2020 at 11:58:38AM +0100, Luis Henriques wrote:
> > Hi!
> > 
> > Please pick the backports for the following upstream commits:
> > 
> >   4fbc0c711b24 "ceph: remove the extra slashes in the server path"
> >   b27a939e8376 "ceph: canonicalize server path in place"
> > 
> > They fix an ancient bug that can be reproduced in kernels as old as 4.9 (I
> > couldn't reproduced it with 4.4).
> 
> All now queued up, including for 5.5.y, thanks.

Awesome, thanks.  And sorry, I forgot to mention in the cover-letter that
5.5 was a clean cherry-pick.

Cheers,
--
Luís
