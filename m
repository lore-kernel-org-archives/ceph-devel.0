From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: 12.2.2 Luminous validation status
Date: Thu, 23 Nov 2017 17:04:46 +0100
Message-ID: <87vai1ugkh.fsf@suse.com>
References: <CAMMFjmH0-XbJ1P431bErnMS1BEaU3Ln9XhVMPbEte3ixm+YSzQ@mail.gmail.com> <9162c114-44ea-3153-fc3f-76fbd20e06b4@redhat.com> <CAMMFjmG_6UrMOEWmanz76GyGsJioFLt-ZAYRaYzQJ72LH2pRqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:43977 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbdKWQEs (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 23 Nov 2017 11:04:48 -0500
In-Reply-To: <CAMMFjmG_6UrMOEWmanz76GyGsJioFLt-ZAYRaYzQJ72LH2pRqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Ilya Dryomov <idryomov@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yuri Weinstein <yweinste@redhat.com> writes:

> Josh's fixed merged and tested, so rados is good.
>
> Ilya's kernel fix helped sort out knfs and kcepfs failures, however
> some jobs still failed (see details/bugs in the ticket) and need
> Patrick, Ilya review.

I saw patrick's approval on cephfs, though k{RBD/cephfs} suites need
Ilya's approval I belive. 
>
> Please review the tests results and either approve or comment.
>
> Thx
> YuriW
>
> On Wed, Nov 15, 2017 at 6:07 PM, Josh Durgin <jdurgin@redhat.com> wrote:
>> On 11/15/2017 02:00 PM, Yuri Weinstein wrote:
>>>
>>> Details of this release summarized here
>>> http://tracker.ceph.com/issues/21830#note-26
>>
>>
>> The rados failures are due to a bug in the test fixed by:
>>
>> https://github.com/ceph/ceph/pull/18808
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
