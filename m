From: Sage Weil <sage@newdream.net>
Subject: Re: [cppcheck] suggested a few performance improvements
Date: Thu, 25 Mar 2010 11:57:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003251154380.29332@cobra.newdream.net>
References: <20100322203502.295370@gmx.net>
	<Pine.LNX.4.64.1003221348030.21746@cobra.newdream.net>
	<20100324200852.307830@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100324200852.307830@gmx.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Martin Ettl <ettl.martin@gmx.de>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi Martin,

On Wed, 24 Mar 2010, Martin Ettl wrote:
> attached to this mail, there is the output of scan with cppcheck. 
> Cppcheck reports few issues about post and pre incrementation of 
> iterators (post increment is faster) and const correctness,e.g:

Thanks for the results.  I'll fix some of these (those that look like 
actual errors).  Some of the style complaints probably aren't worth 
changing (e.g. pre/post increment, const), unless someone has time to 
kill.

I'm looking into Coverity as well... scan.coverity.com does free analysis 
of open source projects.

Thanks-
sage


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
