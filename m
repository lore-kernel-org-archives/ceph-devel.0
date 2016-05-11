From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Hammer vs Jewel librbd performance testing and git
 bisection results
Date: Wed, 11 May 2016 09:52:30 -0400
Message-ID: <CA+aFP1BN=mpR-7xid=+vgz3rpSWkirthrYDPuEy-OkreVp=A-g@mail.gmail.com>
References: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <f9f54455-8348-42b7-153b-e38850eed5e1-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "cbt-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <cbt-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Awesome work Mark!  Comments / questions inline below:

On Wed, May 11, 2016 at 9:21 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> There are several commits of interest that have a noticeable effect on 128K
> sequential read performance:
>
>
> 1) https://github.com/ceph/ceph/commit/3a7b5e3
>
> This commit was the first that introduced anywhere from a 0-10% performance
> decrease in the 128K sequential read tests.  Primarily it made performance
> lower on average and more variable.

This one is surprising to me since this change is also in Hammer
(cf6e1f50ea7b5c2fd6298be77c06ed4765d66611).  When you are performing
the bisect, are you keeping the OSDs at the same version and only
swapping out librbd?

> 2) https://github.com/ceph/ceph/commit/c474ee42
>
> This commit had a very large impact, reducing performance by another 20-25%.

Definitely an area we should optimize given the number of
AioCompletions that are constructed.

> 3) https://github.com/ceph/ceph/commit/66e7464
>
> This was a fix that helped regain some of the performance loss due to
> c474ee42, but didn't totally reclaim it.

Odd -- since that effectively reverted c474ee42 (unique_lock_name)
within the IO path.

> 5) https://github.com/ceph/ceph/commit/8aae868
>
> The new AioImageRequestWQ appears to be the cause of the most recent large
> reduction in 128K sequential read performance.

We will have to investigate this -- AioImageRequestWQ is just a
wrapper around the same work queue used in the Hammer release.

-- 
Jason
