From: Christian Brunner <chb@muc.de>
Subject: Re: kvm driver
Date: Tue, 9 Mar 2010 22:00:38 +0100
Message-ID: <20100309210038.GA50616@ncolin.muc.de>
References: <20100308054150.GA40223@ncolin.muc.de>
	<Pine.LNX.4.64.1003081402260.15770@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1003081402260.15770@cobra.newdream.net>
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

On Mon, Mar 08, 2010 at 10:18:11PM +0000, Sage Weil wrote:
> > 
> > The patch for qemu-0.12.3 is attached. I would appreciate it if someone
> > with a deeper understanding of the signal handling in librados and/or
> > kvm could have a look.
> 
> Yehuda is taking a look at it now.  The signals are used to wake up 
> blocking read()/write()/connect(), but we should be able to use poll() or 
> select() instead (and clean things up in the process).

Great! - That was really a quick response. I will check out the current
git version tomorrow and will give it a try.

> I would number the objects in hex so that it's easier to translate a block 
> or byte offset to an object (maybe just sprintf(n, "%s.%08llx", ...)).  
> And then name the metadata object something more explicit, like 
> %s.head or %s.metadata or something along those lines.
> 
> Also, the object size should probably be a parameter in the header object, 
> so that you can specify whatever stripe size you want when creating the 
> device (4MB is somewhat arbitrary).  The same goes for the block size too, 
> I guess (is 4K a more reasonable default?).

OK. I will do that. (I'm not sure about how kvm handles the block size,
but I'll look into it).

> Is there any particular reason to restrict the 'device name' to 12 chars?

On the ceph blog I have read that the name of an object is a fixed-size
20 byte identifier. That's why I've chosen to use a base64 encoded sequence
number. This sequence number requires 8 bytes to store, so there are 12 bytes
left for the 'device name'. If this is no longer a restriction, using longer 
names (with a hex encoding of the sequence number) would make sense.

Christian

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
