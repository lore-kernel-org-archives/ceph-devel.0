From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: hammer v0.94.6 QE Validation status
Date: Sun, 14 Feb 2016 12:31:19 -0800
Message-ID: <CAJ4mKGZLedmu7PsTtPQuLOQtsjRC6TK+HWB6yixOzUMgEbJCMQ@mail.gmail.com>
References: <CAMMFjmHcBKZubn7e_ebmNMcE-7MbzPYXD0fAPFzA_ME2oEBkPQ@mail.gmail.com>
	<CAJ4mKGZi_pMc4eXq91FPync-gz_7_5NmDCb3QGz5n=zB+5GTTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37022 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbcBNUbV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Feb 2016 15:31:21 -0500
Received: by mail-wm0-f43.google.com with SMTP id g62so84351772wme.0
        for <ceph-devel@vger.kernel.org>; Sun, 14 Feb 2016 12:31:20 -0800 (PST)
In-Reply-To: <CAJ4mKGZi_pMc4eXq91FPync-gz_7_5NmDCb3QGz5n=zB+5GTTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>

On Wed, Feb 10, 2016 at 11:24 AM, Gregory Farnum <gfarnum@redhat.com> w=
rote:
> On Wed, Feb 10, 2016 at 10:56 AM, Yuri Weinstein <yweinste@redhat.com=
> wrote:
>> Hello
>>
>> Detailed summary of the QE Validation can be found here
>> http://tracker.ceph.com/issues/13356#note-61
>>
>> The following suites were in scope of this point release testing:
>>
>> rados (subset 1/7)
>> rbd
>> rgw
>> fs
>> krbd
>> kcephfs
>> hadoop
>> samba
>> rest
>> ceph-deploy
>> upgrade/client-upgrade
>> upgrade/dumpling-firefly-x (hammer)
>> upgrade/firefly-x (hammer)
>> upgrade/hammer
>> upgrade/hammer-x (infernalis)
>> powercycle
>>
>> Outstanding issues (approval requested):
>>
>> fs:
>> http://tracker.ceph.com/issues/14716 - Greg, do you want those to be
>> fixed for this release or approve release as is with a known issue?
>>
>> samba:
>> http://tracker.ceph.com/issues/14714 - Greg, do you want those to be
>> fixed for this release or approve release as is with a known issue?

Okay, I looked briefly at the samba issue and honestly I'm just not
that fussed about it. I'm a little concerned by the thread assert,
although the fact that it's happening on shutdown anyway mitigates it
some...
I suppose I wouldn't call it a release blocker, but it's not a great
precedent to set. I think ideally you'd want to try and identify where
it happened =E2=80=94 is it a genuinely new issue, or something showing=
 up on
the smithi boxes but not other hardware?
You might check that by running this on the miras and/or ovh, and by
running the version that last passed on ovh against smithi and seeing
if/where the issues show up.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
