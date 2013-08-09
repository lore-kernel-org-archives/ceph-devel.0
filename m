From: Sage Weil <sage@inktank.com>
Subject: Re: cephfs set_layout
Date: Fri, 9 Aug 2013 08:26:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308090821540.12756@cobra.newdream.net>
References: <20130809074457.GA27330@oder.mch.fsc.net> <20130809090350.GB27330@oder.mch.fsc.net> <CAAM7YA=G=upWHPjsq+0WRjwyG88h9MPVRvU4qxSzj5ndPWwdjw@mail.gmail.com> <20130809131937.GC27330@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35298 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964963Ab3HIP0N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 11:26:13 -0400
In-Reply-To: <20130809131937.GC27330@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Dieter,

On Fri, 9 Aug 2013, Kasper Dieter wrote:
> On Fri, Aug 09, 2013 at 03:06:37PM +0200, Yan, Zheng wrote:
> > On Fri, Aug 9, 2013 at 5:03 PM, Kasper Dieter
> > <dieter.kasper@ts.fujitsu.com> wrote:
> > > OK,
> > > I found this nice page: http://ceph.com/docs/next/dev/file-striping/
> > > which explains "--stripe_unit --stripe_count --object_size"
> > >
> > > But still I'm not sure about
> > > (1) what is the equivalent command on cephfs to 'rbd create --order 16' ?
> > 
> > you can get/set file layout through virtual xattr. for example:
> > 
> > # getfattr -d -m - targetfile
> > 
> > > (2) how to use those parameters to achieve different optimized layouts on CephFS directories
> > >     (e.g. for streaming, small sequential IOs, small random IOs)
> > >
> > 
> > ceph directories are not implemented as files. you can't optimize ceph
> > directories by this way.
> 
> In my view 'Directories' in CephFS are similar to 'Volumes' in RBD.
> 
> With 'rbd create --order 16 new-volume' I can assign an object size to a volume.
> With 'cephfs directory set_layout ...'  I can set similar parameters to a directory:
> 
> # mkdir /mnt/cephfs/test-dir
> # cephfs /mnt/cephfs/test-dir show_layout
> layout not specified
> 
> # cephfs /mnt/cephfs/test-dir set_layout -p 3 -s 4194304 -u 4194304 -c 1
> # cephfs /mnt/cephfs/test-dir show_layout
> layout.data_pool:     3
> layout.object_size:   4194304
> layout.stripe_unit:   4194304
> layout.stripe_count:  1
> 
> # echo asd > /mnt/cephfs/test-dir/test-file
> # cephfs /mnt/cephfs/test-dir/test-file show_layout
> layout.data_pool:     3
> layout.object_size:   4194304
> layout.stripe_unit:   4194304
> layout.stripe_count:  1
> 
> The set_layout attribute of a DIR will be inherit to the FILES below.
> 
> My question is: which combination of "--stripe_unit --stripe_count --object_size"
> will be optimal for streaming, small sequential IOs, small random IOs ?
> (in/below a DIR)

Just setting object_size = stripe_unit = 64K will work, except that the 
final objects will be pretty small, which is not especially efficient on 
the back end.  In that case I would do something like 

 object_size = 4M
 stripe_unit = 64K
 stripe_count = 16

so that we stripe over 16 objects until they fill up and then move on to 
the next 16.  Note that you can do the same thing with RBD now too when 
you are using librbd, but the non-trivial striping is not supported by the 
kernel client.

Yan mentioned this, but I'll reiterate: using the virtual xattrs to adjust 
these parameters is generally more convenient than the cephfs tool, and 
works both with ceph-fuse and the kernel client.  See

	ceph.git/qa/workunits/misc/layout_vxattrs.sh

to see how they are used.

sage



 > > 
> Best Regards,
> -Dieter
> 
> 
> > 
> > Regards
> > Yan, Zheng
> > 
> > > -Dieter
> > >
> > > On Fri, Aug 09, 2013 at 09:44:57AM +0200, Kasper Dieter wrote:
> > >> Hi,
> > >>
> > >> my goal is to set the 'object size' used in the distribution inside rados
> > >> in an equal (or similar) way between RBD and CephFS.
> > >>
> > >> To set obj_size=64k in RBD I use the command:
> > >> rbd create --size 1024000 --pool SSD-r2 ssd2-1T-64k --order 16
> > >>
> > >> On cephfs set_layout '-s 65536' runs into EINVAL:
> > >> cephfs /mnt/cephfs/fio-64k/ set_layout -p 3 -s   65536 -u 4194304 -c 1
> > >> Error setting layout: Invalid argument
> > >>
> > >> cephfs /mnt/cephfs/fio-64k/ set_layout -p 3 -s   65536 -u 65536 -c 1
> > >> cephfs /mnt/cephfs/fio-64k/ show_layout
> > >> layout.data_pool:     3
> > >> layout.object_size:   65536
> > >> layout.stripe_unit:   65536
> > >> layout.stripe_count:  1
> > >>
> > >> The man page of cephfs says
> > >> ---snip---
> > >>        -u --stripe_unit
> > >>               Set the size of each stripe
> > >>
> > >>        -c --stripe_count
> > >>               Set the number of objects to stripe across
> > >>
> > >>        -s --object_size
> > >>               Set the size of the objects to stripe across
> > >> ---snip---
> > >>
> > >> What is the equivalent command on cephfs to 'rbd create --order 16' ?
> > >> Can you please give same explanation how "--stripe_unit --stripe_count --object_size"
> > >> should be used in combination to achieve different layouts on CephFS directories
> > >> (e.g. optimized for streaming, small sequential IOs, small random IOs)
> > >> ?
> > >>
> > >> Thanks,
> > >> -Dieter
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
