From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 13:06:57 -0700
Message-ID: <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
	<CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
	<20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36564 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbcFJUG7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 16:06:59 -0400
Received: by mail-vk0-f45.google.com with SMTP id u64so649320vkf.3
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 13:06:58 -0700 (PDT)
In-Reply-To: <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, Jun 10, 2016 at 12:58 PM, Adam C. Emerson <aemerson@redhat.com>=
 wrote:
> On 10/06/2016, Gregory Farnum wrote:
>> Maybe I'm misunderstanding the scope of what you're proposing, but I
>> don't think this is a good reason to go through this work right now.
>> Lots of things that seem process-specific turn out to be essentially
>> cluster properties, despite being configurable on both ends, and wil=
l
>> need to be referenced from all over the stack. And in general if we'=
re
>> addressing multiple Ceph clusters within a utility we want a full
>> RadosClient etc for each cluster, so the split doesn't do us much go=
od
>> on its own, does it? (If we don't want separate admin sockets for ea=
ch
>> one, we'd need to extend all of those interfaces to support two
>> entries for the same type of thing, etc)
>
> Finding out exactly which things are process specific is one reason
> I'm soliciting for feedback. AdminSocket doesn't have to be
> included. Really, I think we'd get a lot of benefit if we made JUST
> some debug options and dout support process specific and refactored i=
t
> that way. Other things could move later on if people wanted them to
> but wouldn't have to.
>
>
>> If this is your actual goal, I think the unappealing work of replaci=
ng
>> g_ceph_context with a CephContext *cct is the way to go =E2=80=94 we=
'd need to
>> do this much to support multiple ClusterContexts within a process
>> anyway. Once we have a motivating use case for splitting stuff up, w=
e
>> can address that. But if we try and do a generic solution it'll be
>> much more difficult, and probably will miss some key points we don't
>> run into until trying to make use of it.
>>
>> Am I missing something?
>> -Greg
>
> I have been working on the unappealing work of replacing
> g_ceph_context with CephContext* cct. It's not just unappealing work,
> it ends up wiht a result ugly enough I don't think I'd want to merge
> it if someone presented it to me. It's very invasive in that it
> changes a whole lot of everything. The split would ALSO change a whol=
e
> lot of everything, but likely less. You would at least be able to
> avoid changing the constructors of a while bunch of unrelated things
> just to pass a variable in that only some member several classes in
> cares about so it can log a message.

So you want everything to stay with/go back to having a global member
for the ProcessContext?
I'm surprised it needs to find its way into so many random things;
most objects have references to their parent that let them go back to
the MDSRank/OSD/whatever main class there is.

>
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
