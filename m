From: John Spray <john.spray@redhat.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 19:02:09 +0000
Message-ID: <CAGd4Wr055nGU8D+pzN_bFhOkNVrNBZA1xZdfo80+Mu5Bddx+pg@mail.gmail.com>
References: <54B7D2D6.4020503@42on.com>
	<CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com>
	<alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
	<alpine.DEB.2.00.1501150942450.26676@cobra.newdream.net>
	<CAC6JEv-r2a6UOWOd8XKsn4armJU4iR76eYtG3kR4eGmKW6k++w@mail.gmail.com>
	<alpine.DEB.2.00.1501151004540.15918@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40379 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbbAOTCL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 14:02:11 -0500
Received: by mail-lb0-f182.google.com with SMTP id u10so14795962lbd.13
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 11:02:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501151004540.15918@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <greg@gregs42.com>, Yehuda Sadeh <yehuda@redhat.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 15, 2015 at 6:07 PM, Sage Weil <sweil@redhat.com> wrote:
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

The trouble with this is admin socket part is that any tool that
manages Ceph must use the admin socket interface as well as the normal
over-the-network command interface, and by extension must be able to
execute locally on a mon.  We would no longer have a comprehensive
remote management interface for the mon: management tools would have
to run some code locally too.

I think it's sufficient to require two API calls (set the flag or
config option, then do the delete) within the remote API, rather than
requiring that anyone driving the interface knows how to speak two
network protocols (usual mon remote command + SSH-to-asok).

John
