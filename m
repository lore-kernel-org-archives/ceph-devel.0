From: Phil Susi <psusi@ubuntu.com>
Subject: Re: parted behavior change between 3.1 and 3.2
Date: Tue, 24 May 2016 13:16:47 -0400
Message-ID: <5ba70630-84af-f7b6-802c-933b1a26f273@ubuntu.com>
References: <5742B42C.7050000@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36800 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcEXRQs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2016 13:16:48 -0400
Received: by mail-vk0-f41.google.com with SMTP id y2so30761665vka.3
        for <ceph-devel@vger.kernel.org>; Tue, 24 May 2016 10:16:48 -0700 (PDT)
In-Reply-To: <5742B42C.7050000@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 5/23/2016 3:41 AM, Loic Dachary wrote:
> Hi Philip,
> 
> In the context of the Ceph ( http://ceph.com/ ) project, I'm trying
> to figure out why parted 3.2 fixes a problem that shows in 3.1 [1].
> In a nutshell, calling partprobe sometime fails with "device busy"
> with 3.1 and when using 3.2 that never happens (all things are the
> same, only parted changes). I took a look at the commits in
> http://git.savannah.gnu.org/cgit/parted.git/log/ but I didn't see a
> commit that would explain such a behavior change.
> 
> Any pointer or idea you may have would be greatly appreciated :-)

An strace would help, but if I had to guess, one significant change
between 3.1 and 3.2 was the addition of the ability to resize mounted
partitions, so it could be that partprobe is adjusting the size of a
changed partition, and it used to not be able to do that if it is mounted.

