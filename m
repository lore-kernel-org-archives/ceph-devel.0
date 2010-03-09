From: Anton <anton.vazir@gmail.com>
Subject: Re: v0.19.1 stable updates
Date: Tue, 9 Mar 2010 16:48:36 +0500
Message-ID: <201003091648.36832.anton.vazir@gmail.com>
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
Cc: Sage Weil <sage@newdream.net>, ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

Sage, do you think CEPH now is ok (stable enough) to be 
atleast sure that uploaded data will not be corrupted, (and 
could be recovered in the case of fault) - for use as simple 
file store - say in the scenario of  "upload/modify rarely, 
read often"?. Right now I use Gluster as clustered FS - but 
overhead of 1+1 replication in Gluster is just HUGE

Regards,
Anton.

On Wednesday 03 March 2010, Sage Weil wrote:
> Hi all,
> 
> We've pushed out some stable updates to master granches
>  of the git trees and tagged a 0.19.1 stable release. 
>  For the server side, the fixes are minor: mainly a
>  problem with /etc/init.d/ceph when /bin/sh is dash
>  (ubuntu) and a rare mds crash.  The kernel client fixes
>  are a bit more significant: mainly a bad write(2) return
>  value and a crash when snapshots were deleted.
> 
> sage
> 
> -- server side ------------------
> 
> Sage Weil (8):
>       debian: mount.ceph in /sbin, not /usr/sbin
>       Makefile: include debian/
>       Makefile: fix /sbin hack
>       mds: fix sessionmap decoding
>       init-ceph: don't barf on dash when no command
>       cauthtool: --caps fn alone is a command
>       debian: new release, push, build, publish scripts
>       0.19.1
> 
> Yehuda Sadeh (1):
>       automake: fix mount sbin dir when configured with
>  prefix
> 
> 
> -- kernel client -----------------
> 
> Alexander Beregalov (1):
>       ceph: move dereference after NULL test
> 
> Sage Weil (5):
>       ceph: fix handle_forward parsing
>       ceph: reset front len on return to msgpool; BUG on
>  mismatched front iov ceph: set osd request message front
>  length correctly ceph: fix osdmap decoding when pools
>  include (removed) snaps ceph: v0.19.1 stable release
> 
> Yehuda Sadeh (1):
>       ceph: don't clobber write return value when using
>  O_SYNC
> 
> 
> ---------------------------------------------------------
> --------------------- Download Intel&#174; Parallel
>  Studio Eval
> Try the new software tools for yourself. Speed compiling,
>  find bugs proactively, and fine-tune applications for
>  parallel performance. See why Intel Parallel Studio got
>  high marks during beta. http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
> 



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
