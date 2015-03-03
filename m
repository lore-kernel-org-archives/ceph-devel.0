From: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: v0.80.8 and librbd performance
Date: Tue, 03 Mar 2015 16:28:02 -0700
Message-ID: <54F64382.7060308@redhat.com>
References: <alpine.DEB.2.00.1503031512270.25972@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1503031512270.25972-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 03/03/2015 04:19 PM, Sage Weil wrote:
> Hi,
> 
> This is just a heads up that we've identified a performance regression in 
> v0.80.8 from previous firefly releases.  A v0.80.9 is working it's way 
> through QA and should be out in a few days.  If you haven't upgraded yet 
> you may want to wait.
> 
> Thanks!
> sage

Hi Sage,

I've seen a couple Redmine tickets on this (eg
http://tracker.ceph.com/issues/9854 ,
http://tracker.ceph.com/issues/10956). It's not totally clear to me
which of the 70+ unreleased commits on the firefly branch fix this
librbd issue.  Is it only the three commits in
https://github.com/ceph/ceph/pull/3410 , or are there more?

- Ken
