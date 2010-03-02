From: Brian Jackson <iggy@theiggy.com>
Subject: Re: users, 2.6.34
Date: Tue, 2 Mar 2010 16:07:17 -0600
Message-ID: <201003021607.17858.iggy@theiggy.com>
References: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
Cc: Sage Weil <sage@newdream.net>
List-Id: ceph-devel.vger.kernel.org

On Tuesday 02 March 2010 01:27:11 pm Sage Weil wrote:
> Hi,
> 
> The 2.6.34 merge window is open, and I will be sending another request to
> Linus shortly asking him to merge the Ceph kernel client.  I'd like to be
> able to accurate describe the current user base and level of interest.


We are currently still evaluating, but our eventual goal is to have a 
small(ish) Ceph cluster being our main file store for a bunch of Linux dev 
machines and also have the Ceph filesystem (or some portion of it) shared out 
to the admin staff (i.e. Windows users) via some sort of failover Samba if 
possible.

Arguably, Ceph has some hurdles to cross before we are ready to put that out 
there for general use inside our company, but I think it will likely mesh with 
our timetable for doing this pretty well.

Our next product release will likely be based on Fedora 13 and all of our 
build/dev boxes will move to F13 at that time. So it would be awesome to get 
Ceph in there. For the older build/dev systems (Fedora 9 I think) we'll likely 
use NFS to export the Ceph filesystem or possibly the fuse client.


> 
> If you've tried v0.19, can you take a minute to let us know what your
> experience has been?  Did you get the system up and running?  Were there
> problems along the way?  What size system are you testing and/or planning?
> 
> If you haven't tried the code recently, is there anything specific you're
> waiting to see before you do?
> 
> The next Fedora will include packages for the Ceph server side.  It
> probably won't include the kernel client, unless it goes upstream first.
> Is there interest in seeing packages build for other distributions?
> 
> Thanks-
> sage
> 
> ---------------------------------------------------------------------------
> --- Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
