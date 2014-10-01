From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: librados AIO problem diagnostic
Date: Wed, 1 Oct 2014 15:09:48 +0200
Message-ID: <1412168988.6822.27.camel@sebmain.cern.ch>
References: <542BA6D4.4070207@dachary.org>
		 <1412148537.6822.11.camel@sebmain.cern.ch> <542BBBE7.4000806@dachary.org>
	 <1412163429.6822.20.camel@sebmain.cern.ch> <542BFCCB.4000203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:42077 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbaJANKj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Oct 2014 09:10:39 -0400
In-Reply-To: <542BFCCB.4000203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Ok, we are getting closer then.
I'll try to reinstall the ubuntu machine and run with -g.

Sebastien

On Wed, 2014-10-01 at 15:08 +0200, Loic Dachary wrote:
> 
> On 01/10/2014 13:37, Sebastien Ponce wrote:
> > I've tried it on the RHEL6 like machine, but no luck. Or should I say I
> > was lucky ? Anyway no crash.
> > 
> > Discussing with Dan Van Der Ster, he told me that he had once the case
> > where the crash was there or not depending on the libc version. Just in
> > case, what are you using ? On the machine I've used this morning, it's
> > glibc-2.12-1.107.el6.x86_64
> 
> I'm using 
> 
> ii  libc-bin                                              2.19-0ubuntu3 
> 
> and I do not have glibc installed. I'm quite sure you can reproduce the problem on a fresh Ubuntu 14.04 with the following
> 
> ./autogen.sh ; ./configure --disable-static --with-debug CFLAGS="-Wall -g" CXXFLAGS="-Wall -g"
> 
> it fails consistently in my container. When I try with ./configure it does not fail. Something is going on when there is -g instead of the default flags. I checked that --disable-static and --with-debug make no difference.
> 
> Cheers
> 
> > 
> > Sebastien
> > 
> > On Wed, 2014-10-01 at 10:31 +0200, Loic Dachary wrote:
> >> Hi,
> >>
> >> On 01/10/2014 09:28, Sebastien Ponce wrote:
> >>> Thanks for this effort !
> >>> I'll look at all that this afternoon (it's mid morning here).
> >>
> >> Same here : I'm in Paris ;-)
> >>
> >>> Concerning configure and autogen, I do the standard (naive ?)
> >>> "./autogen.sh; ./configure; make" given by the readme.
> >>
> >> Could you try with
> >>
> >> ./autogen.sh ; ./configure --disable-static --with-debug CC='ccache gcc' CXX='ccache g++' CFLAGS="-Wall -g" CXXFLAGS="-Wall -g" ; make
> >>
> >> and let me know if you see a problem when running
> >>
> >> cd src
> >> rm -fr dev out ;  mkdir -p dev ; CEPH_NUM_MON=1 CEPH_NUM_OSD=3 ./vstart.sh -d -n -X -l mon osd
> >> ./ceph_test_rados_striper_api_aio
> >>
> >> I'm trying with your "./configure" on my end to check if this changes something.
> >>
> >> It's going to be a fun one ;-)
> >>
> >> Cheers
> >>
> >>>
> >>> Sebastien
> >>>
> >>>
> >>> On Wed, 2014-10-01 at 09:01 +0200, Loic Dachary wrote:
> >>>> Hi Sebastien,
> >>>>
> >>>> In the context of http://tracker.ceph.com/issues/9356 I'm trying to collect as much information as I can in an environment that can be reconstructed to avoid interferences. Could you please let me know which ./configure line you are using ? Or which do_autogen.sh command you are using.
> >>>>
> >>>> Thanks in advance :-)
> >>>>
> >>>
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 


