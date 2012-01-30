From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Installing_on_RedHat_or_CentOS
Date: Mon, 30 Jan 2012 09:11:49 -0800
Message-ID: <CAF3hT9DvvJ8PNQ3bXyZTt-FhHfA1GZ8bncm-HmZs9OX5=97aBA@mail.gmail.com>
References: <4F26BB5A.5060103@cirrhus9.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46744 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab2A3RLu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2012 12:11:50 -0500
Received: by ghrr11 with SMTP id r11so1872260ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 09:11:49 -0800 (PST)
In-Reply-To: <4F26BB5A.5060103@cirrhus9.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: JJ <jjones@cirrhus9.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 30, 2012 at 7:46 AM, JJ <jjones@cirrhus9.com> wrote:
> I am trying to follow the direction at
> http://ceph.newdream.net/wiki/Installing_on_RedHat_or_CentOS
>
> This is my 3rd or 4th attempt trying to install ceph on 2 different OSs,
> (CentOS 5.[57] and Ubuntu 11.10
>
> Lately, on CentOS 5.5, the boost-devel 1.33.1 comes installed.
> I found a repo that has boost-devel* 1.39 and upgraded my system to that
> release.
>
> the part that fails at
> http://ceph.newdream.net/wiki/Installing_on_RedHat_or_CentOS is the
> instruction titled ""Building ceph itself" / "git checkout -b rc origin/rc"
> complains with
> "fatal: git checkout: updating paths is incompatible with switching
> branches.
> "Did you intend to checkout 'origin/rc' which can not be resolved as
> commit?"

Ah; those instructions are out of date. I've updated them to point at
the "stable" branch. Try:
git checkout -b stable origin/stable

:)

> I don't know git or it's particulars.
>
> Is 64bit architecture a requirement?
Nope!
> Is fuse* a requirement? (modprobe fuse doesn't issue any warnings)
Nope! Although you will have an easier time with the FUSE client than
the kernel client on a CentOS machine.

> Where can I find a more detailed list of requirements?
I don't know that there are any; generally we expect people to use the
packages if they want the dependencies to auto-resolve. :) There are
packages for Ceph but I'm not sure what state they're in; somebody
else will have a better idea!
-Greg
