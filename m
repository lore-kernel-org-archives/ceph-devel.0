From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Mourning the demise of mkcephfs
Date: Thu, 14 Nov 2013 08:25:18 -0600
Message-ID: <5284DD4E.4080609@inktank.com>
References: <5281192D.4090707@bob-the-boat.me.uk> <CANtztVwJyK7C5LS1G3YCLh-0T0VODCsUuWE1ADz_PupJe4nAAQ@mail.gmail.com> <5282F309.2030104@catalyst.net.nz> <5282F7FB.4070803@catalyst.net.nz> <5284C1C0.2080909@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62845 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab3KNOZV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Nov 2013 09:25:21 -0500
Received: by mail-ie0-f173.google.com with SMTP id x13so2823962ief.32
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 06:25:20 -0800 (PST)
In-Reply-To: <5284C1C0.2080909@bob-the-boat.me.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, Alfredo Deza <alfredo.deza@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 11/14/2013 06:27 AM, Dave (Bob) wrote:
> I would suggest that it is always dangerous to make assumptions.
> If ceph-deploy needs some information, then this should be explicit, and
> configurable.
> If it needs to know whether initialisation is done by systemd, upstart,
> or sysv init, then what is wrong with requesting a config option?
>
> As it happens, ceph-deploy doesn't seem to be what I require as a
> mkcephfs replacement.
> An earlier exchange with Mark suggests that it wants to involve itself
> with the installation of software, and the configuration of startup
> mechanisms.

I am not an expert on ceph-deploy by any means.  ceph-deploy can do 
these thing (install software, startup, etc), but I don't think it 
strictly has to.

> This is not what I want, and it is not any part of what mkcephfs did.
>
> Given that I have ceph installed, and a bunch of disk drives, I need to
> be able to drive the ceph applications appropriately to set up the
> osd's, keys, and other required data so that I can start the
> ceph-osd(s), the ceph-mon(s), and the ceph-mds(s) [which I can do by
> typing! (and I can make systemd do it automatically if and when I find
> that I'm ready for that)].
>
> This is what mkcephfs did.
>
> The original documentation site gave information on how to perform all
> these operations manually. I am not sure that this information is still
> available.
>
> Whilst I can see that a kind of 'Windows installer' type of application
> could be useful in some circumstances, it is not appropriate to delete
> basic instructions and believe that what I referred to as a 'smoke and
> mirrors' approach to operation is an adequate substitute.
>
> There has been several helpful replies here, and I thank those people.
>
> Please don't maintain the notion that some 'magic installer' is a proper
> substitute for basic and comprehensive 'man pages' and other appropriate
> documentation.
>
> I have been tracking ceph development for many tens of revisions; I have
> discovered the weakness of BTRFS for ceph (which I use in all cases
> except for OSDs, where I take the advice and use XFS); I experiment with
> different hardware configurations; I take advantage of all kernel
> developments that improve disk I/O performance; I keep working with the
> latest kernel and the latest ceph. I am really looking forward to being
> able to rely on ceph, it is the answer to many prayers.
>
> My test is to rsync a large amount of data (several terabytes) to a ceph
> filesystem and for this to happen without hitch. When this happens, I'll
> have confidence. Ceph stresses everything.
>
> I think that this day is now very close.
>
> Very warm regards,
> David
>
> On 13/11/2013 03:54, Mark Kirkwood wrote:
>> On 13/11/13 16:33, Mark Kirkwood wrote:
>>> On 13/11/13 04:53, Alfredo Deza wrote:
>>>> On Mon, Nov 11, 2013 at 12:51 PM, Dave (Bob)
>>>> <dave@bob-the-boat.me.uk> wrote:
>>>>
>>>>> It is unuseable for me at present, because it reports:
>>>>>
>>>>> [ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:
>>>>>
>>>> That looks like a bug. For the past few months the log output of
>>>> ceph-deploy has tried to improve to give as much useful information
>>>> as possible.
>>>>
>>>> To get to the bottom of this it would be super helpful to know what
>>>> distro you were attempting to connect to, what the actual command was,
>>>> and what version of ceph-deploy you were using.
>>>>
>>>> Hopefully, with that information and the (possible) bug fix, it will
>>>> mean that more and more people find ceph-deploy as a robust solution
>>>> to get
>>>> a Ceph cluster up and running.
>>>>
>>>>
>>>
>>> I believe he is using a self built (or heavily customized) Linux
>>> installation - so distribution detection is not going to work in this
>>> case. I'm wondering if there could be some sensible fall back for
>>> that, e.g:
>>>
>>> - refuse to install or purge
>>> - assume sysv init
>>>
>>> so that ceph-deploy can 'do the best it can' in these situations.
>>> Thoughts?
>>>
>>
>> Ahem - replying to myself, sorry:
>>
>> It might be just as easy to allow init to be specified as an option
>> (--init INITTYPE). As an aside, for my development (Ubuntu)
>> workstation, I'm building ceph from src and using ceph-deploy to
>> install it - *but* am switching init to sysv afterwards (I just prefer
>> to use it for that situation).
>>
>> Cheers
>>
>> Mark
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

