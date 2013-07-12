From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: [PATCH] ceph:Update the file time after mmap-write.
Date: Fri, 12 Jul 2013 11:16:30 +0800
Message-ID: <CAAM7YAnVgYMWV53HrPUjU42YbAiru1YtYw_DmCYDvwND-1PX6w@mail.gmail.com>
References: <201307110917146231510@gmail.com>
	<CAAM7YA=3stCqYppd6YAwk9tC_rHMzraqge_L6gGZkzaG8LH6Ag@mail.gmail.com>
	<201307111553503594177@gmail.com>
	<CAAM7YAmAwNEX4x2sbTocZTtP01GwW62UD5m9JDWBsRUuf7i1gQ@mail.gmail.com>
	<CAPYLRzgce868NGs96seUa-UVrTaz-8DFSdrcmQgCDCQOygtuTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:49753 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798Ab3GLDQc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 23:16:32 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so7296151lab.40
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jul 2013 20:16:30 -0700 (PDT)
In-Reply-To: <CAPYLRzgce868NGs96seUa-UVrTaz-8DFSdrcmQgCDCQOygtuTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: majianpeng <majianpeng@gmail.com>, sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 12, 2013 at 10:46 AM, Gregory Farnum <greg@inktank.com> wrote:
> On Thu, Jul 11, 2013 at 2:03 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Thu, Jul 11, 2013 at 3:53 PM, majianpeng <majianpeng@gmail.com> wrote:
>>>>On Thu, Jul 11, 2013 at 9:17 AM, majianpeng <majianpeng@gmail.com> wrote:
>>>>> Although, mmap-write of ceph update the time of file using
>>>>> file_update_time.Because it don't mark the relative cap so the time
>>>>> can't save.
>>>>
>>>>I think cephfs' mmap IO support is still broken. mmap IO does not respect
>>>>ceph capabilities at all. It's possible that the kclient has no Fw cap when
>>>>ceph_page_mkwrite is called.
>>>>
>>>>Yan, Zheng
>>>>
>>>>
>>> Hi Yan,
>>>         For the read of mmap, i think we also add cap-check.
>>> And i think we can rewrite the filemap_fault ect ceph_filemap_fault.
>>> In ceph_filemap_fault, most code from filemap_fault, we only add cap-check for read-operation.
>>> How about this or can you suggest anthor method?
>>>
>>
>> This doesn't work. if a file is opened by multiple clients, the MDS
>> doesn't issue Fcb caps to the client.
>> If we add cap check to filemap_fault and page_mkwrite, they can block
>> forever. To make mmap IO work
>> properly, I think the only solution is introducing a new cache
>> coherence protocol for mmap IO
>
> I'm not familiar with the mmap IO paths here at all, but is there some
> reason we need Fcb for it? Not having those just means everything
> needs to be synchronous to the OSD, which is going to be hella slow
> but should be legal?

For mmap write, the kernel has no way to know when an write operation
is finished,
so it can't do synchronous write to the OSD.

Yan, Zheng
Regards

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
