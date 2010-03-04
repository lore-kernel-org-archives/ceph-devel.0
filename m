From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: build fails on centos 5
Date: Thu, 4 Mar 2010 15:47:54 +0000 (UTC)
Message-ID: <hmokna$lnv$2@dough.gmane.org>
References: <hmo8e2$lnv$1@dough.gmane.org>
	<Pine.LNX.4.64.1003040707500.28379@cobra.newdream.net>
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

Am Thu, 04 Mar 2010 07:11:00 -0800 schrieb Sage Weil:

> Hi Thomas,
> 
> On Thu, 4 Mar 2010, Thomas Mueller wrote:
>> /usr/src/ceph-0.19.1/src/os/FileStore.cc:928: undefined reference to
>> `sync_file_range' libos.a(FileStore.o): In function
>> `FileStore::flusher_entry()':
> 
> sync_file_range() appeared in 2.6.17.  It sounds like CentOS 5 was based
> on an older kernel.  Since your kernel is new, a recent glibc is
> probably all you need to get things going.

original centos kernel is 2.6.18. anyhow, i found a RHEL bug (which 
centos is based on):

https://bugzilla.redhat.com/show_bug.cgi?id=518581

comment #1 from this bug:
It has only been added to glibc 2.6, and cannot be backported due to ABI
breakage.  You can always fall back to syscall(3).    

so, RHEL/CentOS 5 will never support this directly. 

what about implementing the mentioned "syscall(3)" workaround for RHEL/
CentOS?

- Thomas


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
