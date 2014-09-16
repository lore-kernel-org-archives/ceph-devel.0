From: Daniel Swarbrick <daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: Crushmap ruleset for rack aware PG placement
Date: Tue, 16 Sep 2014 12:02:36 +0200
Message-ID: <lv91s9$4j2$1@ger.gmane.org>
References: <CADgBPFCVUVQZtHNkSsuMhskL2X-FTBTYy6zcav3CRpNCBGHJgg@mail.gmail.com>
	<alpine.DEB.2.00.1409150826060.513@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1409150826060.513-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 15/09/14 17:28, Sage Weil wrote:
>
> rule myrule {
> 	ruleset 1
> 	type replicated
> 	min_size 1
> 	max_size 10
> 	step take default
> 	step choose firstn 2 type rack
> 	step chooseleaf firstn 2 type host
> 	step emit
> }
>
> That will give you 4 osds, spread across 2 hosts in each rack.  The pool 
> size (replication factor) is 3, so RADOS will just use the first three (2 
> hosts in first rack, 1 host in second rack).

I have a similar requirement, where we currently have four nodes, two in
each fire zone, with pool size 3. At the moment, due to the number of
nodes, we are guaranteed at least one replica in each fire zone (which
we represent with bucket type "room"). If we add more nodes in future,
the current ruleset may cause all three replicas of a PG to land in a
single zone.

I tried the ruleset suggested above (replacing "rack" with "room"), but
when testing it with crushtool --test --show-utilization, I simply get
segfaults. No amount of fiddling around seems to make it work - even
adding two new hypothetical nodes to the crushmap doesn't help.

What could I perhaps be doing wrong?
