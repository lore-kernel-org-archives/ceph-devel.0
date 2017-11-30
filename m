From: Gregory Farnum <gfarnum@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_osd=3A_fine=2Dgrained_statistics_for_object_?=
        =?UTF-8?Q?space_usage?=
Date: Thu, 30 Nov 2017 13:46:17 -0800
Message-ID: <CAJ4mKGbzJonr9sbvVxsXjBDPtMCoWyQvf=C100JZyku2P-Z=ew@mail.gmail.com>
References: <201711300849388246138@zte.com.cn> <alpine.DEB.2.11.1711300304240.8333@piezo.novalocal>
 <CAJ4mKGb8uFJ738YU9BKT3S3h7ePhVFbLkz+KyEQn+e2S8BbArQ@mail.gmail.com> <alpine.DEB.2.11.1711302125440.12766@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:41989 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdK3VqT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Nov 2017 16:46:19 -0500
Received: by mail-it0-f43.google.com with SMTP id p139so219151itb.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Nov 2017 13:46:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711302125440.12766@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Igor Fedotov <ifedotov@suse.de>, Xie Xingguo <xie.xingguo@zte.com.cn>

On Thu, Nov 30, 2017 at 1:27 PM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 30 Nov 2017, Gregory Farnum wrote:
>> On Wed, Nov 29, 2017 at 7:06 PM Sage Weil <sweil@redhat.com> wrote:
>> >
>> > On Thu, 30 Nov 2017, xie.xingguo@zte.com.cn wrote:
>> > > （My network connection seems to be problematic, resending :( ）
>> > >
>> > >   Anyway, I am + 1 for doing this in a more effective way (e.g., as Igor
>> > > suggested).
>> > >
>> > >   The potential big challenge might be making the scrub-process happy,
>> > > though!
>> >
>> > Would this be something like:
>> >
>> > 1- an object_info_t field like uint32_t allocated_size, which has been
>> > incorporated into the pg summation, and
>> >
>> > 2- an ObjectStore method that returns the allocated size for an object?
>> >
>> > The challenge I see is that the new value (or delta) needs to be sorted
>> > out at the transaction prepare time because the stat update is part of the
>> > transaction, but we won't really know what the result is until bluestore
>> > (or any other impl) does it's write preparation work.  :/
>>
>>
>> It would take some doing but this might be a good time to start adding
>> delayed work. We could get the stat updates as part of the objectstore
>> callback and incorporate them into future disk ops, and part of the
>> startup/replay process could be querying for stat updates to objects
>> we haven’t committed yet.
>>
>> ...except we don’t really have an OSD-level or pg replay phase any
>> more, do we. Hrmm. And doing it in the transaction would require some
>> sort of set-up/query phase to the transaction, then finalization and
>> submission, which isn’t great since it impacts checksumming and other
>> stuff (although *hopefully* not actual allocation).
>
> Hmm, and there is a larger problem here: we can't really make this
> ObjectStore implementation specific because it may vary across OSDs (some
> may be BlueStore, some may be FileStore).
>
> Even if we didn't have that issue, it constrains the ordering somewhat:
> you would need to prepare and submit the local transaction (to get
> the stat delta) before sending the replica writes.

Yeah. This isn't a problem if we do the stat maintenance separately,
but it's a much larger-scoped patch than just poking the interfaces.

Would you be opposed to a simple OSD-level replay step that could do
stuff like update pg stats for recent object writes?

> I think this sort of layer boundary crossing would make our lives very
> difficult down the line.  :/

I mean, that's true, but it's also something eminently reasonable for
admins to want. I've always found it a bit embarrassing we can't
expose which snapshots are actually taking up space. Saying which
things are using up storage is sort of a critical feature. :/
-Greg
