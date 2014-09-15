From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Crushmap ruleset for rack aware PG placement
Date: Mon, 15 Sep 2014 08:28:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409150826060.513@cobra.newdream.net>
References: <CADgBPFCVUVQZtHNkSsuMhskL2X-FTBTYy6zcav3CRpNCBGHJgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADgBPFCVUVQZtHNkSsuMhskL2X-FTBTYy6zcav3CRpNCBGHJgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Amit Vijairania <amit.vijairania-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "Cecil Lee -X (cecille - TEKSYSTEMS INC at Cisco)" <cecille-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Amit,

On Mon, 15 Sep 2014, Amit Vijairania wrote:
> Hello!
> 
> In a two (2) rack Ceph cluster, with 15 hosts per rack (10 OSD per
> host / 150 OSDs per rack), is it possible to create a ruleset for a
> pool such that the Primary and Secondary PGs/replicas are placed in
> one rack and Tertiary PG/replica is placed in the other rack?
> 
> root standard {
>   id -1 # do not change unnecessarily
>   # weight 734.400
>   alg straw
>   hash 0 # rjenkins1
>   item rack1 weight 367.200
>   item rack2 weight 367.200
> }
> 
> Given there are only two (2) buckets, but three (3) replica, is it
> even possible?

Yes:

rule myrule {
	ruleset 1
	type replicated
	min_size 1
	max_size 10
	step take default
	step choose firstn 2 type rack
	step chooseleaf firstn 2 type host
	step emit
}

That will give you 4 osds, spread across 2 hosts in each rack.  The pool 
size (replication factor) is 3, so RADOS will just use the first three (2 
hosts in first rack, 1 host in second rack).

sage




> I think following Giant blueprint is trying to address scenario I
> described above.. Is the following blueprint targeted for Giant
> release?
> http://wiki.ceph.com/Planning/Blueprints/Giant/crush_extension_for_more_flexible_object_placement
> 
> 
> Regards,
> Amit Vijairania  |  Cisco Systems, Inc.
> --*--
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
