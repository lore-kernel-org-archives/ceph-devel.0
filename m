From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Fri, 10 Aug 2012 10:01:46 +0800
Message-ID: <50246B8A.5070504@gmail.com>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com> <5023E96E.30209@sandia.gov> <CADvuQRG9DrG6irjuD8ZZcAz_grgS=9i6M6GDV0-gYWfAyje4uw@mail.gmail.com> <5023ED56.9070102@bisect.de> <CADvuQRHf=_nQetqmghUp7Mbe-QtcfOYfkdRkTJQhbBpzSGXDRg@mail.gmail.com> <alpine.DEB.2.00.1208091845090.8611@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56904 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758411Ab2HJCBu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 22:01:50 -0400
Received: by pbbrr13 with SMTP id rr13so1867037pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 19:01:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208091845090.8611@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, Danny Kukawka <danny.kukawka@bisect.de>, ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

On 08/10/2012 09:53 AM, Sage Weil wrote:
> On Thu, 9 Aug 2012, Tommi Virtanen wrote:
>> On Thu, Aug 9, 2012 at 10:03 AM, Danny Kukawka <danny.kukawka@bisect.de> wrote:
>>> So you mean chef?! Will there be an alternative to simply setup a
>>> cluster from console?
>>>
>>> We (SUSE) are already working on an own chef ceph cookbook. But from
>>> what I've seen till now it's really hard and more laborious to initially
>>> setup a cluster with chef than with mkcephfs.
>>
>> I've written about this on the mailing list several times. We see a
>> lot of demand for Chef, but don't want to tie our hands -- Canonical
>> is working on Juju Charms, and I would like to see a mkcephfs
>> replacement that relies on just SSH connections from a workstation
>> node. We've made an explicit effort to improve the product as a whole,
>> and to make the Chef cookbook as thin as possible.
>>
>> For some reason, the threading is broken on the archive, but this is a
>> fragment of the most recent thread that talked about this:
>>
>> http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/8263/focus=8265
>
> I think the real question is whether the planned "mkcephfs 2.0" is going
> to capture the equivalent functionality of being able to enumerate up
> front which osds will exist and which disks/journals they will use, and to
> bring them up.  Assuming it will (IMHO it needs to), can we make that
> compatible with the current way that mkcephfs is invoked (i.e., a
> ceph.conf file and a few command line args)?  Not everyone (and I daresay
> probably a minority) of users will be using Chef/Juju/Puppet/whatever,
> regardless of whether or not we feel that is the right way to do things
> and try to push them in that direction.
>
> In any case, since the new osd hotplugging stuff isn't available now and
> is probably still a sprint or two off, I think we should consider applying
> this patch.  We aren't recommending btrfs across the board, and cluster
> bringup is currently painful on ext4/xfs/etc.  And, Danny already did the
> work.  :)
>
> sage
> --

+1.

Rgds,

Xiaopong


