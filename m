From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: wip-addr
Date: Sat, 10 Oct 2015 11:20:52 +0800
Message-ID: <CACJqLyZG1FyJ0ScS-Fwcb6rGmNGvxM93iW6GZ7=2hxzG3Msu=g@mail.gmail.com>
References: <20151002232413.GA8939@degu.b.linuxbox.com>
	<alpine.DEB.2.00.1510091446090.29929@cobra.newdream.net>
	<CACJqLyZh4WQZv_3isjXJy=t6YL700C2GjWuen-QG1D5=RkKHYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35498 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbJJDUx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Oct 2015 23:20:53 -0400
Received: by vkha6 with SMTP id a6so5087175vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2015 20:20:52 -0700 (PDT)
In-Reply-To: <CACJqLyZh4WQZv_3isjXJy=t6YL700C2GjWuen-QG1D5=RkKHYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Marcus Watts <mwatts@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, dzafman@redhat.com

resend to ML

On Sat, Oct 10, 2015 at 11:20 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>
>
> On Sat, Oct 10, 2015 at 5:49 AM, Sage Weil <sage@newdream.net> wrote:
>>
>> Hey Marcus,
>>
>> On Fri, 2 Oct 2015, Marcus Watts wrote:
>> > wip-addr
>> >
>> > 1. where is it?
>> > 2. current state
>> > 3. more info
>> > 4. cheap fixes
>> > 5. in case you were wondering why?
>> >
>> > ____ 1. where is it?
>> >
>> > I've just pushed another update to wip-addr:
>> >
>> > git@github.com:linuxbox2/linuxbox-ceph.git
>> > wip-addr
>> >
>> > ____ 2. current state
>> >
>> > This version
>> > 1/ compiles
>> > 2/ ran an extremely limited set of tests successfully
>> >       (was able to bring up ceph-mon, ceph-osd).
>> >
>> > In theory, it should do everything a recent "master" branch copy of ceph
>> > can do and little or nothing past that.  Internally it adds "address
>> > vector"
>> > support, some parsing/print logic, and lots of encoding rules to pass
>> > them
>> > around, but there's nothing that can create and little that makes any
>> > sensible use of this.  So this is just the back end encoding and storage
>> > rules.
>>
>> This is looking pretty good. I left some comments.  There are still a few
>> XXX's left... but not many.  Haomai, can you help with the async msgr one?
>> (Also, Marcus, can you check if the msg/Simple/Pipe.cc connect() and
>> accept() code doing the right thing?)
>
>
> I have a quick view among all commits, looks a great improvement for the
> future enhancing.
>
>>
>>
>> One minor thing.. please put the subsystem as the prefix to the commit
>> message instead of the branch name (e.g., mds: add features to event
>> types).
>>
>> > Phase 2 is to add logic to actually make it useful.
>> >       (the very start of this is on linuxbox2 "wip-addr-p2",
>> >       just monmap changes so far...)
>> > ____ 3. more info
>> >
>> > There's an etherpad document that describes this in more detail,
>> >
>> > http://pad.ceph.com/p/wip_addr
>> >
>> > ____ 4. cheap fixes
>> >
>> > a couple of minor issues that should be easy to resolve,
>> > 1.
>> > AsyncConnection.cc
>> > this passes addresses back and forth as it's setting up the connection,
>> > and it also exchanges features.  As best I can tell, it looks like
>> > it exchanges addresses before it knows what features the other end
>> > supports.  There should be something in here that
>> > does this after knowing what features the other end supports.
>>
>> Copying Haomai.
>
>
> Right, it should be the same as simple messenger. The "features" bit is
> exchanged in "ceph_msg_connect" and "ceph_msg_connect_reply".
>
> I'm afraid that making features before addr exchange isn't a smooth way.
> Maybe we need a middle release to help format migrating. Or we need to add
> retry mechanism, we could add proper way to let new-style addr side detect
> peer format.
>
>>
>>
>> > 2.
>> > (about line 2067 in src/tools/ceph_objectstore_tool.cc)
>> > (use via ceph cmd?) tools - "object store tool".
>> > This has a way to serialize objects which includes a watch list
>> > which includes an address.  There should be an option here to say
>> > whether to include exported addresses.
>>
>> I think it's safe to use defaults here.. what do you think, David?
>>
>> Thanks!
>> sage
>>
>
>
>
> --
>
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
