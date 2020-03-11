From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [ceph-users] cephfs snap mkdir strange timestamp
Date: Wed, 11 Mar 2020 11:25:24 +0000
Message-ID: <20200311112524.GA72386@suse.com>
References: <"H000007100163fdf.1583792359.sx.f1-outsourcing.eu*"@MHS>
 <"H000007100164304.1583836879.sx.f1-outsourcing.eu*"@MHS>
 <20200310134613.GA74810@suse.com>
 <7f684a1a23c007858d996346532971bd0de9f138.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKLZ1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:25:27 -0400
Content-Disposition: inline
In-Reply-To: <7f684a1a23c007858d996346532971bd0de9f138.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Marc Roos <M.Roos@f1-outsourcing.eu>, ceph-users <ceph-users@ceph.io>, ceph-devel@vger.kernel.org

On Tue, Mar 10, 2020 at 01:39:29PM -0400, Jeff Layton wrote:
...
> What about the atime, and the ci->i_btime ?

FYI, I've also created PR#33879 to also get the atime in the fuse client.

Cheers,
--
Luis
