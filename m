From: Casey Bodley <cbodley@redhat.com>
Subject: Re: fun with seastar
Date: Tue, 24 Oct 2017 16:17:00 -0400
Message-ID: <5b97e2fb-a7a5-ace6-ec7a-39f15f133136@redhat.com>
References: <91a5fd79-ff50-53f7-d187-97d024cee8ba@redhat.com>
 <CACJqLyZ0rAZX3_9iGX9MVkR=PJ9BMF6n2f0yb_PHqWLiqN++Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:48308 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdJXURD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Oct 2017 16:17:03 -0400
Received: by mail-qt0-f194.google.com with SMTP id f8so32089339qta.5
        for <ceph-devel@vger.kernel.org>; Tue, 24 Oct 2017 13:17:03 -0700 (PDT)
In-Reply-To: <CACJqLyZ0rAZX3_9iGX9MVkR=PJ9BMF6n2f0yb_PHqWLiqN++Tg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>



On 10/23/2017 10:23 PM, Haomai Wang wrote:
> On Tue, Oct 24, 2017 at 4:17 AM, Casey Bodley <cbodley@redhat.com> wrote:
>> Hi folks,
>>
>> I mentioned in last week's perf call that I've been experimenting with the
>> Seastar library [1] to see how well it can integrate with the ceph codebase.
>> So far I've managed to add bufferlist conversions to/from the seastar buffer
>> types, and build up a seastar messenger that can send/receive ceph Messages.
>> The branch [2] includes a simple echo server unit test and a README with
>> build instructions.
>>
>> This follows some prototype work a couple years ago by Adam Emerson and
>> myself, dubbed Project Crimson [3], to evaluate Seastar as the basis for a
>> low-latency OSD. Interesting parts of this project include a Cap'n
>> Proto-based messenger and an async ObjectStore interface with Memstore
>> implementation.
> I'm also interested on seastar, but how we get benefit from it to
> ceph? rewrite lots of codes is needed to fit seastar framework..... I
> think a rough integration can't see much benefit

Right. The Seastar model imposes a lot of constraints to achieve the 
performance that it does, and that makes it hard to use with existing 
Ceph code. But for now, I think it's worth exploring what shape such an 
OSD would take, what early steps we could take to get something working, 
and what the biggest challenges would be going forward.

>> -Casey
>>
>> [1] https://github.com/scylladb/seastar
>> [2] https://github.com/cbodley/ceph/commits/wip-seastar-msg
>> [3] https://github.com/cohortfsllc/crimson
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

