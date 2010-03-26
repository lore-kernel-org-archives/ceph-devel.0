From: yehuda <yehuda@hq.newdream.net>
Subject: Re: Updated kvm driver
Date: Fri, 26 Mar 2010 12:20:50 -0700
Message-ID: <1269631250.19540.0.camel@yehudasa-desktop>
References: <20100314161415.GA83139@ncolin.muc.de>
	<a37615151003261134g5954fd7ib783243ca753f4d7@mail.gmail.com>
	<Pine.LNX.4.64.1003261215060.12653@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1003261215060.12653@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sourceforge.net, Christian Brunner <chb@muc.de>
List-Id: ceph-devel.vger.kernel.org

On Fri, 2010-03-26 at 12:17 -0700, Sage Weil wrote:
> On Fri, 26 Mar 2010, Yehuda Sadeh Weinraub wrote:
> > On Sun, Mar 14, 2010 at 9:14 AM, Christian Brunner <chb@muc.de> wrote:
> > >
> > > Attached is an updated version of my rados kvm driver. I did the following
> > > changes:
> > >
> > 
> > We tested it and it looks great. We were working on a native linux
> > rados block device, and it'll be great if it would be compatible with
> > the kvm one. There were some fairly minor issues that were related to
> > the header. This is the modified metadata header that we're currently
> > using:
> > 
> > struct rbd_obj_header_ondisk {
> > 	char text[64];
> > 	char signature[4];
> > 	char version[8];
> > 	__le64 image_size;
> > 	char obj_order;
> 
> Maybe
> 	unsigned char obj_order;
> 
> > 	unsigned char crypt_type;
> > 	unsigned char comp_type;
> 
> or __u8 for all of these?
> 
> > 	__le16 snap_count;
> > 	__le32 snap_id[0];
> 
> Make this:
> 	__le64 snap_seq;
> 	__le16 snap_count;
> 	__le64 snap_id[0];
> 
> > } __attribute__((packed));

Fixed.

Thanks!
Yehuda


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
