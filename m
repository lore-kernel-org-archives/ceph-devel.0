From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: xattrs vs. omap with radosgw
Date: Tue, 16 Jun 2015 21:11:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506162109220.16406@cobra.newdream.net>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>
	<alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
	<06681238D8946F44A60AA400760A1CBF01FDC834@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-681950229-1434514261=:16406"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <06681238D8946F44A60AA400760A1CBF01FDC834-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Zhou, Yuan" <yuan.zhou-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-681950229-1434514261=:16406
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2015, Zhou, Yuan wrote:
> FWIW, there was some discussion in OpenStack Swift and their performanc=
e tests showed 255 is not the best in recent XFS. They decided to use lar=
ge xattr boundary size(65535).
>=20
> https://gist.github.com/smerritt/5e7e650abaa20599ff34

If I read this correctly the total metadata they are setting is pretty=20
big:

PILE_O_METADATA =3D pickle.dumps(dict(
    ("attribute%d" % i, hashlib.sha512("thingy %d" % i).hexdigest())
    for i in range(200)))

So lots of small attrs won't really help since they'll have to spill out=20
into other extents eventually no matter what.

In our case, we have big (2k) inodes and can easily fit everything in=20
there.. as long as it is in <255 byte pieces.

sage


>=20
>=20
> -----Original Message-----
> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-owner-fy+rA21nqHI@public.gmane.org=
rnel.org] On Behalf Of Sage Weil
> Sent: Wednesday, June 17, 2015 3:43 AM
> To: GuangYang
> Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Subject: Re: xattrs vs. omap with radosgw
>=20
> On Tue, 16 Jun 2015, GuangYang wrote:
> > Hi Cephers,
> > While looking at disk utilization on OSD, I noticed the disk was cons=
tantly busy with large number of small writes, further investigation show=
ed that, as radosgw uses xattrs to store metadata (e.g. etag, content-typ=
e, etc.), which made the xattrs get from local to extents, which incurred=
 extra I/O.
> >=20
> > I would like to check if anybody has experience with offloading the m=
etadata to omap:
> > =A0 1> Offload everything to omap? If this is the case, should we mak=
e the inode size as 512 (instead of 2k)?
> > =A0 2> Partial offload the metadata to omap, e.g. only offloading the=
 rgw specified metadata to omap.
> >=20
> > Any sharing is deeply appreciated. Thanks!
>=20
> Hi Guang,
>=20
> Is this hammer or firefly?
>=20
> With hammer the size of object_info_t crossed the 255 byte boundary, wh=
ich is the max xattr value that XFS can inline.  We've since merged somet=
hing that stripes over several small xattrs so that we can keep things in=
line, but it hasn't been backported to hammer yet.  See c6cdb4081e366f471=
b372102905a1192910ab2da.  Perhaps this is what you're seeing?
>=20
> I think we're still better off with larger XFS inodes and inline xattrs=
 if it means we avoid leveldb at all for most objects.
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-681950229-1434514261=:16406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-681950229-1434514261=:16406--
