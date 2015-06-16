From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: xattrs vs. omap with radosgw
Date: Tue, 16 Jun 2015 18:38:19 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDA415A@SACMBXIP01.sdcorp.global.sandisk.com>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BLU175-W13D5737A24429707F8F978DFA70-MsuGFMq8XAE@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Guang,
Try to play around with the following conf attributes specially filestore_max_inline_xattr_size and filestore_max_inline_xattrs

// Use omap for xattrs for attrs over
// filestore_max_inline_xattr_size or
OPTION(filestore_max_inline_xattr_size, OPT_U32, 0)     //Override
OPTION(filestore_max_inline_xattr_size_xfs, OPT_U32, 65536)
OPTION(filestore_max_inline_xattr_size_btrfs, OPT_U32, 2048)
OPTION(filestore_max_inline_xattr_size_other, OPT_U32, 512)

// for more than filestore_max_inline_xattrs attrs
OPTION(filestore_max_inline_xattrs, OPT_U32, 0) //Override
OPTION(filestore_max_inline_xattrs_xfs, OPT_U32, 10)
OPTION(filestore_max_inline_xattrs_btrfs, OPT_U32, 10)
OPTION(filestore_max_inline_xattrs_other, OPT_U32, 2)

I think the behavior for XFS is if the xttrs are more than 10, it will use OMAP.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of GuangYang
Sent: Tuesday, June 16, 2015 11:31 AM
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Subject: [ceph-users] xattrs vs. omap with radosgw

Hi Cephers,
While looking at disk utilization on OSD, I noticed the disk was constantly busy with large number of small writes, further investigation showed that, as radosgw uses xattrs to store metadata (e.g. etag, content-type, etc.), which made the xattrs get from local to extents, which incurred extra I/O.

I would like to check if anybody has experience with offloading the metadata to omap:
  1> Offload everything to omap? If this is the case, should we make the inode size as 512 (instead of 2k)?
  2> Partial offload the metadata to omap, e.g. only offloading the rgw specified metadata to omap.

Any sharing is deeply appreciated. Thanks!

Thanks,
Guang
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
