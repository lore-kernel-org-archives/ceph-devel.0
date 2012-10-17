From: Sage Weil <sage@inktank.com>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Wed, 17 Oct 2012 15:45:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210171544340.5342@cobra.newdream.net>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com> <alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net> <CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com> <CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com>
 <alpine.DEB.2.00.1210031238300.23173@cobra.newdream.net> <506DF09B.20505@ubuntu.com> <1349388042.11633.161.camel@julia> <CAPrxi58Cm98s0e1qZUBhsZBVgV2bSEb7cESxHF9Vk1_+QMg=tQ@mail.gmail.com> <5075EFF3.9000106@cs.ucsc.edu> <1349916817.25403.1.camel@julia>
 <CAPrxi58zNBQtaaMP=1TuRgy81w=bxm5G6CWQ30SdyNx7tixEhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42147 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab2JQWpc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 18:45:32 -0400
In-Reply-To: <CAPrxi58zNBQtaaMP=1TuRgy81w=bxm5G6CWQ30SdyNx7tixEhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>, James Page <james.page@ubuntu.com>, Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 10 Oct 2012, Noah Watkins wrote:
> On Wed, Oct 10, 2012 at 5:53 PM, Laszlo Boszormenyi (GCS) <gcs@debian.hu> wrote:
> > Hi Noah,
> >
> > On Wed, 2012-10-10 at 15:00 -0700, Noah Watkins wrote:
> >> Laszlo, James:
> >>
> >> Changes based on your previous feedback are ready for review. I pushed the changes here:
> >>
> >>   git://github.com/noahdesu/ceph.git wip-java-cephfs
> >  Checking only the diff, as it's 3 am here. It looks quite OK. But will
> > check it further in the afternoon.
> 
> Ok, great. The one thing I was most curious about is if the ceph.jar
> reference in debian/libceph-java.jlibs is correct. Previously I was
> able to reference its installation path within debian/tmp
> (usr/lib/ceph.jar), but jh_installlibs was only able to find the jar
> when I referenced its build location (src/java/ceph.jar).

Laszlo, any comment there?

Also, I have one question: this packages up libcephfs bindings in 
libceph-java.  Should that be libcephfs-java, or should be put *all* ceph 
lib bindings in here (libcephfs, librados, librbd)?

sage
