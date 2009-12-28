From: Sage Weil <sage@newdream.net>
Subject: update
Date: Mon, 28 Dec 2009 09:52:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0912280945400.28566@cobra.newdream.net>
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
To: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

Hi all-

Just a quick update.

I'm out of town for the next week and a half.  Greg and Yehuda are working 
on the last few known kclient problems and pending disk format changes.  
I'm giving a talk on Ceph at linux.conf.au (in New Zealand this year) in 
January, so I'm hoping we can get those sorted out and do a release before 
that for wider testing.

The major unresolved issue at this point is with OSD performance.  The way 
the cosd daemon currently handles commits with btrfs is problematic: btrfs 
is slow to do a full commit.  That can be improved with some effort, but 
that can only be improved so much.  I'm working on some changes that will 
let you change the way the regular writes and journal interact, so you can 
do either parallel or write-ahead journaling.  That will let us hopefully 
keep write latency low (even will the btrfs commit is slow), especially 
when there is a second spindle/nvram/ssd for the journaling.  
(Unfortunately all my work so far on that from last week was on a disk 
that went kaput; it's due back from the data recovery place in the next 
couple days.)

sage

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
