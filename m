From: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error in ceph rbd
 mirroring(rbd::mirror::InstanceWatcher: C_NotifyInstanceRequestfinish:
 resending after timeout)
Date: Fri, 26 Jul 2019 12:31:48 +0300
Message-ID: <20190726093147.GA31242@gmail.com>
References: <CAEbG6hG7dAhg=Z9JUKcCCTOEPyXZ6cZcS=jar7SeL-5VTcqEgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEbG6hG7dAhg=Z9JUKcCCTOEPyXZ6cZcS=jar7SeL-5VTcqEgA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, Jul 26, 2019 at 12:31:59PM +0530, Ajitha Robert wrote:
>  I have a rbd mirroring setup with primary and secondary clusters as peers
> and I have a pool enabled image mode.., In this i created a rbd image ,
> enabled with journaling.
> But whenever i enable mirroring on the image,  I m getting error in
> rbdmirror.log and  osd.log.
> I have increased the timeouts.. nothing worked and couldnt traceout the
> error
> please guide me to solve this error.
> 
> *Logs*
> http://paste.openstack.org/show/754766/

What do you mean by "nothing worked"? According to mirroring status
the image is mirroring: it is in "up+stopped" state on the primary as
expected, and in "up+replaying" state on the secondary with 0 entries
behind master.

The "failed to get omap key" error in the osd log is harmless, and
just a week ago the fix was merged upstream not to display it.

The cause of "InstanceWatcher: ... resending after timeout" error in
the rbd-mirror log is not clear but if it is not repeating it is
harmless too.

I see you were trying to map the image with krbd. It is expected to
fail as the krbd does not support "journaling" feature, which is
necessary for mirroring. You can access those images only with librbd
(e.g. mapping with rbd-nbd driver or via qemu).

-- 
Mykola Golub
