From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Hard links
Date: Sun, 7 Feb 2010 01:09:40 +0000 (UTC)
Message-ID: <loom.20100207T015701-836@post.gmane.org>
References: <26595.1265144721@n20.hq.graphstream.com>
	<Pine.LNX.4.64.1002021340380.9187@cobra.newdream.net>
	<loom.20100205T000156-623@post.gmane.org>
	<Pine.LNX.4.64.1002050828120.9306@cobra.newdream.net>
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

Sage Weil <sage <at> newdream.net> writes:
> On Fri, 5 Feb 2010, Chris Dunlop wrote:
>> Does the "hard links are rare" assertion imply that ceph may
>> have some issues (e.g. hard limits or performance) handling very
>> large numbers of hard links?
>> 
>> E.g. I see that hard links are mentioned in your Dec 2007
>> dissertation on ceph, along with the use of an anchor table
>> which is "managed by a single MDS".  Might this be an issue
>> (e.g. a 'hot spot') for situations with a large number of hard
>> links such as that described above?
> 
> Yes and no.  The performance impact of hard links is low for the 
> common backup scenario, but the anchor table scaling has not been 
> address (it's still a single MDS).
> 
> What slide 39 doesn't include is a description of the figure.  One of the 
> most common use scenarios of hard links is what I called 'parallel' links, 
> where many files in one directory are all hard linked to parallel files in 
> a different directory, which is exactly what you see with cp -al or 
> rsnapshot.  In that case, the cost of doing a lookup in the anchor 
> table is amortized over the whole directory.
> 
> The anchor table is still maintained by a single MDS, though, and it's all 
> in RAM at once, so it will be a scaling problem if the fs has a lot of 
> hard links.  That just needs some design attention at some point.

"Just a small matter of designing and coding..."  :-)

With the current design of the anchor table maintained by a
single MDS, does this have an impact on the resiliancy of the
system? Specifically, what happens if that one MDS becomes
unavailable?

How much memory does the anchor table require?  E.g. for a
million, or 100 million hard links?

Chris



------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
