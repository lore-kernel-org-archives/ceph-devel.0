From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 11 Nov 2016 14:53:36 -0800
Message-ID: <CADRKj5Qd5oRhS4mvZCez1y0P5TmYHga8HrKM8KNJADGRigU=cw@mail.gmail.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
 <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
 <alpine.DEB.2.11.1606101616210.6221@cpach.fuggernut.com> <20160610210433.GA16959@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101716180.6221@cpach.fuggernut.com> <CADRKj5S-wzkZztQvyPMQHLCD-NqmQewbyKY65y1SyKtbjX8bzw@mail.gmail.com>
 <C313FA75-BCBE-49AE-A3C5-5234F2E7D4E6@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34094 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935421AbcKKWxm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 17:53:42 -0500
Received: by mail-ua0-f181.google.com with SMTP id 51so24449461uai.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 14:53:37 -0800 (PST)
In-Reply-To: <C313FA75-BCBE-49AE-A3C5-5234F2E7D4E6@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <Bassam.Tabbara@quantum.com>
Cc: Sage Weil <sweil@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, Nov 11, 2016 at 2:17 PM, Bassam Tabbara
<Bassam.Tabbara@quantum.com> wrote:
> Sorry, I’m late to the discussion, but why not just pass the context to every class that needs it. Its a painful one time change but the compiler will keep you honest. Also if we can figure out a way around the clock skew (which seems like a corner case) I think the surface are is significantly reduced. Using TLS and other mechanisms seems like more complication.

Because then you end up with passing around extra param that you need
to get trickled down to the most basic functions. That's basically
what we are doing now and it's a huge annoyance.

Yehuda

>
> Thanks!
> Bassam
>
>> On Nov 11, 2016, at 1:31 PM, Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:
>>
>> Resurrecting this thread.
>>
>> Trying to extract a simple and practical plan. Here are my thoughts:
>>
>> We need to have different ceph contexts for:
>> - process (e.g, ceph-osd)
>> - entity (e.g., osd.1, osd.2)
>> - cluster (? -- maybe in the case where it's a client)
>>
>> We can make a thread local storage variable that will reference the
>> context this thread needs to use.
>> Threads that deal with common stuff should use the process or entity
>> context. This should be set explicitly in these threads. Upon thread
>> creation we need to set the context for that thread. By default the
>> context that will be used will be the process context. g_ceph_context
>> can be changed to be a function (via a macro) that handles the context
>> selection logic.
>>
>> Thoughts?
>>
>> Yehuda
>>
>> On Fri, Jun 10, 2016 at 2:20 PM, Sage Weil <sage@newdream.net> wrote:
>>> On Fri, 10 Jun 2016, Adam C. Emerson wrote:
>>>> On 10/06/2016, Sage Weil wrote:
>>>>> I think the crux of the issue is the debug/logging code.  Almost all
>>>>> the other uses of cct are related to config options that are
>>>>> per-cluster.
>>>>
>>>> That is correct. I thought we might pull some things like (like the
>>>> Crypto stuff) while we were at it but that was more "As long as I'm
>>>> here anyway I might as well see if there's anything more to do..."
>>>>
>>>>> And with logging... it seems like even this is really a per-cluster
>>>>> (well, per entity) thing.  Sorting through a log file that combines
>>>>> output from two different objecters sounds horrific, and when we
>>>>> cram multiple OSDs into one process, we're going to want them to
>>>>> still feed into different log files.
>>>>
>>>> This is a good point that I had not considered. Though, I'm not sure
>>>> if the un-separated case is that much better. I think part of the
>>>> savings we would want from multi-OSD work (at least in principle) is
>>>> to be able to have them share messengers and other overhead. In that
>>>> case giving each OSD its own fully fledged CephContext doesn't make
>>>> sense, I don't think.
>>>
>>> The messengers aren't tied to CephContext, so I don't think this changes
>>> things in that regard.  I'm guessing we'll end up with something where
>>> each entity has a thing that implements the Messenger interface but many
>>> of those are sharing all their resources behind the scenes (thread pools,
>>> multiplexing their connections, etc.).  We'll have to figure out how the
>>> config options related to messenger itself are handled, but I think that
>>> oddity needs to be done explicitly anyway.  We wouldn't for instance, want
>>> to assume that all clusters in the same process must share the same
>>> messenger options.  (Maybe we invent an entity that governs the shared
>>> resources (process.NNN) and somehow direct config options/admin socket
>>> commands/whatever toward that?  Who knows.)
>>>
>>>> Some form of sterring might work, perhaps making the log system smart
>>>> enough to shove things around based on subsystem or an entity
>>>> identifier or something.
>>>>
>>>>> How bad is the cct plumbing patch?  I fear this might still be the
>>>>> best path forward...
>>>>
>>>> It's not great? Really at all. I wrote it and I don't like it. I
>>>> could pull it up and smack it into shape and make sure it passes tests
>>>> if it were necessary.
>>>
>>> Is it pushed somewhere?  Maybe much of the pain is related to the clock
>>> thing...
>>>
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DQIBaQ&c=8S5idjlO_n28Ko3lg6lskTMwneSC-WqZ5EBTEEvDlkg&r=BTMd2ANcDl5P_nTkEam5zzywWdGjHoaoXy4JMG_yHPA&m=QKRlbMbVgp2mHcuHDtHefIP61023h3qQSsiXl9dsMFY&s=-_S4Iv0GTotef4x0R2-A98N0ufnGQnNa3OOZJwPwjqw&e=
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DQIBaQ&c=8S5idjlO_n28Ko3lg6lskTMwneSC-WqZ5EBTEEvDlkg&r=BTMd2ANcDl5P_nTkEam5zzywWdGjHoaoXy4JMG_yHPA&m=QKRlbMbVgp2mHcuHDtHefIP61023h3qQSsiXl9dsMFY&s=-_S4Iv0GTotef4x0R2-A98N0ufnGQnNa3OOZJwPwjqw&e=
>
>
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
