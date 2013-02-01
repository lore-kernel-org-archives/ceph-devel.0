From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: on disk encryption
Date: Thu, 31 Jan 2013 17:16:50 -0700
Message-ID: <CALFpzo6d6SF-wFQGvA-buK2Na8O_RbKwVX6GOByv80S60RzQrg@mail.gmail.com>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net>
	<CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com>
	<50C5A894.8020507@ubuntu.com>
	<6EACA8977B8949FE9A17B74B37772B4A@inktank.com>
	<50FF0478.7020702@ubuntu.com>
	<alpine.DEB.2.00.1301221603360.17154@cobra.newdream.net>
	<CALFpzo5WBnRa=LTVqnqo+iG4FziyCxJxjYVp=tvE=aYJEBw4zw@mail.gmail.com>
	<510B068D.8000706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:39317 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab3BAAVy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 19:21:54 -0500
Received: by mail-ve0-f177.google.com with SMTP id m1so2492838ves.8
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 16:21:53 -0800 (PST)
In-Reply-To: <510B068D.8000706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: Sage Weil <sage@inktank.com>, James Page <james.page@ubuntu.com>, Gregory Farnum <greg@inktank.com>, Peter Reiher <reiher@inktank.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, ceph-devel@vger.kernel.org

That's a great idea, it simplifies things for the admin and doesn't
sound too hairy on the monitor side. One alternative option is to do
it in one of the ways that ZFS does; that is you can provide a config
option that says 'get the keys from here'. For example you could set
up an https server and have ceph fetch the keys from it at start up.
Users could provide a master key for the whole pool, or per OSD, or
different keys for groups of OSDs, per the config file.

 I still like the monitor idea better, but different users may prefer
different methods, and this might be an easier solution to implement
first.

Here's some of the zfs documentation in case it sparks some other ideas.

# zfs create -o encryption=on -o
keysource=raw,https://keys.example.com/mykey tank/project/R

http://www.oracle.com/technetwork/articles/servers-storage-admin/manage-zfs-encryption-1715034.html

On Thu, Jan 31, 2013 at 5:04 PM, Mark Kampe <mark.kampe@inktank.com> wrote:
> Correct.
>
> I wasn't actually involved in this (or any other real) work,
> but as I recall the only real trick is how much key management
> you want:
>
>   Do we want to be able to recover the key if a good disk
>   is rescued from a destroyed server and added to a new
>   server?
>
>   Do we want to ensure that the keys are not persisted on
>   the server, so that an entire server can be decommissioned
>   without having to worry about the data being recovered
>   by somebody who knows where to look?
>
> If you are willing to keep the key on the server and lose
> the data when the server fails, this is trivial.  If you
> are unwilling to keep the key on the server, or if you need
> the disk to remain readable after the server is lost, we
> need some third party (like the monitors) to maintain the
> keys.
>
> We thought these might be important, so we were looking
> at how to get the monitors to keep track of the encryption
> keys.
>
>
> On 01/31/2013 03:42 PM, Marcus Sorensen wrote:
>>
>> Yes, anyone could do this now by setting up the OSDs on top of
>> dm-crypted disks, correct? This would just automate the process, and
>> manage keys for us?
>
>
