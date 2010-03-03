From: Sage Weil <sage@newdream.net>
Subject: Re: users, 2.6.34
Date: Tue, 2 Mar 2010 16:27:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003021619380.27179@cobra.newdream.net>
References: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
	<a4423d671003021406s57ab89c5j9e1537a99914531@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1751934109-1267576040=:27179"
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a4423d671003021406s57ab89c5j9e1537a99914531@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1751934109-1267576040=:27179
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Mar 2010, Alexander Beregalov wrote:
> On 2 March 2010 22:27, Sage Weil <sage@newdream.net> wrote:
> > Hi,
> >
> > The 2.6.34 merge window is open, and I will be sending another request =
to
> > Linus shortly asking him to merge the Ceph kernel client. =A0I'd like t=
o be
> > able to accurate describe the current user base and level of interest.
> >
> > If you've tried v0.19, can you take a minute to let us know what your
> > experience has been? =A0Did you get the system up and running? =A0Were =
there
> > problems along the way? =A0What size system are you testing and/or plan=
ning?
>=20
> Hi Sage
> I tried Ceph two weeks ago on two hosts (one mds, two osds, two
> clients), but performance was not so good as I expected. I used
> dbench. Perhaps the reason was high logging traffic, but I did not try
> to turn it off. I am going to test it on real world task - kernel
> building, but sorry, I do not have time to look at it now.

If you have any logging turned on, that will definitely slow things down a=
=20
lot.

> My dream is to have a parallel-distributed FS with good performance on
> small files. We have few tens (up to hundred) of hosts for distributed
> compilation tasks (that's why small files) and others (not so small
> files). OSDs should work as clients as well.
> Now we run on NFSv3 and fight with it (not atomic, not coherent, hard
> to scale). But NFS performance is not awful really, new FS should work
> at least not worse than it (I mean aggregated performance).

If you are comparing NFS vs ceph on equivalent hardware (single server,=20
with single mds+osd), the performance will be similar, or a bit slower=20
with ceph (it is not heavily optimized).  The real advantage is that=20
overall system performance will scale linearly as you go from one server=20
to 10's or 100's of servers. For a compilation workload, performance will=
=20
be bounded mostly by metadata operations.  If you have lots of clients,=20
you should see quite a bit of benefit from multiple MDSs.

Anyway, thanks for the feedback!
sage
--557981400-1751934109-1267576040=:27179
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--557981400-1751934109-1267576040=:27179
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--557981400-1751934109-1267576040=:27179--
