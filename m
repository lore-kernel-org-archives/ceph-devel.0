From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: jewel 10.2.8 last call
Date: Fri, 28 Apr 2017 08:41:45 -0700
Message-ID: <CADRKj5Sb_ptBD5=YyT5AAdfVJgG7q3ZQCXyRCzi2kV7ouW5DuA@mail.gmail.com>
References: <18bf7357-dfbd-2def-ee9c-506e67fc24e0@suse.cz> <0015fa14-1baa-f79f-0a95-3a7a904b8c6b@objoo.org>
 <1ee6d36b-9b30-b7c7-a430-3e008383a5dd@suse.cz> <a442ed6e-7fe2-cadd-3841-b1b0f945bf93@objoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35729 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755797AbdD1Plr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Apr 2017 11:41:47 -0400
Received: by mail-qk0-f172.google.com with SMTP id f76so56020777qke.2
        for <ceph-devel@vger.kernel.org>; Fri, 28 Apr 2017 08:41:46 -0700 (PDT)
In-Reply-To: <a442ed6e-7fe2-cadd-3841-b1b0f945bf93@objoo.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <yd@objoo.org>
Cc: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I want to get this one in:
https://github.com/ceph/ceph/pull/14851

Yehuda

On Thu, Apr 27, 2017 at 12:34 PM, Yann Dupont <yd@objoo.org> wrote:
>
>
> Le 25/04/17 à 22:47, Nathan Cutler a écrit :
>>
>> Hi Yann:
>>
>>> AFAICT, this one still isn't merged :
>>>
>>>
>>> https://github.com/ceph/ceph/commit/793ceac2f3d5a2c404ac50569c44a21de6001b62
>>>
>>>
>>>
>>> This is quite simple, but without it, tiering throttling isn't working
>>> the way it should.
>>
>>
>> OK, created http://tracker.ceph.com/issues/19773 and flagged for backport
>> to jewel!
>
> Thanks Nathan !
> Cheers,
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
