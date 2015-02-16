From: Sage Weil <sage@newdream.net>
Subject: Re: giant integration branch for v0.87.1 ready for QE
Date: Mon, 16 Feb 2015 10:02:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502160946480.30478@cobra.newdream.net>
References: <54DA3DD6.7070108@dachary.org> <54DB757E.2000009@dachary.org> <1387059957.19365485.1424108024488.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38533 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbbBPSCl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Feb 2015 13:02:41 -0500
In-Reply-To: <1387059957.19365485.1424108024488.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 16 Feb 2015, Yuri Weinstein wrote:
> I have completed suites execution on giant branch (v0.87.1 RC)
> 
> All results are summarized in http://tracker.ceph.com/issues/10501 under "QE VALIDATION" section.
> Some suites had to be run more then ones due to environment noise.
> 
> Two suites are being re-run now - upgrade:firefly-x and powecycle.
> 
> Next steps:
> -  the team leads to review/confirm results
> -  Loic - can you review and triage issues as needed.
> -  two suites require results analysis:
>    multimds
>    rados (two known tickets, but need more checking) ## 10209, 9891

10209: nothing has chnaged in os/ since 0.87, so i don't think this is 
a regression.  there have been lots of changes since then in master.  it 
is a bit strange that we haven't seen this on master...  could it be this?

commit 456255b728b678b0490082e1df3b1fe89b16d3a1
Author: Sage Weil <sage@redhat.com>
Date:   Sun Nov 23 20:53:06 2014 -0800

    os/DBObjectMap: include hash in header key for EC objects
    
    We were inadvertantly dropping the hash portion of the header key for EC
    objects.  This is usually not noticeable, but turns up quite quickly with
    the new pgmeta objects, which share the same name ('') across PGs with
    different hash values
    
    Fixes: #10171
    Signed-off-by: Sage Weil <sage@redhat.com>

9891: this just needs to be cherry-picked... there is a commit here:

734e9af5df4ae419ded108f5036bee068a9bc2b2
https://github.com/ceph/ceph/pull/3731

Loic, I think you said something about this the other day though?  I 
don't see it in the current giant branch...

>    krbd (two new tickets, but need more checking) ## 10889, 10890

10889: client side bug, moved to kernel project.
10890: i think these have been failing for a while?

neither of these should block the giant point release, IMO

sage


> 
> 
> Thx
> YuriW
> 
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, February 11, 2015 7:30:06 AM
> Subject: Re: giant integration branch for v0.87.1 ready for QE
> 
> Hi Yuri,
> 
> The giant-backports pull requests were merged into https://github.com/ceph/ceph/tree/giant which is not ready for testing.
> 
> For the record, the head is https://github.com/ceph/ceph/commit/78c71b9200da5e7d832ec58765478404d31ae6b5
> 
> Cheers
> 
> On 10/02/2015 18:20, Loic Dachary wrote:
> > Hi Yuri,
> > 
> > The giant integration branch for v0.87.1 as found at https://github.com/ceph/ceph/commits/giant-backports has been approved by Yehuda, Josh and Sam and is ready for QE. 
> > 
> > For the record, the head is https://github.com/ceph/ceph/commit/6b08a729540c61f3c8b15c5a3ce9382634bf800c
> > 
> > Cheers
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
