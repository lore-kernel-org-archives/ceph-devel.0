From: Sage Weil <sage@newdream.net>
Subject: rebased kernel git on 2.6.34-rc2
Date: Mon, 22 Mar 2010 13:34:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003220926430.22122@cobra.newdream.net>
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

Hi everyone,

I've rebased everything in ceph-client.git not included by Linus' pull 
on 2.6.34-rc2.  (Previously everything was based on 2.6.32-rc2.)  I've 
also reorganized the outstanding patches into a few branches:

 master,for-linus: bug fixes only, intended to be merged for 2.6.34
 for-next: for-linus + everything else (cleanups, feature adds), intended 
for the next merge window.
 unstable: for-next + shiny new stuff

The basic plan is to put anything new in unstable.  Once it passes the 
basic unit testing, it'll be added to for-linus or for-next, depending on 
whether it's a fix intended for this window or for the next.  Normally 
master (latest stable) will match for-linus.  The for-next and unstable 
branches will be rebased periodically on top of master as needed.

Cheers-
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
