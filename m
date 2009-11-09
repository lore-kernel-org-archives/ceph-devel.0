From: =?iso-8859-15?Q?J=FCrgen_Herrmann?= <Juergen.Herrmann@XLhost.de>
Subject: prefering local reads?
Date: Mon, 9 Nov 2009 12:36:31 +0100 (CET)
Message-ID: <ff215e13c5bc2943146ddf9f7fd3852a.squirrel@xlhost.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

hi there!

i plan to set up a ceph fs for our mail cluster testing.
initially i want to have 2 mds and 2 osds, one on each of the
involved machines. each machine would mount the ceph fs.
so in the non-failure case every client could read from
the local osd, is there a way to assure that?

is the requirement to have at least 3 mons in clustered mode
still in effect? reading
http://ceph.newdream.net/wiki/Monitor_cluster_expansion
one could come to the conclusion that having 2 mons is
working too.

thanks in andvance,
j=FCrgen
--
>> XLhost.de - eXperts in Linux hosting =AE <<

XLhost.de GmbH
J=FCrgen Herrmann, Gesch=E4ftsf=FChrer
Boelckestrasse 21, 93051 Regensburg, Germany

Gesch=E4ftsf=FChrer: Volker Geith, J=FCrgen Herrmann
Registriert unter: HRB9918
Umsatzsteuer-Identifikationsnummer: DE245931218

Fon:  +49 (0)800 XLHOSTDE [0800 95467833]
Fax:  +49 (0)800 95467830

WEB:  http://www.XLhost.de
IRC:  #XLhost@irc.quakenet.org


---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
