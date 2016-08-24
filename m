From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 09:38:26 -0700
Message-ID: <CADRKj5QOmD6FZukz1n_mGLz2feHaPRT0B=njhKLZXAYNGJ2J5A@mail.gmail.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
 <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com>
 <alpine.DEB.2.11.1606271642550.2844@piezo.us.to> <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
 <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com> <alpine.DEB.2.11.1608241621090.25681@piezo.us.to>
 <20160824162643.GB22386@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:35991 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbcHXREp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 13:04:45 -0400
Received: by mail-ua0-f173.google.com with SMTP id 97so39315972uav.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 10:04:05 -0700 (PDT)
In-Reply-To: <20160824162643.GB22386@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

On Wed, Aug 24, 2016 at 9:26 AM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 24/08/2016, Sage Weil wrote:
> [snip]
>> This is appealing, except:
>>
>> > > Note that using the system assert isn't a total disaster: system
>> > > assert will trigger an abort, which will trigger the SIGABRT handler
>> > > which *also* dumps a stack trace to the debug log.  The problem is
>> > > that it doesn't show the assertion condition and line number.
> [snip]
>> I think not getting the assertion condition and line number in the
>> ceph log is a deal breaker.
>
> We should be able to get the condition and line number in the log,
> they're passed to __assert_fail() so we could pass them to
> ceph_assert_fail (see the commit that Casey linked to.)

Will that work on any system we compile on?

>
> I can see arguments either way, the main one I would make AGAINST this
> approach is that it makes portability/building more complicated.
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
