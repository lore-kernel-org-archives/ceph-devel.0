From: Sage Weil <sage@newdream.net>
Subject: Re: kvm driver
Date: Tue, 9 Mar 2010 13:09:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003091305450.32679@cobra.newdream.net>
References: <20100308054150.GA40223@ncolin.muc.de>
	<Pine.LNX.4.64.1003081402260.15770@cobra.newdream.net>
	<20100309210038.GA50616@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100309210038.GA50616@ncolin.muc.de>
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

On Tue, 9 Mar 2010, Christian Brunner wrote:
> On Mon, Mar 08, 2010 at 10:18:11PM +0000, Sage Weil wrote:
> > Is there any particular reason to restrict the 'device name' to 12 chars?
> 
> On the ceph blog I have read that the name of an object is a fixed-size
> 20 byte identifier. That's why I've chosen to use a base64 encoded sequence
> number. This sequence number requires 8 bytes to store, so there are 12 bytes
> left for the 'device name'. If this is no longer a restriction, using longer 
> names (with a hex encoding of the sequence number) would make sense.

Oh, yeah, that restriction was removed a while ago now.  The object name 
is now an arbitrary string, so you can use whatever is most 
convenient.

Let us know how it goes!
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
