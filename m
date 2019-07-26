From: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error in ceph rbd
 mirroring(rbd::mirror::InstanceWatcher: C_NotifyInstanceRequestfinish:
 resending after timeout)
Date: Fri, 26 Jul 2019 16:25:46 +0300
Message-ID: <20190726132546.GA6825@gmail.com>
References: <CAEbG6hG7dAhg=Z9JUKcCCTOEPyXZ6cZcS=jar7SeL-5VTcqEgA@mail.gmail.com>
 <20190726093147.GA31242@gmail.com>
 <CAEbG6hFgvWFMgaYHRRtZdth-OkJ7ib4vWxf__b7QvGPd1rF6Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEbG6hFgvWFMgaYHRRtZdth-OkJ7ib4vWxf__b7QvGPd1rF6Qg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Fri, Jul 26, 2019 at 04:40:35PM +0530, Ajitha Robert wrote:
> Thank you for the clarification.
> 
> But i was trying with openstack-cinder.. when i load some data into the
> volume around 50gb, the image sync will stop by 5 % or something within
> 15%...  What could be the reason?

I suppose you see image sync stop in mirror status output? Could you
please provide an example? And I suppose you don't see any other
messages in rbd-mirror log apart from what you have already posted?
Depending on configuration rbd-mirror might log in several logs. Could
you please try to find all its logs? `lsof |grep 'rbd-mirror.*log'`
may be useful for this.

BTW, what rbd-mirror version are you running?

-- 
Mykola Golub
