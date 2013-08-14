From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: Re: cephfs set_layout - tuning
Date: Wed, 14 Aug 2013 22:38:01 +0200
Message-ID: <20130814203801.GA27534@oder.mch.fsc.net>
References: <20130809074457.GA27330@oder.mch.fsc.net>
 <20130809090350.GB27330@oder.mch.fsc.net>
 <CAPYLRzj2bisxFcATOt66tCfr5jnUU3eZ23kDiDA0sN_+50Am+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:43840 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760255Ab3HNUiO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 16:38:14 -0400
Content-Disposition: inline
In-Reply-To: <CAPYLRzj2bisxFcATOt66tCfr5jnUU3eZ23kDiDA0sN_+50Am+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 14, 2013 at 10:17:24PM +0200, Gregory Farnum wrote:
> On Fri, Aug 9, 2013 at 2:03 AM, Kasper Dieter
> <dieter.kasper@ts.fujitsu.com> wrote:
> > OK,
> > I found this nice page: http://ceph.com/docs/next/dev/file-striping/
> > which explains "--stripe_unit --stripe_count --object_size"
> >
> > But still I'm not sure about
> > (1) what is the equivalent command on cephfs to 'rbd create --order 16' ?
> 
> There's not a direct one; CephFS lets you specify arbitrary sizes
> (--stripe-unit) while rbd restricts you to powers of two. If you want
> a new file to use a 64KB object size you can just set the object_size
> to be 64KB.
> 
> > (2) how to use those parameters to achieve different optimized layouts on CephFS directories
> >     (e.g. for streaming, small sequential IOs, small random IOs)
> 
> If (as Yan suspects) you mean specifying how the directory is laid out
> on disk, you can't ? CephFS directories aren't maintained that way and
> it wouldn't make any sense. If you're talking about making all the
> files underneath it use a new layout, you can specify a directory
> layout which is applied to all new descendent files the same way as
> you specify the layout on an individual file.
Thank you Greg,

my question was which parameters of "--stripe_unit --stripe_count --object_size"
would be optimal for new descendent files under directories
/mnt/cephfs/streaming
/mnt/cephfs/seq-IOs
/mnt/cephfs/rand-IOs

e.g. 
cephfs /mnt/cephfs/streaming set_layout -p 3 -s 4194304 -u 4194304 -c 1
cephfs /mnt/cephfs/seq-IOs   set_layout -p 3 -s 4194304 -u   65536 -c 8
cephfs /mnt/cephfs/rand-IOs  set_layout -p 3 -s   65536 -u   65536 -c 1

-Dieter

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> 
> >
> > -Dieter
> >
> > On Fri, Aug 09, 2013 at 09:44:57AM +0200, Kasper Dieter wrote:
> >> Hi,
> >>
> >> my goal is to set the 'object size' used in the distribution inside rados
> >> in an equal (or similar) way between RBD and CephFS.
> >>
> >> To set obj_size=64k in RBD I use the command:
> >> rbd create --size 1024000 --pool SSD-r2 ssd2-1T-64k --order 16
> >>
> >> On cephfs set_layout '-s 65536' runs into EINVAL:
> >> cephfs /mnt/cephfs/fio-64k/ set_layout -p 3 -s   65536 -u 4194304 -c 1
> >> Error setting layout: Invalid argument
> >>
> >> cephfs /mnt/cephfs/fio-64k/ set_layout -p 3 -s   65536 -u 65536 -c 1
> >> cephfs /mnt/cephfs/fio-64k/ show_layout
> >> layout.data_pool:     3
> >> layout.object_size:   65536
> >> layout.stripe_unit:   65536
> >> layout.stripe_count:  1
> >>
> >> The man page of cephfs says
> >> ---snip---
> >>        -u --stripe_unit
> >>               Set the size of each stripe
> >>
> >>        -c --stripe_count
> >>               Set the number of objects to stripe across
> >>
> >>        -s --object_size
> >>               Set the size of the objects to stripe across
> >> ---snip---
> >>
> >> What is the equivalent command on cephfs to 'rbd create --order 16' ?
> >> Can you please give same explanation how "--stripe_unit --stripe_count --object_size"
> >> should be used in combination to achieve different layouts on CephFS directories
> >> (e.g. optimized for streaming, small sequential IOs, small random IOs)
> >> ?
> >>
> >> Thanks,
> >> -Dieter
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
