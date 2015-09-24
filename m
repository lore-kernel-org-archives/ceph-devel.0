From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Thu, 24 Sep 2015 19:00:38 +0300
Message-ID: <56041E26.1030508@mirantis.com>
References: <56018A05.6090100@mirantis.com>
 <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
 <56029F66.3070503@mirantis.com>
 <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
 <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
 <5602C48C.4010009@mirantis.com>
 <CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
 <5604131E.2030408@mirantis.com>
 <alpine.DEB.2.00.1509240829540.13265@cobra.newdream.net>
 <D229D7B5.6CBA%paul.hewlett@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35690 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbbIXQAm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 12:00:42 -0400
Received: by lacwc7 with SMTP id wc7so11733180lac.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 09:00:40 -0700 (PDT)
In-Reply-To: <D229D7B5.6CBA%paul.hewlett@alcatel-lucent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "HEWLETT, Paul (Paul)" <paul.hewlett@alcatel-lucent.com>, ceph-devel <ceph-devel@vger.kernel.org>

As for me that's the first time I hear about it.

But if we introduce pluggable compression back-ends that would be pretty 
easy to try.

Thanks,
Igor.

On 24.09.2015 18:41, HEWLETT, Paul (Paul) wrote:
> Out of curiosity have you considered the Google compression algos:
>
> http://google-opensource.blogspot.co.uk/2015/09/introducing-brotli-new-comp
> ression.html
>
>
> Paul
>
> On 24/09/2015 16:34, "ceph-devel-owner@vger.kernel.org on behalf of Sage
> Weil" <ceph-devel-owner@vger.kernel.org on behalf of sweil@redhat.com>
> wrote:
>
>> On Thu, 24 Sep 2015, Igor Fedotov wrote:
>>> On 23.09.2015 21:03, Gregory Farnum wrote:
>>>> On Wed, Sep 23, 2015 at 6:15 AM, Sage Weil <sage@newdream.net> wrote:
>>>>>>> The idea of making the primary responsible for object
>>> compression
>>>>>>> really concerns me. It means for instance that a single random
>>> access
>>>>>>> will likely require access to multiple objects, and breaks many
>>> of the
>>>>>>> optimizations we have right now or in the pipeline (for
>>> instance:
>>>>>>> direct client access).
>>>>> Could you please elaborate why multiple objects access is required
>>> on
>>>>> single
>>>>> random access?
>>>> It sounds to me like you were planning to take an incoming object
>>>> write, compress it, and then chunk it. If you do that, the symbols
>>>> ("abcdefgh = a", "ijklmnop = b", etc) for the compression are likely
>>>> to reside in the first object and need to be fetched for each read in
>>>> other objects.
>>> Gregory,
>>> do you mean a kind of compressor dictionary under symbols "abcdefgh =
>>> a", etc
>>> here.
>>> And your assumption is that such dictionary is made on the first write,
>>> saved
>>> and reused by any subsequent reads, right?
>>> I think that's not the case - it's better to compress each write
>>> independently.  Thus there is no need to access "dictionary" object (
>>> i.e. the
>>> first object with these symbols) on every read operation,. The latter
>>> uses
>>> compressed block data only.
>>> Yes, this might affect total compression ratio but thinks that's
>>> acceptabl.
>> I was also assuming each stripe unit would be independently compressed,
>> but I didn't think about the efficiency.  This approach implies that
>> you'd want a relatively large stripe size (100s of KB or more).
>>
>> Hmm, a quick google search suggests the zlib compression window is only
>> 32KB anyway, which isn't so big.  The more aggressive algorithms probably
>> aren't what people would reach for anyway for CPU utilization reasons...
>> I
>> guess?
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

