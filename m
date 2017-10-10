From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: [ceph-users] killing ceph-disk [was Re: ceph-volume: migration
 and disk partition support]
Date: Tue, 10 Oct 2017 14:14:06 +0200
Message-ID: <a1c7e8df-44a1-a03f-ddbc-2bb66494256a@digiware.nl>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
 <alpine.DEB.2.11.1710091448500.26711@piezo.us.to>
 <20171010095014.64940afa@batzmaru.gol.ad.jp>
 <CAC-Np1yBe3_mTzLvMfxvO+0CW20p1txjVwL2zg6ACqu6L1s7iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:64139 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755888AbdJJMO1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Oct 2017 08:14:27 -0400
In-Reply-To: <CAC-Np1yBe3_mTzLvMfxvO+0CW20p1txjVwL2zg6ACqu6L1s7iQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Christian Balzer <chibi@gol.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On 10-10-2017 13:51, Alfredo Deza wrote:
> On Mon, Oct 9, 2017 at 8:50 PM, Christian Balzer <chibi@gol.com> wrote:
>>
>> Hello,
>>
>> (pet peeve alert)
>> On Mon, 9 Oct 2017 15:09:29 +0000 (UTC) Sage Weil wrote:
>>
>>> To put this in context, the goal here is to kill ceph-disk in mimic.

Right, that means we need a ceph-volume zfs before things get shot down.
Fortunately there is little history to carry over.

But then still somebody needs to do the work. ;-|
Haven't looked at ceph-volume, but I'll put it on the agenda.

--WjW


