From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: Updated kvm driver
Date: Fri, 26 Mar 2010 11:34:07 -0700
Message-ID: <a37615151003261134g5954fd7ib783243ca753f4d7@mail.gmail.com>
References: <20100314161415.GA83139@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100314161415.GA83139@ncolin.muc.de>
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

On Sun, Mar 14, 2010 at 9:14 AM, Christian Brunner <chb@muc.de> wrote:
>
> Attached is an updated version of my rados kvm driver. I did the following
> changes:
>

We tested it and it looks great. We were working on a native linux
rados block device, and it'll be great if it would be compatible with
the kvm one. There were some fairly minor issues that were related to
the header. This is the modified metadata header that we're currently
using:

struct rbd_obj_header_ondisk {
	char text[64];
	char signature[4];
	char version[8];
	__le64 image_size;
	char obj_order;
	unsigned char crypt_type;
	unsigned char comp_type;
	__le16 snap_count;
	__le32 snap_id[0];
} __attribute__((packed));


Note that I changed objsize to obj_order, so that it'd be clear that
the object size is a power of 2. Also, each of the fields should have
be endian aware. We prefer using little-endian data, just so that it
would be consistent across the ceph system.
Another issue is that the structure should be packed, so that it
doesn't have any alignment problems.
The original structure specified an array of MAX_SNAPS snap_id, where
MAX_SNAPS is currently 4096. I'd rather have it set later on
dynamically, as this is huge and quite a waste.

The following was also changed:

#define RBD_SUFFIX	 	".rbd"

#define RBD_MAX_OBJ_NAME_SIZE	96
#define RBD_MAX_SEG_NAME_SIZE	128

I'd rather that the RBD_SUFFIX be a bit more meaningful. The object
name size was reduced to 96 so that we don't overflow when adding the
segment name.

Thanks!
Yehuda

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
