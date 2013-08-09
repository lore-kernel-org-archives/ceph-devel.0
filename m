From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: Re: cephfs set_layout
Date: Fri, 9 Aug 2013 15:19:37 +0200
Message-ID: <20130809131937.GC27330@oder.mch.fsc.net>
References: <20130809074457.GA27330@oder.mch.fsc.net>
 <20130809090350.GB27330@oder.mch.fsc.net>
 <CAAM7YA=G=upWHPjsq+0WRjwyG88h9MPVRvU4qxSzj5ndPWwdjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:35079 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967097Ab3HINTj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 09:19:39 -0400
Content-Disposition: inline
In-Reply-To: <CAAM7YA=G=upWHPjsq+0WRjwyG88h9MPVRvU4qxSzj5ndPWwdjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 09, 2013 at 03:06:37PM +0200, Yan, Zheng wrote:
> On Fri, Aug 9, 2013 at 5:03 PM, Kasper Dieter
> <dieter.kasper@ts.fujitsu.com> wrote:
> > OK,
> > I found this nice page: http://ceph.com/docs/next/dev/file-striping/
> > which explains "--stripe_unit --stripe_count --object_size"
> >
> > But still I'm not sure about
> > (1) what is the equivalent command on cephfs to 'rbd create --order 16' ?
> 
> you can get/set file layout through virtual xattr. for example:
> 
> # getfattr -d -m - targetfile
> 
> > (2) how to use those parameters to achieve different optimized layouts on CephFS directories
> >     (e.g. for streaming, small sequential IOs, small random IOs)
> >
> 
> ceph directories are not implemented as files. you can't optimize ceph
> directories by this way.

In my view 'Directories' in CephFS are similar to 'Volumes' in RBD.

With 'rbd create --order 16 new-volume' I can assign an object size to a volume.
With 'cephfs directory set_layout ...'  I can set similar parameters to a directory:

# mkdir /mnt/cephfs/test-dir
# cephfs /mnt/cephfs/test-dir show_layout
layout not specified

# cephfs /mnt/cephfs/test-dir set_layout -p 3 -s 4194304 -u 4194304 -c 1
# cephfs /mnt/cephfs/test-dir show_layout
layout.data_pool:     3
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1

# echo asd > /mnt/cephfs/test-dir/test-file
# cephfs /mnt/cephfs/test-dir/test-file show_layout
layout.data_pool:     3
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1

The set_layout attribute of a DIR will be inherit to the FILES below.

My question is: which combination of "--stripe_unit --stripe_count --object_size"
will be optimal for streaming, small sequential IOs, small random IOs ?
(in/below a DIR)


Best Regards,
-Dieter


> 
> Regards
> Yan, Zheng
> 
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
