From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: cleanup: add override where possible when implementing an interface
Date: Tue, 14 Feb 2017 22:24:39 +0800
Message-ID: <CACKY0b_8RB8-SssyRJJ40TjEQ7tyQ4Np0BmXvs8jd-=7Mbhntw@mail.gmail.com>
References: <CACKY0b8Xy5JNC-5Y8BcQEW8QDrHq85Qa7=nC9DjB3H+VmbarNQ@mail.gmail.com>
 <alpine.DEB.2.11.1702141410190.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35548 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbdBNOYk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 09:24:40 -0500
Received: by mail-yw0-f174.google.com with SMTP id l19so66851690ywc.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 06:24:40 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702141410190.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Sage

I have issued a PR: https://github.com/ceph/ceph/pull/13414


2017-02-14 22:11 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Tue, 14 Feb 2017, liuchang0812 wrote:
>> Hi, Sage and Cephers:
>>
>> I saw a issue "add override where possible when implementing an
>> interface". So I used a LLVM tool called clang-tidy to do it
>> automatically. .
>>
>> I have made a big changes:
>>
>>       246 files changed, 1305 insertions(+), 1305 deletions(-)
>>
>> I could build it successfully, should I make a Pull-Request?
>
> Yeah sure!  If you could break it up by subsystem (rgw, osd, rbd, mds,
> everything else) that would help.  Thanks!
>
>> BTW, I am pleasure to write a simple documentation about this tool if
>> we need this.
>
> Sure!  Something in doc/dev, or even just an email to the list?
>
> sage
