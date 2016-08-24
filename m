From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: assert
Date: Wed, 24 Aug 2016 19:13:42 +0200
Message-ID: <da3bd06c-26f4-4941-589c-2a6718d43806@digiware.nl>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
 <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com>
 <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
 <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
 <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1608241621090.25681@piezo.us.to>
 <20160824162643.GB22386@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25712 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755719AbcH1Ry7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 28 Aug 2016 13:54:59 -0400
In-Reply-To: <20160824162643.GB22386@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

On 24-8-2016 18:26, Adam C. Emerson wrote:
> On 24/08/2016, Sage Weil wrote:
> [snip]
>> This is appealing, except:
>>
>>>> Note that using the system assert isn't a total disaster: system 
>>>> assert will trigger an abort, which will trigger the SIGABRT handler 
>>>> which *also* dumps a stack trace to the debug log.  The problem is 
>>>> that it doesn't show the assertion condition and line number.
> [snip]
>> I think not getting the assertion condition and line number in the
>> ceph log is a deal breaker.
> 
> We should be able to get the condition and line number in the log,
> they're passed to __assert_fail() so we could pass them to
> ceph_assert_fail (see the commit that Casey linked to.)
> 
> I can see arguments either way, the main one I would make AGAINST this
> approach is that it makes portability/building more complicated.

I'd go for the full deal.

The big advantage of doing it yourself is that you are in full control.
And certainly not dependent on any system code that does the trick
slightly different.

I had already a hard time getting FreeBSD and Linux in line over a
simple thing as ENODATA == ENOATTR. And this sounds way much more
complicated.

It might be a lot of changes, but for the first step I guess you can
sort of automate it with
  perl -pni.bak 's/assert\(/ceph_assert\(/g;' \
	`find src -name \*.c -o -name \*.cc`

and then get the refinements in when people pass by in files an know the
priorities.

--WjW


