From: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Ceph QoS user stories
Date: Fri, 2 Dec 2016 22:03:10 -0000
Message-ID: <a26d7ff6.AEAAGOycGBoAAAAAAAAAAFAs4MYAADNJBWwAAAAAAACRXwBYQe-g@mailjet.com>
References: <alpine.DEB.2.11.1612021847590.22800@piezo.novalocal>
Reply-To: nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1612021847590.22800-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
Content-Language: en-gb
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Sage Weil' <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Sage Weil
> Sent: 02 December 2016 19:02
> To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
> Subject: [ceph-users] Ceph QoS user stories
> 
> Hi all,
> 
> We're working on getting infrasture into RADOS to allow for proper distributed quality-of-service guarantees.  The work is based
on
> the mclock paper published in OSDI'10
> 
> 	https://www.usenix.org/legacy/event/osdi10/tech/full_papers/Gulati.pdf
> 
> There are a few ways this can be applied:
> 
>  - We can use mclock simply as a better way to prioritize background activity (scrub, snap trimming, recovery, rebalancing)
against
> client IO.
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS or proportional priority/weight) on RADOS pools
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS) for individual clients.
> 
> Once the rados capabilities are in place, there will be a significant amount of effort needed to get all of the APIs in place to
configure
> and set policy.  In order to make sure we build somethign that makes sense, I'd like to collection a set of user stores that we'd
like to
> support so that we can make sure we capture everything (or at least the important things).
> 
> Please add any use-cases that are important to you to this pad:
> 
> 	http://pad.ceph.com/p/qos-user-stories
> 
> or as a follow-up to this email.
> 
> mClock works in terms of a minimum allocation (of IOPS or bandwidth; they are sort of reduced into a single unit of work), a
maximum
> (i.e. simple cap), and a proportional weighting (to allocation any additional capacity after the minimum allocations are
satisfied).  It's
> somewhat flexible in terms of how we apply it to specific clients, classes of clients, or types of work (e.g., recovery).  How we
put it all
> together really depends on what kinds of things we need to accomplish (e.g., do we need to support a guaranteed level of service
> shared across a specific set of N different clients, or only individual clients?).
> 
> Thanks!
> sage
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

Hi Sage,

You mention IOPs and Bandwidth but would this be applicable to latency as well? Some client operations (buffered IO) can hit several
hundered iops with terrible latency if queue depth is high enough. When the intended requirement might have been to have a more
responsive application.

Would it be possible to apply some sort of shares system to the minimum allocation. Ie, in the event not all allocations can be met,
will it gracefully try to balance available resources or will it completely starve some clients. Maybe partial loss of cluster has
caused performance drop, or user has set read latency to 1ms on a disk based cluster. Is this a tuneable parameter, deadline vs
shares....etc

I can think of a number of scenarios where QOS may help and how it might be applied. Hope they are of some use.

1. Min iop/bandwith/latency for important vm. Probably settable on a per RBD basis. Can maybe have an inheritable default from Rados
pool, or customised to allow to offer bronze/silver/gold service levels.

2. Max iop/bandwith to limit noisy clients, but with option for over allocation if free resources available

3. Min Bandwidth for streaming to tape. Again set per RBD or RBD snapshot. Would help filter out the impact of clients emptying
their buffered writes, as small drops in performance massively effect continuous streaming of tape.

4. Ability to QOS either reads or writes. Eg SQL DB's will benefit from fast consistent sync write latency. But actual write
throughput is fairly small and coalesces well. Being able to make sure all writes jump to front of queue would ensure good
performance.

5. If size < min_size I want recovery to take very high priority as ops might be blocked

6. There probably needs to be some sort of reporting to go along with this to be able to see which targets are being missed/met. I
guess this needs some sort or "ceph top" or "rbd top" before it can be implemented?

7. Currently a RBD with a snapshot can overload a cluster if you do lots of small random writes to the parent. COW causes massive
write amplification. If QOS was set on the parent, how are these COW writes taken into account?
