From: "Robin H. Johnson" <robbat2-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: RGW CreateBucket: AWS vs RGW, 200/409 responses
Date: Mon, 25 Dec 2017 06:28:01 +0000
Message-ID: <robbat2-20171225T061012-699561209Z@orbis-terrarum.net>
References: <20171225035236.EF60F81000ED@webmail.sinamail.sina.com.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8434950916325065947=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20171225035236.EF60F81000ED-2RFepEojUI2gQzYKMK1YzK/p1tWXv8elb9TvmfFkwKk@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============8434950916325065947==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BtNCO5h84ExDStzY"
Content-Disposition: inline


--BtNCO5h84ExDStzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2017 at 11:52:36AM +0800, QR wrote:
> Is anyone know the reason that ERR_BUCKET_EXISTS is modified to zero?
> Thanks.
This comes down to arguing about AWS S3 CreateBucket behavior if the
bucket already existed and was owned by you (plus which region it is in
vs where the request was made to).
AWS S3 us-east-1: returns 200 OK
AWS S3 other regions: return 409 Conflict: BucketAlreadyOwnedByYou

RGW implements the 200-OK behavior, which is why the return is modified
to zero (ret=3D=3D0 -> HTTP 200 OK).

I created issue 17398 a year ago to discuss it:
http://tracker.ceph.com/issues/17398

I see recently that issue 22279 was created for the same thing, with an
attached PR, but the same discussion.
http://tracker.ceph.com/issues/22279
https://github.com/ceph/ceph/pull/19249

Yehuda's opinion is that the 200-OK behavior is better, because
CreateBucket should be an idempotent operation.

My opinion is that the 409-BucketAlreadyOwnedByYou behavior is better,
because the CreateBucket annoyingly is actually two operations:
(CreateBucket, SetBucketACL).
If the bucket does already exist, but the ACLs you pass in bucket
creation are NOT the same as the existing bucket ACLs, what should
happen?
- Skip creation, skip ACLs? 200-OK response is dangerously misleading here.
- Skip creation, replace ACLs? This is going to overwrite the existing
  ACLs, rather than modify them.
- Do nothing and issue a warning about ACL mismatch? Annoying in that
  we're diverging more from AWS behavior.

AWS S3 went to 409-BucketAlreadyOwnedByYou for a reason. They've never
stated exactly why, but I believe their choice makes sense.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Asst. Treasurer
E-Mail   : robbat2-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--BtNCO5h84ExDStzY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlpAmnFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQkdw//dTiOV/dVXKBzsozul9BSlUEo/It58D/2lxopP89xN91vDJw1fY8tCrFz
QRO8cp5NoiNXuAc6DCBFwqciVsWCBuuZMkGI9dhaqDR8GedI9MyjX55EryKDnPud
A64OiLhW1AncOXcnKTPOuWStPo+J9RxafteYBmawwjPH8MW9DSY68Uz6R8UMybDj
Xw/I025sOCeN64iVpdCBukm3FH8DfLVe70SNAFNKG7hZJEsbgfxZyrh9goc8TJBU
hpMi/LvR/oG6HXE6a/QcUNmX1thiVWi8JQIeIDLkD8fZgwOtq9RPYFu2SufKZm0p
vKzw4QuzMpAFoGc5sIMrgOdmFPjpvkU5MTFXfLbdm1AYw/tPUQsOP11qSoSdFplw
OWFPc5PHbBb4vH8IwdBnK5PBhwd+cPdAwLpOU5dX5/elGf4B3b7lyYC/FvQXWRns
0PFgY4XajscAGhvdBoQBKkX3wQeWvRXAD75OHOLzW7DYNZKBjxtJpHsO+PuKjT83
Pemnd9t2+8duq6P44FvinTupa6bcwv7BRM8+OnQy8N5gMG/GJ4FOlhV0dKSDLFRw
Yzesifo5xa7fiCthIKv5J2RHoDQ3Jx24zBKZB1MkCok0fSLolmFIhQ/ApLZBMiIT
ezrbDBqmodjNHO7rAHlZBkvGO1zARR8nZrUghmq5zLvyPhMdYKs=
=sLVP
-----END PGP SIGNATURE-----

--BtNCO5h84ExDStzY--

--===============8434950916325065947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8434950916325065947==--
