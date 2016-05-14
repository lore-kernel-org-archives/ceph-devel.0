From: Junwang Zhao <zhjwpku@gmail.com>
Subject: Re: [on-the-wire]Can not pass 'make check'
Date: Sat, 14 May 2016 09:56:41 +0800
Message-ID: <CAEG8a3+ZBRLSA+Sg7ZkdQ-zJjsOciPVASTxPWnt5ETXu-HMZ0g@mail.gmail.com>
References: <CAEG8a3KwK1nMbmFm2WFjNPuFaET22yeafJJG29YddWkUdh00PQ@mail.gmail.com>
	<CACJqLyaJLJcbcQJBNGJz_vLQ4r4iAS33q-SnDiwuQTNpUMNEdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33246 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbcENB4n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2016 21:56:43 -0400
Received: by mail-vk0-f68.google.com with SMTP id s184so14388791vkb.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2016 18:56:42 -0700 (PDT)
In-Reply-To: <CACJqLyaJLJcbcQJBNGJz_vLQ4r4iAS33q-SnDiwuQTNpUMNEdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: "Sage A. Weil" <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Sure,
I will move on, thanks!

On Sat, May 14, 2016 at 9:44 AM, Haomai Wang <haomai@xsky.com> wrote:
> On Sat, May 14, 2016 at 9:26 AM, Junwang Zhao <zhjwpku@gmail.com> wrote:
>> Hi Sage, Haomai,
>>
>> I am trying to test this patch[1], which I have modified after Sage's comments,
>> I rebased this branch to the ceph/master yestoday, it can build but 'make check'
>> got some 'FAIL' and stuck at some point hardly move on, see the attachment.
>
> Although I'm not sure the reason should be related to env, I think
> it's not caused by your commits.
>
> Go ahead:-)
>
>
>>
>> Need some help, thanks!
>>
>> [1]https://github.com/zhjwpku/ceph/commit/6d3c429de80c23afb2612f01536ef6140fe5d3c2
