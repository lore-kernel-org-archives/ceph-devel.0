From: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: xattrs vs. omap with radosgw
Date: Tue, 16 Jun 2015 18:31:09 +0000
Message-ID: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Cephers,
While looking at disk utilization on OSD, I noticed the disk was constantly=
 busy with large number of small writes, further investigation showed that,=
 as radosgw uses xattrs to store metadata (e.g. etag, content-type, etc.), =
which made the xattrs get from local to extents, which incurred extra I/O.

I would like to check if anybody has experience with offloading the metadat=
a to omap:
=A0 1> Offload everything to omap? If this is the case, should we make the =
inode size as 512 (instead of 2k)?
=A0 2> Partial offload the metadata to omap, e.g. only offloading the rgw s=
pecified metadata to omap.

Any sharing is deeply appreciated. Thanks!

Thanks,
Guang 		 	   		  =
