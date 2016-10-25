From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: jewel 10.2.4 freeze
Date: Mon, 24 Oct 2016 23:27:33 -0400
Message-ID: <CA+aFP1C4DSn+skaQ_UL3KSABdiBZLBZ7SP0y9AE_4ANZ6PQUEQ@mail.gmail.com>
References: <580E1C53.6060503@dachary.org> <87funlerf5.fsf@suse.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36022 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbcJYD1g (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 23:27:36 -0400
Received: by mail-lf0-f46.google.com with SMTP id b75so204297501lfg.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 20:27:35 -0700 (PDT)
In-Reply-To: <87funlerf5.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: Loic Dachary <loic@dachary.org>, Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Nack for RBD pending the following:

https://github.com/ceph/ceph/pull/11467
https://github.com/ceph/ceph/pull/11634

On Mon, Oct 24, 2016 at 10:46 AM, Abhishek L <abhishek@suse.com> wrote:
>
> Loic Dachary writes:
>
>> Hi Abhishek,
>>
>> If we were to freeze jewel 10.2.4 today it would have 115 backports[0]. Do you think it we should stop merging new backports and prepare for the release ? If so, I'll ask the lead of each component to make sure nothing is missing from their point of view.
>
> Yes, lets start getting the ack from the leads
>>
>> You can find the progress of the jewel 10.2.4 release in the ttp://tracker.ceph.com/issues/17487.
>>
>> Cheers
>>
>> [0] issues backported and merged in jewel 10.2.4 http://tracker.ceph.com/versions/524
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>
>
> Best,
> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
