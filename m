From: Cheng Cheng <ccheng.leo@gmail.com>
Subject: Re: About the copy-on-read blueprint
Date: Thu, 4 Sep 2014 23:50:11 -0400
Message-ID: <CAC13JXam+9GOxvtaj=466K3CcV_U=kvcy5TyQqqzE-8G0eKFWQ@mail.gmail.com>
References: <CAC13JXaE0H8xh2rX2c+-x-c0jUGV+nKMuoG3Kg+8ZKj-TKTsFQ@mail.gmail.com>
 <5409299C.4090801@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:35307 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844AbaIEDud (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Sep 2014 23:50:33 -0400
Received: by mail-la0-f45.google.com with SMTP id pn19so13104188lab.18
        for <ceph-devel@vger.kernel.org>; Thu, 04 Sep 2014 20:50:31 -0700 (PDT)
In-Reply-To: <5409299C.4090801@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Hi Wang,

Thanks for replying!

If it is undergoing reviewing process, then can I also join for the
code reviewing so I can get some sense about how to contribute?

I also would like to contribute for other optimizations on RBD. I saw
a three-year old thread
(http://marc.info/?l=ceph-devel&m=129867273303846&q=raw) regarding the
optimizations in RBD layering, and am wondering what is the current
status for those optimizations mentioned. Maybe I can take a look on
those topics.

Thanks!
Cheng

> On Sep 4, 2014, at 11:10 PM, Li Wang <liwang@ubuntukylin.com> wrote:
>
> This feature has been done and currently undergoing review
> with its 3rd version. Nevertheless, we are pleasure to give any help.
> BTW, Sage, Could you please take a little bit time to review the patch
> we submitted one month ago.
>
> Cheers,
> Li Wang
>
>> On 2014/9/5 10:39, Cheng Cheng wrote:
>> Hi Ceph Developers,
>>
>> I am just starting to use Ceph and find it is a great platform for
>> hosting VM storage.
>>
>> As I want to dive further and learn more about Ceph, I want to take a
>> starter task to familiarize myself with Ceph codebase. In particular,
>> I found this copy-on-read is an interesting task
>> (https://wiki.ceph.com/Planning/Sideboard/rbd%3A_copy-on-read_for_clones).
>>
>> However I find it is hard to get my hands dirty without mentorship. So
>> I am wondering can anyone give me some bootstrap about how to
>> contribute to Ceph and how to setup developing environment?
>>
>> Any help would be greatly appreciated!
>>
>> Sincerely,
>> Cheng
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
