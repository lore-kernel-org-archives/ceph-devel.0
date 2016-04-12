From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-maintainers] Deprecating ext4 support
Date: Tue, 12 Apr 2016 08:39:38 +0200
Message-ID: <570C982A.5090600@dachary.org>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:15273 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbcDLGjq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 02:39:46 -0400
In-Reply-To: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Hi Sage,

I suspect most people nowadays run tests and develop on ext4. Not suppo=
rting ext4 in the future means we'll need to find a convenient way for =
developers to run tests against the supported file systems.

My 2cts :-)

On 11/04/2016 23:39, Sage Weil wrote:
> Hi,
>=20
> ext4 has never been recommended, but we did test it.  After Jewel is =
out,=20
> we would like explicitly recommend *against* ext4 and stop testing it=
=2E
>=20
> Why:
>=20
> Recently we discovered an issue with the long object name handling th=
at is=20
> not fixable without rewriting a significant chunk of FileStores filen=
ame=20
> handling.  (There is a limit in the amount of xattr data ext4 can sto=
re in=20
> the inode, which causes problems in LFNIndex.)
>=20
> We *could* invest a ton of time rewriting this to fix, but it only af=
fects=20
> ext4, which we never recommended, and we plan to deprecate FileStore =
once=20
> BlueStore is stable anyway, so it seems like a waste of time that wou=
ld be=20
> better spent elsewhere.
>=20
> Also, by dropping ext4 test coverage in ceph-qa-suite, we can=20
> significantly improve time/coverage for FileStore on XFS and on BlueS=
tore.
>=20
> The long file name handling is problematic anytime someone is storing=
=20
> rados objects with long names.  The primary user that does this is RG=
W,=20
> which means any RGW cluster using ext4 should recreate their OSDs to =
use=20
> XFS.  Other librados users could be affected too, though, like users=20
> with very long rbd image names (e.g., > 100 characters), or custom=20
> librados users.
>=20
> How:
>=20
> To make this change as visible as possible, the plan is to make ceph-=
osd=20
> refuse to start if the backend is unable to support the configured ma=
x=20
> object name (osd_max_object_name_len).  The OSD will complain that ex=
t4=20
> cannot store such an object and refuse to start.  A user who is only =
using=20
> RBD might decide they don't need long file names to work and can adju=
st=20
> the osd_max_object_name_len setting to something small (say, 64) and =
run=20
> successfully.  They would be taking a risk, though, because we would =
like=20
> to stop testing on ext4.
>=20
> Is this reasonable?  If there significant ext4 users that are unwilli=
ng to=20
> recreate their OSDs, now would be the time to speak up.
>=20
> Thanks!
> sage
>=20
> _______________________________________________
> Ceph-maintainers mailing list
> Ceph-maintainers@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-maintainers-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
