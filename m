From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2] ceph: Fix file open flags on ppc64
Date: Fri, 28 Apr 2017 11:14:56 +0200
Message-ID: <56b605cc-ee88-612e-4935-a60a3a151f04@suse.de>
References: <1493310840-201351-1-git-send-email-agraf@suse.de>
 <D29AEA6E-CB75-42CF-A0B6-47F61A23183C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1425402AbdD1JPE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Apr 2017 05:15:04 -0400
In-Reply-To: <D29AEA6E-CB75-42CF-A0B6-47F61A23183C@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan.Fajerski@suse.com, Jeff Layton <jlayton@redhat.com>



On 28.04.17 09:57, Yan, Zheng wrote:
>
>> On 28 Apr 2017, at 00:34, Alexander Graf <agraf@suse.de> wrote:
>>
>> The file open flags (O_foo) are platform specific and should never go
>> out to an interface that is not local to the system.
>>
>> Unfortunately these flags have leaked out onto the wire in the cephfs
>> implementation. That lead to bogus flags getting transmitted on ppc64.
>>
>> This patch converts the kernel view of flags to the ceph view of file
>> open flags.
>>
>> Fixes: 124e68e74 ("ceph: file operations")
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>
>> —
>
> I removed the "unused open flags” dout and applied the patch. Thank you for tracking down and fixing the bug.

I actually put that in on purpose, in case anyone in 2 years tries to 
find out why a particular flag doesn't get populated :).


Alex
