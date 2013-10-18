From: Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Fri, 18 Oct 2013 10:56:57 +0300
Message-ID: <CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
	<alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>
	<20131017151828.GB28859@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20131017151828.GB28859-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, linux-lvm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

> Ugis, please provide the output of:
>
> RBD_DEVICE=<rbd device name>
> pvs -o pe_start $RBD_DEVICE
> cat /sys/block/$RBD_DEVICE/queue/minimum_io_size
> cat /sys/block/$RBD_DEVICE/queue/optimal_io_size
>
> The 'pvs' command will tell you where LVM aligned the start of the data
> area (which follows the LVM metadata area).  Hopefully it reflects what
> was published in sysfs for rbd's striping.

output follows:
#pvs -o pe_start /dev/rbd1p1
  1st PE
    4.00m
# cat /sys/block/rbd1/queue/minimum_io_size
4194304
# cat /sys/block/rbd1/queue/optimal_io_size
4194304

Seems correct in terms of ceph-LVM io parameter negotiation? I wonded
about gpt header+PV metadata - it makes some shift starting from ceph
1st block beginning. Does this mean that all following LVM 4m data
blocks are shifted by this part and span 2 ceph objects?
If so, performance will be affected.

Ugis
