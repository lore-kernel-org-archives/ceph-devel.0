From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [RFC]New Message Implementation Based on Event
Date: Wed, 8 Oct 2014 09:46:54 +0800
Message-ID: <CACJqLybcawENtftZZKucBRfb+zuGbzV4goRCKWRS7TiyeHJm6Q@mail.gmail.com>
References: <CACJqLybDH97G8do8UfLJd+BKz1Oq9wKneasg8P7L2z9ozCewEQ@mail.gmail.com>
	<alpine.DEB.2.00.1409150849030.513@cobra.newdream.net>
	<CACJqLybt40pmABe5igu8wd2vuPFzE7rkQvqvOhP7ZMHuaJ4Zrw@mail.gmail.com>
	<alpine.DEB.2.00.1410070757480.31126@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35384 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbaJHBq4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Oct 2014 21:46:56 -0400
Received: by mail-ig0-f178.google.com with SMTP id h3so309288igd.5
        for <ceph-devel@vger.kernel.org>; Tue, 07 Oct 2014 18:46:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410070757480.31126@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sam.just@inktank.com>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

No problem, I just came from a long vacation. I will create a PR ASAP

On Tue, Oct 7, 2014 at 10:59 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi Haomai,
>
> A branch cleaning up the messenger interface a bit more just merged.
> Everything is now using the Messenger::create() factory method, and the
> type of messenger instantiated is controlled by the ms_type config option.
> There's also a reorg of the SimpleMessenger files into msg/simple/.
>
> Do you mind rebasing your series onto the latest master?
>
> Since this is an optional backend I think we can take a similar route as
> KeyValueStore and merge it early so that it is easier to test and
> improve.
>
> Will you be able to join the performance call tomorrow?
> sage
>
>
> On Tue, 16 Sep 2014, Haomai Wang wrote:
>
>> As for testing, now I mainly passed tests in src/tests such as
>> ceph_test_rados. Because of the lack of Messenger's unittest, I have
>> to deploy this branch into my dev cluster to test. I'm thinking in
>> make ms_inject* options available in this Messenger for failure
>> coverage.
>>
>> On Mon, Sep 15, 2014 at 11:51 PM, Sage Weil <sweil@redhat.com> wrote:
>> > Hi Haomai,
>> >
>> > On Fri, 12 Sep 2014, Haomai Wang wrote:
>> >> Hi all,
>> >>
>> >> Recently, I did some basic work on new message implementation based on
>> >> event(https://github.com/yuyuyu101/ceph/tree/msg-event). The basic
>> >> idea is that we use a Processor thread for each Messenger to monitor
>> >> all sockets and dispatch fd to threadpool. The event mechanism can be
>> >> epoll, kqueue, poll or select. The thread in threadpool will
>> >> read/write with this socket and dispatch message later.
>> >>
>> >> Now the branch has passed basic tests and before make it more stable
>> >> and pass more QA suites. I want to do some benchmark tests compared to
>> >> pipe implementation with large-scale cluster. I would like to use at
>> >> least 100 OSDs(SSD) and hundreds of clients to test it. And now the
>> >> benchmark for only one OSD, the client can get the same latency with
>> >> pipe implementation and the latency stdev will be smaller.
>> >>
>> >> The background for this implementation is that pipe implementation
>> >> consumes too much overhead on context switch and thread resource. In
>> >> our env, several ceph-osd is running on compute node which also runs
>> >> KVM process.
>> >>
>> >> Do you have any ideas about this, or some serious concerns compared to pipe.
>> >
>> > I haven't had time to look at this in much detail yet, but at a high
>> > level, this looks awesome!  It sounds like using an event lib for this is
>> > a good approach, and from a quick skim it looks like you've already done
>> > the hard work of breaking all of the logic in Pipe.cc into a state
>> > machine.
>> >
>> > How much testing have you done with this?
>> >
>> > I hope to find more time this week to look in more detail, but wanted to
>> > let you know I didn't miss this before that :)
>> >
>> > Cheers-
>> > sage
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>



-- 
Best Regards,

Wheat
