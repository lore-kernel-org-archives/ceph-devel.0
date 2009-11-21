From: Sage Weil <sage@newdream.net>
Subject: Re: question about fs/ceph/snap.c
Date: Sat, 21 Nov 2009 12:53:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911211250240.15569@cobra.newdream.net>
References: <Pine.LNX.4.64.0911212130530.28848@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0911212130530.28848@ask.diku.dk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Julia Lawall <julia@diku.dk>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Sat, 21 Nov 2009, Julia Lawall wrote:

> The file fs/ceph/snap.c contains four calls to ceph_lookup_snap_realm, all 
> of which test the returned value first with IS_ERR and then by checking 
> for a NULL pointer.  But the definition of ceph_lookup_snap_realm contains
> a dereference of its argument if it is not NULL, which suggests that an 
> ERR_PTR value is not what expected.  So something seems to be inconsistent 
> here.

Yeah, I'm not sure how it ended up that way.  I'll just remove the 
IS_ERR() checks, since there are no errors the lookup can return (besides 
not found).

The other patches look good; applying them now.  Thank you!  Coccinelle is 
pretty slick.  :)

sage

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
