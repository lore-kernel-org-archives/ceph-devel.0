From: Loic Dachary <loic@dachary.org>
Subject: Re: migrating dmcrypt keys ?
Date: Mon, 20 Feb 2017 22:12:40 +0100
Message-ID: <48410a16-1abd-34ff-2136-06fb8c35f396@dachary.org>
References: <CAGbvivJVPkqdMhWuf=5Lx6DSi9UR9aYnAGtqT7K23NO31y_bPg@mail.gmail.com>
 <dd16ff32-75e9-3f58-b0cc-50a162774d0a@dachary.org>
 <CAGbviv+5PvSYJCxrGWY5-TcDOTEu-h_z_-qbgdzuqk4zSN0V1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38411 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdBTVMq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 16:12:46 -0500
In-Reply-To: <CAGbviv+5PvSYJCxrGWY5-TcDOTEu-h_z_-qbgdzuqk4zSN0V1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 02/20/2017 09:17 PM, Wyllys Ingersoll wrote:
> Can you elaborate - specifically what would I look for in ceph-disk?
> I would be interested in writing the migration tool if I knew where to
> start digging.

The keyword to look for is lockbox, starting from here https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/main.py#L1193 looking at the pull requests that merged this, you should have some valuable context.

Cheers


> 
> thanks!
> 
> On Mon, Feb 20, 2017 at 2:56 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi,
>>
>> On 02/20/2017 08:49 PM, Wyllys Ingersoll wrote:
>>> Is it possible to migrate a legacy (i..e pre-Jewel) osd device that
>>> was originally setup with dmcrypt keys in /etc/ceph/dmcrypt-keys to
>>> use the newer osd-lockbox scheme without having to destroy the osd and
>>> re-prepare it?
>>
>> You can do it manually by mimicing what ceph-disk does. It would be nice to have a tool to do that.
>>
>> Cheers
>>
>>>
>>> Thanks
>>>
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
