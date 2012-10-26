From: Sage Weil <sage@inktank.com>
Subject: Re: osd_pool_default_size
Date: Fri, 26 Oct 2012 09:18:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210260915491.23524@cobra.newdream.net>
References: <CAOLwVUkvCQm-_UF=OsykCfw+CH7CPxBaXZrwDtH19M-T5EPrgg@mail.gmail.com> <508A92F0.7040007@widodh.nl> <CAOLwVUmR_WcXHeDZJp88eaeZt=TTbOCqk4h-kYNTZ2zrSuskgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42300 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965226Ab2JZQSp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 12:18:45 -0400
In-Reply-To: <CAOLwVUmR_WcXHeDZJp88eaeZt=TTbOCqk4h-kYNTZ2zrSuskgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 26 Oct 2012, S?bastien Han wrote:
> > It's the monitor who is preparing the new pool before creating it. I had a
> > discussion regarding this with Greg some time ago, can't re-call if this was
> > on IRC or the ml though.
> 
> Well actually I think I was in the conversation and it was on IRC, but
> I had completely forget about it. -_-
> 
> Thanks the clarification. It may sound weird but if the monitors
> handles the pool creation, it makes sense.
> 
> Now I'm surprised to see that the admin socket has a different value.

The admin socket on the monitor?  Keep in mind that the actual creation is 
coordinated by the lead monitor... 'ceph quorum_status' will tell you 
who that is (the first one listed who is in the quorum).  *that's* the one 
who's config value for 'osd pool default size' matters.

> Moreover after changing the configuration and set the default size to
> 2 and restarted every OSD. It looks like the cluster continue to
> create a pool size of 3...

OSDs are not involved; no need to touch their config or restart them.

> Could be a bug then, any idea?

If you can confirm that the monitor who did the creation created a pool of 
a size different that its osd default pool size, then yes... but let's 
confirm that!

In any case, it's no big deal to change it after the pool is created:

	ceph osd pool set <poolname> size <num replicas>

sage


> 
> On Fri, Oct 26, 2012 at 3:41 PM, Wido den Hollander <wido@widodh.nl> wrote:
> > On 10/26/2012 10:17 AM, S?bastien Han wrote:
> >>
> >> Hi Cephers!
> >>
> >> Some question about this parameter:
> >>
> >> - Why does this parameter need to be in the [mon] section to work?
> >
> >
> > It's the monitor who is preparing the new pool before creating it. I had a
> > discussion regarding this with Greg some time ago, can't re-call if this was
> > on IRC or the ml though.
> >
> > It however contradicts what's in the docs:
> > http://ceph.com/docs/master/config-cluster/osd-config-ref/
> >
> > The docs seem to be wrong at this point:
> >
> > * src/mon/OSDMonitor.cc *
> >
> > int OSDMonitor::prepare_new_pool(string& name, uint64_t auid, int
> > crush_rule,
> >                                  unsigned pg_num, unsigned pgp_num)
> > {
> > ..
> > ..
> >   pending_inc.new_pools[pool].size = g_conf->osd_pool_default_size;
> > ..
> > ..
> > }
> >
> > This is done by the monitor.
> >
> > There seems to be some reference for this in src/osd/OSDMap.cc, but that
> > seems to be for initializing the cluster since it creates the data, metadata
> > and rbd pool there.
> >
> > This was fixed in this commit:
> > https://github.com/ceph/ceph/commit/1292436b8f88ce203bdba97278ce368b1dfa025f
> >
> > Seems to be because of this message on the ml last year:
> > http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/2983
> >
> > So yes, it is odd that something prefixed with "osd" should go into the mon
> > section.
> >
> > Wido
> >
> >> - In my ceph.conf I set a default size of 3:
> >>
> >> # rados mkpool lol
> >> successfully created pool lol
> >>
> >> # ceph osd dump | grep lol
> >> pool 31 'lol' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 8
> >> pgp_num 8 last_change 430 owner 18446744073709551615
> >>
> >> Now if I retrieve the admin daemon I get,
> >>
> >> # ceph --admin-daemon /var/run/ceph/ceph-osd.0.asok config show | grep
> >> 'osd_pool_default_size'
> >> osd_pool_default_size = 2
> >>
> >> Why? Did I something wrong?
> >>
> >> Thanks :)
> >>
> >> Cheers!
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
