From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer v0.94.6 QE Validation status
Date: Tue, 16 Feb 2016 09:37:12 -0800
Message-ID: <CAMMFjmGLyBc+fZzdTbAzFE3=JnE8L9583yU_DJ3i2Axx-Ez9Dg@mail.gmail.com>
References: <CAMMFjmHcBKZubn7e_ebmNMcE-7MbzPYXD0fAPFzA_ME2oEBkPQ@mail.gmail.com>
	<CAJ4mKGZi_pMc4eXq91FPync-gz_7_5NmDCb3QGz5n=zB+5GTTQ@mail.gmail.com>
	<CAJ4mKGZLedmu7PsTtPQuLOQtsjRC6TK+HWB6yixOzUMgEbJCMQ@mail.gmail.com>
	<CAMMFjmFBXkj=JYbxOkpbfTdAcfGG2G=F=ud9bqoQh2ws4K_ygg@mail.gmail.com>
	<CAJ4mKGYeZ4q2v123-Xpcs6GOfSLXg2bw770D+RoJqu+JU0ok=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36563 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188AbcBPRhO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 12:37:14 -0500
Received: by mail-io0-f174.google.com with SMTP id l127so199925001iof.3
        for <ceph-devel@vger.kernel.org>; Tue, 16 Feb 2016 09:37:13 -0800 (PST)
In-Reply-To: <CAJ4mKGYeZ4q2v123-Xpcs6GOfSLXg2bw770D+RoJqu+JU0ok=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>

See updates in 14716, in short it's persisting on different systems.
This is the only remaining issue before we can proceed with this releas=
e.

Thx
YuriW

On Sun, Feb 14, 2016 at 1:05 PM, Gregory Farnum <gfarnum@redhat.com> wr=
ote:
> On Sun, Feb 14, 2016 at 1:00 PM, Yuri Weinstein <yweinste@redhat.com>=
 wrote:
>> On Sun, Feb 14, 2016 at 12:31 PM, Gregory Farnum <gfarnum@redhat.com=
> wrote:
>>> On Wed, Feb 10, 2016 at 11:24 AM, Gregory Farnum <gfarnum@redhat.co=
m> wrote:
>>>> On Wed, Feb 10, 2016 at 10:56 AM, Yuri Weinstein <yweinste@redhat.=
com> wrote:
>>>>> Hello
>>>>>
>>>>> Detailed summary of the QE Validation can be found here
>>>>> http://tracker.ceph.com/issues/13356#note-61
>>>>>
>>>>> The following suites were in scope of this point release testing:
>>>>>
>>>>> rados (subset 1/7)
>>>>> rbd
>>>>> rgw
>>>>> fs
>>>>> krbd
>>>>> kcephfs
>>>>> hadoop
>>>>> samba
>>>>> rest
>>>>> ceph-deploy
>>>>> upgrade/client-upgrade
>>>>> upgrade/dumpling-firefly-x (hammer)
>>>>> upgrade/firefly-x (hammer)
>>>>> upgrade/hammer
>>>>> upgrade/hammer-x (infernalis)
>>>>> powercycle
>>>>>
>>>>> Outstanding issues (approval requested):
>>>>>
>>>>> fs:
>>>>> http://tracker.ceph.com/issues/14716 - Greg, do you want those to=
 be
>>>>> fixed for this release or approve release as is with a known issu=
e?
>>>>>
>>>>> samba:
>>>>> http://tracker.ceph.com/issues/14714 - Greg, do you want those to=
 be
>>>>> fixed for this release or approve release as is with a known issu=
e?
>>>
>>> Okay, I looked briefly at the samba issue and honestly I'm just not
>>> that fussed about it. I'm a little concerned by the thread assert,
>>> although the fact that it's happening on shutdown anyway mitigates =
it
>>> some...
>>> I suppose I wouldn't call it a release blocker, but it's not a grea=
t
>>> precedent to set. I think ideally you'd want to try and identify wh=
ere
>>> it happened =E2=80=94 is it a genuinely new issue, or something sho=
wing up on
>>> the smithi boxes but not other hardware?
>>> You might check that by running this on the miras and/or ovh, and b=
y
>>> running the version that last passed on ovh against smithi and seei=
ng
>>> if/where the issues show up.
>>> -Greg
>>
>> OK, Greg, I will try rerunning samba jobs in suggested environments
>> and we will see more info.
>>
>> Are you still looking into the fs issue http://tracker.ceph.com/issu=
es/14716
>
> 14716 is what I'm referring to when I talk about running the tests
> elsewhere. :) I'm not looking at it actively right now but will take
> the results of any bisecting tests to try and track it down further.
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
