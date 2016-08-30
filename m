From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Fork and RDMA operations
Date: Tue, 30 Aug 2016 10:15:44 +1000
Message-ID: <CAF-wwdGKf+h-tZJ-RPauJ=c=2NrZqucWf_qb3SrdzxRjJiNZQQ@mail.gmail.com>
References: <emc456988a-f658-4bfd-b373-ceec459da0a7@lt-vu-7440>
 <alpine.DEB.2.11.1608121314380.17762@piezo.us.to> <CACJqLybXfss4ay5+9WV6Ux1myrkDBiBN2jUSrbVKB44kak-XQg@mail.gmail.com>
 <alpine.DEB.2.11.1608121625320.17762@piezo.us.to> <d026edff-3e36-e3e3-42d8-811534638439@redhat.com>
 <alpine.DEB.2.11.1608242128000.25681@piezo.us.to> <f67d1686-090d-e495-784f-c68b1b5d1b73@redhat.com>
 <20160826031641.GC17568@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36904 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbcH3APt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 20:15:49 -0400
Received: by mail-wm0-f41.google.com with SMTP id i5so9592619wmg.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 17:15:47 -0700 (PDT)
In-Reply-To: <20160826031641.GC17568@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Adam Emerson <aemerson@redhat.com>

Could boost.process be an alternative here?

On Fri, Aug 26, 2016 at 1:16 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>
>
> On Thu, Aug 25, 2016 at 10:43 PM, Casey Bodley <cbodley@redhat.com> wrote:
>>
>>
>> On 08/24/2016 05:32 PM, Sage Weil wrote:
>>>
>>> On Wed, 24 Aug 2016, Casey Bodley wrote:
>>>>
>>>> On 08/12/2016 12:27 PM, Sage Weil wrote:
>>>>>
>>>>> It seems like it would be simpler to push the fork before any important
>>>>> operations.  (And BTW with systemd and upstart we don't fork anyway;
>>>>> it's
>>>>> just there for sysvinit.)  The preforker thing is there to make it easy
>>>>> to
>>>>> fork early, but keep the parent waiting around so that you can do more
>>>>> intialization, print errors, and terminate with an error code if
>>>>> something
>>>>> (post-fork) goes wrong.  In theory, there's no reason why we couldn't
>>>>> make
>>>>> this almost the very first thing the daemon does so that *all* work is
>>>>> done in the child...
>>>>>
>>>>> sage
>>>>>
>>>> I've recently run into issues related to fork as well (see my "memory
>>>> leaks
>>>> related to CephContext and global_init_daemonize()" email). Trying to
>>>> manage
>>>> resources across a fork is difficult and error-prone, so changing how we
>>>> daemonize could eliminate a whole class of these bugs. And as Haomai
>>>> points
>>>> out, we're going to great lengths to make things work in the current
>>>> model.
>>>>
>>>> I'm a big fan of Sage's theory that all work could be done in the child
>>>> process, and I'm willing to take on the project if we can reach a
>>>> consensus on
>>>> the design.
>>>>
>>>> Whether or not we're interested in long-term support for SysV, the
>>>> ability to
>>>> daemonize is useful our for development workflow (vstart.sh in
>>>> particular). To
>>>> fill this role, some basic requirements for the parent process are:
>>>> * don't exit until initialization is finished
>>>> * return an error code if initialization failed
>>>>
>>>> As Sage pointed out, this is exactly what Preforker is doing for
>>>> ceph-mon. So
>>>> we can start by changing the other daemons to use that instead of
>>>> global_init_daemonize().
>>>>
>>>> The next step is to prevent global_init()/common_init()/CephContext from
>>>> doing
>>>> any work in the parent process (esp. spawning threads for Log,
>>>> CephContextServiceThread, and AdminSocket). Decoupling the config parsing
>>>> from
>>>> CephContext initialization seems like a natural way to accomplish that.
>>>> So the
>>>> parent would create and initialize the md_config_t object, then after
>>>> fork,
>>>> the child would pass that as an argument when creating the CephContext.
>>>>
>>>> How does that sound for a start?
>>>
>>> Sounds good to me!  The last step (decoupling) sounds like it's not
>>> strictly necessary but is probably worthwhile.  It will get deep into a
>>> bunch of crufty code that isn't much fun to deal with, so I suspect you'll
>>> either run away screaming or come up with something pretty satisfying that
>>> removes a bunch of ugly code.
>>>
>>> sage
>>
>>
>> Thanks Sage. I'll have to investigate some more to see how messy it will be,
>> but I'm more worried about trying to construct a 'partial' CephContext for
>> parsing, and exposing that to the application when most of its capabilities
>> (logging, especially) are missing. The parent process won't be able to call
>> any code with dout()s, so I think it's safest to avoid constructing a
>> CephContext in the first place.
>
> I'd like to add some thoughts here if I may?
>
> Recently Kefu and I were discussing uses of fork in the ceph codebase at length
> due to the issue seen in http://tracker.ceph.com/issues/16556 Over recent years
> supporting multiple products, including glibc, I have seen many problems arising
> from what I consider to be misuse of fork.
>
> There is a saying, "The only safe function call to make after fork() is exec()"
> and this is reflected in the fork man page.
>
> "After a fork(2) in a multithreaded program, the child can safely call only
> async-signal-safe functions (see signal(7)) until such time as it calls
> execve(2)."
>
> The list of async-signal-safe functions is not very extensive and does not
> include things like malloc and free and I have seen on multiple occasions
> deadlocks where the child is trying to acquire a malloc arena lock for example
> that was locked when fork was called and hanging forever. Basically, if a lock
> is locked when you fork the child will get a copy (COW) of the lock in the
> locked state with no possibility of the lock being unlocked since the child is
> single threaded. if the child then tries to acquire this lock it will hang
> forever. The same can happen with other resources. Note that even if your code
> is single threaded some libraries may use threads in the background and this can
> also catch you out. Sometimes these bugs can be hideously difficult to pin down
> and happen extremely rarely and only on certain machines, etc. due to timing.
>
> These types of problems with fork are well documented.
>
> https://bugs.chromium.org/p/chromium/issues/detail?id=35374#c51
> http://www.evanjones.ca/fork-is-dangerous.html
> http://thorstenball.com/blog/2014/10/13/why-threads-cant-fork/
> https://github.com/gperftools/gperftools/issues/178 (tcmalloc and its use of
> locks)
>
> Google shows a preference for clone in this document, posix_spawn is another
> alternative.
>
> https://github.com/google/googletest/blob/master/googletest/docs/AdvancedGuide.md#death-tests-and-threads
>
> There are partial solutions like pthread_atfork but it is not a comprehensive
> solution, nor is it without its own problems.
>
> Anyway, I just wanted to get this information out there for discussion so we can
> make an educated decision going forward and so that everyone is aware of the
> potential issues with uses of fork in ceph.
>
> --
> Cheers,
> Brad



-- 
Cheers,
Brad
