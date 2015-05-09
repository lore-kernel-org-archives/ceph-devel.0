From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Newstore Update Part 2
Date: Fri, 08 May 2015 19:52:22 -0500
Message-ID: <554D5A46.7040303@redhat.com>
References: <554D44E3.7080600@redhat.com> <CAC6JEv-thH39P9LG3ErioqzJ=MUVyWNz9_zx+Azg2aAZ+ah2yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47982 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbbEIAw0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 May 2015 20:52:26 -0400
In-Reply-To: <CAC6JEv-thH39P9LG3ErioqzJ=MUVyWNz9_zx+Azg2aAZ+ah2yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 05/08/2015 07:19 PM, Gregory Farnum wrote:
> On Fri, May 8, 2015 at 4:21 PM, Mark Nelson <mnelson@redhat.com> wrote:
>> Hi Guys,
>>
>> At the performance meeting this week we discussed the possibility of
>> changing how newstore handles large partial overwrites.
>
> Er, what was the potential change?

Basically breaking the object up into fragments on overwrite so that we 
don't do big updates to 4MB files behind the scenes.  Instead for 
overwrites of a certain size (say 1MB+) create a new fragment.

>
>> To determine if
>> this is useful, we look at rados bench and rbd performance of newstore at
>> various IO sizes.  I've also included some rados bench read results as folks
>> were interested in those.  On the graphs I've tried to mark interesting
>> improvements/regressions and also some questions/comments. These tests were
>> run without overlay which may help small IO performance in some cases.
>>
>> Graphs are here:
>>
>> http://nhm.ceph.com/newstore/8c8c5903_rbd_rados_tests.pdf
>>
>> Thanks,
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
