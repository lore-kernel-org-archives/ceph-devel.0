From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Slow file creating and deleting using bonnie ++ on Hammer
Date: Tue, 26 May 2015 07:30:02 -0700
Message-ID: <CAC6JEv9D-5LjmUea=K1OBfYDX_uJGyLc2xf1aduyurWBTO7iFA@mail.gmail.com>
References: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>
	<CAC6JEv9ZjK6nn0tK7HpQWMkMcYhn=Kbg77_+J1NxKTq0WWfJOQ@mail.gmail.com>
	<CAMzumdYw_13u2nYDohMRbtD-tcKOTmJNn-x+mEFh2__hpf8XKw@mail.gmail.com>
	<CAMzumdZgmsmBYHci2qq1qDs2nWmXq3StR9FbPT3FfHy_zi9qeA@mail.gmail.com>
	<555F4C78.7060601@redhat.com>
	<CAMzumdYaQ1sZUQPbb-42ZSLZgYxLY7CWWoyE5DsUpryd3s6mhQ@mail.gmail.com>
	<CAAM7YAnxOp3Yo+F=mP4AvZBM1-7xD_N8A8h_H0cVNjOZ=S=cfg@mail.gmail.com>
	<55645FA3.3090507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33915 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbEZOaE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 10:30:04 -0400
Received: by ieczm2 with SMTP id zm2so93343002iec.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2015 07:30:03 -0700 (PDT)
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com. [209.85.213.177])
        by mx.google.com with ESMTPSA id o9sm11096013ioe.35.2015.05.26.07.30.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2015 07:30:02 -0700 (PDT)
Received: by igbhj9 with SMTP id hj9so61069630igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2015 07:30:02 -0700 (PDT)
In-Reply-To: <55645FA3.3090507@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Barclay Jameson <almightybeeij@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 26, 2015 at 4:57 AM, John Spray <john.spray@redhat.com> wrote:
>
>
> On 26/05/2015 07:55, Yan, Zheng wrote:
>>
>> the reason for slow file creations is that bonnie++ call fsync(2) after
>> each creat(2). fsync() wait for safe replies of the create requests. MDS
>> sends safe reply when log event for the request gets journaled safely. MDS
>> flush the journal every 5 seconds (mds_tick_interval). So the speed of file
>> creation for bonnie++ is one file every file seconds.
>
>
> Ah, I hadn't noticed that the benchmark called... I wonder if I'm seeing the
> fuse client return quickly because it simply doesn't implement the fsyncdir
> call.  We should fix that!
>
> It looks like we used to have an OP_FSYNC in the client-server protocol
> (perhaps for flushing the log immediately on fsyncs), anyone have any
> background on why that went away?

Following up, we discussed this in standup and the answer was "no".

Seeing the question in context of this thread, though, I think maybe
I've asked before and either the answer or the deduced reason was
"because we didn't want to let clients force an (expensive) MDS log
flush".
-Greg
