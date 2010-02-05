From: Chris Dunlop <chris@onthe.net.au>
Subject: Hard links
Date: Fri, 5 Feb 2010 00:17:05 +0000 (UTC)
Message-ID: <loom.20100205T000156-623@post.gmane.org>
References: <26595.1265144721@n20.hq.graphstream.com>
	<Pine.LNX.4.64.1002021340380.9187@cobra.newdream.net>
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

G'day Sage,

Sage Weil <sage <at> newdream.net> writes:
> I've posted the openoffice presentation at
> 
> 	http://ceph.newdream.net/presentations/

The last slide (39) mentions "Hard links are rare!".

This isn't necessarily true in a backup system where each
snapshot hard links to the previous snapshot for files that
haven't changed, e.g. an 'rsnapshot' installation.

For some hard numbers, one of our server backups has 72316 files
in yesterday's set, with only 194 not hard linked, and 62141
have 76 hard links (there are currently 76 days of backups for
this server).  This is one of 66 servers being backed up to this
one 4.5 TB storage pool.

Does the "hard links are rare" assertion imply that ceph may
have some issues (e.g. hard limits or performance) handling very
large numbers of hard links?

E.g. I see that hard links are mentioned in your Dec 2007
dissertation on ceph, along with the use of an anchor table
which is "managed by a single MDS".  Might this be an issue
(e.g. a 'hot spot') for situations with a large number of hard
links such as that described above?

Cheers,

Chris



------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
