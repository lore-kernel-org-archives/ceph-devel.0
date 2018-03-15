From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: seeking maintainer for ceph-deploy (was Re:
 ceph-deploy's currentstatus)
Date: Thu, 15 Mar 2018 17:40:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1803151739170.28823@piezo.novalocal>
References: <CAC-Np1zF3DQh=P47z3np3F5_xx8Kdid0v8AVd5tGGn3KYgaqHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1zF3DQh=P47z3np3F5_xx8Kdid0v8AVd5tGGn3KYgaqHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Adding ceph-users to get a bit broader distribution.

tl;dr: is anyone interested in stepping up to help maintain ceph-deploy?

Thanks!
sage


On Fri, 9 Mar 2018, Alfredo Deza wrote:
> Since about October of 2015, ceph-deploy has gone without a dedicated lead
> doing full time development on it. I've tried keeping up with a few pull
> request as they come in, and doing the occasional release.
> 
> For the past two weeks, I've gone and cleaned up the backlog of tickets that
> piled up on the ceph-deploy tracker, but that is hardly enough progress.
> 
> The last large effort was to transition the OSD deployment away from ceph-disk
> and into ceph-volume, producing the 2.0.0 release.
> 
> Although most of the basic Ceph features are supported, there are quite a few
> that are not. The tracker has lots of examples for feature requests that aren't
> implemented and would take quite the effort to get them done.
> 
> Not having a dedicated lead will cause ceph-deploy to fall further behind
> piling issues and feature requests, and it is certainly not ideal to expose it
> in the Ceph documentation as the recommended (basic) deployment tool if this
> status-quo continues.
> 
> There is nothing currently for Ceph that does what ceph-deploy does today:
> easily configure and deploy a cluster, with minimal configuration. Ideally,
> I would love to see ceph-deploy piggy-back from ceph-ansible, and gain all of
> the features as they are implemented there, while keeping the simple/minimalist
> interface (the Gluster team does something similar with its gdeploy tool).
> 
> But then again, that also is quite a big task, and will take the effort of at
> least one lead pushing through and keeping up with new changes as they are
> needed.
> 
> Moving forward I think there are a couple of options:
> 
> If there is no one to lead the project in the next few weeks:
> 
> * Start a deprecation route, updating the docs to reflect its 'frozen' state
> * Remove mentions from the Ceph docs
> * Remove the package from the Ceph repos (this is done on a per-release basis)
> * Update the Ceph docs to point to ceph-ansible usage that might
> provide a similar result.
> 
> If there is interest in stepping up to help lead and work on it:
> 
> * Start addressing the somewhat large backlog of tickets
> (http://tracker.ceph.com/projects/ceph-deploy/issues)
> * Increase the release cadence (we are currently releasing every 5
> months on average!)
> * Consider using ceph-ansible as a backend to reduce the burden of
> implementing new features
> 
> 
> tl;dir
> ceph-deploy hasn't had a dedicated development effort since 2015, issues
> are pilling up, new features aren't getting added, and we are considering
> deprecating it unless there is interest in maintenance moving forward
> 
> 
> -Alfredo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
