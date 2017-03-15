From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Log message -->
 "bdev(/var/lib/ceph/osd/ceph-x/block) aio_submit retries"
Date: Wed, 15 Mar 2017 14:24:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703151422110.10776@piezo.novalocal>
References: <CALWuvY8dEyWiUxg9VDaMkfQGwPSsWG0adrtzvGa9k7fhNmdsGw@mail.gmail.com>
	<CALWuvY9wY08n2AE9HMfZgZCU9ZEtk2XOwa353_stxT-7x7L30A@mail.gmail.com>
	<CALWuvY_9uWE_DKg5UaYZrc_GchfMK1EpX1rkWrJEuAV+Y3+Uww@mail.gmail.com>
	<CAF-wwdFvgzkYMnkheomsWMikZoZU+THyrxzovORx3bCDfPZ7Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-wwdFvgzkYMnkheomsWMikZoZU+THyrxzovORx3bCDfPZ7Ng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 15 Mar 2017, Brad Hubbard wrote:
> +ceph-devel
> 
> On Wed, Mar 15, 2017 at 5:25 PM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hello,
> >
> > We suspect these messages not only at the time of OSD creation. But in idle
> > conditions also. May I know what is the impact of these error? Can we safely
> > ignore this? Or is there any way/config to fix this problem
> >
> > Few occurrence for these events as follows:---
> >
> > ====
> > 2017-03-14 17:16:09.500370 7fedeba61700  4 rocksdb: (Original Log Time
> > 2017/03/14-17:16:09.453130) [default] Level-0 commit table #60 started
> > 2017-03-14 17:16:09.500374 7fedeba61700  4 rocksdb: (Original Log Time
> > 2017/03/14-17:16:09.500273) [default] Level-0 commit table #60: memtable #1
> > done
> > 2017-03-14 17:16:09.500376 7fedeba61700  4 rocksdb: (Original Log Time
> > 2017/03/14-17:16:09.500297) EVENT_LOG_v1 {"time_micros": 1489511769500289,
> > "job": 17, "event": "flush_finished", "lsm_state": [2, 4, 6, 0, 0, 0, 0],
> > "immutable_memtables": 0}
> > 2017-03-14 17:16:09.500382 7fedeba61700  4 rocksdb: (Original Log Time
> > 2017/03/14-17:16:09.500330) [default] Level summary: base level 1 max bytes
> > base 268435456 files[2 4 6 0 0 0 0] max score 0.76
> >
> > 2017-03-14 17:16:09.500390 7fedeba61700  4 rocksdb: [JOB 17] Try to delete
> > WAL files size 244090350, prev total WAL file size 247331500, number of live
> > WAL files 2.
> >
> > 2017-03-14 17:34:11.610513 7fedf3a71700 -1
> > bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 6
> 
> These errors come from here.
> 
> void KernelDevice::aio_submit(IOContext *ioc)
> {
> ...
>     int r = aio_queue.submit(*cur, &retries);
>     if (retries)
>       derr << __func__ << " retries " << retries << dendl;
> 
> The submit function is this one which calls libaio's io_submit
> function directly and increments retries if it receives EAGAIN.
> 
> #if defined(HAVE_LIBAIO)
> int FS::aio_queue_t::submit(aio_t &aio, int *retries)
> {
>   // 2^16 * 125us = ~8 seconds, so max sleep is ~16 seconds
>   int attempts = 16;
>   int delay = 125;
>   iocb *piocb = &aio.iocb;
>   while (true) {
>     int r = io_submit(ctx, 1, &piocb);     <-------------NOTE
>     if (r < 0) {
>       if (r == -EAGAIN && attempts-- > 0) {     <-------------NOTE
>         usleep(delay);
>         delay *= 2;
>         (*retries)++;
>         continue;
>       }
>       return r;
>     }
>     assert(r == 1);
>     break;
>   }
>   return 0;
> }
> 
> 
> From the man page.
> 
> IO_SUBMIT(2)                                   Linux Programmer's
> Manual                                  IO_SUBMIT(2)
> 
> NAME
>        io_submit - submit asynchronous I/O blocks for processing
> ...
> RETURN VALUE
>        On success, io_submit() returns the number of iocbs submitted
> (which may be 0 if nr is zero).  For the  failure
>        return, see NOTES.
> 
> ERRORS
>        EAGAIN Insufficient resources are available to queue any iocbs.
> 
> I suspect increasing bdev_aio_max_queue_depth may help here but some
> of the other devs may have more/better ideas.

Yes--try increasing bdev_aio_max_queue_depth.  It defaults to 32; try 
changing it to 128, 1024, or 4096 and see if these errors go away.

I've never been able to trigger this on my test boxes, but I put in the 
warning to help ensure we pick a good default.

What kernel version are you running?

Thanks!
sage
