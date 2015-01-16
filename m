From: Michael Sevilla <mikesevilla3@gmail.com>
Subject: Re: MDS has inconsistent performance
Date: Fri, 16 Jan 2015 10:35:50 -0800
Message-ID: <CAD=PzHJ1TWG3+iH11-2gMRKn-61jcVmbKO=u=-7Kb0pMtBa0mw@mail.gmail.com>
References: <CAD=PzH+UxcrF-0=fpAWrXsv-CB=q1nbAxbBHSn9A_P-hS1-fGg@mail.gmail.com>
	<CAC6JEv9fXSm+xEcFPiJ90kQNKjoWdFZCs02ZHKD4kJGd4_2Q8w@mail.gmail.com>
	<CAD=PzHLahg1TPu3-zjFk6hO4cXeYg+-TjdR5cw0XNSoVA+_Ebw@mail.gmail.com>
	<CAC6JEv_1Gx3pnmutej7UmABC+eyB+VvoBo6X1OZhHFu+==6fjA@mail.gmail.com>
	<CAD=PzHJFT4QUeer7A-EawAQ=AskEu44pLPqHo4BLpk11zA1UQw@mail.gmail.com>
	<CAC6JEv826RqkkTCt3224LLv_BdS9394yucXf7_qaKwsYHmC-+A@mail.gmail.com>
	<CAAM7YA=QqCfo0AREmCt+=yaDUOzAxqemkjWxKJRxw_TcA_429A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:49567 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756633AbbAPSfw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 13:35:52 -0500
Received: by mail-la0-f42.google.com with SMTP id gd6so20502835lab.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 10:35:50 -0800 (PST)
In-Reply-To: <CAAM7YA=QqCfo0AREmCt+=yaDUOzAxqemkjWxKJRxw_TcA_429A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>

On Fri, Jan 16, 2015 at 8:27 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Fri, Jan 16, 2015 at 2:37 PM, Gregory Farnum <greg@gregs42.com> wrote:
>> On Thu, Jan 15, 2015 at 2:44 PM, Michael Sevilla <mikesevilla3@gmail.com> wrote:
>>> Let me know if this works and/or you need anything else:
>>>
>>> https://www.dropbox.com/s/fq47w6jebnyluu0/lookup-logs.tar.gz?dl=0
>>>
>>> Beware - the clients were on debug=10. Also, I tried this with the
>>> kernel client and it is more consistent; it does the 2 lookups per
>>> create on 1 client every single time.
>>
>> Mmmm, there are no mds logs of note here. :(
>>
>> I did look enough to see that:
>> 1) The MDS is for some reason revoking caps on the file create
>> prompting the switch to double-lookups, which it was not before. The
>> client doesn't really have any visibility into why that would be the
>> case; the best guess I can come up with is that maybe the MDS split up
>> the directory into multiple frags at this point -- do you have that
>> enabled?
>> 2) The only way we set the I_COMPLETE flag is when we create an empty
>> directory, or when we do a complete listdir on one. That makes it
>> pretty difficult to get the flag back (and so do the optimal create
>> path) once you lose it. :( I'd love a better way to do so, but we'll
>> have to look at what's involved in a bit of depth.
>>
>> I'm not sure why the kernel client is so much more cautious, but I
>> think there were a number of troubles with the directory listing
>> orders and things which were harder to solve there - I don't remember
>> if we introduced the I_DIR_ORDERED flag in it or not. Zheng can talk
>> more about that. What kernel client version are you using?
>>
>> And for a vanity data point, what kind of hardware is your MDS running on? :)
>
> For kernel before 3.18, the I_COMPLETE get cleared once directory is modified.
> I_DIR_ORDERED is introduced by 3.18 kernel. I just tried 3.18 kernel,
> unfortunately
> there still is a bug that prevent new directory from having I_COMPLETE flag
>
Ok, I'll stay on 3.4 until that I_COMPLETE flag bug is fixed. Thanks!
> Regards
> Yan, Zheng
>
>>
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
