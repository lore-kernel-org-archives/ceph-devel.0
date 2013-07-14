From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: slow request problem
Date: Sun, 14 Jul 2013 17:46:32 +0200
Message-ID: <10993195-49C7-44DB-B6D2-EFF484204DB3@profihost.ag>
References: <51E00197.7010708@profihost.ag> <51E29660.4040200@profihost.ag>
	<alpine.DEB.2.00.1307140753380.25223@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1307140753380.25223-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi sage,

Am 14.07.2013 um 17:01 schrieb Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:

> On Sun, 14 Jul 2013, Stefan Priebe wrote:
>> Hello list,
>> 
>> might this be a problem due to having too much PGs? I've 370 per OSD instead
>> of having 33 / OSD (OSDs*100/3).
> 
> That might exacerbate it.
> 
> Can you try setting
> 
> osd min pg log entries = 50
> osd max pg log entries = 100

What does that exactly do? And why is a restart of all osds needed. Thanks!

> across your cluster, restarting your osds, and see if that makes a 
> difference?  I'm wondering if this is a problem with pg log rewrites after 
> peering.  Note that adding that option and restarting isn't enough to 
> trigger the trim; you have to hit the cluster with some IO too, and (if 
> this is the source of your problem) the trim itself might be expensive.  
> So add it, restart, do a bunch of io (to all pools/pgs if you can), and 
> then see if the problem is still present?

Will try can't produce a write to every pg. it's a prod. Cluster with KVM rbd. But it has 800-1200 iop/s per second. 

> 
> Also note that the lower osd min pg log entries means that the osd cannot 
> be down as long without requiring a backfill (50 ios per pg).  These 
> probably aren't the values that we want, but I'd like to find out whether 
> the pg log rewrites after peering in cuttlefish are the culprit here.


> 
> Thanks!
> 
>> Is there any plan for PG merging?
> 
> Not right now.  :(  I'll talk to Sam, though, to see how difficult it 
> would be given the split approach we settled on.
> 
> Thanks!
> sage
> 
> 
>> 
>> Stefan
>>> Hello list,
>>> 
>>> anyone else here who always has problems bringing back an offline OSD?
>>> Since cuttlefish i'm seeing slow requests for the first 2-5 minutes
>>> after bringing an OSD oinline again but that's so long that the VMs
>>> crash as they think their disk is offline...
>>> 
>>> Under bobtail i never had any problems with that.
>>> 
>>> Please HELP!
>>> 
>>> Greets,
>>> Stefan
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> 
>> 
