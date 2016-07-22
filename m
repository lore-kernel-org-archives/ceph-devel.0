From: Ira Cooper <ira@wakeful.net>
Subject: Re: CephFS Samba VFS RHEL packages
Date: Thu, 21 Jul 2016 21:11:22 -0400
Message-ID: <20160722011122.GA26458@ira-t460p.lan>
References: <CA+z5Dsx7phEMT1oxENzCwXxQrB0NtCLwxWGPKF+NeMZNr+KkSw@mail.gmail.com>
 <CALqRxCwg3jFN2OTC2ut=otHukOGHw9p9r7+RbByvQdTMBifM8A@mail.gmail.com>
 <CA+z5DszcKbrEcAssNFQEfaE5ugwOaxs3RbcO1s+n9fkGK18K=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33743 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbcGVBLn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 21:11:43 -0400
Received: by mail-qk0-f176.google.com with SMTP id p74so89540551qka.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 18:11:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+z5DszcKbrEcAssNFQEfaE5ugwOaxs3RbcO1s+n9fkGK18K=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, John Spray <john.spray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Fri, Jul 22, 2016 at 08:29:39AM +1100, Blair Bethwaite wrote:
> Ken, Ira, John -
> 
> Thanks a lot for the replies. Our initial setup is simply running
> samba atop a cephfs kernel mount, and initial cursory checks seem to
> show the basics are working as expected (even clustered with ctdb -
> what are your concerns here Ira?). Though we've yet to try any of our
> planned test scenarios/datasets.
> 
> From the conversation here I'm thinking we'd be better off using
> Xenial for our CephFS+Samba test nodes at the moment... though I only
> see packages for Precise and Trusty on gitbuilder.ceph.com at the
> moment. We were planning to compare samba on kernel mount versus ceph
> vfs.
> 
> Can someone clarify what state the cephfs kernel client in RHEL 7.x
> will be in when RHCS 2.0 is released, i.e., will that be back-ported
> or are RHEL users expected to use FUSE? (I'm happy to go ask support
> directly but I suspect this is useful information for others too).

Please note: icooper@redhat.com is not on this list, so I can't
reply from there ;).

I recommend you test your setup THROUGHLY.  CTDB is really in
place to handle failures, so test node failures.  I recommend
hard power-offs for this.  The real world is rarely as kind
as a "nice" poweroff, and it might trick you into thinking
more is working than is.

If you get it right, all the nodes should end up banned if I
remember right.  It's been a bit since I tested with stock
settings.

For my setup I use:

FUSE for the mount so CTDB works.
vfs_ceph for the Samba datapath.

That's what I'd recommend based on talking to people.

No idea on RHCS/Kernel.

Cheers,

-Ira
