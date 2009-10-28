From: Sage Weil <sage@newdream.net>
Subject: Re: code/comment mismatch
Date: Wed, 28 Oct 2009 15:16:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0910281458380.18824@cobra.newdream.net>
References: <04BF1C09-FD96-4666-8C0B-31416E1ECC3C@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <04BF1C09-FD96-4666-8C0B-31416E1ECC3C@soe.ucsc.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Wed, 28 Oct 2009, Noah Watkins wrote:

> I noticed a consistent use of comments didn't match a consistent  
> coding of the calculation being commented. This is definitely core,  
> so the code is probably correct. Just a heads up:
> 
> In ceph_calc_file_object_mapping():
> 
> First usage:
> 	/* bl = *off / su; */
> 	t = off;
> 	do_div(t, su);
> 	bl = t;
> 
> Second usage:
> 	/* *oxoff = *off / layout->fl_stripe_unit; */

You're right, it should be

 	/* *oxoff = *off % layout->fl_stripe_unit; */

(*oxoff is the offset into the object extent.)

Actually, it looks like that calculation is wrong.. I also added

	*oxoff += (stripeno % su_per_object) * su;

Thanks!
sage



> 	t = off;
> 	*oxoff = do_div(t, su);
> 
> The second usage assigns to 'oxoff' the remainder of division, not  
> the quotient.
> 
> -n
> 
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
> 
> 

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
