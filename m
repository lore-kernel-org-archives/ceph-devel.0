From: Sage Weil <sage@newdream.net>
Subject: Re: prefering local reads?
Date: Mon, 9 Nov 2009 09:53:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911090945040.28614@cobra.newdream.net>
References: <ff215e13c5bc2943146ddf9f7fd3852a.squirrel@xlhost.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1855070569-1257789219=:28614"
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <ff215e13c5bc2943146ddf9f7fd3852a.squirrel@xlhost.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: =?iso-8859-15?Q?J=FCrgen_Herrmann?= <Juergen.Herrmann@XLhost.de>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1855070569-1257789219=:28614
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Nov 2009, J=FCrgen Herrmann wrote:

> hi there!
>=20
> i plan to set up a ceph fs for our mail cluster testing.
> initially i want to have 2 mds and 2 osds, one on each of the
> involved machines. each machine would mount the ceph fs.
> so in the non-failure case every client could read from
> the local osd, is there a way to assure that?

No, Ceph currently does not routing of requests to replicas based on how=20
close they are.  You should also be careful running an OSD on the same=20
node as the kernel client, as there are theoretical deadlocks possible=20
when memory is low.

For a simple two node setup, you may be better off with something like=20
OCFS2 and a shared block device (DRDB?).

> is the requirement to have at least 3 mons in clustered mode
> still in effect? reading
> http://ceph.newdream.net/wiki/Monitor_cluster_expansion
> one could come to the conclusion that having 2 mons is
> working too.

It's possible to have two monitors, and it improves durability in that the=
=20
total loss of a single node won't permanently kill the monitor's data, but=
=20
availability is worse because the failure of either node will deactivate=20
the cluster (a majority of monitor nodes must be online to be active). =20
3 monitors is better.

sage


>=20
> thanks in andvance,
> j=FCrgen
> --
> >> XLhost.de - eXperts in Linux hosting =AE <<
>=20
> XLhost.de GmbH
> J=FCrgen Herrmann, Gesch=E4ftsf=FChrer
> Boelckestrasse 21, 93051 Regensburg, Germany
>=20
> Gesch=E4ftsf=FChrer: Volker Geith, J=FCrgen Herrmann
> Registriert unter: HRB9918
> Umsatzsteuer-Identifikationsnummer: DE245931218
>=20
> Fon:  +49 (0)800 XLHOSTDE [0800 95467833]
> Fax:  +49 (0)800 95467830
>=20
> WEB:  http://www.XLhost.de
> IRC:  #XLhost@irc.quakenet.org
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay=20
> trial. Simplify your report design, integration and deployment - and focu=
s on=20
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>=20
>=20
--557981400-1855070569-1257789219=:28614
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--557981400-1855070569-1257789219=:28614
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--557981400-1855070569-1257789219=:28614--
