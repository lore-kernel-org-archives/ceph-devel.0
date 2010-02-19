From: Sage Weil <sage@newdream.net>
Subject: Re: Write operation is stuck
Date: Fri, 19 Feb 2010 10:39:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002191007260.20757@cobra.newdream.net>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002161032280.31640@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A238242@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <C6A64D82E3A5D24B949315CFBC1FA1AD072A238242@DEWDFECCR01.wdf.sap.corp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: "Talyansky, Roman" <roman.talyansky@sap.com>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

Hi Roman,

On Fri, 19 Feb 2010, Talyansky, Roman wrote:
> Since I test several ceph versions simultaneously I could confuse the error checking at different nodes.
> I'll double check this and let you know.

Thanks.  If you haven't switched to the just-released 0.19, now might be 
the time to do that.

> > It also looks like the IO is synchronous, which may have something 
> > to do with your performance.  Are you mounting with -o sync or using 
> > direct IO, or are multiple clients reading and writing to the same file or 
> > something?
>
> The IO is indeed synchronous. However the performance under ceph is much 
> worse than even under nfs, which looks strange. I do not mount with -o 
> synch. And in our experiments multiple clients read and write the same 
> file.

If you are accessing the same file from multiple clients, then any 
comparison with nfs is going to be misleading.  NFS provides only close to 
open consistency, so IO will be buffered and inconsistent.  Ceph provides 
fully consistent semantics by switching to synchronous IO when there are 
multiple clients.  Ceph will be slower, but correct; nfs will be fast, but 
incorrect.

If your application is smart enough to handle it's own consistency (each 
client is writing to a different region of the file) then you probably 
want something along the lines of O_LAZY [1], so that the application can 
tell the FS not to worry about consistency and stick with buffered IO.  
Unfortunately O_LAZY doesn't exist in Linux at this point.  There is some 
preliminary support for it in Ceph... if that's what you're looking for, 
we can cook up some patches for you.

If you can find us in #ceph on irc.oftc.net that might be a quicker way to 
diagnose the performance problems with your workload.

Thanks!
sage

[1] http://www.pdl.cmu.edu/posix/docs/posix_lazy_io.pdf

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
