From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: Master needs newer version of boost on centos?
Date: Mon, 17 Feb 2014 13:39:25 -0500 (EST)
Message-ID: <1199991763.111.1392662365781.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1402171030170.20749@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1225 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbaBQSja (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Feb 2014 13:39:30 -0500
In-Reply-To: <alpine.DEB.2.00.1402171030170.20749@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Sandon Van Ness <sandon@inktank.com>

Hi,

Ok, sure, will follow up.

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> On Mon, 17 Feb 2014, Matt W. Benjamin wrote:
> > Hi,
> > 
> > I think the offset,length change is probably not correct, since we
> need
> > to span the range actually being written.
> > 
> > Also we think that overlapping intervals are possible.
> 
> Yeah, it looks like it.
> 
> Pushed wip-barrier, which fixes the interval and another small item
> that I 
> noticed, but then just disables barriers to fix the build.
> 
> Note that I see two places wehre intersect() is used.  One is in 
> commit_barrier, but this is comparing two static intervals, so the
> full 
> class isn't really necessary.  (The internal one could be used, but
> this 
> is a degenerate case so it is probably just easier to open-code the
> range 
> checks.)
> 
> The other case is write_barrier(), where we are using span, which 
> likely does include overlapping intervals (assuming that overlapping 
> writes are possible, which I assume they are).  This is non-trivial to
> 
> change.
> 
> BTW looking at that function, it looks like the cond blocking behavior
> is 
> broken.  done is set to true after the cond variable wakes up, but
> that 
> change isn't guarded by the condition check (a signal can cause a 
> wakeup).  Probably the done variable and check shoudl be there at all
> so 
> that the condition is verified before the function completes.
> 
> Anyway, unless you have a quick fix in mind, let's merge this now and
> 
> hopefully get this fixed up in the next couple of weeks before
> release?
> 
> 	https://github.com/ceph/ceph/pull/1254
> 
> Thanks!
> sage
> 
> 
> > 
> > Matt
> > 
> > ----- "Sage Weil" <sage@inktank.com> wrote:
> > 
> > > On Mon, 17 Feb 2014, Matt W. Benjamin wrote:
> > > > Hi,
> > > > 
> > > > I don't know, that's an interesting catch.  I guess it's not
> really
> > > feasible to do
> > > > anything accept ack this, for now.
> > > 
> > > Probably given that we need to be able to build, but really it
> comes 
> > > down to one questions and a sanity check:
> > > 
> > > - Does the (start,end) -> (start, length) fix look right?  AFAICS
> it's
> > > 
> > > coming straight from the caller, so it should only break something
> if
> > > the 
> > > external caller is also broken.
> > > 
> > > - Is span supposed to contain overlapping intervals?  If so, then
> our
> > > 
> > > internal type is not sufficient.
> > > 
> > > sage
> > > 
> > > 
> > > 
> > > > 
> > > > Matt
> > > > 
> > > > ----- "Sage Weil" <sage@inktank.com> wrote:
> > > > 
> > > > > On Mon, 17 Feb 2014, Matt W. Benjamin wrote:
> > > > > > Hi Sage,
> > > > > > 
> > > > > > I originally used this, and it was replaced with the Boost
> > > version
> > > > > as part
> > > > > > of a bugfix.
> > > > > 
> > > > > I wonder if the bug was our internal class asserting because
> of an
> > > 
> > > > > overlapping interval due to the (start, end) thing?
> > > > > 
> > > > > s
> > > > > > 
> > > > > > Matt
> > > > > > 
> > > > > > ----- "Sage Weil" <sage@inktank.com> wrote:
> > > > > > 
> > > > > > > Hi Matt,
> > > > > > > 
> > > > > > > I pushed wip-interval-set, which replaces the boost
> > > interval_set
> > > > > with
> > > > > > > our 
> > > > > > > internal type.  As far as I can see it is only being used
> for
> > > 
> > > > > > > intersects(), which we support.  As long as the
> interval_set
> > > isn't
> > > > > 
> > > > > > > supposed to handle overlapping sets (ours doesn't) this
> should
> > > be
> > > > > > > fine.
> > > > > > > 
> > > > > > > I did notice one discrepancy where one user was passing
> in
> > > (start,
> > > > > 
> > > > > > > length) and the other was using (start, end).  I switched
> it
> > > to
> > > > > > > (start, 
> > > > > > > offset) (since that's what our class does) but didn't
> verify
> > > the
> > > > > > > semantics 
> > > > > > > were what was originally intended... can you take a look?
> > > > > > > 
> > > > > > > 	https://github.com/ceph/ceph/pull/1253
> > > > > > > 
> > > > > > > Thanks!
> > > > > > > sage
> > > > > > > 
> > > > > > > 
> > > > > > > On Fri, 14 Feb 2014, Matt W. Benjamin wrote:
> > > > > > > 
> > > > > > > > yarg, sorry
> > > > > > > > 
> > > > > > > > ----- "Josh Durgin" <josh.durgin@inktank.com> wrote:
> > > > > > > > 
> > > > > > > > > ICL was added in 1.46 according to
> > > > > > > http://www.boost.org/doc/libs/.
> > > > > > > > > This also fails on debian wheezy with only 1.42
> > > available:
> > > > > > > > > 
> > > > > > > > > http://tracker.ceph.com/issues/7422
> > > > > > > > > 
> > > > > > > > > On 02/14/2014 04:26 PM, Matt W. Benjamin wrote:
> > > > > > > > > > according to google, 1.41 ahould have it.
> > > > > > > > > >
> > > > > > > > > > ----- "Sage Weil" <sage@inktank.com> wrote:
> > > > > > > > > >
> > > > > > > > > >> On Fri, 14 Feb 2014, Matt W. Benjamin wrote:
> > > > > > > > > >>> but we haven't built on centos, to my
> knowledge...
> > > > > > > > > >>
> > > > > > > > > >> I think the question is really: is there an
> > > interval_set
> > > > > in
> > > > > > > boost
> > > > > > > > > 1.41
> > > > > > > > > >>
> > > > > > > > > >> that you can use, can you use something else
> instead,
> > > or do
> > > > > we
> > > > > > > need
> > > > > > > > > to
> > > > > > > > > >> do
> > > > > > > > > >> a boost backport in order to build for centos/rhel
> > > 6.x?
> > > > > > > > > >>
> > > > > > > > > >> sage
> > > > > > > > > >>
> > > > > > > > > >>>
> > > > > > > > > >>> ----- "Matt W. Benjamin" <matt@linuxbox.com>
> wrote:
> > > > > > > > > >>>
> > > > > > > > > >>>> oh, ok.  I think they need an extra boost rpm?
> > > > > > > > > >>>>
> > > > > > > > > >>>> ----- "Sage Weil" <sage@inktank.com> wrote:
> > > > > > > > > >>>>
> > > > > > > > > >>>>> Hey Matt,
> > > > > > > > > >>>>>
> > > > > > > > > >>>>> This is in the libcephfs code I merged
> yesterday. 
> > > Any
> > > > > > > ideas?
> > > > > > > > > >>>>>
> > > > > > > > > >>>>> Thanks!
> > > > > > > > > >>>>> sage
> > > > > > > > > >>>>>
> > > > > > > > > >>>>>
> > > > > > > > > >>>>> On Fri, 14 Feb 2014, Sandon Van Ness wrote:
> > > > > > > > > >>>>>
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>> The last couple builds of master have been
> failing
> > > on
> > > > > the
> > > > > > > > > >> centos
> > > > > > > > > >>>>> gitbuilder.
> > > > > > > > > >>>>>> here is the build log:
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>
> > > > > > > > > >>>>
> > > > > > > > > >>
> > > > > > > > >
> > > > > > >
> > > > >
> > >
> http://gitbuilder.sepia.ceph.com/gitbuilder-centos6-amd64/log.cgi?log=f47062d8a66b94743888aaea13e0766579379395
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>> Its running into:
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>> CXX mds/Capability.lo
> > > > > > > > > >>>>>> CXX mds/Dumper.lo
> > > > > > > > > >>>>>> In file included from client/Client.h:38,
> > > > > > > > > >>>>>> from libcephfs.cc:21:
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>>       error: client/barrier.h:25:38:
> > > > > > > > > >> boost/icl/interval_set.hpp:
> > > > > > > > > >>>> No
> > > > > > > > > >>>>> such
> > > > > > > > > >>>>>>       file or directory
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>> It looks like its not effecting fedora
> gitbuilders
> > > > > that
> > > > > > > have
> > > > > > > > > >> a
> > > > > > > > > >>>> newer
> > > > > > > > > >>>>> version
> > > > > > > > > >>>>>> of boost but on centos/rhel the version is
> only
> > > > > 1.41.0-18.
> > > > > > > Is
> > > > > > > > > >>>> there
> > > > > > > > > >>>>> something
> > > > > > > > > >>>>>> we can do to get around this without
> back-porting
> > > or
> > > > > will
> > > > > > > > > >>>>> backporting a newer
> > > > > > > > > >>>>>> boost for rhel/centos be necessary?
> > > > > > > > > >>>>>> --
> > > > > > > > > >>>>>> To unsubscribe from this list: send the line
> > > > > "unsubscribe
> > > > > > > > > >>>>> ceph-devel" in
> > > > > > > > > >>>>>> the body of a message to
> majordomo@vger.kernel.org
> > > > > > > > > >>>>>> More majordomo info at
> > > > > > > > > >>>> http://vger.kernel.org/majordomo-info.html
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>
> > > > > > > > > >>>> --
> > > > > > > > > >>>> Matt Benjamin
> > > > > > > > > >>>> The Linux Box
> > > > > > > > > >>>> 206 South Fifth Ave. Suite 150
> > > > > > > > > >>>> Ann Arbor, MI  48104
> > > > > > > > > >>>>
> > > > > > > > > >>>> http://linuxbox.com
> > > > > > > > > >>>>
> > > > > > > > > >>>> tel.  734-761-4689
> > > > > > > > > >>>> fax.  734-769-8938
> > > > > > > > > >>>> cel.  734-216-5309
> > > > > > > > > >>>> --
> > > > > > > > > >>>> To unsubscribe from this list: send the line
> > > > > "unsubscribe
> > > > > > > > > >> ceph-devel"
> > > > > > > > > >>>> in
> > > > > > > > > >>>> the body of a message to
> majordomo@vger.kernel.org
> > > > > > > > > >>>> More majordomo info at
> > > > > > > > > >> http://vger.kernel.org/majordomo-info.html
> > > > > > > > > >>>
> > > > > > > > > >>> --
> > > > > > > > > >>> Matt Benjamin
> > > > > > > > > >>> The Linux Box
> > > > > > > > > >>> 206 South Fifth Ave. Suite 150
> > > > > > > > > >>> Ann Arbor, MI  48104
> > > > > > > > > >>>
> > > > > > > > > >>> http://linuxbox.com
> > > > > > > > > >>>
> > > > > > > > > >>> tel.  734-761-4689
> > > > > > > > > >>> fax.  734-769-8938
> > > > > > > > > >>> cel.  734-216-5309
> > > > > > > > > >>>
> > > > > > > > > >>>
> > > > > > > > > >
> > > > > > > > > 
> > > > > > > > > --
> > > > > > > > > To unsubscribe from this list: send the line
> "unsubscribe
> > > > > > > ceph-devel"
> > > > > > > > > in
> > > > > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > > > > More majordomo info at 
> > > > > > > http://vger.kernel.org/majordomo-info.html
> > > > > > > > 
> > > > > > > > -- 
> > > > > > > > Matt Benjamin
> > > > > > > > The Linux Box
> > > > > > > > 206 South Fifth Ave. Suite 150
> > > > > > > > Ann Arbor, MI  48104
> > > > > > > > 
> > > > > > > > http://linuxbox.com
> > > > > > > > 
> > > > > > > > tel.  734-761-4689 
> > > > > > > > fax.  734-769-8938 
> > > > > > > > cel.  734-216-5309 
> > > > > > > > 
> > > > > > > >
> > > > > > 
> > > > > > -- 
> > > > > > Matt Benjamin
> > > > > > The Linux Box
> > > > > > 206 South Fifth Ave. Suite 150
> > > > > > Ann Arbor, MI  48104
> > > > > > 
> > > > > > http://linuxbox.com
> > > > > > 
> > > > > > tel.  734-761-4689 
> > > > > > fax.  734-769-8938 
> > > > > > cel.  734-216-5309 
> > > > > > 
> > > > > >
> > > > 
> > > > -- 
> > > > Matt Benjamin
> > > > The Linux Box
> > > > 206 South Fifth Ave. Suite 150
> > > > Ann Arbor, MI  48104
> > > > 
> > > > http://linuxbox.com
> > > > 
> > > > tel.  734-761-4689 
> > > > fax.  734-769-8938 
> > > > cel.  734-216-5309 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > > > 
> > > >
> > 
> > -- 
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> > 
> > http://linuxbox.com
> > 
> > tel.  734-761-4689 
> > fax.  734-769-8938 
> > cel.  734-216-5309 
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> >

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
