From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH] ceph: canonicalize server path in place
Date: Tue, 7 Apr 2020 18:23:38 +0100
Message-ID: <20200407172338.GA20223@suse.com>
References: <20200211095314.28931-1-idryomov@gmail.com>
 <4adab4636c62b614d8460ecac70225c9ce485b37.camel@kernel.org>
 <20200407135204.GA31471@suse.com>
 <2fc4a60980d697c3b68a996596c7f860cca7d0cd.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgDGRXT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:23:19 -0400
Content-Disposition: inline
In-Reply-To: <2fc4a60980d697c3b68a996596c7f860cca7d0cd.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

On Tue, Apr 07, 2020 at 11:19:48AM -0400, Jeff Layton wrote:
> On Tue, 2020-04-07 at 14:52 +0100, Luis Henriques wrote:
...
> I'm fine with getting stable to pick both of those up.

Great!

> Looks like the main conflicts are due to the mount option parsing
> changes? If you had to massage the patches to get them to merge, then
> you should note that in the changelog so Greg knows why you're sending
> him a backport rather than just asking him to pick it.
> 
> Otherwise I think these look good to me.

Awesome, thanks.  I'll try to get these tested a bit for those stable
kernels and send the backports to Greg.

Cheers,
--
Luís
