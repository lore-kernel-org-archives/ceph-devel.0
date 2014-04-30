From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: osd systemtap initial steps
Date: Wed, 30 Apr 2014 15:19:28 +0200
Message-ID: <5360F860.20902@bisect.de>
References: <CA+4uBUbt8SikqyznV1q17UyqdAVyNM7fG7n5k5i4uSjSFuL8pg@mail.gmail.com> <CACJqLybakktJy0ewWdV4TMe63_9_XuxxgfCHze2N4LDzK+q6Vg@mail.gmail.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:40563 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751651AbaD3Niu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Apr 2014 09:38:50 -0400
In-Reply-To: <CACJqLybakktJy0ewWdV4TMe63_9_XuxxgfCHze2N4LDzK+q6Vg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Marc Koderer <marckoderer@gmail.com>

Am 30.04.2014 04:21, schrieb Haomai Wang:
> So cool!
> 
> I remember a telekomcloud guy is also worked for it since last summit.

Correct ... our initial version is/was this:
https://github.com/dalgaaf/ceph/commits/wip-master-bp-systemtap

Danny

> On Wed, Apr 30, 2014 at 6:17 AM, Samuel Just <sam.just@inktank.com> wrote:
>> I'm starting on adding systemtap trace points to the osd.
>>
>> https://github.com/athanatos/ceph/tree/wip-osd-stap
>>
>> has some initial build changes and a single tracepoint in OSD::handle_op.
>>
>> I'll ping the list when I've got more.
>> -Sam

