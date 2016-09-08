From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore memory leak
Date: Thu, 8 Sep 2016 20:31:34 +0000
Message-ID: <BL2PR02MB2115B854CD3ECBA130B8731AF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB21153E4497C3C2364B543BAEF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3effe79d-b044-c6a2-36d0-53d0b3c149ce@redhat.com>
 <BL2PR02MB2115528CD794399F5E7D7A75F4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <777f0f87-864a-a88e-fd37-39ff7e309c62@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0049.outbound.protection.outlook.com ([104.47.33.49]:8128
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755265AbcIHUbh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 16:31:37 -0400
In-Reply-To: <777f0f87-864a-a88e-fd37-39ff7e309c62@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes, a bit probably :-)..Will try to find out from where it is leaking..

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com]=20
Sent: Thursday, September 08, 2016 1:28 PM
To: Somnath Roy; ceph-devel
Subject: Re: Bluestore memory leak

What I'm seeing is that after 5 minutes of 4k random writes, my OSDs are us=
ing about half the memory they were previously.  I'm not sure we have entir=
ely fixed it, but can you you confirm that it's at least growing slower tha=
n it used to?

Mark

On 09/08/2016 03:24 PM, Somnath Roy wrote:
> Sage/Mark,
> Leak is still there with latest master, I can't complete a 5 min run , me=
mory is getting full.
>
> root@emsnode11:~/ceph-master/build# ceph -v
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***=20
> ceph version v11.0.0-2173-g0985370=20
> (0985370d2d729c6b8ef373e2dc4241b0eea474bf)
> root@emsnode11:~/ceph-master/build#
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Wednesday, September 07, 2016 7:04 PM
> To: Somnath Roy; ceph-devel
> Subject: Re: Bluestore memory leak
>
> Hi Somnath,
>
> I complained loudly and often enough to get Sage to take a look and he fi=
xed a bunch of stuff. :)  The following PR dramatically improves things, th=
ough I haven't verified that it's totally fixed yet:
>
> https://github.com/ceph/ceph/pull/11011
>
> Mark
>
> On 09/07/2016 08:08 PM, Somnath Roy wrote:
>> Sage,
>> As Mark said, the latest code has severe memory leak , my system memory =
(64GB) started swapping after 3 min of 4K RW run.
>>
>> Thanks & Regards
>> Somnath
>> PLEASE NOTE: The information contained in this electronic mail message i=
s intended only for the use of the designated recipient(s) named above. If =
the reader of this message is not the intended recipient, you are hereby no=
tified that you have received this message in error and that any review, di=
ssemination, distribution, or copying of this message is strictly prohibite=
d. If you have received this communication in error, please notify the send=
er by telephone or e-mail (as shown above) immediately and destroy any and =
all copies of this message in your possession (whether hard copies or elect=
ronically stored copies).
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
