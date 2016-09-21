From: Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: cache tier on rgw index pool
Date: Wed, 21 Sep 2016 05:57:18 -0700
Message-ID: <CAN=+7FWdY6ZS_Pgx=5EDmDag60vgrZ6hcW6WMSN0=Cuftrcv-g@mail.gmail.com>
References: <CAP3mxSwSbn9YJyiffENP8nykXDzQZKBbneS83Pb5BEyRpqx0dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAP3mxSwSbn9YJyiffENP8nykXDzQZKBbneS83Pb5BEyRpqx0dA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Abhishek Varshney <abhishek.varshney-ay2nrczjKqVWk0Htik3J/w@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I seriously doubt that it's ever going to be a winning strategy to let
rgw index objects go to a cold tier.  Some practical problems:
1) We don't track omap size (the leveldb entries for an object)
because it would turn writes into rmw's -- so they always show up as 0
size.  Thus, the target_max_bytes param is going to be useless.
2) You can't store omap objects on an ec pool at all, so if the base
pool is an ec pool, nothing will ever be demoted.
3) We always promote whole objects.

As to point 2., I'm guessing that Greg meant that OSDs don't care
about each other's leveldb instances *directly* since leveldb itself
is behind two layers of interfaces (one osd might have bluestore using
rocksdb, while the other might have filestore with some other
key-value db entirely).  Of course, replication -- certainly including
the omap entries -- still happens, but at the object level rather than
at the key-value db level.
-Sam

On Wed, Sep 21, 2016 at 5:43 AM, Abhishek Varshney
<abhishek.varshney-ay2nrczjKqVWk0Htik3J/w@public.gmane.org> wrote:
> Hi,
>
> I am evaluating on setting up a cache tier for the rgw index pool and
> have a few questions regarding that. The rgw index pool is different
> as it completely stores the data in leveldb. The 'rados df' command on
> the existing index pool shows size in KB as 0 on a 1 PB cluster with
> 500 million objects running ceph 0.94.2.
>
> Seeking clarifications on the following points:
>
> 1. How are the cache tier parameters like target_max_bytes,
> cache_target_dirty_ratio and cache_target_full_ratio honoured given
> the size of index pool is shown as 0 and how does flush/eviction take
> place in this case? Is there any specific reason why the omap data is
> not reflected in the size, as Sage mentions it here [1]
>
> 2. I found a mail archive in ceph-devel where Greg mentions that
> "there's no cross-OSD LevelDB replication or communication" [2]. In
> that case,  how does ceph handle re-balancing of leveldb instance data
> in case of node failure?
>
> 3. Are there any surprises that can be expected on deploying a cache
> tier for rgw index pool ?
>
> [1] http://www.spinics.net/lists/ceph-devel/msg28635.html
> [2] http://www.spinics.net/lists/ceph-devel/msg24990.html
>
> Thanks
> Abhishek Varshney
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
