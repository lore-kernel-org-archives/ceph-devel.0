From: Sage Weil <sage@newdream.net>
Subject: Re: End to end data integrity checking in Ceph?
Date: Mon, 22 Mar 2010 09:58:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003220938310.21746@cobra.newdream.net>
References: <29143.1269202949@n20.hq.graphstream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <29143.1269202949@n20.hq.graphstream.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Craig Dunwoody <cdunwoody@graphstream.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi Craig,

On Sun, 21 Mar 2010, Craig Dunwoody wrote:
> -   Some of my customers are particularly paranoid about data integrity.
>     I believe that there are some parallel/distributed storage systems
>     (Panasas? Others?)  that claim to provide options for some kind of
>     data integrity checking within the fault domain of the client, as a
>     final step before delivering read-data to the application, and
>     perhaps also as a first step after receiving write-data from the
>     application.
> 
>     The hope would be to catch any data corruption that could possibly
>     take place between clients and servers, even if relatively unlikely
>     (e.g.  bits getting flipped in network transport).
> 
> -   Does the current Ceph implementation already do some variation of
>     this?  If not, how difficult do you think it might be to add as a
>     future optional feature?  Could it be added without breaking
>     compatibility of wire-protocol and on-disk format?

The ceph transport layer does a crc32c over all data that passes over the 
wire to catch bit flips from the network (TCP's checksumming isn't very 
strong).  This isn't truly end-to-end protection, though, as bit flips on 
the client after the applicate write(2) but before writeback starts, or on 
the server after receiving the message won't be detected.

Btrfs does do it's own checksumming, so in theory if we match the function 
on the client we can do better.  There is also some end-to-end data 
integrity infrastructure in the kernel that IIRC Martin Peterson was 
working on.  Much that is in the block layer, though; the only parts that 
would be useful to ceph would relate to the userspace interface and page 
cache.  I'm not sure what the current state of that work is.

It would be nice to see end-to-end protection (complete with some sort of 
userspace api) in action on a local file system (probably btrfs, which 
actually stores checksums) as a model before trying to build it into a 
more complicated distributed file system...
 
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
