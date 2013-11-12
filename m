From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: Re: Mourning the demise of mkcephfs
Date: Tue, 12 Nov 2013 10:58:07 -0500
Message-ID: <CANtztVxTaXPM3fhrVDQgzJYH2uAOD69NidnHa5tsfkvFrWE0qA@mail.gmail.com>
References: <5281192D.4090707@bob-the-boat.me.uk>
	<5281D734.3060807@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:55417 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab3KLP6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 10:58:07 -0500
Received: by mail-ob0-f179.google.com with SMTP id wn1so4814463obc.38
        for <ceph-devel@vger.kernel.org>; Tue, 12 Nov 2013 07:58:07 -0800 (PST)
In-Reply-To: <5281D734.3060807@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "Dave (Bob)" <dave@bob-the-boat.me.uk>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 12, 2013 at 2:22 AM, Wido den Hollander <wido@42on.com> wrote:
> On 11/11/2013 06:51 PM, Dave (Bob) wrote:
>>
>> The utility mkcephfs seemed to work, it was very simple to use and
>> apparently effective.
>>
>> It has been deprecated in favour of something called ceph-deploy, which
>> does not work for me.
>>
>> I've ignored the deprecation messages until now, but in going from 70 to
>> 72 I find that mkcephfs has finally gone.
>>
>> I have tried ceph-deploy, and it seems to be tied in to specific
>> 'distributions' in some way.
>>
>> It is unuseable for me at present, because it reports:
>>
>> [ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:
>>
>>
>> I therefore need to go back to first principles, but the documentation
>> seems to have dropped descriptions of driving ceph without smoke and
>> mirrors.
>>
>> The direct approach may be more laborious, but at least it would not
>> depend on anything except ceph itself.
>>
>
> I myself am not a very big fan of ceph-deploy as well.

Why not? I definitely want to make it better for users, and any
feedback is super useful. What kind of caveats have
you found that lead you to not use it (or use something completely different) ?

>  Most installations I
> do are done by bootstrapping the monitors and osds manually.
>
> I have some homebrew scripts for this, but I mainly use Puppet to make sure
> all the packages and configuration is present on the nodes and afterwards
> it's just a matter of adding the OSDs and formatting their disks once.
>
> The guide to bootstrapping a monitor:
> http://eu.ceph.com/docs/master/dev/mon-bootstrap/
>
> When the monitor cluster is running you can start generating cephx keys for
> the OSDs and add them to the cluster:
> http://eu.ceph.com/docs/master/rados/operations/add-or-rm-osds/
>
> I don't know if the docs are 100% correct. I've done this so many times that
> I do a lot of things without even reading the docs, so there might be a typo
> in it somewhere. If so, report it so it can be fixed.
>
> Where I think that ceph-deploy works for a lot of people I fully understand
> that some people just want to manually bootstrap a Ceph cluster from
> scratch.
>
> Wido
>
>
>> Maybe I need to step back a version or two, set up my cluster with
>> mkcephfs, then switch back to the latest to use it.
>>
>> I'll search the documentation again.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
