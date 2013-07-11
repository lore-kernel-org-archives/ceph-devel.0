From: Sage Weil <sage@inktank.com>
Subject: Re: Using valgrind_osd option
Date: Thu, 11 Jul 2013 12:38:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307111237320.8931@cobra.newdream.net>
References: <CA+bvTtnt_GZEiwHgsmW_uWvjhFxE3QxyUTWX=nM6hs5E6ikLuQ@mail.gmail.com> <51DCB596.4040800@inktank.com> <CA+bvTtkDCOVMO3vXWsU+V00Q_4rO=ZZstxmi+SAedg0o6Cc2hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44808 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab3GKTih (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 15:38:37 -0400
In-Reply-To: <CA+bvTtkDCOVMO3vXWsU+V00Q_4rO=ZZstxmi+SAedg0o6Cc2hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ranjan Sarpangala Venkatesh <ranjansv@soe.ucsc.edu>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On Wed, 10 Jul 2013, Ranjan Sarpangala Venkatesh wrote:
> Hi Mark,
> 
> I upgraded valgrind to 3.8.1 and also used
> --soname-synonyms=somalloc=*tcmalloc* option. However, no massif.out
> file was created.
> 
> Kindly let me know if i am missing something.

I haven't run into this.  I usually run without tcmalloc in my dev 
environment so that I can do valgrind leak checking, though.  
make clean and ./do_autogen.sh -d 3 -T in the base dir of ceph.git...?

sage



> 
> With regards
> Ranjan
> 
> On Tue, Jul 9, 2013 at 6:15 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> > Hi,
> >
> > I ran into this problem a while back and it was because I was trying to use
> > a version of valgrind that didn't support tcmalloc (which Ceph was compiled
> > to use).  Try upgrading valgrind to 3.8.0 or newer.  You'll also need to
> > pass something like:
> >
> > --soname-synonyms=somalloc=*tcmalloc*
> >
> > Mark
> >
> >
> > On 07/09/2013 08:10 PM, Ranjan Sarpangala Venkatesh wrote:
> >>
> >> Hi,
> >>
> >> I am trying to collect memory of the OSD daemon with the following
> >>
> >> ./vstart.sh -n -x -l --valgrind_osd 'massif'
> >>
> >> However, when I print massif.out file there is nothing
> >>
> >> cat massif.out.15391
> >>
> >> desc: (none)
> >> cmd: ./ceph-osd -i 0 -c ceph.conf -f
> >> time_unit: i
> >> #-----------
> >> snapshot=0
> >> #-----------
> >> time=0
> >> mem_heap_B=0
> >> mem_heap_extra_B=0
> >> mem_stacks_B=0
> >> heap_tree=empty
> >>
> >> --
> >> With regards,
> >> Ranjan
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> 
> 
> 
> -- 
> With regards,
> Ranjan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
