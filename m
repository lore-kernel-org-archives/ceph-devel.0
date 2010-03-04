From: Sage Weil <sage@newdream.net>
Subject: Re: users, 2.6.34
Date: Thu, 4 Mar 2010 08:06:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003040757180.28379@cobra.newdream.net>
References: <ce7365351003040429w39061f24yb614988339828bc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <ce7365351003040429w39061f24yb614988339828bc9@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Stefan Majer <stefan.majer@gmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi Stefan,

On Thu, 4 Mar 2010, Stefan Majer wrote:
> we are currently in the evaluation of ceph. We want to use ceph as
> filesystem to store kvm virtual machine block images, as well as a s3
> object store.

We have talked about writing a storage driver for qemu to interact 
directly with the object storage layer for KVM images.  This would avoid 
any interaction with the MDS (which is largely superfluous) and hopefully 
be a bit faster.  Have you seen the Sheepdog project?  They've done 
something similar.

> Our test setup is build of 4 servers with 1.2TB raid0, composed of
> 4*300GB SCSI drives. We have 4 osds and 1 mds running actually but we
> want to have at least 2-3 mds.
> 
> We use fedora12 x64 and we had a couple of issues so far.
> 
> 1. We were not able to start 4 individual osd per server. With this
> configuration we tried to get best cpu utilization (one osd per
> CPU-Core, one osd per single disk). We always got Kernel OOPS when we
> tried to stop osd.
> [...]
> 2. With the actual configuration (4 disks per server configured to
> raid0, one osd per server ) we sometimes have similar crashes when we
> try to stop ceph.

Are you using btrfs?  If so, there was a problem a while back where the 
user transaction code would break jbd journaling (in ext3/4) due to the 
btrfs' use of current->journal_info.  The bug was fixed in 2.6.32, so just 
upgrading your kernel should fix the problem.  (You _may_ also be able to 
work around it by disabling all logging, but no promises there. :)

> 3. modifying the crushmap does not work at all:
> 
> [root@sc01 ~]# ceph osd getcrushmap -o /tmp/crush
> 10.03.04 14:25:53.944335 mon <- [osd,getcrushmap]
> 10.03.04 14:25:53.944921 mon0 -> 'got crush map from osdmap epoch 33' (0)
> 10.03.04 14:25:53.945578 wrote 349 byte payload to /tmp/crush
> [root@sc01 ~]# crushtool -d /tmp/crush -o /tmp/crush.txt
> [root@sc01 ~]#  crushtool -c /tmp/crush.txt -o /tmp/crush.new
> /tmp/crush.txt:52 error: parse error at ''

This appears to be a problem with the version of the latest boost parsing 
library used for building the sid package (the slightly older version on 
my dev machine work fine).  I'll see if I can narrow it down today.

> Beside that we think that ceph is very promising and we would like to
> contribute to bring this filesystem to a production quality, at least
> with extensive testing.

Thanks!
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
