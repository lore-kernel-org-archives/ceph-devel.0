From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: Computation in the storage
Date: Mon, 5 Dec 2016 23:08:07 +0000
Message-ID: <64D605E0-8851-4F60-B0AB-864CBDA7B3F7@Teradata.com>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
 <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de>
 <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
 <200977EA-767F-41DA-9912-143C403D5D7B@Teradata.com>
 <CAB2gnbVn0U_G12L8XV=hbznB2i_TMo40TpC5cVzJZKOr_MAQ7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33373 "EHLO
        rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751998AbcLEXIJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2016 18:08:09 -0500
In-Reply-To: <CAB2gnbVn0U_G12L8XV=hbznB2i_TMo40TpC5cVzJZKOr_MAQ7Q@mail.gmail.com>
Content-Language: en-US
Content-ID: <A3926C24FC3CD346A186BD2E760C2FB6@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Joao Eduardo Luis <joao@suse.de>, "nebil.benmabrouk@orange.com" <nebil.benmabrouk@orange.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> On Dec 4, 2016, at 3:02 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
> 
> On Fri, Dec 2, 2016 at 3:04 PM, Kamble, Nitin A
> <Nitin.Kamble@teradata.com> wrote:
>> 
>> Is anybody using real RADOS object classes on ceph clusters? Any of them on github?
>> I would like to look at some of the real world examples if it is there.
>> And more documentation of this feature would definitely help too.
> 
> We use object classes [0] for a distributed shared log [1] on Ceph.
> 
> [0]: https://github.com/noahdesu/ceph/blob/zlog/jewel/src/cls/zlog/cls_zlog.cc
> [1]: https://github.com/noahdesu/zlog


Thank you Noah & Brad for your pointers for sample Ceph classes. 

Nitin

