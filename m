From: Ricardo Dias <ricardo.dias@suse.com>
Subject: Re: why rbd journaling first write journal to journal pool and then write data
Date: Mon, 22 Aug 2016 10:31:42 +0100
Message-ID: <FCFF045F-961E-4FCF-973F-9D0DFB6469DC@suse.com>
References: <CAKZcxgdqLtdyLPF-dXczMu1hWjbtoF3i2iugDJH1ngtmqNLNNA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:55868 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbcHVJb7 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 22 Aug 2016 05:31:59 -0400
In-Reply-To: <CAKZcxgdqLtdyLPF-dXczMu1hWjbtoF3i2iugDJH1ngtmqNLNNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Jaze,

If you write data first, and you have a failure after writing data and before writing to the journal, then you cannot recover that write operation and it will be lost.

You can see the journal as a primary replica of data.

Ricardo Dias

Sent from my mobile phone

> On 22 Aug 2016, at 09:46, Jaze Lee <jazeltq@gmail.com> wrote:
> 
> Hi all:
>   I found that rbd journaling first write journal and then write data.
>   Why we not first write data and then write journal? Is there some
> considerration
>   for which is first ?
> 
>   Thanks a lot.
> 
> -- 
> 谦谦君子
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

