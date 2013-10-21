From: Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Mon, 21 Oct 2013 14:27:18 -0400
Message-ID: <20131021182717.GB29416@redhat.com>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
	<alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>
	<20131017151828.GB28859@redhat.com>
	<CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>
	<alpine.DEB.2.00.1310181657151.19763@cobra.newdream.net>
	<CAE63xUO4ZrzObMFeQ=FXGFnqpwWsjCiiDr2_VhOt91h=djofYw@mail.gmail.com>
	<alpine.DEB.2.00.1310202051240.29488@cobra.newdream.net>
	<20131021141147.GA30189@infradead.org>
	<20131021150129.GA28099@redhat.com>
	<20131021180616.GA7196@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131021180616.GA7196-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-lvm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Oct 21 2013 at  2:06pm -0400,
Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:

> On Mon, Oct 21, 2013 at 11:01:29AM -0400, Mike Snitzer wrote:
> > It isn't DM that splits the IO into 4K chunks; it is the VM subsystem
> > no?
> 
> Well, it's the block layer based on what DM tells it.  Take a look at
> dm_merge_bvec
> 
> >From dm_merge_bvec:
> 
> 	/*
>          * If the target doesn't support merge method and some of the devices
>          * provided their merge_bvec method (we know this by looking at
>          * queue_max_hw_sectors), then we can't allow bios with multiple vector
>          * entries.  So always set max_size to 0, and the code below allows
>          * just one page.
>          */
> 	
> Although it's not the general case, just if the driver has a
> merge_bvec method.  But this happens if you using DM ontop of MD where I
> saw it aswell as on rbd, which is why it's correct in this context, too.

Right, but only if the DM target that is being used doesn't have a
.merge method.  I don't think it was ever shared which DM target is in
use here.. but both the linear and stripe DM targets provide a .merge
method.
 
> Sorry for over generalizing a bit.

No problem.
