From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore memory leak
Date: Thu, 8 Sep 2016 20:24:37 +0000
Message-ID: <BL2PR02MB2115528CD794399F5E7D7A75F4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB21153E4497C3C2364B543BAEF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3effe79d-b044-c6a2-36d0-53d0b3c149ce@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:30368
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758478AbcIHUYj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 16:24:39 -0400
In-Reply-To: <3effe79d-b044-c6a2-36d0-53d0b3c149ce@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage/Mark,
Leak is still there with latest master, I can't complete a 5 min run , memo=
ry is getting full.

root@emsnode11:~/ceph-master/build# ceph -v
*** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
ceph version v11.0.0-2173-g0985370 (0985370d2d729c6b8ef373e2dc4241b0eea474b=
f)
root@emsnode11:~/ceph-master/build#

Thanks & Regards
Somnath

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com]=20
Sent: Wednesday, September 07, 2016 7:04 PM
To: Somnath Roy; ceph-devel
Subject: Re: Bluestore memory leak

Hi Somnath,

I complained loudly and often enough to get Sage to take a look and he fixe=
d a bunch of stuff. :)  The following PR dramatically improves things, thou=
gh I haven't verified that it's totally fixed yet:

https://github.com/ceph/ceph/pull/11011

Mark

On 09/07/2016 08:08 PM, Somnath Roy wrote:
> Sage,
> As Mark said, the latest code has severe memory leak , my system memory (=
64GB) started swapping after 3 min of 4K RW run.
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>
