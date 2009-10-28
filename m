From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: code/comment mismatch
Date: Wed, 28 Oct 2009 14:23:16 -0700
Message-ID: <04BF1C09-FD96-4666-8C0B-31416E1ECC3C@soe.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v753.1)
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

I noticed a consistent use of comments didn't match a consistent  
coding of the calculation being commented. This is definitely core,  
so the code is probably correct. Just a heads up:

In ceph_calc_file_object_mapping():

First usage:
	/* bl = *off / su; */
	t = off;
	do_div(t, su);
	bl = t;

Second usage:
	/* *oxoff = *off / layout->fl_stripe_unit; */
	t = off;
	*oxoff = do_div(t, su);

The second usage assigns to 'oxoff' the remainder of division, not  
the quotient.

-n


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
