From: Dan van der Ster <dan@vanderster.com>
Subject: Re: firefly v0.80.10 QE validation completed
Date: Mon, 22 Jun 2015 10:52:34 +0200
Message-ID: <CABZ+qq=6bdicLnsCV3moVBRaBe=gXkHxqSMuL8rUZW1Mmpfj9Q@mail.gmail.com>
References: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>
 <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com>
 <1434958820.2806.3.camel@daevel.fr> <5587CBD3.5020804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35240 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbbFVIxR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jun 2015 04:53:17 -0400
Received: by lbbwc1 with SMTP id wc1so104528446lbb.2
        for <ceph-devel@vger.kernel.org>; Mon, 22 Jun 2015 01:53:15 -0700 (PDT)
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com. [209.85.217.172])
        by mx.google.com with ESMTPSA id o5sm4501662lag.9.2015.06.22.01.53.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2015 01:53:14 -0700 (PDT)
Received: by lbbpo10 with SMTP id po10so4768525lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 22 Jun 2015 01:53:14 -0700 (PDT)
In-Reply-To: <5587CBD3.5020804@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Olivier Bonvalet <ceph.list@daevel.fr>, Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <ldachary@redhat.com>, Xinxin Shu <xinxin.shu@intel.com>, Alfredo Deza <adeza@redhat.com>, Sage Weil <sweil@redhat.com>

Hi Loic,

What does "published" mean? 0.80.10 looks published to me:
http://ceph.com/rpm-firefly/el6/x86_64/

Cheers, Dan



On Mon, Jun 22, 2015 at 10:48 AM, Loic Dachary <loic@dachary.org> wrote=
:
>
> Hi Olivier,
>
> On 22/06/2015 03:40, Olivier Bonvalet wrote:
>> Hi,
>>
>> I saw the proposed upgrade to 0.80.10 this morning, but can't find t=
he
>> announce about this (neither by email or on the website).
>>
>> Is the 0.80.10 ready to be used ?
>>
>
> The QE validation is the last step before it is published. But it's n=
ot published yet. You can track progress at http://tracker.ceph.com/iss=
ues/11090
>
> Cheers
>
>> thanks,
>> Olivier
>>
>> Le mercredi 17 juin 2015 =C3=A0 21:33 -0400, Yuri Weinstein a =C3=A9=
crit :
>>> firefly v0.80.10 is ready for publishing (Sage, Alfredo, Loic, Xinx=
in
>>> FYI)
>>>
>>> All results details were summarized in
>>> http://tracker.ceph.com/issues/11090
>>>
>>> Note:
>>>
>>> - upgrade/dumpling-firefly-x (to hammer)(distros) - runs out of
>>> memory on vps and unreliable
>>> - #11957 fixed (thanks Ilya, Zack!) and tested
>>>
>>> Thx
>>> YuriW
>>>
>>> ----- Original Message -----
>>> From: "Yuri Weinstein" <yweinste@redhat.com>
>>> To: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Cc: "Loic Dachary" <ldachary@redhat.com>, "Xinxin Shu" <
>>> xinxin.shu@intel.com>
>>> Sent: Monday, June 15, 2015 9:37:20 AM
>>> Subject: firefly v0.80.10 QE validation status 6/15/2015
>>>
>>> QE validation is almost completed (there are a couple of jobs that
>>> are still running)
>>>
>>> All statis details were summarized in
>>> http://tracker.ceph.com/issues/11090
>>>
>>> Highlights (by suite/issue):
>>>
>>> rados #11914 needs Sam's approval
>>> kcephfs n/a needs Greg's approval
>>> samba #6613 needs Greg's approval
>>>
>>> Nice to have fixes (no blockers):
>>> upgrade/firefly(distros) #11957      (env noise)
>>>
>>>
>>> Thx
>>> YuriW
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
