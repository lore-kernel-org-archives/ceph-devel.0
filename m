From: Sheldon Mustard <sheldon.mustard@inktank.com>
Subject: Re: FileJournal bug : additional information request
Date: Wed, 1 Oct 2014 11:54:10 -0400
Message-ID: <CAGW2oNxiayzaAmbGvykkPBixNv_djPtOPvd1r33AgZccgnoVNA@mail.gmail.com>
References: <542ABE45.5030808@dachary.org>
	<CAGW2oNw+ZVDi40SkzdyR1-Dx1kcOxq045hqtbHC6EzcUTqBZVA@mail.gmail.com>
	<542BD034.4050604@dachary.org>
Reply-To: sjm@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:56440 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbaJAPyL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Oct 2014 11:54:11 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so641782ieb.28
        for <ceph-devel@vger.kernel.org>; Wed, 01 Oct 2014 08:54:10 -0700 (PDT)
In-Reply-To: <542BD034.4050604@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

added to the tracker, putting it here also:

linux kernel is 3.12.7 and libaio is 0.3.109-2ubuntu1

On Wed, Oct 1, 2014 at 5:58 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Could you please add the version of the kernel that is running as wel=
l as the version of the libaio library ?
>
> Thanks in advance :-)
>
> On 30/09/2014 17:06, Sheldon Mustard wrote:
>> Hey Loic,
>>
>> Thanks for looking into it, I have attached the one small log file w=
e
>> have to the tracker now. Unfortunately I don't have much else to add
>> at this point, it was a one off thing so we can't reproduce it with
>> debugging turned on.
>>
>> SJM
>>
>> On Tue, Sep 30, 2014 at 10:29 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>> Hi Sheldon,
>>>
>>> I would be greatfull if you could add as much information as possib=
le to http://tracker.ceph.com/issues/9570 . In particular the logs of t=
he failed OSD would be great. Hunting the problem is a nice journey (I =
did not know this part of the code before) and I'm eager to discover th=
e reason for this seemingly impossible event :-)
>>>
>>> Thanks for your help !
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
