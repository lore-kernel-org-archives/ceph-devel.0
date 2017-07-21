From: Mark Nelson <mnelson@redhat.com>
Subject: Re: ec performance in small random io testing
Date: Fri, 21 Jul 2017 13:02:09 -0500
Message-ID: <0fa30405-8944-3711-49ca-581adee08f98@redhat.com>
References: <CALi+v18oLKMLcJWBG2BD2K7UzxTpZnYgf255BXUYv3Xr-RO-Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbdGUSCK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Jul 2017 14:02:10 -0400
In-Reply-To: <CALi+v18oLKMLcJWBG2BD2K7UzxTpZnYgf255BXUYv3Xr-RO-Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zengran zhang <z13121369189@gmail.com>, ceph-devel@vger.kernel.org

Hello,

Out of curiosity where you using filestore or bluestore?

Mark

On 07/21/2017 04:26 AM, zengran zhang wrote:
> Hi :
>
>    we found that the ec pool's iops is low in 4K randwrite test, I
> think its because the append op will amplify most random small io, and
> next small write on pending area will cause rmw and clone range...
>
>     could we change the `append` to `write`, and change the `truncate`
> to `unmap` when rollback?
>
>     now the write io fall on one object will splite into one append
> plus one overwrite at most, if we change to write+overwrite, write may
> splite into many writes and overwrites that depending on how much
> holes on the write range..
>
>     now the UNMAP is not yet implemented，want to know wether it is hard to do?
>
>     thanks and regards!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
