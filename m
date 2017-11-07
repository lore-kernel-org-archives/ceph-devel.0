From: Erik McCormick <emccormick@cirrusseven.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Tue, 7 Nov 2017 01:39:00 -0500
Message-ID: <CAHUi5cPe+KzspSPaB=TGxo=kO9k71=Oqknhovy=fYZ1NHW_Pqg@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
 <alpine.DEB.2.11.1706091602210.3646@piezo.novalocal> <CAHUi5cOM8zrnZ80RMqJhEwowE6XmM3dnAKJmxNf8E82fM7Nfbg@mail.gmail.com>
 <alpine.DEB.2.11.1706091626211.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:47604 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbdKGGjC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Nov 2017 01:39:02 -0500
Received: by mail-qk0-f180.google.com with SMTP id m189so14011531qke.4
        for <ceph-devel@vger.kernel.org>; Mon, 06 Nov 2017 22:39:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1706091626211.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Fri, Jun 9, 2017 at 12:30 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 9 Jun 2017, Erik McCormick wrote:
>> On Fri, Jun 9, 2017 at 12:07 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Thu, 8 Jun 2017, Sage Weil wrote:
>> >> Questions:
>> >>
>> >>  - Does anybody on the list use a non-default cluster name?
>> >>  - If so, do you have a reason not to switch back to 'ceph'?
>> >
>> > It sounds like the answer is "yes," but not for daemons. Several users use
>> > it on the client side to connect to multiple clusters from the same host.
>> >
>>
>> I thought some folks said they were running with non-default naming
>> for daemons, but if not, then count me as one who does. This was
>> mainly a relic of the past, where I thought I would be running
>> multiple clusters on one host. Before long I decided it would be a bad
>> idea, but by then the cluster was already in heavy use and I couldn't
>> undo it.
>>
>> I will say that I am not opposed to renaming back to ceph, but it
>> would be great to have a documented process for accomplishing this
>> prior to deprecation. Even going so far as to remove --cluster from
>> deployment tools will leave me unable to add OSDs if I want to upgrade
>> when Luminous is released.
>
> Note that even if the tool doesn't support it, the cluster name is a
> host-local thing, so you can always deploy ceph-named daemons on other
> hosts.
>
> For an existing host, the removal process should be as simple as
>
>  - stop the daemons on the host
>  - rename /etc/ceph/foo.conf -> /etc/ceph/ceph.conf
>  - rename /var/lib/ceph/*/foo-* -> /var/lib/ceph/*/ceph-* (this mainly
> matters for non-osds, since the osd dirs will get dynamically created by
> ceph-disk, but renaming will avoid leaving clutter behind)
>  - comment out the CLUSTER= line in /etc/{sysconfig,default}/ceph (if
> you're on jewel)
>  - reboot
>
> If you wouldn't mind being a guinea pig and verifying that this is
> sufficient that would be really helpful!  We'll definitely want to
> document this process.
>
> Thanks!
> sage
>
Sitting here in a room with you reminded me I dropped the ball on
feeding back on the procedure. I did this a couple weeks ago and it
worked fine. I had a few problems with OSDs not wanting to unmount, so
I had to reboot each node along the way. I just used it as an excuse
to run updates.

-Erik
>
>>
>> > Nobody is colocating multiple daemons from different clusters on the same
>> > host.  Some have in the past but stopped.  If they choose to in the
>> > future, they can customize the systemd units themselves.
>> >
>> > The rbd-mirror daemon has a similar requirement to talk to multiple
>> > clusters as a client.
>> >
>> > This makes me conclude our current path is fine:
>> >
>> >  - leave existing --cluster infrastructure in place in the ceph code, but
>> >  - remove support for deploying daemons with custom cluster names from the
>> > deployment tools.
>> >
>> > This neatly avoids the systemd limitations for all but the most
>> > adventuresome admins and avoid the more common case of an admin falling
>> > into the "oh, I can name my cluster? cool! [...] oh, i have to add
>> > --cluster rover to every command? ick!" trap.
>> >
>>
>> Yeah, that was me in 2012. Oops.
>>
>> -Erik
>>
>> > sage
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
