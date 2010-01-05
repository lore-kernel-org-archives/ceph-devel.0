From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: ceph in v2.6.33?
Date: Tue, 5 Jan 2010 10:30:17 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001051000310.17179@Psilocybe.Update.UU.SE>
References: <Pine.LNX.4.64.0912071511470.32397@cobra.newdream.net>
	<alpine.LFD.2.00.0912181327200.3712@localhost.localdomain>
	<Pine.LNX.4.64.0912181629100.29068@cobra.newdream.net>
	<200912281205.36802.anton.vazir@gmail.com>
	<Pine.LNX.4.64.0912280937231.28566@cobra.newdream.net>
Reply-To: ceph-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0912280937231.28566@cobra.newdream.net>
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


I have used Ceph for some time for evaluation on computional clusters. I 
administrate a small cluster (one rack) at a department at our university 
running MOSIX using NFS as a file server. I am very intrested in migrating 
to Ceph if stable enough and performance for our applications are better 
than NFS.

The main proprietary competitor is Panasas. Our university recently bought 
a rack for use with the university central computing resources. The other 
open source project I am looking at is GlusterFS, but I prefer the 
architecture of Ceph.

I agree that it would be nice to have Ceph client in the kernel tree but 
maybe more important is to get packages for the major distributions (RHEL 
with clones etc) which in time, when Ceph stabilize and get more users, 
might be lifted into the actual distributions. Then putting client into 
kernel is only a small step.

Regards,
Jerker Nyberg.


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
