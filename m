From: Vasiliy Angapov <angapov@gmail.com>
Subject: Re: Would it make sense to require ntp
Date: Fri, 6 Nov 2015 23:19:10 +0800
Message-ID: <CAGtbiz0TMKNfhRxv8WWJD-BeafuQEqmV0E0B9kSTOBt9=gU79A@mail.gmail.com>
References: <563C7BB1.7030500@suse.cz>
	<CALe9h7eP-vabaMCYuLuEUO2pME-cRfUHVrOFgkzRcZNqxL2ZbA@mail.gmail.com>
	<CAJ4mKGYB57udBju=5g-B0FmBtbKeqrWNw2tk08noJmvX1RzVng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34665 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161301AbbKFPTM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 10:19:12 -0500
Received: by lfgh9 with SMTP id h9so73357470lfg.1
        for <ceph-devel@vger.kernel.org>; Fri, 06 Nov 2015 07:19:11 -0800 (PST)
In-Reply-To: <CAJ4mKGYB57udBju=5g-B0FmBtbKeqrWNw2tk08noJmvX1RzVng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: John Spray <jspray@redhat.com>, Joao Eduardo Luis <joao@suse.com>, Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

Btw, in RHEL 7 based distros there is a choice between ntpd and
chronyd with the latest being more preferred.
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/ch-Configuring_NTP_Using_the_chrony_Suite.html

2015-11-06 23:08 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Fri, Nov 6, 2015 at 4:26 AM, John Spray <jspray@redhat.com> wrote:
>> On Fri, Nov 6, 2015 at 10:06 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>> Hi Ceph:
>>>
>>> Recently I encountered some a "clock skew" issue with 0.94.3. I have
>>> some small demo clusters in AWS. When I boot them up, in most cases the
>>> cluster will start in HEALTH_WARN due to clock skew on some of the MONs.
>>>
>>> I surmise that this is due to a race condition between the ceph-mon and
>>> ntpd systemd services. Sometimes ntpd.service starts *after* ceph-mon -
>>> in this case the MON sees a wrong/unsynchronized time value.
>>>
>>> Now, even though ntpd.service starts (and fixes the time value) very
>>> soon afterwards, the cluster remains in clock skew for a long time - but
>>> that is a separate issue. What I would like to ask is this:
>>>
>>> Is there any reasonable Ceph cluster node configuration that does not
>>> include running the NTP daemon?
>>
>> Only if there is some other time service replacing it.  I don't really
>> know of anyone using alternative ntp daemons, but it's a possibility
>> to consider before introducing a hard dependency on ntpd.
>>
>>> If the answer is "no", would it make sense to make NTP a runtime
>>> dependency and tell the ceph-mon systemd service to wait for
>>> ntpd.service before it starts?
>>
>> Just waiting for the service is quick, but it doesn't achieve any
>> effect on the clock other than promising that it will be synced at
>> some point in the future.  Wouldn't we have to wait for time sync
>> rather than just waiting for the service?  That could take a while.
>>
>> My hunch is that users wouldn't appreciate the mon blocking until
>> times were in sync, they'd probably prefer to go ahead and start up,
>> but raise a warning (like we currently do).
>>
>> Given all that, maybe the question is actually: why do the mons stay
>> in the skew state for so long after the clocks are corrected?
>
> Perhaps they're just keeping the warning log up until the next
> regularly-scheduled clock sync test? I don't know that we want to
> start higher-frequency testing when in an error state (how expensive
> are the clock sync tests?) but we could at least let admins trigger
> one directly. (Maybe we do, but I didn't find anything about clocks in
> MonCommands.)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
