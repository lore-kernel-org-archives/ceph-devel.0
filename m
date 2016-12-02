From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: Computation in the storage
Date: Fri, 2 Dec 2016 23:04:06 +0000
Message-ID: <200977EA-767F-41DA-9912-143C403D5D7B@Teradata.com>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
 <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de>
 <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33136 "EHLO
        rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752938AbcLBXEJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2016 18:04:09 -0500
In-Reply-To: <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
Content-Language: en-US
Content-ID: <80C0EFDADEAC6B48A8F773AAE038FFC8@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Joao Eduardo Luis <joao@suse.de>, "nebil.benmabrouk@orange.com" <nebil.benmabrouk@orange.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> On Dec 2, 2016, at 3:49 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> 
> On Fri, Dec 2, 2016 at 9:40 PM, Joao Eduardo Luis <joao@suse.de> wrote:
>> On 12/02/2016 11:03 AM, nebil.benmabrouk@orange.com wrote:
>>> 
>>> Hello,
>>> 
>>> I  am interested in embedding some specific data processing in the storage
>>> close to the data.
>>> I read that, we can integrate some code (e.g., java classes) in Ceph, but
>>> I find no documentation about it.
>> 
>> 
>> What you are looking is actually 'rados object classes' (or ceph classes,
>> according to the docs), and you may find a brief remark about that here
>> 
>> http://docs.ceph.com/docs/master/architecture/#extending-ceph
>> 

Is anybody using real RADOS object classes on ceph clusters? Any of them on github?
I would like to look at some of the real world examples if it is there.
And more documentation of this feature would definitely help too.

Thanks,
Nitin

>> which contains pointers to the code you should look into.
>> 
>> Somehow it feels like there should be some more information about this
>> somewhere, but I can't really recall where.
> 
> Hmmm... that needs updating. Any takers?
> 
> Look at the following.
> 
> src/objclass/objclass.h
> src/test/fooclass.cc
> src/test/barclass.cc
> 
> All the code below src/cls/, especially "hello".
> 
>> 
>>  -Joao
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Cheers,
> Brad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

