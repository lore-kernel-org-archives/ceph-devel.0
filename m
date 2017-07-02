From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cannot do ceph pg dump
Date: Sun, 2 Jul 2017 19:15:57 +0200
Message-ID: <fad4ed8a-74e5-1034-97d0-fa9cb1bf383f@digiware.nl>
References: <7e8f4b8a-8a85-8356-0f56-485d02696fd2@digiware.nl>
 <CAJ4mKGY=xYvjz7x=L1D6OMNyMBocasZNwDF-VrDywdV4jd5NAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:11984 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbdGBRQD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 2 Jul 2017 13:16:03 -0400
In-Reply-To: <CAJ4mKGY=xYvjz7x=L1D6OMNyMBocasZNwDF-VrDywdV4jd5NAg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 2-7-2017 17:58, Gregory Farnum wrote:
> On Sun, Jul 2, 2017 at 4:45 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> I can rebuild the cluster, and fix it for mgr, but that is not the point
>> of my message:
>>
>> ---
>> root@cephtest:/zfs/home/wjw # ceph pg dump
>> Error EACCES: access denied' does your client key have mgr caps? See
>> http://docs.ceph.com/docs/master/mgr/administrator/#client-authentication
>> ---
>>
>> When I try to follow that link, it does not really work, because the
>> actual link on that page to give the instructions how to do this, tha
>> page does not exist.
> 
> ...bah humbug. It's supposed to link to
> http://docs.ceph.com/docs/master/rados/operations/user-management/#id1
> ; I'll get that fixed up tomorrow.

Thanx, that'll help.

--WjW


