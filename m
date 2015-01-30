From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rgw backports to giant update
Date: Fri, 30 Jan 2015 11:05:21 -0800
Message-ID: <CABBk=J837H7WnZYBAa=SP0_CcDrRcVzY3_2dB-S_zMk6OHB7XQ@mail.gmail.com>
References: <54C98379.7030100@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36276 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbbA3TFW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 14:05:22 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so55693772pab.0
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 11:05:21 -0800 (PST)
In-Reply-To: <54C98379.7030100@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

these are the actual issues that I backported:

 - 9878  rhel7 s3-tests fail due to missing reason
 - 9918  RGW-Swift: SubUser access permissions, does not seems to workm=
inor
 - 10103 swift tests failing
 - 10354 Failed s3 tests in
upgrade:dumpling-firefly-x:parallel-next-distro-basic-multi run
 - 10471 rgw: metadata sync doesn't create subusers correctly
 - 9254  rgw: civetweb requires explicit \r\n for http headers
 - 9478  Incorrect content type in response header
 - 9479  ETag is not included in the XML response to put object copy
operationminor
 - 9877  In some cases it's possible for rgw to segfault on http COPY
 - 10329 rgw: s3 need to return SignatureDoesNotMatch instead of
AccessDenied- minor
 - 5595  object has a Content-Type, but its content_type property is
not shown in Swift object enumeration
 - 9907  Normal    radosgw-admin: can't disable max_size quota
 - 9973  Validation of Swift DLO manifest object ETag doesn't match
OpenStack Swift behavior
 - 10307 rgw: setting bucket attributes (swift POST on bucket)
sometimes failminor
 - 10334 rgw: s3 need to return InvalidAccessKeyId instead of AccessDen=
ied
 - 9587  ceph-radosgw sysvinit script on EL6 cannot set ulimit


On Wed, Jan 28, 2015 at 4:48 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yehuda,
>
> Unless I'm mistaken there currently are no rgw issues scheduled to be=
 backported to giant (i.e. with the giant word in the backport field of=
 the issue)[1] that have already been backported to firefly, as part of=
 the v0.80.8[2] release or after[3]. You mentionned that about 18 patch=
es backported to firefly should also be backported to giant and I was h=
oping to find which one exactly thanks to the backport field.
>
> I'll go thru the rgw backports found in v0.80.8 to figure out which o=
ne should be in giant. I don't need anything righ now, this is just an =
update to let you know things are making progress.
>
> Cheers
>
> [1] inventory of the pending giant v0.87.1 release http://tracker.cep=
h.com/issues/10501
> [2] inventory of the firefly v0.80.8 commits http://tracker.ceph.com/=
issues/10639
> [3] inventory of the pending firefly v0.80.9 release http://tracker.c=
eph.com/issues/10641
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
