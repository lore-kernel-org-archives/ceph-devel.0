From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rados semantic changes
Date: Wed, 9 Mar 2016 14:00:44 -0800
Message-ID: <CADRKj5SRWLeP=AzTPpXFjOAK=5PfDQeLtS4vdBS+Skac3KmSdg@mail.gmail.com>
References: <alpine.DEB.2.00.1505061044140.28239@cobra.newdream.net>
	<1500936117.16594659.1431127115994.JavaMail.zimbra@redhat.com>
	<CAC6JEv-BO88qnp4-Pkd6Qy5C+-OsgFBJPRTNFtprBQONUqZf+w@mail.gmail.com>
	<alpine.DEB.2.00.1505101927130.28239@cobra.newdream.net>
	<alpine.DEB.2.11.1603091539530.22603@cpach.fuggernut.com>
	<CAJ4mKGa7W2sDTAK-ZGshigjfsuea6j3cAsVidQO4r2_auuXiaQ@mail.gmail.com>
	<alpine.DEB.2.11.1603091634250.14377@cpach.fuggernut.com>
	<CAJ4mKGbXkvxX3N8vjJP=BXG=_1k0Sytk53YJZNQau0NTPZV-QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33134 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934283AbcCIWAq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 17:00:46 -0500
Received: by mail-vk0-f41.google.com with SMTP id k1so73498702vkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 14:00:45 -0800 (PST)
In-Reply-To: <CAJ4mKGbXkvxX3N8vjJP=BXG=_1k0Sytk53YJZNQau0NTPZV-QA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Mar 9, 2016 at 1:56 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Wed, Mar 9, 2016 at 1:47 PM, Sage Weil <sage@newdream.net> wrote:
>> On Wed, 9 Mar 2016, Gregory Farnum wrote:
>>> On Wed, Mar 9, 2016 at 12:42 PM, Sage Weil <sage@newdream.net> wrote:
>>> > Resurrecting an old thread.
>>> >
>>> > I think we really want to make these semantic changes to current rados
>>> > ops (like delete) to make life better going forward.  Ideally shortly
>>> > after jewel so that they have plenty of time to bake before K and L.
>>> >
>>> > I'm wondering if the way to make this change visible to users is to
>>> > (finally) rev librados to librados3.  We can take the opportunity to make
>>> > any other pending cleanups to the public API as well...
>>>
>>> Yep. I presume you're thinking of this because of
>>> http://tracker.ceph.com/issues/14468? It looks like we didn't really
>>> have any good solutions for that pipelining problem though; any new
>>> suggestions?
>>
>> Yeah, I'm still not very happy with either alternative:
>>
>> 1) We persistently record the reqid and return value in the pg log.  This
>> turns failed rw ops into a replicated (metadata) write, which sort of
>> sucks.  It also means that we probably *wouldn't* store any reply payload,
>> which means we lose the ability to have a failure return useful data
>> (e.g., info about why it failed).
>
> This inability to return data on writes has pretty persistently sucked
> for us... I wonder if we should be attacking it from that direction
> instead. We just don't want pglog entries to get that large and are
> worried about being able to reproduce the data on replay, right?
> Perhaps we could add some kind of limited-size lookaside thing. Given
> that RW ops *are* a write on success (whatever "success" means in the
> op's context) I'm not so concerned about turning them into writes even
> if they would have been a read. The other option is #2, which as you
> note might have some serious performance implications on the client
> side. :/

+1

Both in terms of usefulness for client applications, and in
performance implications. Maybe we can relax the guarantees of the
returned data on writes, so that it doesn't become an issue?

Yehuda
