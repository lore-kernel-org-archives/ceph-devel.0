From: Dan van der Ster <dan@vanderster.com>
Subject: Re: noout equivalent for temporary OSD rm?
Date: Wed, 8 Feb 2017 14:11:31 +0100
Message-ID: <CABZ+qqkbio_Gz7N5dKkdzBgRQcUE=R1pk6tuxELKg7FwcoXTYg@mail.gmail.com>
References: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
 <CA+z5DszEL4m_OYHKbhgifQctVvnMp3Ay59dD1oaF_XUrG5GHgg@mail.gmail.com> <CALe9h7d8z-A41pCd7-XkLbLOdk1Yfr13EpsBOk+HD5LkUKGkbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33392 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbdBHNNL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 08:13:11 -0500
Received: by mail-wr0-f171.google.com with SMTP id i10so60348683wrb.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 05:12:19 -0800 (PST)
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com. [74.125.82.51])
        by smtp.gmail.com with ESMTPSA id o143sm3342013wmd.3.2017.02.08.05.12.12
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 05:12:12 -0800 (PST)
Received: by mail-wm0-f51.google.com with SMTP id v77so189994884wmv.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 05:12:12 -0800 (PST)
In-Reply-To: <CALe9h7d8z-A41pCd7-XkLbLOdk1Yfr13EpsBOk+HD5LkUKGkbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Blair Bethwaite <blair.bethwaite@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 8, 2017 at 1:50 PM, John Spray <jspray@redhat.com> wrote:
> On Wed, Feb 8, 2017 at 12:41 PM, Blair Bethwaite
> <blair.bethwaite@gmail.com> wrote:
>> Hi John,
>>
>> ceph osd set nobackfill/norecover/norebalance ?
>>
>> It's not something you want to accidentally leave set, but is use
>> nonetheless - I'm using it right at this moment to load an edited
>> crushmap and examine the PG remapping impact before actually pulling
>> the trigger and letting things sort themselves out (if I decide not to
>> I can always re-inject the previous/current crushmap).
>
> Ah ha, of course nobackfill is the one.  I am exposing my lack of
> experience in actually operating a cluster here :-)
>

That said, it might make sense for Ceph to wait a few minutes before
starting to backfill after any osdmap changes.
The current behaviour can be a little spastic at times.

-- Dan


> John
>
>>
>> Cheers,
>>
>> On 8 February 2017 at 23:26, John Spray <jspray@redhat.com> wrote:
>>> So I've just finished upgrading my home cluster OSDs to bluestore by
>>> killing them one by one and then letting backfill happen to "new" OSDs
>>> on the same drives.  Hooray!
>>>
>>> One slightly awkward thing I ran into was that even though I had noout
>>> set throughout, during the period between removing the old OSD and
>>> adding the "new" one, some PGs would of course get remapped (and start
>>> generating backfill IO to third party OSDs).  This does make sense
>>> when you think about it (noout doesn't make the cluster magically
>>> remember OSDs that have been removed), but is still an undesirable
>>> behaviour.
>>>
>>> A) Do we currently have a mechanism to tell the cluster "even though I
>>> removed this OSD, don't go moving PGs around just yet"?  Should we add
>>> one?
>>> B) Was there a way for me to avoid this by e.g. skipping the "osd rm
>>> X" and "osd crush rm osd.X" that I'm currently doing before adding the
>>> new OSD that will take the old OSD's ID?
>>>
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Cheers,
>> ~Blairo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
