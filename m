From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Revert a CephFS snapshot?
Date: Thu, 14 Nov 2019 19:48:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.1911141900360.17979@piezo.novalocal>
References: <CAKQB+ftphk7pepLdGEgckLtfj=KBp02cMqdea+R_NTd6Gwn-TA@mail.gmail.com>
 <CA+2bHPaCg4Pq-88hnvnH93QCOfgKv27gDTUjHF5rnDr6Nd2=wQ@mail.gmail.com>
 <CAKQB+fvUCUAeHEHwP06auyK+ZGUHZdRzTT-38xtgsSbQDjyoHQ@mail.gmail.com>
 <CA+2bHPbw3uMLeq77XfjZfhYnYcnF-Gk+Od6UJrTiYkW+g77s4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+2bHPbw3uMLeq77XfjZfhYnYcnF-Gk+Od6UJrTiYkW+g77s4w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Jerry Lee <leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 14 Nov 2019, Patrick Donnelly wrote:
> On Wed, Nov 13, 2019 at 6:36 PM Jerry Lee <leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > On Thu, 14 Nov 2019 at 07:07, Patrick Donnelly <pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > >
> > > On Wed, Nov 13, 2019 at 2:30 AM Jerry Lee <leisurelysw24-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > Recently, I'm evaluating the snpahsot feature of CephFS from kernel
> > > > client and everthing works like a charm.  But, it seems that reverting
> > > > a snapshot is not available currently.  Is there some reason or
> > > > technical limitation that the feature is not provided?  Any insights
> > > > or ideas are appreciated.
> > >
> > > Please provide more information about what you tried to do (commands
> > > run) and how it surprised you.
> >
> > The thing I would like to do is to rollback a snapped directory to a
> > previous version of snapshot.  It looks like the operation can be done
> > by over-writting all the current version of files/directories from a
> > previous snapshot via cp.  But cp may take lots of time when there are
> > many files and directories in the target directory.  Is there any
> > possibility to achieve the goal much faster from the CephFS internal
> > via command like "ceph fs <cephfs_name> <dir> snap rollback
> > <snapname>" (just a example)?  Thank you!
> 
> RADOS doesn't support rollback of snapshots so it needs to be done
> manually. The best tool to do this would probably be rsync of the
> .snap directory with appropriate options including deletion of files
> that do not exist in the source (snapshot).

rsync is the best bet now, yeah.

RADOS does have a rollback operation that uses clone where it can, but 
it's a per-object operation, so something still needs to walk the 
hierarchy and roll back each file's content.  The MDS could do this more 
efficiently than rsync give what it knows about the snapped inodes 
(skipping untouched inodes or, eventually, entire subtrees) but it's a 
non-trivial amount of work to implement.

sage
