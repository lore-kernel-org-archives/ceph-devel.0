From: Barclay Jameson <almightybeeij@gmail.com>
Subject: Re: Slow file creating and deleting using bonnie ++ on Hammer
Date: Tue, 26 May 2015 09:50:29 -0500
Message-ID: <CAMzumdZsGzykN4=t6QeqhG5Y=xge1+oWi-75PBUCi2xkE4NEbQ@mail.gmail.com>
References: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>
	<CAC6JEv9ZjK6nn0tK7HpQWMkMcYhn=Kbg77_+J1NxKTq0WWfJOQ@mail.gmail.com>
	<CAMzumdYw_13u2nYDohMRbtD-tcKOTmJNn-x+mEFh2__hpf8XKw@mail.gmail.com>
	<CAMzumdZgmsmBYHci2qq1qDs2nWmXq3StR9FbPT3FfHy_zi9qeA@mail.gmail.com>
	<555F4C78.7060601@redhat.com>
	<CAMzumdYaQ1sZUQPbb-42ZSLZgYxLY7CWWoyE5DsUpryd3s6mhQ@mail.gmail.com>
	<CAAM7YAnxOp3Yo+F=mP4AvZBM1-7xD_N8A8h_H0cVNjOZ=S=cfg@mail.gmail.com>
	<55645FA3.3090507@redhat.com>
	<CAC6JEv9D-5LjmUea=K1OBfYDX_uJGyLc2xf1aduyurWBTO7iFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:32976 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbbEZOuj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 10:50:39 -0400
Received: by yhcb70 with SMTP id b70so31326419yhc.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2015 07:50:29 -0700 (PDT)
In-Reply-To: <CAC6JEv9D-5LjmUea=K1OBfYDX_uJGyLc2xf1aduyurWBTO7iFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thank you for the great explanation Zheng! That definitely shows what
I was seeing with the bonnie++ test. What bad things would happen if I
modified the config option mds_tick_interval to flush the journal to a
second or less? Does this also mean any custom code written should
avoid use of fsync() if writing a large number of files?

On Tue, May 26, 2015 at 9:30 AM, Gregory Farnum <greg@gregs42.com> wrote:
> On Tue, May 26, 2015 at 4:57 AM, John Spray <john.spray@redhat.com> wrote:
>>
>>
>> On 26/05/2015 07:55, Yan, Zheng wrote:
>>>
>>> the reason for slow file creations is that bonnie++ call fsync(2) after
>>> each creat(2). fsync() wait for safe replies of the create requests. MDS
>>> sends safe reply when log event for the request gets journaled safely. MDS
>>> flush the journal every 5 seconds (mds_tick_interval). So the speed of file
>>> creation for bonnie++ is one file every file seconds.
>>
>>
>> Ah, I hadn't noticed that the benchmark called... I wonder if I'm seeing the
>> fuse client return quickly because it simply doesn't implement the fsyncdir
>> call.  We should fix that!
>>
>> It looks like we used to have an OP_FSYNC in the client-server protocol
>> (perhaps for flushing the log immediately on fsyncs), anyone have any
>> background on why that went away?
>
> Following up, we discussed this in standup and the answer was "no".
>
> Seeing the question in context of this thread, though, I think maybe
> I've asked before and either the answer or the deduced reason was
> "because we didn't want to let clients force an (expensive) MDS log
> flush".
> -Greg
