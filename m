From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: stalls caused by scrub on jewel
Date: Tue, 6 Dec 2016 11:09:33 +0100
Message-ID: <CABZ+qqmyyGrvLRT2zRMn5_RXWPeKyiKaPXfJRZ3qCY5v13-m_Q@mail.gmail.com>
References: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1611152232260.2650-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

Could you please clarify: do we need to set nodeep-scrub also, or does
this somehow only affect the (shallow) scrub?

(Note that deep scrubs will start when the deep_scrub_interval has
passed, even with noscrub set).

Cheers, Dan


On Tue, Nov 15, 2016 at 11:35 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi everyone,
>
> There was a regression in jewel that can trigger long OSD stalls during
> scrub.  How long the stalls are depends on how many objects are in your
> PGs, how fast your storage device is, and what is cached, but in at least
> one case they were long enough that the OSD internal heartbeat check
> failed and it committed suicide (120 seconds).
>
> The workaround for now is to simply
>
>  ceph osd set noscrub
>
> as the bug is only triggered by scrub.  A fix is being tested and will be
> available shortly.
>
> If you've seen any kind of weird latencies or slow requests on jewel, I
> suggest setting noscrub and seeing if they go away!
>
> The tracker bug is
>
>  http://tracker.ceph.com/issues/17859
>
> Big thanks to Yoann Moulin for helping track this down!
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
