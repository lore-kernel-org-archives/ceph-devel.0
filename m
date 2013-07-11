From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: [PATCH] ceph:Update the file time after mmap-write.
Date: Thu, 11 Jul 2013 17:03:40 +0800
Message-ID: <CAAM7YAmAwNEX4x2sbTocZTtP01GwW62UD5m9JDWBsRUuf7i1gQ@mail.gmail.com>
References: <201307110917146231510@gmail.com>
	<CAAM7YA=3stCqYppd6YAwk9tC_rHMzraqge_L6gGZkzaG8LH6Ag@mail.gmail.com>
	<201307111553503594177@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48355 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618Ab3GKJDm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 05:03:42 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so6520071lbd.18
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jul 2013 02:03:40 -0700 (PDT)
In-Reply-To: <201307111553503594177@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 11, 2013 at 3:53 PM, majianpeng <majianpeng@gmail.com> wrote:
>>On Thu, Jul 11, 2013 at 9:17 AM, majianpeng <majianpeng@gmail.com> wrote:
>>> Although, mmap-write of ceph update the time of file using
>>> file_update_time.Because it don't mark the relative cap so the time
>>> can't save.
>>
>>I think cephfs' mmap IO support is still broken. mmap IO does not respect
>>ceph capabilities at all. It's possible that the kclient has no Fw cap when
>>ceph_page_mkwrite is called.
>>
>>Yan, Zheng
>>
>>
> Hi Yan,
>         For the read of mmap, i think we also add cap-check.
> And i think we can rewrite the filemap_fault ect ceph_filemap_fault.
> In ceph_filemap_fault, most code from filemap_fault, we only add cap-check for read-operation.
> How about this or can you suggest anthor method?
>

This doesn't work. if a file is opened by multiple clients, the MDS
doesn't issue Fcb caps to the client.
If we add cap check to filemap_fault and page_mkwrite, they can block
forever. To make mmap IO work
properly, I think the only solution is introducing a new cache
coherence protocol for mmap IO


> Thanks!
> Jianpeng Ma
