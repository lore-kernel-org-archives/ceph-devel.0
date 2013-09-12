From: Jeff Bachtel <jbachtel-ZeuxUiT9EukFoECaAgFIynS5uNuOjpZe@public.gmane.org>
Subject: Re: ocfs2 for OSDs?
Date: Thu, 12 Sep 2013 11:13:17 -0400
Message-ID: <CAHahqg0uUvPht-h+va31G=wb8intvixvceh+XX5d5Q4hPppJbw@mail.gmail.com>
References: <CAE63xUNKj7JnU_Kypnh39j4z6qVPh2ZLCdiEvfis3_9fDBZ2FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0137598941=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAE63xUNKj7JnU_Kypnh39j4z6qVPh2ZLCdiEvfis3_9fDBZ2FA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0137598941==
Content-Type: multipart/alternative; boundary=089e01227ca4734f0304e6312dbe

--089e01227ca4734f0304e6312dbe
Content-Type: text/plain; charset=ISO-8859-1

Previous experience with OCFS2 was that its actual performance was pretty
lackluster/awful. The bits Oracle threw on top of (I think) ext3 to make it
work as a multi-writer filesystem with all of the signalling that implies
brought the overall performance down.

Jeff


On Wed, Sep 11, 2013 at 9:58 AM, Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
>
> I wonder is ocfs2 suitable for hosting OSD data?
> In ceph documentation only XFS, ext4 and btrfs are discussed, but
> looking at ocfs2 feature list it theoretically also could host OSDs:
>
> Some of the notable features of the file system are:
> Optimized Allocations (extents, reservations, sparse, unwritten
> extents, punch holes)
> REFLINKs (inode-based writeable snapshots)
> Indexed Directories
> Metadata Checksums
> Extended Attributes (unlimited number of attributes per inode)
> Advanced Security (POSIX ACLs and SELinux)
> User and Group Quotas
> Variable Block and Cluster sizes
> Journaling (Ordered and Writeback data journaling modes)
> Endian and Architecture Neutral (x86, x86_64, ia64 and ppc64)
> Buffered, Direct, Asynchronous, Splice and Memory Mapped I/Os
> In-built Clusterstack with a Distributed Lock Manager
> Cluster-aware Tools (mkfs, fsck, tunefs, etc.)
>
> ocfs2 can work in cluster mode but it can also work for single node.
>
> Just wondering would OSD work on ocfs2 and what would performance
> characteristics be.
> Any thoughts/experience?
>
> BR,
> Ugis Racko
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--089e01227ca4734f0304e6312dbe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Previous experience with OCFS2 was that its actual perform=
ance was pretty lackluster/awful. The bits Oracle threw on top of (I think)=
 ext3 to make it work as a multi-writer filesystem with all of the signalli=
ng that implies brought the overall performance down.<div>
<br></div><div>Jeff</div></div><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">On Wed, Sep 11, 2013 at 9:58 AM, Ugis <span dir=3D"ltr">&=
lt;<a href=3D"mailto:ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
I wonder is ocfs2 suitable for hosting OSD data?<br>
In ceph documentation only XFS, ext4 and btrfs are discussed, but<br>
looking at ocfs2 feature list it theoretically also could host OSDs:<br>
<br>
Some of the notable features of the file system are:<br>
Optimized Allocations (extents, reservations, sparse, unwritten<br>
extents, punch holes)<br>
REFLINKs (inode-based writeable snapshots)<br>
Indexed Directories<br>
Metadata Checksums<br>
Extended Attributes (unlimited number of attributes per inode)<br>
Advanced Security (POSIX ACLs and SELinux)<br>
User and Group Quotas<br>
Variable Block and Cluster sizes<br>
Journaling (Ordered and Writeback data journaling modes)<br>
Endian and Architecture Neutral (x86, x86_64, ia64 and ppc64)<br>
Buffered, Direct, Asynchronous, Splice and Memory Mapped I/Os<br>
In-built Clusterstack with a Distributed Lock Manager<br>
Cluster-aware Tools (mkfs, fsck, tunefs, etc.)<br>
<br>
ocfs2 can work in cluster mode but it can also work for single node.<br>
<br>
Just wondering would OSD work on ocfs2 and what would performance<br>
characteristics be.<br>
Any thoughts/experience?<br>
<br>
BR,<br>
Ugis Racko<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br></div>

--089e01227ca4734f0304e6312dbe--

--===============0137598941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0137598941==--
