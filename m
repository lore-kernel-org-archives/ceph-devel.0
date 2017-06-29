From: Jens Rosenboom <j.rosenboom@x-ion.de>
Subject: Re: ceph-mgr setup magic
Date: Thu, 29 Jun 2017 09:16:08 +0000
Message-ID: <CADr68WZfn34PQjNvHE3piaaA37dOSySN+ts0BirYXhWCJ28VuA@mail.gmail.com>
References: <alpine.DEB.2.11.1706281857110.8533@piezo.novalocal> <b35fe433-e55e-e7da-f32e-56cd88687f43@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36475 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdF2JQK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 05:16:10 -0400
Received: by mail-wm0-f43.google.com with SMTP id 62so76209905wmw.1
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 02:16:09 -0700 (PDT)
In-Reply-To: <b35fe433-e55e-e7da-f32e-56cd88687f43@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, jspray@redhat.com

2017-06-29 5:14 GMT+00:00 Tim Serong <tserong@suse.com>:
> On 06/29/2017 05:04 AM, Sage Weil wrote:
>> There is some goofy behavior with the systemd unit files that tries to
>> make a new ceph-mgr daemon automagically appear next to the mons during a
>> cluster upgrade:
>>
>> - The ceph-mon@.service triggers ceph-mgr@ to start
>> - The ceph-mgr@.service tries to create a ceph-mgr key using whatever
>> mon key it can find
>>
>> This was intended to ease the upgrade path by auto-creating ceph-mgr
>> daemons along the way.
>
> It's also helpful for new installs; it means you don't actually have to
> explicitly configure mgr daemons in order to get a running cluster.  You
> just end up with as many mgrs as mons automatically.
>
> That said, it is somewhat obscure, and also can make it slightly
> irritating if you want to run mgrs on separate nodes (then you have to
> explicitly deploy mgr, and also either uninstall the ceph-mgr package
> from the mon nodes, or at least `systemctl mask ceph-mgr@$(hostname)` on
> those nodes.

IMO this is a good point, please remove the interdependency between
mon and mgr packages.

>> Do we really want this?  I was reminded this behavior is here because of
>> #19994, which points out that this isn't implemented for upstart (still
>> used by trusty 14.04).
>>
>> The jewel -> luminous upgrade process is currently documented here
>>
>>       http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken
>>
>> and basically has a step that says 'verify mgr daemons are running and, if
>> not, create some'.  Is that sufficient?
>
> Probably.  Especially given that now ceph-mgr isn't optional (you'll end
> up with "HEATH_ERR; no active mgr"), there's incentive for everyone to
> configure some mgr daemons ;-)
>
> More seriously: the systemd magic was able to ensure mgr was running
> with Kraken, prior to the various deployment tools growing support for
> deploying mgr, and (possibly?) prior to mgr appearing in the docs.
>
> That magic still works fine and I personally don't mind keeping it, but
> if it's going to result in inconsistent automatic behaviour across
> distros, that's probably bad.  Maybe then for Luminous it's best now to
> drop the magic and require everyone to explicitly configure mgr, as for
> all other daemons?

+1 to removing magic, it is making things unnecessarily complicated
for people who want to deploy their cluster with some kind of
automation tool. I was happy that the ceph-create-keys service has
finally been dropped, please don't let it return through the backdoor.
