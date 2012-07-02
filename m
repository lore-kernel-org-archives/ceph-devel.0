From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph and KVM live migration
Date: Mon, 2 Jul 2012 11:21:40 -0700
Message-ID: <CAPYLRzjWRwvud8cNKHE5X7bbTQL8ZjdxPdy=1gJ=pWp_brnX+g@mail.gmail.com>
References: <4FEF9CF1.6030008@bashkirtsev.com>
	<4FEFA53F.4020503@inktank.com>
	<4FEFB2D6.6010603@bashkirtsev.com>
	<4FEFB5EC.5090202@inktank.com>
	<4FEFC225.5080204@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37884 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab2GBSVm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 14:21:42 -0400
Received: by bkwj10 with SMTP id j10so974965bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 11:21:41 -0700 (PDT)
In-Reply-To: <4FEFC225.5080204@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Jun 30, 2012 at 8:21 PM, Vladimir Bashkirtsev
<vladimir@bashkirtsev.com> wrote:
> On 01/07/12 11:59, Josh Durgin wrote:
>>
>> On 06/30/2012 07:15 PM, Vladimir Bashkirtsev wrote:
>>>
>>> On 01/07/12 10:47, Josh Durgin wrote:
>>>>
>>>> On 06/30/2012 05:42 PM, Vladimir Bashkirtsev wrote:
>>>>>
>>>>> Dear all,
>>>>>
>>>>> Currently I testing KVMs running on ceph and particularly testing
>>>>> recent
>>>>> cache feature. Performance is of course vastly improved but still have
>>>>> occasional KVM hold ups - not sure who is at blame ceph of KVM. But I
>>>>> will deal with it later. Right now I've got myself a question which I
>>>>> could not get answered myself: if I do live migration of KVM while
>>>>> there
>>>>> some uncommitted data in ceph cache will this cache be committed prior
>>>>> cut-over to another host? Reading through the list I've got an
>>>>> impression that it may be left uncommitted and thus it may cause data
>>>>> corruption. I just would like a simple confirmation if code which
>>>>> commits cache on cut-over to new host does exist and no data corruption
>>>>> due to RBD cache+live migration should happen.
>>>>>
>>>>> Regards,
>>>>> Vladimir
>>>>
>>>>
>>>> QEMU does a flush on all the disks when it stops the guest on the
>>>> original host, so there will be no uncommitted data in the cache.
>>>>
>>>> Josh
>>>
>>> Thank you for quick and precise answer. Now when I actually attempted to
>>> live migrate ceph based VM I get:
>>>
>>> Unable to migrate guest: Invalid relative path
>>> 'rbd/mail.logics.net.au:rbd_cache=true': Invalid argument
>>>
>>> I guess KVM does not like having :rbd_cache=true (migration works
>>> without it). I know that it is most likely KVM problem but still decided
>>> to ask here in case if you know about it. Any ideas how to fix it?
>>>
>>> Regards,
>>> Vladimir
>>
>>
>> Is the destination librbd older and not supporting the cache option?
>>
>> Migrating with rbd_cache=true and other options specified like that
>> worked in my testing.
>>
>> Josh
>
> Both installations are the same:
> qemu 1.0.17
> ceph 0.47.3
> libvirt 0.9.12
>
> I have googled around and found that if I call migration with --unsafe
> option then it should go. And indeed: it works. Apparently this check
> introduced in libvirt 0.9.12 . Did quick downgrade to libvirt 0.9.11 and no
> problems migrating.

Have we checked if the live migrate actually does do the cache flushes
when you use the unsafe flag? That worries me a little!

In either case, I created a bug so we can try and make QEMU play nice:
http://tracker.newdream.net/issues/2685
-Greg
