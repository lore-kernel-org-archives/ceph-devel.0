From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: scoping daemon-helper replacement effort
Date: Fri, 29 Jul 2016 11:40:47 -0700
Message-ID: <CAJ4mKGYhHebR-bb_HEroVWwhnUqNfRKWAnTUKbPKc2KSsAiZrw@mail.gmail.com>
References: <CALqRxCxebmt1Anng1JxT-EU0RH8vFBvHaYs-5dFkgzg-5aWpEA@mail.gmail.com>
 <579B8A76.7020606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33135 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcG2Sks (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 14:40:48 -0400
Received: by mail-vk0-f51.google.com with SMTP id x130so60442149vkc.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 11:40:48 -0700 (PDT)
In-Reply-To: <579B8A76.7020606@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 29, 2016 at 9:55 AM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 07/29/2016 09:40 AM, Ken Dreyer wrote:
>>
>> daemon-helper predates a lot of things in Ceph, and the further we go
>> into systemd-land with things like unprivilged daemons, SELinux, and
>> cgroups, the further Teuthology diverges from what our users do. To
>> remedy this, I want to retire daemon-helper and have Teuthology tests
>> use the normal init system, particularly now that our main supported
>> distros are unified around systemd.
>>
>>  From what I understand, we use daemon-helper in Teuthology to:
>>
>>    1) start a daemon and eventually stop it with either SIGTERM or
>> SIGKILL, depending on whether the Teuthology task has enabled the
>> coverage or valgrind options,
>>
>>    2) send data via STDIN
>>
>>    3) print some messages when the child crashes
>>
>> I think we could run the services using the systemd unit files and
>> still accomplish #1 and #3.
>>
>> For #2 (communicating to the daemons via STDIN), how could we
>> accomplish this? What sort of things are we writing to the daemons'
>> STDIN? I'm having trouble finding examples in ceph-qa-suite.git.
>
>
> We're not using it to write data to the daemons, but as a way to kill them
> automatically if our ssh connection dies.
>
> With fast reimaging in the works, this will be irrelevant. Even now,
> it's not really useful for the usual scheduled jobs where the nodes are
> rebooted on failure. So I wouldn't worry about (2).

I think we also use this to kill processes by closing stdin on the
teuthology process side. Some quick grepping suggests we have ~21 call
sites and they're largely not in the tracker; I don't imagine they'll
be too hard to replace but it might be a little awkward in some
places.
-Greg
