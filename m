From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Strange behavior after upgrading to 0.48
Date: Fri, 06 Jul 2012 16:14:28 +1200
Message-ID: <4FF66624.1040607@catalyst.net.nz>
References: <4FF53706.7070003@gmail.com> <Pine.LNX.4.64.1207050725550.6931@cobra.newdream.net> <72a6b171-725b-417c-9538-07f6a4ef5032@email.android.com> <Pine.LNX.4.64.1207050737400.6931@cobra.newdream.net> <4FF64FB7.90709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:48849 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab2GFEOb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 00:14:31 -0400
In-Reply-To: <4FF64FB7.90709@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 06/07/12 14:38, Xiaopong Tran wrote:
>
> Thanks for the quick reply, I didn't have the computer with me last
> night. But you were right. I checked the version of ceph on ubuntu,
> and it's still stuck with 0.47.3, despite upgrading. I redid the
> upgrade, and it's still stuck with that version. That's something
> I didn't pay attention to.
>
> I had to purge the ceph, ceph-common and other related packages,
> and re-install it, then I got 0.48. And now ceph -s works just
> as it should.
>
> So, somehow, the upgrade on ubuntu does not work properly.
>
> Thinking about this issue just right now, I think ceph -s
> still worked right because there was still an older version
> of mon when the first two nodes were being upgraded. When
> the last one was upgraded, there's no mon of the same version
> anymore.
>
> Sorry, should have checked if apt upgrade was done properly
> first :)
>
>

FYI: I ran into this too - you need to do:

apt-get dist-upgrade

for the 0.47-2 packages to be replaced by 0.48 (of course purging 'em 
and reinstalling works too...just a bit more drastic)!

regards

Mark
