From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Ceph and KVM live migration
Date: Sat, 30 Jun 2012 19:29:00 -0700
Message-ID: <4FEFB5EC.5090202@inktank.com>
References: <4FEF9CF1.6030008@bashkirtsev.com> <4FEFA53F.4020503@inktank.com> <4FEFB2D6.6010603@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34187 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab2GAC3A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jun 2012 22:29:00 -0400
Received: by obbuo13 with SMTP id uo13so5968822obb.19
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jun 2012 19:29:00 -0700 (PDT)
In-Reply-To: <4FEFB2D6.6010603@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On 06/30/2012 07:15 PM, Vladimir Bashkirtsev wrote:
> On 01/07/12 10:47, Josh Durgin wrote:
>> On 06/30/2012 05:42 PM, Vladimir Bashkirtsev wrote:
>>> Dear all,
>>>
>>> Currently I testing KVMs running on ceph and particularly testing recent
>>> cache feature. Performance is of course vastly improved but still have
>>> occasional KVM hold ups - not sure who is at blame ceph of KVM. But I
>>> will deal with it later. Right now I've got myself a question which I
>>> could not get answered myself: if I do live migration of KVM while there
>>> some uncommitted data in ceph cache will this cache be committed prior
>>> cut-over to another host? Reading through the list I've got an
>>> impression that it may be left uncommitted and thus it may cause data
>>> corruption. I just would like a simple confirmation if code which
>>> commits cache on cut-over to new host does exist and no data corruption
>>> due to RBD cache+live migration should happen.
>>>
>>> Regards,
>>> Vladimir
>>
>> QEMU does a flush on all the disks when it stops the guest on the
>> original host, so there will be no uncommitted data in the cache.
>>
>> Josh
> Thank you for quick and precise answer. Now when I actually attempted to
> live migrate ceph based VM I get:
>
> Unable to migrate guest: Invalid relative path
> 'rbd/mail.logics.net.au:rbd_cache=true': Invalid argument
>
> I guess KVM does not like having :rbd_cache=true (migration works
> without it). I know that it is most likely KVM problem but still decided
> to ask here in case if you know about it. Any ideas how to fix it?
>
> Regards,
> Vladimir

Is the destination librbd older and not supporting the cache option?

Migrating with rbd_cache=true and other options specified like that
worked in my testing.

Josh
