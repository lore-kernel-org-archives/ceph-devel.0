From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 14:54:20 -0700
Message-ID: <BANLkTi=Nx2=mC0C_70vjwxuJ94UKB93xhw@mail.gmail.com>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
	<20110421185606.GC9431@dreamer>
	<BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
	<20110421193240.GA26545@dreamer>
	<99672323C62444DFA181A0659E4D37FC@gmail.com>
	<BANLkTimvdNXA+F6sTS0HqkdUqE1uqFNkJA@mail.gmail.com>
	<BANLkTikVQcMKsR1WY8uBQOk1KQ+tO+ezXA@mail.gmail.com>
	<BANLkTikfqcYyiqirZ9zY+ZMiLbc-=BodRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52263 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab1DUVyV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 17:54:21 -0400
Received: by iyb14 with SMTP id 14so114564iyb.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 14:54:20 -0700 (PDT)
In-Reply-To: <BANLkTikfqcYyiqirZ9zY+ZMiLbc-=BodRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Apr 21, 2011 at 2:44 PM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> On Thu, Apr 21, 2011 at 2:23 PM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>> On Thu, Apr 21, 2011 at 2:09 PM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
>>> On Thu, Apr 21, 2011 at 1:03 PM, Gregory Farnum
>>> <gregory.farnum@dreamhost.com> wrote:
>>>> I really don't see how pushing the naming complexity into the local filesystem,
>>>> where it adds lots of otherwise-useless inodes and dentries, is going to help us.
>>>
>>> Here is a quick summary of how the TV's proposal would help us.
>>> 1. it avoids collisions entirely
>>> 2. You don't ever have do an extra xattr lookup, no matter how short
>>> or long the object name is.
>>
>> Yeah, but you read more directories. Note that btrfs stores the xattrs
>> on the directories, so reading those xattrs will have a lower IO
>> impact than traversing directories recursively.
>
> It does seem like btrfs' extended attribute implementation is fairly
> efficient. But Linux's dentry cache (dcache) is also pretty efficient.
>
(resending to list)

It needs to be populated first before being efficient. And it'll be
less efficient now that you populate it with extra entries.

Yehuda
