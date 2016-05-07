From: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: removing 'rados cppool' command
Date: Sat, 7 May 2016 10:06:26 +0300
Message-ID: <20160507070625.GA2167@gmail.com>
References: <alpine.DEB.2.11.1605061538160.1841@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1605061538160.1841-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
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
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, May 06, 2016 at 03:41:34PM -0400, Sage Weil wrote:
> This PR
> 
> 	https://github.com/ceph/ceph/pull/8975
> 
> removes the 'rados cppool' command.  The main problem is that the command 
> does not make a faithful copy of all data because it doesn't preserve the 
> snapshots (and snapshot related metadata).  That means if you copy an RBD 
> pool it will render the images somewhat broken (snaps won't be present and 
> won't work properly).  It also doesn't preserve the user_version field 
> that some librados users may rely on.
> 
> Since it's obscure and of limited use, this PR just removes it.

Copying a pool sometimes is useful, even with those limitations.

Until there is an alternative way to do the same I would not remove
this. A better approach to me is to move this functionality to
something like `ceph_radostool` (people use such tools only when
facing extraordinary situations so they are more careful and expect
limitations).

-- 
Mykola Golub
