From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next giant release
Date: Tue, 10 Feb 2015 10:29:06 -0500 (EST)
Message-ID: <1926683775.2844514.1423582146260.JavaMail.zimbra@redhat.com>
References: <54DA1E34.8050301@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:59583 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbBJPaK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 10:30:10 -0500
In-Reply-To: <54DA1E34.8050301@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 10, 2015 7:05:24 AM
> Subject: rgw and the next giant release
>=20
> Hi Yehuda,
>=20
> The rgw teuthology suite for the next giant release as found in
> https://github.com/ceph/ceph/commits/giant-backports came back (see
> http://pulpito.ceph.com/loic-2015-02-02_23:56:11-rgw-giant-backports-=
--basic-multi)
> with one environmental error
> http://tracker.ceph.com/issues/10501#teuthology-run-6b08a729540c61f3c=
8b15c5a3ce9382634bf800c-february-2015.
>=20
> Do you think it is ready for QE to start their own round of testing ?

Yes.

Thanks,
Yehuda

>=20
> Note that the integration branch now contains all the rgw pull reques=
ts
> targeting giant as listed here:
>=20
> http://workbench.dachary.org/ceph/ceph-backports/wikis/giant#included=
-and-tested-in-integration-branch
>=20
> Which includes cherry picks I did for the following as you suggested:
>=20
>  - 9918  RGW-Swift: SubUser access permissions, does not seems to wor=
kminor
>  - 10103 swift tests failing
> upgrade:dumpling-firefly-x:parallel-next-distro-basic-multi run
>  - 10471 rgw: metadata sync doesn't create subusers correctly
>  - 9254  rgw: civetweb requires explicit \r\n for http headers
>  - 9478  Incorrect content type in response header
>  - 9479  ETag is not included in the XML response to put object copy
> operationminor
>  - 9877  In some cases it's possible for rgw to segfault on http COPY
>  - 5595  object has a Content-Type, but its content_type property is
> not shown in Swift object enumeration
>  - 9907  Normal    radosgw-admin: can't disable max_size quota
>  - 9973  Validation of Swift DLO manifest object ETag doesn't match
> OpenStack Swift behavior
>  - 10307 rgw: setting bucket attributes (swift POST on bucket)
> sometimes failminor
>  - 9587  ceph-radosgw sysvinit script on EL6 cannot set ulimit
>=20
> Your original list included three more:
>=20
>  - 9878  rhel7 s3-tests fail due to missing reason
>  - 10329 rgw: s3 need to return SignatureDoesNotMatch instead of Acce=
ssDenied
>  - 10334 rgw: s3 need to return InvalidAccessKeyId instead of AccessD=
enied
>=20
> but you wrote that 10329 and 10334 do not need backporting and 9878 w=
as
> already backported.
>=20
> Cheers
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
