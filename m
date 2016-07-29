From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: scoping daemon-helper replacement effort
Date: Fri, 29 Jul 2016 10:25:51 -0700
Message-ID: <CAKPXa=ZiZz_wtAm3aoXb-xgrQAGcmTdqWJNsPYnm6vz8OP9xLw@mail.gmail.com>
References: <CALqRxCxebmt1Anng1JxT-EU0RH8vFBvHaYs-5dFkgzg-5aWpEA@mail.gmail.com>
 <579B8A76.7020606@redhat.com> <CAKPXa=aHDPjiz4oG7Tvd_CtoNbvVmi=Da3T5FQirO9jCPJCpWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35604 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbcG2RZw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 13:25:52 -0400
Received: by mail-oi0-f44.google.com with SMTP id l72so115347084oig.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 10:25:52 -0700 (PDT)
In-Reply-To: <CAKPXa=aHDPjiz4oG7Tvd_CtoNbvVmi=Da3T5FQirO9jCPJCpWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 29, 2016 at 10:22 AM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
> On Fri, Jul 29, 2016 at 9:55 AM, Josh Durgin <jdurgin@redhat.com> wrote:
>> On 07/29/2016 09:40 AM, Ken Dreyer wrote:
>>>
>>> daemon-helper predates a lot of things in Ceph, and the further we go
>>> into systemd-land with things like unprivilged daemons, SELinux, and
>>> cgroups, the further Teuthology diverges from what our users do. To
>>> remedy this, I want to retire daemon-helper and have Teuthology tests
>>> use the normal init system, particularly now that our main supported
>>> distros are unified around systemd.
> If we just have to worry about systemd it would be much simpler compared to
> supporting various previous initd systems(14.04/7.0 etc). changes can
> affect only jewel+ branches.
>
>>>
>>>  From what I understand, we use daemon-helper in Teuthology to:
>>>
>>>    1) start a daemon and eventually stop it with either SIGTERM or
>>> SIGKILL, depending on whether the Teuthology task has enabled the
>>> coverage or valgrind options,
> I still see some challenges here, some of the code in ceph_manager.py
> does pretty fast killing and revive of osd's, I think that would be possible
  Correction: will not be possible

> with systemd and also generally KILL of process wont work since systemd
> will end up restart the process based on its config, So those cases have
> to be rewritten.
>
>>>
>>>    2) send data via STDIN
>>>
>>>    3) print some messages when the child crashes
>>>
>>> I think we could run the services using the systemd unit files and
>>> still accomplish #1 and #3.
>>>
>>> For #2 (communicating to the daemons via STDIN), how could we
>>> accomplish this? What sort of things are we writing to the daemons'
>>> STDIN? I'm having trouble finding examples in ceph-qa-suite.git.
>>
>>
>> We're not using it to write data to the daemons, but as a way to kill them
>> automatically if our ssh connection dies.
>>
>> With fast reimaging in the works, this will be irrelevant. Even now,
>> it's not really useful for the usual scheduled jobs where the nodes are
>> rebooted on failure. So I wouldn't worry about (2).
>>
>> Josh
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
