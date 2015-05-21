From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [PATCH] Rbd: support copy-on-read option
Date: Thu, 21 May 2015 19:50:52 +0800
Message-ID: <555DC69C.9000505@ubuntukylin.com>
References: <1432192565-11811-1-git-send-email-liwang@ubuntukylin.com> <CAOi1vP80DLrThmz8uwjU5xhMqtQfdiW-gix1VH1vaYeZWU7zEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:35572 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbEULvJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 07:51:09 -0400
In-Reply-To: <CAOi1vP80DLrThmz8uwjU5xhMqtQfdiW-gix1VH1vaYeZWU7zEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Min Chen <minchen@ubuntukylin.com>

Updated at https://github.com/ceph/ceph/pull/4735,
thanks for the comments

On 2015/5/21 17:12, Ilya Dryomov wrote:
> On Thu, May 21, 2015 at 10:16 AM, Li Wang <liwang@ubuntukylin.com> wrote:
>> From: Min Chen <minchen@ubuntukylin.com>
>>
>> Signed-off-by: Min Chen <minchen@ubuntukylin.com>
>> Reviewed-by: Li Wang <liwang@ubuntukylin.com>
>> ---
>>   doc/man/8/rbd.rst | 1 +
>>   src/rbd.cc        | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
>> index 4552951..3fb747f 100644
>> --- a/doc/man/8/rbd.rst
>> +++ b/doc/man/8/rbd.rst
>> @@ -430,6 +430,7 @@ the running kernel.
>>
>>   * ro - Map the image read-only.  Equivalent to --read-only.
>>
>> +* ro - Map the image with copy-on-read turned on.
>
> Need to change the name of the option, ro -> cor.
>
> Thanks,
>
>                  Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
