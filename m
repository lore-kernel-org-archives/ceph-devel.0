From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: suites running on the hammer-backports branch
Date: Mon, 4 May 2015 23:29:58 +0530
Message-ID: <CAEw75dOomkcukQcTc7Xkt0g8u__CFAsLvjP3SE14VZsr=D_Urw@mail.gmail.com>
References: <55461DBA.1060009@dachary.org>
	<55473AFF.80902@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:34759 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbbEDR77 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 13:59:59 -0400
Received: by qcyk17 with SMTP id k17so75879796qcy.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 May 2015 10:59:58 -0700 (PDT)
In-Reply-To: <55473AFF.80902@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 4, 2015 at 2:55 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 03/05/2015 15:08, Loic Dachary wrote:> Hi Abhishek,
>>
>> The rados suite you scheduled ( http://tracker.ceph.com/issues/11492=
#rados ) failed because of environmental noise and I re-scheduled the 8=
4 failed jobs on your behalf.
>
> It turns out the rados suite did not fail because of environmental no=
ise but because the thrasher yaml file also contains the ceph installat=
ion. Removing the thrasher yaml file had the infortunate side effect of=
 not installing Ceph. And without Ceph installed the tests don't run ve=
ry well ;-) I fixed this at https://github.com/dachary/ceph-qa-suite/tr=
ee/wip-rados-no-thrash-hammer and re-scheduled a suite of 116 jobs at h=
ttp://tracker.ceph.com/issues/11492#rados
>
> Note that it was not possible to only re-schedule the ones that faile=
d (88 out of 116) using the usual method because I introduced new yaml =
files (ceph.yaml with only the ceph installation). The descriptions are=
 differents and the filtering does not work anymore.

It seems a couple of the rados suites have failed again.. I've linked
the corresponding job ids against the failures in the tracker descripti=
on,
though I'm not sure of the reason yet (probably some changes in upstrea=
m
teuthology?)


>>
>> I've scheduled the rgw suite as well, suppressing the apache tests a=
nd keeping the civetweb tests which should be enough for the purpose of=
 the pull requests in the integration branch (44 jobs instead of 88 job=
s). http://tracker.ceph.com/issues/11492#rgw
>>
>> The rbd and fs suites were also scheduled, as usual.
>>
>> Cheers
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
Regards
Abhishek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
