From: Sage Weil <sage@newdream.net>
Subject: Re: Makefile missing from ceph-kclient-source
Date: Tue, 10 Nov 2009 07:19:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911100718300.30993@cobra.newdream.net>
References: <4AF95A30.9080501@tuxbox.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4AF95A30.9080501@tuxbox.ie>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Martin List-Petersen <martin@tuxbox.ie>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Tue, 10 Nov 2009, Martin List-Petersen wrote:

> Hi,
> 
> it seems that the debian build of the 0.17 tree for ceph-kclient-source
> is missing the Makefile.
> 
> When pulling a source file, I get the 0.16 version instead. Copying the
> Makefile of that lets me compile the 0.17 kernel module according to the
> documentation at http://ceph.newdream.net/wiki/Debian
> 
> What needs to be done to remedy the debian repository (updating source
> file to 0.17 and adding Makefile to modules-package) ??

Fixed this... the package in the unstable repo now includes the Makefile 
(ceph-kclient-source_0.17git20091110071616_all.deb).

Thanks!
sage

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
