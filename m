From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Persistent Write Back Cache
Date: Wed, 4 Mar 2015 08:33:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503040826450.18660@cobra.newdream.net>
References: <48f4882a.9Ro.9Gf.20.ePXs4G@mailjet.com>
	<20150304174011.3279132e@batzmaru.gol.ad.jp>
	<63f84f7b.9Ro.9Gf.1J.ePZrwr@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <63f84f7b.9Ro.9Gf.1J.ePZrwr-ImYt9qTNe79BDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Nick, Christian,

This is something we've discussed a bit but hasn't made it to the top of 
the list.

I think having a single persistent copy on the client has *some* value, 
although it's limited because its a single point of failure.  The simplest 
scenario would be to use it as a write-through cache that accellerates 
reads only.

Another option would be to have a shared but local device (like an SSD 
that is connected to a pair of client hosts, or has fast access within a 
rack--a scenario that I've heard a few vendors talk about).  It 
still leaves a host pair or rack as a failure zone, but there are 
times where that's appropriate.

In either case, though, I think the key RBD feature that would make it 
much more valuable would be if RBD (librbd presumably) could maintain the 
writeback cache with some sort of checkpoints or journal internally such 
that writes that get flushed back to the cluster are always *crash 
consistent*.  So even if you lose the client cache entirely, your disk 
image is still holding a valid file system that looks like it is just a 
little bit stale.

If the client-side writeback cache were structured as a data journal this 
would be pretty staightforward...  it might even mesh well with the RBD 
mirroring?

sage



On Wed, 4 Mar 2015, Nick Fisk wrote:

> Hi Christian,
> 
> Yes that's correct, it's on the client side. I don't see this much different
> to a battery backed Raid controller, if you lose power, the data is in the
> cache until power resumes when it is flushed.
> 
> If you are going to have the same RBD accessed by multiple servers/clients
> then you need to make sure the SSD is accessible to both (eg DRBD / Dual
> Port SAS). But then something like pacemaker would be responsible for
> ensuring the RBD and cache device are both present before allowing client
> access.
> 
> When I wrote this I was thinking more about 2 HA iSCSI servers with RBD's,
> however I can understand that this feature would prove more of a challenge
> if you are using Qemu and RBD.
> 
> Nick
> 
> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of
> Christian Balzer
> Sent: 04 March 2015 08:40
> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Cc: Nick Fisk
> Subject: Re: [ceph-users] Persistent Write Back Cache
> 
> 
> Hello,
> 
> If I understand you correctly, you're talking about the rbd cache on the
> client side.
> 
> So assume that host or the cache SSD on if fail terminally.
> The client thinks its sync'ed are on the permanent storage (the actual ceph
> storage cluster), while they are only present locally. 
> 
> So restarting that service or VM on a different host now has to deal with
> likely crippling data corruption.
> 
> Regards,
> 
> Christian
> 
> On Wed, 4 Mar 2015 08:26:52 -0000 Nick Fisk wrote:
> 
> > Hi All,
> > 
> >  
> > 
> > Is there anything in the pipeline to add the ability to write the 
> > librbd cache to ssd so that it can safely ignore sync requests? I have 
> > seen a thread a few years back where Sage was discussing something 
> > similar, but I can't find anything more recent discussing it.
> > 
> >  
> > 
> > I've been running lots of tests on our new cluster, buffered/parallel 
> > performance is amazing (40K Read 10K write iops), very impressed. 
> > However sync writes are actually quite disappointing.
> > 
> >  
> > 
> > Running fio with 128k block size and depth=1, normally only gives me 
> > about 300iops or 30MB/s. I'm seeing 2-3ms latency writing to SSD OSD's 
> > and from what I hear that's about normal, so I don't think I have a 
> > ceph config problem. For applications which do a lot of sync's, like 
> > ESXi over iSCSI or SQL databases, this has a major performance impact.
> > 
> >  
> > 
> > Traditional storage arrays work around this problem by having a 
> > battery backed cache which has latency 10-100 times less than what you 
> > can currently achieve with Ceph and an SSD . Whilst librbd does have a 
> > writeback cache, from what I understand it will not cache syncs and so 
> > in my usage case, it effectively acts like a write through cache.
> > 
> >  
> > 
> > To illustrate the difference a proper write back cache can make, I put 
> > a 1GB (512mb dirty threshold) flashcache in front of my RBD and 
> > tweaked the flush parameters to flush dirty blocks at a large queue 
> > depth. The same fio test (128k iodepth=1) now runs at 120MB/s and is 
> > limited by the performance of SSD used by flashcache, as everything is 
> > stored as 4k blocks on the ssd. In fact since everything is stored as 
> > 4k blocks, pretty much all IO sizes are accelerated to max speed of the
> SSD.
> > Looking at iostat I can see all the IO's are getting coalesced into 
> > nice large 512kb IO's at a high queue depth, which Ceph easily swallows.
> > 
> >  
> > 
> > If librbd could support writing its cache out to SSD it would 
> > hopefully achieve the same level of performance and having it 
> > integrated would be really neat.
> > 
> >  
> > 
> > Nick
> > 
> > 
> > 
> > 
> 
> 
> -- 
> Christian Balzer        Network/Systems Engineer                
> chibi-FW+hd8ioUD0@public.gmane.org   	Global OnLine Japan/Fusion Communications
> http://www.gol.com/
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
> 
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
