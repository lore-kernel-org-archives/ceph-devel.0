From: Tim Spriggs <tims@uahirise.org>
Subject: Re: /etc/init.d/ceph vs upstart
Date: Tue, 3 Dec 2013 11:15:37 -0700
Message-ID: <CAEUrXvwAqOK3=s33Rf9fV6yLQJPybteDX=sQhZiapLvJ-ORTWg@mail.gmail.com>
References: <CAEUrXvweJa50=ZVFvWOknCSzO9NKvvxikYhn7-Mmz4NgvYAkTA@mail.gmail.com>
	<CAEUrXvySMMz=HiXTTPY+d1i50XYSayuguMz8tLGH+_Z4PvJ9uw@mail.gmail.com>
	<CAEUrXvyVN0y1WTAP5HeM2EEnONJu2UgHBdvQtENQzCELkhRvPA@mail.gmail.com>
	<CAEUrXvy6u3zWtJYhfsggaK_akW5eeb_Agm6eVa8Tipxjhpqb0Q@mail.gmail.com>
	<5293C8FB.4040709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:34866 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3LCSPi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Dec 2013 13:15:38 -0500
Received: by mail-oa0-f44.google.com with SMTP id m1so15438555oag.17
        for <ceph-devel@vger.kernel.org>; Tue, 03 Dec 2013 10:15:37 -0800 (PST)
In-Reply-To: <5293C8FB.4040709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

This does seem to fix the issue. Thanks!

On Mon, Nov 25, 2013 at 3:02 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 11/25/2013 11:01 AM, Tim Spriggs wrote:
>>
>> ... ping
>>
>> On Thu, Nov 7, 2013 at 3:31 PM, Tim Spriggs <tims@uahirise.org> wrote:
>>>
>>> Oops, I just realized I did the patch in the wrong direction :)
>>>
>>> On Thu, Nov 7, 2013 at 3:06 PM, Tim Spriggs <tims@uahirise.org> wrote:
>>>>
>>>> Hi All,
>>>>
>>>>    I am battling extraneous error messages from two sources:
>>>>
>>>>    logrotate which is run in cron.daily and has a definition from the
>>>> ceph package in /etc/logrotate.d. The message I get in an email from
>>>> every node once a day is:
>>>>
>>>> cat: /var/run/ceph/osd.3.pid: No such file or directory
>>>>
>>>> This comes up because upstart is actually running ceph-osd while the
>>>> init.d script expects a pidfile.
>>>>
>>>>
>>>>    /var/log/ceph/ceph-osd.$id.log which complains:
>>>>
>>>> ERROR: error converting store /var/lib/ceph/osd/ceph-3: (16) Device or
>>>> resource busy
>>>>
>>>> This happens on boot as well as on log rotation.
>>>>
>>>>
>>>> After talking with dmick on irc.oftc.net#ceph, I was alerted to the
>>>> fact that there are bits in upstart as well as the sysvinit style
>>>> script that attempt to only use one scheme or the other. However, the
>>>> logic seems wrong. Inside of ceph_common.sh, there is a function named
>>>> check_host which looks for /var/lib/ceph/$type/ceph-$id/sysvinit and
>>>> if it exists, it returns. If it doesn't exist, it just goes on to the
>>>> next check (which passes in my environment.) Instead, it should return
>>>> a non-0 value. Attached is an example patch.
>
>
> I think continuing if the host matches is intentional, so the init
> script continues working for daemons deployed before
> /var/lib/ceph/$type/ceph-$id/sysvinit or
> /var/lib/ceph/$type/ceph-$id/upstart were used.
>
> To maintain backwards compatibility, and prevent both upstart and sysvinit
> from trying to manage the same daemons, I think we can exit
> if the file for the other init system is present, like this patch:
>
> https://github.com/ceph/ceph/commit/b1d260cabb90bb9155f18c8e38a1dca102e6466c
>
> Does this work for you?
>
> Josh
