From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadosGW performance and disk space usage
Date: Mon, 28 Jan 2013 09:33:51 -0800
Message-ID: <CAC-hyiE8mye5VKkfhLn9Wby9meWD1NLKsHVr3UA8geMH3Skb1g@mail.gmail.com>
References: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com>
	<CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com>
	<CALFpzo4u2PspjkvSig3LL821YY_XA2iHBjAh30JxgwWTFGsgcA@mail.gmail.com>
	<CAJVE5RXpqJ3ZcbxAOCSD0f5OwN6Nre_TuhjY1BUveJTb=cga9A@mail.gmail.com>
	<CAJVE5RVE5_QzvNEYnm86NaKs4GVaAfXDUVUsrdJneXX5GbWgBw@mail.gmail.com>
	<51068B29.2060809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:43908 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674Ab3A1Rdw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 12:33:52 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so1119481ieb.31
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 09:33:51 -0800 (PST)
In-Reply-To: <51068B29.2060809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: Cesar Mello <cmello@gmail.com>, Marcus Sorensen <shadowsor@gmail.com>, Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 28, 2013 at 6:28 AM, Joao Eduardo Luis
<joao.luis@inktank.com> wrote:
> On 01/27/2013 11:10 PM, Cesar Mello wrote:
>>
>> Hi,
>>
>> Just tried rest-bench. This little tool is wonderful, thanks!
>>
>> I still have to learn lots of things. So please don't spend much time
>> explaining me, but instead please give me any pointers to
>> documentation or source code that can be useful. As a curiosity, I'm
>> pasting the results from my laptop. I'll repeat the same tests using
>> my desktop as the server.
>>
>> Notice there is an assert being triggered, so I guess I'm running a
>> build with debugging code ?!. I compiled using ./configure
>> --with-radosgw --with-rest-bench followed by make.
>
>
> asserts are usually used to mark invariants on the code logic, and are
> always built, regardless debugging being enabled or disabled.  Given you are
> hitting one, it probably means something is not quite right (might be a bug,
> or some invariant was broken for some reason).
>
>
>> common/WorkQueue.cc: In function 'virtual ThreadPool::~ThreadPool()'
>> thread 7f1211401780 time 2013-01-27 20:51:01.196525
>> common/WorkQueue.cc: 59: FAILED assert(_threads.empty())
>>   ceph version 0.56-464-gfa421cf
>> (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
>>   1: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
>>   2: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
>>   3: (main()+0x75b) [0x42521b]
>>   4: (__libc_start_main()+0xed) [0x7f120f37576d]
>>   5: rest-bench() [0x426079]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>
>
> Looks like http://tracker.newdream.net/issues/3896
>
Right, 3896. Probably some cleanup before shutdown issues.

Yehuda
