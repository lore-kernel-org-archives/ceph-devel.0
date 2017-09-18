From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Bluestore aio_nr?
Date: Mon, 18 Sep 2017 21:19:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709182117520.4417@piezo.novalocal>
References: <CAEYCsVJNnY7yV=VjfdP7B3jtVMz5v=8a9MmVPqS0kyhdKf0Tvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEYCsVJNnY7yV=VjfdP7B3jtVMz5v=8a9MmVPqS0kyhdKf0Tvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 19 Sep 2017, Xiaoxi Chen wrote:
> Hi,
>      I just hit an OSD cannot start due to insufficient aio_nr.  Each
> OSD is with a separate SSD partition as db.block

Can you paste the message you saw?  I'm not sure which check you mean.

>      Further checking showing 6144 AIO contexts were required per OSD,
>  could anyone explain a little bit on where the 6144 aio contexts goes
> to?
> 
>      It looks to me like the bdev_aio_max_queue_depth is default to
> 1024, but  how can we have 6 bdev to get 6144?

I'm guessing the is fallout from the kernel's behavior.  When you set up 
an IO queue you specify how many aios you want to allow (that's where we 
use the max_queue_depth value), but the kernel rounds the buffer up to a 
page boundary, so in reality it will use more.  That can make you hit the 
host maximum sooner.

sage
