From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] ceph/rbd block driver for qemu-kvm (v8)
Date: Mon, 29 Nov 2010 09:59:37 +0100
Message-ID: <4CF36B79.4000008@redhat.com>
References: <20101117214223.GA31321@sir.home>	<AANLkTikLu0OJ3b+Ch7b0nnkOnF9wUGiUqZRcQgGeog73@mail.gmail.com>	<AANLkTikpvEQXc5iz-ii74XBshGrt0nNk5bCrHgteNXyA@mail.gmail.com> <AANLkTimwfxz3D+MZQ7TH_DktMNzyN-=Q3AaZVsi+4rdO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab0K2I6j (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Nov 2010 03:58:39 -0500
In-Reply-To: <AANLkTimwfxz3D+MZQ7TH_DktMNzyN-=Q3AaZVsi+4rdO@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Christian Brunner <c.m.brunner@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, ceph-devel@vger.kernel.org

Am 27.11.2010 08:12, schrieb Stefan Hajnoczi:
> On Fri, Nov 26, 2010 at 9:59 PM, Christian Brunner
> <c.m.brunner@gmail.com> wrote:
>> Thanks for the review. What am I supposed to do now?
> 
> Kevin is the block maintainer.  His review is the next step, I have
> CCed him.  After that rbd would be ready to merge.

If I don't find anything really obvious and it doesn't break the build,
I'll merge it based on your review.

Kevin
