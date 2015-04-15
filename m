From: Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: v0.80.8 and librbd performance
Date: Tue, 14 Apr 2015 22:22:32 -0700
Message-ID: <552DF598.8040404@redhat.com>
References: <bb7a4f02-e495-4d69-961f-b0f970b407d1@redhat.com>
	<CAPntomB=AiCtx2ypTi+fUFUCUDtkyURb=d-RgwX3ft2mrAibEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPntomB=AiCtx2ypTi+fUFUCUDtkyURb=d-RgwX3ft2mrAibEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: shiva rkreddy <shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 04/14/2015 08:01 PM, shiva rkreddy wrote:
> The clusters are in test environment, so its a new deployment of 0.80.9.
> OS on the cluster nodes is reinstalled as well, so there shouldn't be
> any fs aging unless the disks are slowing down.
>
> The perf measurement is done initiating multiple cinder create/delete
> commands and tracking the volume to be in available or completely gone
> from "cinder list" output.
>
> Even running  "rbd rm " command from cinder node results in similar
> behaviour.
>
> I'll try with  increasing  rbd_concurrent_management in ceph.conf.
>   Is the param name rbd_concurrent_management or rbd-concurrent-management ?

'rbd concurrent management ops' - spaces, hyphens, and underscores are
equivalent in ceph configuration.

A log with 'debug ms = 1' and 'debug rbd = 20' from 'rbd rm' on both 
versions might give clues about what's going slower.

Josh

> On Tue, Apr 14, 2015 at 12:36 PM, Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> <mailto:jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>> wrote:
>
>     I don't see any commits that would be likely to affect that between
>     0.80.7 and 0.80.9.
>
>     Is this after upgrading an existing cluster?
>     Could this be due to fs aging beneath your osds?
>
>     How are you measuring create/delete performance?
>
>     You can try increasing rbd concurrent management ops in ceph.conf on
>     the cinder node. This affects delete speed, since rbd tries to
>     delete each object in a volume.
>
>     Josh
>
>
>     *From:* shiva rkreddy <shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>     <mailto:shiva.rkreddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>     *Sent:* Apr 14, 2015 5:53 AM
>     *To:* Josh Durgin
>     *Cc:* Ken Dreyer; Sage Weil; Ceph Development; ceph-users-Qp0mS5GaXlQ@public.gmane.org
>     <mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org>
>     *Subject:* Re: v0.80.8 and librbd performance
>
>         Hi Josh,
>
>         We are using firefly 0.80.9 and see both cinder create/delete
>         numbers slow down compared 0.80.7.
>         I don't see any specific tuning requirements and our cluster is
>         run pretty much on default configuration.
>         Do you recommend any tuning or can you please suggest some log
>         signatures we need to be looking at?
>
>         Thanks
>         shiva
>
>         On Wed, Mar 4, 2015 at 1:53 PM, Josh Durgin <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
>         <mailto:jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>> wrote:
>
>             On 03/03/2015 03:28 PM, Ken Dreyer wrote:
>
>                 On 03/03/2015 04:19 PM, Sage Weil wrote:
>
>                     Hi,
>
>                     This is just a heads up that we've identified a
>                     performance regression in
>                     v0.80.8 from previous firefly releases.  A v0.80.9
>                     is working it's way
>                     through QA and should be out in a few days.  If you
>                     haven't upgraded yet
>                     you may want to wait.
>
>                     Thanks!
>                     sage
>
>
>                 Hi Sage,
>
>                 I've seen a couple Redmine tickets on this (eg
>                 http://tracker.ceph.com/__issues/9854
>                 <http://tracker.ceph.com/issues/9854> ,
>                 http://tracker.ceph.com/__issues/10956
>                 <http://tracker.ceph.com/issues/10956>). It's not
>                 totally clear to me
>                 which of the 70+ unreleased commits on the firefly
>                 branch fix this
>                 librbd issue.  Is it only the three commits in
>                 https://github.com/ceph/ceph/__pull/3410
>                 <https://github.com/ceph/ceph/pull/3410> , or are there
>                 more?
>
>
>             Those are the only ones needed to fix the librbd performance
>             regression, yes.
>
>             Josh
>
>             --
>             To unsubscribe from this list: send the line "unsubscribe
>             ceph-devel" in
>             the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>             <mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>             More majordomo info at
>             http://vger.kernel.org/__majordomo-info.html
>             <http://vger.kernel.org/majordomo-info.html>
>
>
>
