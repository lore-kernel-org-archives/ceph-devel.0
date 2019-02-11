From: Philippe Van Hecke <Philippe.VanHecke-58DTJjpCniqzQB+pC5nmwQ@public.gmane.org>
Subject: Re: Luminous cluster in very bad state need some
 assistance.
Date: Mon, 11 Feb 2019 06:19:34 +0000
Message-ID: <1549865974477.33670@belnet.be>
References: <d8faa6e9eaf146cb952a3dadba5c5343@EXCHLOU1.ad.fw.belnet.be>,
 <alpine.DEB.2.11.1902031716470.4436@piezo.novalocal>
 <1549259449109.740@belnet.be>
 <alpine.DEB.2.11.1902040556120.4436@piezo.novalocal>,
 <alpine.DEB.2.11.1902040617170.4436@piezo.novalocal>,
 <1549261672944.37241@belnet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1549261672944.37241-58DTJjpCniqzQB+pC5nmwQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi, 

Sorry for late reaction. With the help of Sage
we finally recover our cluster. 

How we have recover ? 

It seem that due to the network flaps , some pg(s) of two
of our pools was not in good state. before doing thing well
i tried many things i see in the list and manipulate pg without
using ceph-objectstore-tool. This probably didn't help us
and conduct to some lost of data.

So with the pressure to come back operational situation we decided to 
remove one of the two pools with problematics pg. This pools
was mainly used for rbd image for our internal kvm infrastructure
for which we had backup for most vm. Before removing the pool, 
we tried to extract most images as we can. Many was completly corrupt,
but for many others we were able to extract 99% of the content and a fsck
at os level let us get data.

After removed this pool there are still some pg in bad state for customer facing pool. 
The problem was that those pg(s) was blocked by osd(s) that didn't want to join again
the cluser. To solve this, we created an empty osd with weight of 0.0 

We were able to extract the pg from the faulty osd(s)
and inject them into the freshly create osd using the import / export command of 
the ceph-objectstore-tool. 

After that the cluster completly recover but with still osd(s) that didn't want to join the cluster.
But as data of those osd are not needed any more we decided that we will restart it 
from scratch.

What we learned of this experience.

- Ensure that you network is rock solid. ( ceph realy dislike very unstable network)
  avoid layer 2 internconnection between your DC. and have a flat layer2 network.
- keep calm and first let the time to the cluster to do theire job. ( can take some time)
- never manipulate pg without using ceph-objectstore-tool or you will be in trouble.
- have spare disk on some node of the cluster to be able to have empty osd to make some
  recovery.

I would like again thanks the comunity and Sage in particular to save us from 
a complete disaster.

Kr

Philippe.
________________________________________
From: Philippe Van Hecke
Sent: 04 February 2019 07:27
To: Sage Weil
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; Belnet Services; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [ceph-users] Luminous cluster in very bad state need some assistance.

Sage,

Not during the network flap or before flap , but after i had already tried the
ceph-objectstore-tool remove export with no possibility to do it.

And conf file never had the "ignore_les" option. I was even not aware of the existence of this option and seem that it preferable to forget that it inform me about it immediately :-)

Kr
Philippe.


On Mon, 4 Feb 2019, Sage Weil wrote:
> On Mon, 4 Feb 2019, Philippe Van Hecke wrote:
> > Hi Sage, First of all tanks for your help
> >
> > Please find here  https://filesender.belnet.be/?s=download&token=dea0edda-5b6a-4284-9ea1-c1fdf88b65e9

Something caused the version number on this PG to reset, from something
like 54146'56789376 to 67932'2.  Was there any operator intervention in
the cluster before or during the network flapping?  Or did someone by
chance set the (very dangerous!) ignore_les option in ceph.conf?

sage
