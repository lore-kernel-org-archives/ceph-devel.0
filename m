From: Mohamad Gebai <mgebai@suse.com>
Subject: Re: Beginner's guide to ceph development
Date: Thu, 1 Jun 2017 14:10:55 -0400
Message-ID: <2ff6faba-0e44-3781-e37a-fe0f9f6fe61c@suse.com>
References: <CAODUPsGy7gBSiNcR3ap38yeJXvRzKCAygWcF6s+Mvf6OUQA9HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:34555 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFASLV (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 1 Jun 2017 14:11:21 -0400
In-Reply-To: <CAODUPsGy7gBSiNcR3ap38yeJXvRzKCAygWcF6s+Mvf6OUQA9HQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>, ceph-devel@vger.kernel.org

Hi,

The README at the root directory of the source code is a good place to
start, along with the -DCMAKE_BUILD_TYPE=Debug option to cmake for
debugging. Ceph also supports tracing to get insights on run-time behavior.

Mohamad

On 06/01/2017 02:05 PM, Oleg Kolosov wrote:
> Hi
> I'm interested in writing an original erasure code in Ceph for my
> research purposes. I was wondering if there is any guide for the tools
> available for quick compilation and debugging of ceph source code.
>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

