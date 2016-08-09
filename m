From: Sebastien Han <shan@redhat.com>
Subject: Re: [Feature request] config diff on a single option with the admin socket
Date: Tue, 9 Aug 2016 11:52:15 +0200
Message-ID: <CA+HUO7KTXfHeHOcQpRX4pfneA+ReyQb2FoBjkxurzZw87NaiSA@mail.gmail.com>
References: <CA+HUO7+qxtsS03yKp2ETUhKy6WTX1ESd0Xridw13viWwa0Cj3Q@mail.gmail.com>
 <alpine.LSU.2.20.1607291125130.28641@ancalagon.suse.com> <CA+HUO7+QVu-HqBT7EuuEoLwPVng84HzG_MmbvMQyueEstR-6Gw@mail.gmail.com>
 <1470691964.14948.2.camel@suse.com> <1470710335.14948.10.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36215 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbcHIJwh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 05:52:37 -0400
Received: by mail-wm0-f45.google.com with SMTP id q128so22589081wma.1
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 02:52:37 -0700 (PDT)
In-Reply-To: <1470710335.14948.10.camel@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Oliveira <doliveira@suse.com>
Cc: Jesse Williamson <jwilliamson@suse.de>, Squid Cybernetic <ceph-devel@vger.kernel.org>

Thanks a lot Daniel, that looks exactly right.
If nothing changed I think it's valid to keep both fields showing the
same value.
This is either when comparing with whatever tool because the structure
won't change so we don't have to handle a particular case.

Others? Thoughts?

On Tue, Aug 9, 2016 at 4:38 AM, Daniel Oliveira <doliveira@suse.com> wrote:
> Sebastien,
>
> For now, We have something like this (which follows the same standard
> as 'config diff' and 'config get' :
>
> #1:
> ./ceph --admin-daemon out/osd.1.asok config diff get
> mon_data_avail_crit
> {
>     "diff": {
>         "current": {
>             "mon_data_avail_crit": "1"
>         },
>         "defaults": {
>             "mon_data_avail_crit": "5"
>         }
>     },
>     "unknown": []
> }
>
> ./ceph --admin-daemon out/osd.1.asok config diff get
> mon_data_avail_warn
> {
>     "diff": {
>         "current": {
>             "mon_data_avail_warn": "10"
>         },
>         "defaults": {
>             "mon_data_avail_warn": "30"
>         }
>     },
>     "unknown": []
> }
>
> What would be the proper way to display a setting that *was not*
> changed from its default?, for example:
> ./ceph --admin-daemon out/osd.1.asok config diff get num_client
> {
>     "diff": {
>         "current": {},
>         "defaults": {}
>     },
>     "unknown": []
> }
>
> Or only the "current" value?
>
> Thanks,
> -Daniel
>
>
> On Mon, 2016-08-08 at 15:32 -0600, Daniel Oliveira wrote:
>> Sebastien,
>>
>> As I was working on a couple of other things related to validating
>> parameters/settings, I ended up adding the feature in question and I
>> am just in the process of testing it. I will keep you posted.
>>
>> Thanks,
>> -Daniel
>>
>>
>> On Mon, 2016-08-08 at 14:16 +0200, Sebastien Han wrote:
>> > Would be nice if you could get a stab at it, actually I don't know
>> > where to look in the code to see where the magic is happening for
>> > the
>> > admin socket.
>> > Most of the logic is there so this shouldn't be too difficult :).
>> >
>> > Did you get a chance to look into this Jesse?
>> > Thanks for offering your help on this one!
>> >
>> > On Fri, Jul 29, 2016 at 8:32 PM, Jesse Williamson <
>> > jwilliamson@suse.de> wrote:
>> > > On Fri, 29 Jul 2016, Sebastien Han wrote:
>> > >
>> > > Hi Sebastien,
>> > >
>> > > > I'd like to have the same but for a specific option only.
>> > > >
>> > > > So something like:
>> > > >
>> > > > ceph daemon mon.ceph-mon-01 config diff get <field>
>> > > >
>> > > > Which will return the diff between the actual config value and
>> > > > the
>> > > > original config value.
>> > >
>> > >
>> > > I might be able to help with this, if there's no support that
>> > > anyone already
>> > > knows of, or clear takers. I'm working on a small config-related
>> > > librados
>> > > feature right now and am somewhat familiar with the relevant
>> > > moving parts on
>> > > that end, so I might be in a good position to work on it.
>> > >
>> > > WRT the admin socket, I'm less clear, but can be pointed in the
>> > > right
>> > > direction. :-)
>> > >
>> > > -Jesse
>> >
>> >
>> >



-- 
Cheers

––––––
Sébastien Han
Principal Storage Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roquépine - 75008 Paris
