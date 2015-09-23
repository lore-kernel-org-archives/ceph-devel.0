From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: ceph-mon always election when change crushmap in
	firefly
Date: Wed, 23 Sep 2015 05:34:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509230531150.11876@cobra.newdream.net>
References: <CAA4r=YCZ+7jekicx6NqJ-+bzAcniMReMrLL-dYafCtrPGixpMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAA4r=YCZ+7jekicx6NqJ-+bzAcniMReMrLL-dYafCtrPGixpMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexander Yang <yangwanyuan8861-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 23 Sep 2015, Alexander Yang wrote:
> hello,
>         We use Ceph+Openstack in our private cloud. In our cluster, we have
> 5 mons and 800 osds, the Capacity is about 1Pb. And run about 700 vms and
> 1100 volumes,
>         recently, we increase our pg_num , now the cluster have about 70000
> pgs. In my real intention? I want every osd have 100pgs. but after increase
> pg_num, I find I'm wrong. Because the different crush weight for different
> osd, the osd's pg_num is different, some osd have exceed  500pgs.
>         Now, the problem is  appear?cause some reason when i want to change
> some osd  weight, that means change the crushmap.  This change cause about
> 0.03% data to migrate. the mon is always begin to election. It's will hung
> the cluster, and when they end, the  original  leader still is the new
> leader. And during the mon eclection?On the upper layer, vm have too many
> slow request will appear. so now i dare to do any operation about change
> crushmap. But i worry about an important thing, If  when our cluster  down
>  one host even down one rack.   By the time, the cluster curshmap will
> change large, and the migrate data also large. I worry the cluster will
> hung  long time. and result on upper layer, all vm became to  shutdown.
>         In my opinion, I guess when I change the crushmap,* the leader mon
> maybe calculate the too many information*, or* too many client want to get
> the new crushmap from leader mon*.  It must be hung the mon thread, so the
> leader mon can't heatbeat to other mons, the other mons think the leader is
> down then begin the new election.  I am sorry if i guess is wrong.
>         The crushmap in accessory. So who can give me some advice or guide,
> Thanks very much!

There were huge improvements made in hammer in terms of mon efficiency in 
these cases where it is under load.  I recommend upgrading as that will 
help.

You can also mitigate the problem somewhat by adjusting the mon_lease and 
associated settings up.  Scale all of mon_lease, mon_lease_renew_interval, 
mon_lease_ack_timeout, mon_accept_timeout by 2x or 3x.

It also sounds like you may be using some older tunables/settings 
for your pools or crush rules.  Can you attach the output of 'ceph osd 
dump' and 'ceph osd crush dump | tail -n 20' ?

sage
