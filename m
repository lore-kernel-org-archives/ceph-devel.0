From: Jerry Lee <leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Revert a CephFS snapshot?
Date: Thu, 14 Nov 2019 10:36:05 +0800
Message-ID: <CAKQB+fvUCUAeHEHwP06auyK+ZGUHZdRzTT-38xtgsSbQDjyoHQ@mail.gmail.com>
References: <CAKQB+ftphk7pepLdGEgckLtfj=KBp02cMqdea+R_NTd6Gwn-TA@mail.gmail.com>
 <CA+2bHPaCg4Pq-88hnvnH93QCOfgKv27gDTUjHF5rnDr6Nd2=wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+2bHPaCg4Pq-88hnvnH93QCOfgKv27gDTUjHF5rnDr6Nd2=wQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Patrick Donnelly <pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 14 Nov 2019 at 07:07, Patrick Donnelly <pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> On Wed, Nov 13, 2019 at 2:30 AM Jerry Lee <leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Recently, I'm evaluating the snpahsot feature of CephFS from kernel
> > client and everthing works like a charm.  But, it seems that reverting
> > a snapshot is not available currently.  Is there some reason or
> > technical limitation that the feature is not provided?  Any insights
> > or ideas are appreciated.
>
> Please provide more information about what you tried to do (commands
> run) and how it surprised you.

The thing I would like to do is to rollback a snapped directory to a
previous version of snapshot.  It looks like the operation can be done
by over-writting all the current version of files/directories from a
previous snapshot via cp.  But cp may take lots of time when there are
many files and directories in the target directory.  Is there any
possibility to achieve the goal much faster from the CephFS internal
via command like "ceph fs <cephfs_name> <dir> snap rollback
<snapname>" (just a example)?  Thank you!


- Jerry

>
> --
> Patrick Donnelly, Ph.D.
> He / Him / His
> Senior Software Engineer
> Red Hat Sunnyvale, CA
> GPG: 19F28A586F808C2402351B93C3301A3E258DD79D
>
