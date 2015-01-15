From: Gregory Farnum <greg@gregs42.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 10:45:44 -0800
Message-ID: <CAC6JEv__Dz+8MNHDZ8nJf-OYBRo01nTkqy35=HemS49CiymCbw@mail.gmail.com>
References: <54B7D2D6.4020503@42on.com>
	<CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com>
	<alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
	<alpine.DEB.2.00.1501150942450.26676@cobra.newdream.net>
	<CAC6JEv-r2a6UOWOd8XKsn4armJU4iR76eYtG3kR4eGmKW6k++w@mail.gmail.com>
	<alpine.DEB.2.00.1501151004540.15918@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:48869 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbbAOSpq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 13:45:46 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so16503745iec.10
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 10:45:45 -0800 (PST)
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com. [209.85.213.181])
        by mx.google.com with ESMTPSA id r12sm1417044ioe.43.2015.01.15.10.45.45
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 10:45:45 -0800 (PST)
Received: by mail-ig0-f181.google.com with SMTP id r2so14260176igi.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 10:45:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501151004540.15918@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Yehuda Sadeh <yehuda@redhat.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

Oh, I think it might be fine to require setting a config option before
you delete stuff; I just don't want to prevent the option from being
injectable. :)

On Thu, Jan 15, 2015 at 10:07 AM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 15 Jan 2015, Gregory Farnum wrote:
>> On Thu, Jan 15, 2015 at 9:44 AM, Sage Weil <sweil@redhat.com> wrote:
>> > In addition (or instead of) making the API harder to fat-finger, we could
>> > also add a mon config option like
>> >
>> >  mon allow pool deletion = false
>> >
>> > that defaults off.  Then, to delete any pool, you need to update ceph.conf
>> > and restart mons or inject the config option change (ceph daemon
>> > mon.`hostname` conig set ... on the leader) or the API will give you
>> > EPERM.
>> >
>> > This offers some protection even for client.admin key users if we prevent
>> > injectargs for that option (maybe feasible) and they don't have access to
>> > the actual mon machine.
>>
>> What would that buy us? Preventing injectargs on it would require mon
>> restarts, which is unfortunate ? and makes it sounds more like a
>> security feature than a safety blanket.
>
> I meant 'ceph tell mon.* injectargs ...' as distinct from 'ceph daemon ...
> config set', which requires access to the host.  But yeah, if we went to
> the effort to limit injectargs (maybe a blanket option that disables
> injectargs on mons?), it could double as a security feature.
>
> But whether it may also useful for security doesn't change whether it is a
> good safety blanket.  I like it because it's simple, easy to implement,
> and easy to disable for testing... :)
>
> sage
>
