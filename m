From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Mourning the demise of mkcephfs
Date: Tue, 12 Nov 2013 08:07:20 -0600
Message-ID: <52823618.6000305@inktank.com>
References: <5281192D.4090707@bob-the-boat.me.uk> <5281D734.3060807@42on.com> <52821D6F.9000602@bob-the-boat.me.uk> <52823397.3050905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50485 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab3KLOHS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 09:07:18 -0500
Received: by mail-ie0-f180.google.com with SMTP id qd12so1688472ieb.11
        for <ceph-devel@vger.kernel.org>; Tue, 12 Nov 2013 06:07:17 -0800 (PST)
In-Reply-To: <52823397.3050905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel@vger.kernel.org

I forgot to mention you can change the ceph-init script in the packaged 
version too if you don't want to compile ceph from source.  It's a very 
easy modification and it should work fine afterwards.

Mark

On 11/12/2013 07:56 AM, Mark Nelson wrote:
> FYI, I created a bug for this last week:
>
> http://tracker.ceph.com/issues/6720
>
> Mark
>
> On 11/12/2013 06:22 AM, Dave (Bob) wrote:
>> On 12/11/2013 07:22, Wido den Hollander wrote:
>>> On 11/11/2013 06:51 PM, Dave (Bob) wrote:
>>>> The utility mkcephfs seemed to work, it was very simple to use and
>>>> apparently effective.
>>>>
>>>> It has been deprecated in favour of something called ceph-deploy, which
>>>> does not work for me.
>>>>
>>>> I've ignored the deprecation messages until now, but in going from
>>>> 70 to
>>>> 72 I find that mkcephfs has finally gone.
>>>>
>>>> I have tried ceph-deploy, and it seems to be tied in to specific
>>>> 'distributions' in some way.
>>>>
>>>> It is unuseable for me at present, because it reports:
>>>>
>>>> [ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:
>>>>
>>>>
>>>> I therefore need to go back to first principles, but the documentation
>>>> seems to have dropped descriptions of driving ceph without smoke and
>>>> mirrors.
>>>>
>>>> The direct approach may be more laborious, but at least it would not
>>>> depend on anything except ceph itself.
>>>>
>>>
>>> I myself am not a very big fan of ceph-deploy as well. Most
>>> installations I do are done by bootstrapping the monitors and osds
>>> manually.
>>>
>>> I have some homebrew scripts for this, but I mainly use Puppet to make
>>> sure all the packages and configuration is present on the nodes and
>>> afterwards it's just a matter of adding the OSDs and formatting their
>>> disks once.
>>>
>>> The guide to bootstrapping a monitor:
>>> http://eu.ceph.com/docs/master/dev/mon-bootstrap/
>>>
>>> When the monitor cluster is running you can start generating cephx
>>> keys for the OSDs and add them to the cluster:
>>> http://eu.ceph.com/docs/master/rados/operations/add-or-rm-osds/
>>>
>>> I don't know if the docs are 100% correct. I've done this so many
>>> times that I do a lot of things without even reading the docs, so
>>> there might be a typo in it somewhere. If so, report it so it can be
>>> fixed.
>>>
>>> Where I think that ceph-deploy works for a lot of people I fully
>>> understand that some people just want to manually bootstrap a Ceph
>>> cluster from scratch.
>>>
>>> Wido
>>>
>>>> Maybe I need to step back a version or two, set up my cluster with
>>>> mkcephfs, then switch back to the latest to use it.
>>>>
>>>> I'll search the documentation again.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>>
>> Thank you very much Wido.
>> David
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

