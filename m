From: Sage Weil <sweil@redhat.com>
Subject: Re: how to use teuthology-suite in the new world
Date: Thu, 22 Dec 2016 22:21:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612222220510.10615@piezo.novalocal>
References: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal> <9ea71ad4-b933-a55c-f92c-c2716e6c4645@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757063AbcLVWVs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Dec 2016 17:21:48 -0500
In-Reply-To: <9ea71ad4-b933-a55c-f92c-c2716e6c4645@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel@vger.kernel.org, "sepia@ceph.com" <sepia@ceph.com>

On Thu, 22 Dec 2016, Nathan Cutler wrote:
> > Teuthology now defaults to https://github.com/ceph/ceph-ci.git instead of
> > ceph.git.
> > 
> > To schedule a test against something in ceph-ci.git,
> > 
> >   teuthology-suite -s rados -c wip-foo
> > 
> > To schedule against something in ceph.git (e.g., master),
> > 
> >   teuthology-suite -s rados -c master --ceph-repo
> > https://github.com/ceph/ceph.git
> 
> Understood, but this does not seem to work. In latest teuthology, when I
> specify "--ceph-repo https://github.com/ceph/ceph.git", the option is ignored.
> 
> Maybe I'm just doing something ignorant and/or stupid.
> 
> For details, see http://tracker.ceph.com/issues/18342

Maybe your teuthology checkout is not up to date?  I've been using this 
extensively for the last few days...

sage

