From: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error in ceph rbd
 mirroring(rbd::mirror::InstanceWatcher: C_NotifyInstanceRequestfinish:
 resending after timeout)
Date: Mon, 29 Jul 2019 19:30:36 +0300
Message-ID: <20190729163035.GB8882@gmail.com>
References: <CAEbG6hG7dAhg=Z9JUKcCCTOEPyXZ6cZcS=jar7SeL-5VTcqEgA@mail.gmail.com>
 <20190726093147.GA31242@gmail.com>
 <CAEbG6hFgvWFMgaYHRRtZdth-OkJ7ib4vWxf__b7QvGPd1rF6Qg@mail.gmail.com>
 <20190726132546.GA6825@gmail.com>
 <CAEbG6hE1s=wJ7hGAPSiFee7iLu7QPrC-s4zDf1kZa3xMsVscdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEbG6hE1s=wJ7hGAPSiFee7iLu7QPrC-s4zDf1kZa3xMsVscdw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Sat, Jul 27, 2019 at 06:08:58PM +0530, Ajitha Robert wrote:

> *1) Will there be any folder related to rbd-mirroring in /var/lib/ceph ? *

no

> *2) Is ceph rbd-mirror authentication mandatory?*

no. But why are you asking?

> *3)when even i create any cinder volume loaded with glance image i get the
> following error.. *
> 
> 2019-07-27 17:26:46.762571 7f93eb0a5780 20 librbd::api::Mirror: peer_list:
> 2019-07-27 17:27:07.541701 7f939d7fa700  0 rbd::mirror::ImageReplayer:
> 0x7f93c800e9e0 [19/b6656be7-6006-4246-ba93-a49a220e33ce] handle_shut_down:
> remote image no longer exists: scheduling deletion
> 2019-07-27 17:27:16.766199 7f93eb0a5780 20 librbd::api::Mirror: peer_list:
> 2019-07-27 17:27:22.568970 7f939d7fa700  0 rbd::mirror::ImageReplayer:
> 0x7f93c800e9e0 [19/b6656be7-6006-4246-ba93-a49a220e33ce] handle_shut_down:
> mirror image no longer exists
> 2019-07-27 17:27:46.769158 7f93eb0a5780 20 librbd::api::Mirror: peer_list:
> 2019

The log tells that the primary image was deleted by some reason and
the rbd-mirror scheduled the secondary (mirrored) image deletion. From
the logs it is not seen why the primary image was deleted. It might be
sinder but can't exlude some bug in the rbd-mirror, running on the
primary cluster, though I don't recall any issues like this.

> *Attimes i can able to create bootable cinder volume apart from the above
> errors, but certain times i face the following
> 
> example, For a 50 gb volume, Local image get created, but it couldnt create
> a mirror image

"Connection timed out" errors suggest you have a connectivity issue
between sites?

-- 
Mykola Golub
