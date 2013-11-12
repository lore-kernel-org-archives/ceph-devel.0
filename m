From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: Re: Mourning the demise of mkcephfs
Date: Tue, 12 Nov 2013 10:53:35 -0500
Message-ID: <CANtztVwJyK7C5LS1G3YCLh-0T0VODCsUuWE1ADz_PupJe4nAAQ@mail.gmail.com>
References: <5281192D.4090707@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38670 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408Ab3KLPxf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 10:53:35 -0500
Received: by mail-oa0-f50.google.com with SMTP id k1so1787979oag.9
        for <ceph-devel@vger.kernel.org>; Tue, 12 Nov 2013 07:53:35 -0800 (PST)
In-Reply-To: <5281192D.4090707@bob-the-boat.me.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 11, 2013 at 12:51 PM, Dave (Bob) <dave@bob-the-boat.me.uk> wrote:
> The utility mkcephfs seemed to work, it was very simple to use and
> apparently effective.
>
> It has been deprecated in favour of something called ceph-deploy, which
> does not work for me.
>
> I've ignored the deprecation messages until now, but in going from 70 to
> 72 I find that mkcephfs has finally gone.
>
> I have tried ceph-deploy, and it seems to be tied in to specific
> 'distributions' in some way.

It is! ceph-deploy needs to know what distribution is it talking to
because different distros will install/uninstall packages
with different packages managers. Init scripts will also be different,
so this "distro detection" is a must to provide the same
functionality regardless of what supported distro you might be using.

>
> It is unuseable for me at present, because it reports:
>
> [ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:
>

That looks like a bug. For the past few months the log output of
ceph-deploy has tried to improve to give as much useful information
as possible.

To get to the bottom of this it would be super helpful to know what
distro you were attempting to connect to, what the actual command was,
and what version of ceph-deploy you were using.

Hopefully, with that information and the (possible) bug fix, it will
mean that more and more people find ceph-deploy as a robust solution
to get
a Ceph cluster up and running.

>
> I therefore need to go back to first principles, but the documentation
> seems to have dropped descriptions of driving ceph without smoke and
> mirrors.
>
> The direct approach may be more laborious, but at least it would not
> depend on anything except ceph itself.
>
> Maybe I need to step back a version or two, set up my cluster with
> mkcephfs, then switch back to the latest to use it.
>
> I'll search the documentation again.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
