From: John Spray <john.spray@redhat.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 22:02:46 +0000
Message-ID: <CAGd4Wr2wkDYcYyU5Q3G0ZABELNx6jAkpWSNPoVm_Otr5oQdB_g@mail.gmail.com>
References: <54B7D2D6.4020503@42on.com>
	<CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com>
	<alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
	<alpine.DEB.2.00.1501150942450.26676@cobra.newdream.net>
	<CAC6JEv-r2a6UOWOd8XKsn4armJU4iR76eYtG3kR4eGmKW6k++w@mail.gmail.com>
	<alpine.DEB.2.00.1501151004540.15918@cobra.newdream.net>
	<CAGd4Wr055nGU8D+pzN_bFhOkNVrNBZA1xZdfo80+Mu5Bddx+pg@mail.gmail.com>
	<alpine.DEB.2.00.1501151105050.15918@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:43711 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbAOWCr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 17:02:47 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so16069289lab.4
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 14:02:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501151105050.15918@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <greg@gregs42.com>, Yehuda Sadeh <yehuda@redhat.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 15, 2015 at 7:07 PM, Sage Weil <sweil@redhat.com> wrote:
>> The trouble with this is admin socket part is that any tool that
>> manages Ceph must use the admin socket interface as well as the normal
>> over-the-network command interface, and by extension must be able to
>> execute locally on a mon.  We would no longer have a comprehensive
>> remote management interface for the mon: management tools would have
>> to run some code locally too.
>
> True.. if we make that option enabled by default.  If we it's off by
> default them it's an opt-in layer of protection.  Most clusters don't have
> ephemeral pools so I think lots of people would want this.

+1, the problem goes away if it's opt-in, should be easy enough for
API consumers to inspect the conf setting and give a nice informative
error if the safety catch is engaged.  I can imagine wanting to engage
this ahead of plugging in a GUI or some config management recipes that
you didn't quite trust yet.

John
