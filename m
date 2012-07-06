From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Re: Strange behavior after upgrading to 0.48
Date: Fri, 06 Jul 2012 10:38:47 +0800
Message-ID: <4FF64FB7.90709@gmail.com>
References: <4FF53706.7070003@gmail.com> <Pine.LNX.4.64.1207050725550.6931@cobra.newdream.net> <72a6b171-725b-417c-9538-07f6a4ef5032@email.android.com> <Pine.LNX.4.64.1207050737400.6931@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46283 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab2GFCiw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 22:38:52 -0400
Received: by pbbrp8 with SMTP id rp8so13790734pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 19:38:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1207050737400.6931@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/05/2012 10:38 PM, Sage Weil wrote:
> On Thu, 5 Jul 2012, Xiaopong Tran wrote:
>>> The problem is that the ceph utility itself is pre-0.48, but the
>>> monitors
>>> are running 0.48.  You need to upgrade the utility as well.  (There was
>>> a
>>> note about this in the release announcement.)
>>>
>>> This only affects the -s and -w commands.
>>>
>>> sage
>>
>> I have read the notes, andupgraded the utility first. There was no
>> problem when the first two were upgraded and recovering. This only
>> happened when the third node is upgraded.
>>
>> The nodes are running debian wheezy, while the client admin node is
>> running ubuntu 12.04.
>
> Oooh, maybe the package for wheezy in the repo is wrong.  Can you confirm
> which version the ceph utility is with 'ceph -v'?
>
> Thanks!
> sage
>
>

Thanks for the quick reply, I didn't have the computer with me last
night. But you were right. I checked the version of ceph on ubuntu,
and it's still stuck with 0.47.3, despite upgrading. I redid the
upgrade, and it's still stuck with that version. That's something
I didn't pay attention to.

I had to purge the ceph, ceph-common and other related packages,
and re-install it, then I got 0.48. And now ceph -s works just
as it should.

So, somehow, the upgrade on ubuntu does not work properly.

Thinking about this issue just right now, I think ceph -s
still worked right because there was still an older version
of mon when the first two nodes were being upgraded. When
the last one was upgraded, there's no mon of the same version
anymore.

Sorry, should have checked if apt upgrade was done properly
first :)

Thanks


Xiaopong
