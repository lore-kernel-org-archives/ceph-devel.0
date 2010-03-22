From: Sage Weil <sage@newdream.net>
Subject: Re: [cppcheck] suggested a few performance improvements
Date: Mon, 22 Mar 2010 13:49:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003221348030.21746@cobra.newdream.net>
References: <20100322203502.295370@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100322203502.295370@gmx.net>
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

On Mon, 22 Mar 2010, Martin Ettl wrote:
> i have checked the current git head with cppcheck ( a static code 
> analysis tool, http://sourceforge.net/projects/cppcheck/). It is an 
> allready very powerfull tool that makes some suggestions, how to improve 
> performance of the code.
> 
> Here is a snipped of the scan:
> ....
> [./src/mds/MDSMap.h:236]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
> [./src/mds/MDSMap.h:256]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
> [./src/mds/MDSMap.h:263]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
> [./src/mds/MDSMap.h:280]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
> [./src/mds/MDSMap.h:291]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
> [./src/include/LogEntry.h:100]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
> [./src/ceph.cc:317]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
> [./src/mds/MDSMap.h:247]: (possible style) Use failed.empty() instead of failed.size() to guarantee fast code.
> ....
> 
> 
> Please refer the attached patch that chanes a few of this suggestions.
> What do you think about this? Does it boost the performance?

I don't think it'll affect performance in these cases, but stylistically 
it's an improvement, so I'll apply it.

Did cppcheck have anything else to say?

Thanks!
sage


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
