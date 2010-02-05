From: Sage Weil <sage@newdream.net>
Subject: Re: Hard links
Date: Fri, 5 Feb 2010 12:34:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002050828120.9306@cobra.newdream.net>
References: <26595.1265144721@n20.hq.graphstream.com>
	<Pine.LNX.4.64.1002021340380.9187@cobra.newdream.net>
	<loom.20100205T000156-623@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <loom.20100205T000156-623@post.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Fri, 5 Feb 2010, Chris Dunlop wrote:
> G'day Sage,
> 
> Sage Weil <sage <at> newdream.net> writes:
> > I've posted the openoffice presentation at
> > 
> > 	http://ceph.newdream.net/presentations/
> 
> The last slide (39) mentions "Hard links are rare!".
> 
> This isn't necessarily true in a backup system where each
> snapshot hard links to the previous snapshot for files that
> haven't changed, e.g. an 'rsnapshot' installation.
> 
> For some hard numbers, one of our server backups has 72316 files
> in yesterday's set, with only 194 not hard linked, and 62141
> have 76 hard links (there are currently 76 days of backups for
> this server).  This is one of 66 servers being backed up to this
> one 4.5 TB storage pool.
> 
> Does the "hard links are rare" assertion imply that ceph may
> have some issues (e.g. hard limits or performance) handling very
> large numbers of hard links?
> 
> E.g. I see that hard links are mentioned in your Dec 2007
> dissertation on ceph, along with the use of an anchor table
> which is "managed by a single MDS".  Might this be an issue
> (e.g. a 'hot spot') for situations with a large number of hard
> links such as that described above?

Yes and no.  The performance impact of hard links is low for the 
common backup scenario, but the anchor table scaling has not been 
address (it's still a single MDS).

What slide 39 doesn't include is a description of the figure.  One of the 
most common use scenarios of hard links is what I called 'parallel' links, 
where many files in one directory are all hard linked to parallel files in 
a different directory, which is exactly what you see with cp -al or 
rsnapshot.  In that case, the cost of doing a lookup in the anchor 
table is amortized over the whole directory.

The anchor table is still maintained by a single MDS, though, and it's all 
in RAM at once, so it will be a scaling problem if the fs has a lot of 
hard links.  That just needs some design attention at some point.

sage

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
