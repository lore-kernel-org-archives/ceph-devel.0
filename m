From: Sage Weil <sweil@redhat.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 10:07:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501151004540.15918@cobra.newdream.net>
References: <54B7D2D6.4020503@42on.com> <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com> <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net> <alpine.DEB.2.00.1501150942450.26676@cobra.newdream.net>
 <CAC6JEv-r2a6UOWOd8XKsn4armJU4iR76eYtG3kR4eGmKW6k++w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763AbbAOSoa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Jan 2015 13:44:30 -0500
In-Reply-To: <CAC6JEv-r2a6UOWOd8XKsn4armJU4iR76eYtG3kR4eGmKW6k++w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Yehuda Sadeh <yehuda@redhat.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 15 Jan 2015, Gregory Farnum wrote:
> On Thu, Jan 15, 2015 at 9:44 AM, Sage Weil <sweil@redhat.com> wrote:
> > In addition (or instead of) making the API harder to fat-finger, we could
> > also add a mon config option like
> >
> >  mon allow pool deletion = false
> >
> > that defaults off.  Then, to delete any pool, you need to update ceph.conf
> > and restart mons or inject the config option change (ceph daemon
> > mon.`hostname` conig set ... on the leader) or the API will give you
> > EPERM.
> >
> > This offers some protection even for client.admin key users if we prevent
> > injectargs for that option (maybe feasible) and they don't have access to
> > the actual mon machine.
> 
> What would that buy us? Preventing injectargs on it would require mon
> restarts, which is unfortunate ? and makes it sounds more like a
> security feature than a safety blanket.

I meant 'ceph tell mon.* injectargs ...' as distinct from 'ceph daemon ... 
config set', which requires access to the host.  But yeah, if we went to 
the effort to limit injectargs (maybe a blanket option that disables 
injectargs on mons?), it could double as a security feature.

But whether it may also useful for security doesn't change whether it is a 
good safety blanket.  I like it because it's simple, easy to implement, 
and easy to disable for testing... :)

sage

