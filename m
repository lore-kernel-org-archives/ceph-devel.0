From: John Spray <jspray@redhat.com>
Subject: Re: fs: mandatory client quota
Date: Wed, 10 May 2017 08:03:24 +0100
Message-ID: <CALe9h7cXHxwDo=aBYKJyVn0jo5xeKctBhB8SHTcuqwJ8wjfmSQ@mail.gmail.com>
References: <CABZ+qqkk=2Q8p+KCpOEKWw_ZkviPW_v6rgt=ML984O25CFYxOw@mail.gmail.com>
 <CABZ+qqnFwaV9Va-B4WHp=ntPgKZdsDA1P=m67pLPWU7Y9Tyu+Q@mail.gmail.com>
 <alpine.DEB.2.11.1705051456250.3646@piezo.novalocal> <CAJ4mKGZJ0ZJxhuKf9ndhchp4Ca=Y8+QUdkq-tZBvnsCqfCdkTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35734 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdEJHDq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 03:03:46 -0400
Received: by mail-wr0-f181.google.com with SMTP id z52so29868935wrc.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 May 2017 00:03:46 -0700 (PDT)
In-Reply-To: <CAJ4mKGZJ0ZJxhuKf9ndhchp4Ca=Y8+QUdkq-tZBvnsCqfCdkTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 9, 2017 at 5:47 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Fri, May 5, 2017 at 7:57 AM, Sage Weil <sage@newdream.net> wrote:
>> On Fri, 5 May 2017, Dan van der Ster wrote:
>>> On Fri, May 5, 2017 at 4:36 PM, Dan van der Ster <dan@vanderster.com>
>>> wrote:
>>> > Hi all,
>>> >
>>> > It would be really nice if for Luminous client quotas were always
>>> > enabled -- it should be impossible to disable quota enforcement on the
>>> > client side.
>>> >
>>> > From the looks of things, the patch to remove client_quota and
>>> > client_quota_df would be trivial.
>>> > Is there some reason we need to leave that optional?
>>>
>>> PR: 14978
>>
>> This seems reasonable to me.  Client can of course run modified code so
>> it's not really "secure" in that sense but it's certainly inconvenient to
>> circumvent.
>
> I'm sure John will comment on this once he gets back from vacation, but
> there were some reasons not to enable it by default when this was discussed
> by the team last fall. I think it was combined concern about the lack of
> server-side enforcement and (more importantly) not wanting to provide
> default experiences which differ across the userspace and kernel clients.

client_quota has been true by default in master for about a year -- I
think at this stage the question is just whether it's important to
enable people to disable them, where disabling is really only sensible
in cases where someone e.g. hits a quota bug and wants to skip the
code.

My view is that the simplicity of support (not worrying about users
disabling quota and then complaining about it not working) is a good
enough motivator to remove the setting.  Making it less convenient for
naughty clients to circumvent quota is a bonus.

Commenting on PR....

John

> -Greg
