From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: noout equivalent for temporary OSD rm?
Date: Thu, 9 Feb 2017 00:17:53 +1100
Message-ID: <CA+z5DsyNbnAgkEMxrYWUVWOpv46m+1PppMPk+JxteiZy-nrRtA@mail.gmail.com>
References: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
 <CA+z5DszEL4m_OYHKbhgifQctVvnMp3Ay59dD1oaF_XUrG5GHgg@mail.gmail.com>
 <CALe9h7d8z-A41pCd7-XkLbLOdk1Yfr13EpsBOk+HD5LkUKGkbQ@mail.gmail.com> <CABZ+qqkbio_Gz7N5dKkdzBgRQcUE=R1pk6tuxELKg7FwcoXTYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36157 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932242AbdBHNSU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 08:18:20 -0500
Received: by mail-wm0-f54.google.com with SMTP id c85so196907665wmi.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 05:18:15 -0800 (PST)
In-Reply-To: <CABZ+qqkbio_Gz7N5dKkdzBgRQcUE=R1pk6tuxELKg7FwcoXTYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 9 February 2017 at 00:11, Dan van der Ster <dan@vanderster.com> wrote:
> On Wed, Feb 8, 2017 at 1:50 PM, John Spray <jspray@redhat.com> wrote:
>> On Wed, Feb 8, 2017 at 12:41 PM, Blair Bethwaite
>> <blair.bethwaite@gmail.com> wrote:
>>> Hi John,
>>>
>>> ceph osd set nobackfill/norecover/norebalance ?
>>>
>>> It's not something you want to accidentally leave set, but is use
>>> nonetheless - I'm using it right at this moment to load an edited
>>> crushmap and examine the PG remapping impact before actually pulling
>>> the trigger and letting things sort themselves out (if I decide not to
>>> I can always re-inject the previous/current crushmap).
>>
>> Ah ha, of course nobackfill is the one.  I am exposing my lack of
>> experience in actually operating a cluster here :-)
>>
>
> That said, it might make sense for Ceph to wait a few minutes before
> starting to backfill after any osdmap changes.
> The current behaviour can be a little spastic at times.

Agreed. And the scenario I described above must be very common in
operations, where I suspect more often that not people just make the
change and hope all will be well. It's true crushtool can simulate
mappings, but what I really want to see is the `ceph -s` after the
crush change but before the cluster starts actually acting on it, that
e.g. gives you a chance to see the amount of data that will move and
see if the number of impacted PGs makes sense for the change.

-- 
Cheers,
~Blairo
