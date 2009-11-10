From: Martin List-Petersen <martin@tuxbox.ie>
Subject: Makefile missing from ceph-kclient-source
Date: Tue, 10 Nov 2009 12:18:56 +0000
Message-ID: <4AF95A30.9080501@tuxbox.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi,

it seems that the debian build of the 0.17 tree for ceph-kclient-source
is missing the Makefile.

When pulling a source file, I get the 0.16 version instead. Copying the
Makefile of that lets me compile the 0.17 kernel module according to the
documentation at http://ceph.newdream.net/wiki/Debian

What needs to be done to remedy the debian repository (updating source
file to 0.17 and adding Makefile to modules-package) ??

Kind regards,
Martin List-Petersen





------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
