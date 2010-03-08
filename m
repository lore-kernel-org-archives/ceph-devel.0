From: Sage Weil <sage@newdream.net>
Subject: Re: kvm driver
Date: Mon, 8 Mar 2010 14:18:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003081402260.15770@cobra.newdream.net>
References: <20100308054150.GA40223@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100308054150.GA40223@ncolin.muc.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi Christian,

This looks great!

On Mon, 8 Mar 2010, Christian Brunner wrote:
> since you where talking about a kvm driver storage driver lately, I wanted
> to let you know that I've started writing such a driver. 
> 
> Getting the driver - called "rbd" (Rados Block Device) - to a basic working
> state was not that hard. However there still is a problem when used together
> with the kvm raw-aio driver (i.e. for attaching a virtual cdrom). My suspicion
> is, that the signal handling used inside librados and the one inside the
> kvm raw driver conflicts. I've already tried to build a work around and
> the situation got slightly better, but I'm still experiencing timeout 
> problems in the raw-aio driver.
> 
> The patch for qemu-0.12.3 is attached. I would appreciate it if someone
> with a deeper understanding of the signal handling in librados and/or
> kvm could have a look.

Yehuda is taking a look at it now.  The signals are used to wake up 
blocking read()/write()/connect(), but we should be able to use poll() or 
select() instead (and clean things up in the process).

> Your opinion on the naming scheme used to store the objects of the device
> image is welcome, too. (see comment in the code for details)

I would number the objects in hex so that it's easier to translate a block 
or byte offset to an object (maybe just sprintf(n, "%s.%08llx", ...)).  
And then name the metadata object something more explicit, like 
%s.head or %s.metadata or something along those lines.

Also, the object size should probably be a parameter in the header object, 
so that you can specify whatever stripe size you want when creating the 
device (4MB is somewhat arbitrary).  The same goes for the block size too, 
I guess (is 4K a more reasonable default?).

Is there any particular reason to restrict the 'device name' to 12 chars?

I look forward to trying this out once we have the signals sorted out.
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
