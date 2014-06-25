From: Sage Weil <sage@redhat.com>
Subject: Re: Reliability metrics in ceph-tools
Date: Tue, 24 Jun 2014 21:37:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406241816060.17707@cobra.newdream.net>
References: <CACUN8h1G4Fy-vk6D0Pu6VFa3VJSr_5bEWpX+R-E3vWE=8xYauQ@mail.gmail.com> <CAFMfnwrcccX5+NUxB0f8ervCOSNQZ3Yo6HhKXXD08nueTTUf1w@mail.gmail.com> <CACUN8h2gbDYJbQpeHX-jgAEF-ggRDCmVCFNrdv1ajz9mmu_-kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53478 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbaFYEh2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 00:37:28 -0400
In-Reply-To: <CACUN8h2gbDYJbQpeHX-jgAEF-ggRDCmVCFNrdv1ajz9mmu_-kw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: Kyle Bader <kyle.bader@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

On Wed, 25 Jun 2014, Koleos Fuscus wrote:
> Hi,
> 
> > recovery. The actual configuration parameters that people tend to
> > adjust depending on their cluster configuration are:
> > osd recovery op priority
> 
> Simple question, priority 1 is the highest in this context?

Actually higher is better. It's only meaningful relative to 'osd client op 
priority'.

> > osd max backfills
> > osd recovery max active
> > osd recovery threads
> >
> > You can read a little bit about them here:
> >
> > https://ceph.com/docs/master/rados/configuration/osd-config-ref/
> 
> Actually, this page talks about recovery when the OSD crashes and
> restarts again. In that case, the data is not lost, but some may be
> outdated. In a way, we can say that  partial data is missing. I assume
> that updating data is equivalent to repairing (recode) data?

Yes, in that the updated object is copied in its entirely, just like a 
missing object.

> The estimation of data to be updated can be proportional to the time 
> that the OSD was gone and the write ratio to mutable data?

Correct, although may be skewed a bit by the fact that you can send a 
small write that mutates a large object and triggers a full object 
recovery.  If you simplify things to workloads that write only full 
objects, though, then yes.

> Does it have sense at all to consider that kind of recovery in a cold 
> storage tier? The page does not say anything regarding recovery when OSD 
> crashes and never starts again. I understand that such kind of recovery 
> is trigger when the primary OSD does scrubbing. I think this is the only 
> type of recovery we are interested. Are the above configuration 
> parameters applicable to this case too?

If the OSD stays down long enough (minutes to hours, depending on what the 
write frequency is) the OSD needs to walk the objects in the degraded PGs 
to find which objects are changed or missing (vs brief periods where we 
have an in-memory list of exactly what is missing/stale).  That's hard to 
model in the down-for-a-while case, but in the more common replace-a-disk 
case where the target has no data, the recovery cost is going to be 
proportional to (some small constant multipled by) the object count.  I 
think if we want to accurately model that aspect the recovery time for 
each object will be something like A + B*size, and A would include both 
some of the communication overhead and the enumeration cost.  That's 
probably too much detail for this point in time, though.

> > Any improvement that makes the model more realistic would be a great
> > contribution. A good first pass might be adding a configuration
> > setting that is be populated by the operator with osd_max_backfills
> > multiplied by the number of osds per host. This way you can divide the
> > restore bandwidth by the number of current restorations to get a per
> > placement group restoration rate. I'm not sure how best to track
> > placement groups that are waiting for a recovery slot.
> 
> Backfilling is a special type of recovery, I was not aware until today...
> Is there any diagram to help understand the transitions between the pg
> states specified in
> http://ceph.com/docs/master/rados/operations/pg-states/ ? That would
> be great to understand the behavior, if not I will try to do one.

A detailed state diagram would be nice, but most of the PG states are 
probably not relevant for this. It is probably simpler to understand the 
way PGs are layed out and recover in a general sense and model in its 
simplest form.

> >> 3) The above formula doesn't say anything about the replication
> >> latency, the cost of encoding, etc. For the case of erasure, such
> >> values are significant. Furthermore, repairing means read k chunks and
> >> store again k+m chunks. What happen with previous chunks that are
> >> still available? Only the missing chunk is replaced? I wonder how to
> >> adapt the previous formula with the k and m.   I add the factor 2
> >> because the k chunks how to be fetch from somewhere else to do the
> >> re-coding and then k+m chunks have to be stored again.
> >> seconds = float(self.disk.size * self.full *(2k+m)) / (speed * self.pgs) ??
> >
> > I'm curious how significant of a difference this would make, I'd be
> > interested in seeing some rough tests of encoding and decoding. With
> > the test data you could probably extrapolate the results and get a
> > rough idea of the impact it would have on recovery time.
> 
> But is my initial though correct? Repairing in erasure coding is much 
> more expensive than in replication. In the first one, the primary OSD 
> needs to fetch k blocks and generate k+m blocks and upload only the 
> missing blocks. Maybe, some simple assumption is assuming that the 
> recovery rate (speed) for erasure coding is much slower and use the same 
> formula as replication. How much slower is not clear yet. Loic did some 
> benchmarks and publish them in http://dachary.org/?p=2594: Recovering 
> the loss of one OSD: 10GB/s Recovering the loss of two OSD: 3.2GB/s But 
> this is cpu related and not networking and that actually baffles me. 
> Maybe Loic can help me to understand this benchmarks. if you did erasure 
> code (k=6,m=2) and you are not considering the network, why you get 
> different recovery ratio? I understand that repairing is a dummy process 
> and you have to regenerate all 6+2 blocks always to repair the loss of 1 
> or 2 OSD. Do you have some improve library where you can indicate the 
> erasures?

I'll leave this one for Loic :).  I assumed that the encoding 
process would take the k data blocks and always produce k coding 
blocks (and then you'd write whichever ones are missing), but I'm not very 
familiar.

> >> 4) Declustering: I am not sure if I understand how it works. From the
> >> reliability model "The number of OSDs read-from and written-to is
> >> assumed to be equal to the
> >> specified declustering factor, with each of those transfers happening
> >> at the specified recovery speed."  I also read sth written by Sage in
> >> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg01650.html
> >> But I am confused. Not clear for me how to use self.pgs (in the
> >> context of the tool) and k&m in the formula above.

At the risk of restating the basics, the basic placement process is:

1. object name is hashed to a 32-bit value
2. the bottom N bits of that value determine which pg the object belongs 
   to (i.e., hash(name) % pg_num when pg_num is a power of 2)
3. each pg is mapped to N random osds (separated across hosts, racks, or 
   whatever)

For replication, pg_num * num_rep / num_osds = ~90 PGs (if num_rep==3). I 
think this (either 90 or 30) is what the model is calling the declustering 
factor.

For EC, instead of num_rep we have k+m which is usually quite a bit 
higher.  We probably want to aim for a similar number of PGs per node (and 
similar number of peers), which means that pg_num will probably be set to 
a lower value.

sage
