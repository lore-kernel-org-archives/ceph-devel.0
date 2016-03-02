From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Wed, 2 Mar 2016 13:48:03 +0100
Message-ID: <CABZ+qqkfjbmxZuBhODV8q4-k-rVaD2eCAdpa3CyPc+PbHbWN_w@mail.gmail.com>
References: <CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
 <EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com> <CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
 <FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com> <1456736629334.47610@croc.ru>
 <191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
 <1456745435596.21796@croc.ru> <CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
 <56D45CCC.8010608@dachary.org> <alpine.DEB.2.11.1602291056350.1904@cpach.fuggernut.com>
 <20160302010625.GA10914@onthe.net.au> <1456913706999.87255@croc.ru> <56D6CF42.7080909@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36599 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbcCBMsr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 07:48:47 -0500
Received: by mail-lf0-f42.google.com with SMTP id l83so86796891lfd.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 04:48:46 -0800 (PST)
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com. [209.85.215.45])
        by smtp.gmail.com with ESMTPSA id jr10sm5551100lbc.42.2016.03.02.04.48.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2016 04:48:43 -0800 (PST)
Received: by mail-lf0-f45.google.com with SMTP id l13so22078269lfb.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 04:48:43 -0800 (PST)
In-Reply-To: <56D6CF42.7080909@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Odintsov Vladislav <VlOdintsov@croc.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Loic,

On Wed, Mar 2, 2016 at 12:32 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 02/03/2016 17:15, Odintsov Vladislav wrote:
>> Hi,
>>
>> it looks very strange, that LTS release suddenly stopped support of =
one of OS'es in the middle of lifecycle. Especially when there are no t=
echnical problems.
>> How can we help community with building hammer branch officially?
>>
>
> Hi,
>
> I think you misread what Sage wrote : "The intention was to continue =
building stable releases (0.94.x) on the old list of supported platform=
s (which inclues 12.04 and el6)". In other words, the old OS'es are sti=
ll supported. Their absence is a glitch in the release process that wil=
l be fixed.
>

BTW, has there been any discussion to do 0.94.7 on a shorter interval?
There is at least one unfortunate regression in .6:
http://tracker.ceph.com/issues/14873

Cheers, Dan


> Cheers
>
>> ________________________________
>> Regards,
>>
>> Vladislav Odintsov
>>
>> ________________________________________
>> From: ceph-users <ceph-users-bounces@lists.ceph.com> on behalf of Ch=
ris Dunlop <chris@onthe.net.au>
>> Sent: Wednesday, March 2, 2016 04:06
>> To: Sage Weil
>> Cc: Loic Dachary; ceph-devel@vger.kernel.org; ceph-users@ceph.com
>> Subject: Re: [ceph-users] v0.94.6 Hammer released
>>
>> Hi,
>>
>> The "old list of supported platforms" includes debian wheezy.
>> Will v0.94.6 be built for this?
>>
>> Chris
>>
>> On Mon, Feb 29, 2016 at 10:57:53AM -0500, Sage Weil wrote:
>>> The intention was to continue building stable releases (0.94.x) on =
the old
>>> list of supported platforms (which inclues 12.04 and el6).  I think=
 it was
>>> just an oversight that they weren't built this time around.  I the
>>> overhead to doing so is just keeping a 12.04 and el6 jenkins build =
slave
>>> around.
>>>
>>> Doing this builds in the existing environment sounds much better th=
an
>>> trying to pull in externally built binaries...
>>>
>>> sage
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
