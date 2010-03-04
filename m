From: Sage Weil <sage@newdream.net>
Subject: Re: build fails on centos 5
Date: Thu, 4 Mar 2010 07:11:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003040707500.28379@cobra.newdream.net>
References: <hmo8e2$lnv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <hmo8e2$lnv$1@dough.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi Thomas,

On Thu, 4 Mar 2010, Thomas Mueller wrote:
> /usr/src/ceph-0.19.1/src/os/FileStore.cc:928: undefined reference to `sync_file_range'
> libos.a(FileStore.o): In function `FileStore::flusher_entry()':

sync_file_range() appeared in 2.6.17.  It sounds like CentOS 5 was based 
on an older kernel.  Since your kernel is new, a recent glibc is probably 
all you need to get things going.

sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
