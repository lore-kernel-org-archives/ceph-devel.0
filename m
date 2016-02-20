From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 4/4] libceph: use sizeof_footer() in ceph_msg_revoke()
Date: Sat, 20 Feb 2016 20:51:56 +0100
Message-ID: <CAOi1vP-YS-8MCuwjOPw9b4Kv8HuvmiMVwDi4THhH-c7dP4mB2w@mail.gmail.com>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
	<1455986729-12544-5-git-send-email-idryomov@gmail.com>
	<56C8B4C0.3020009@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33857 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcBTTv5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 14:51:57 -0500
Received: by mail-wm0-f48.google.com with SMTP id b205so108452531wmb.1
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 11:51:57 -0800 (PST)
In-Reply-To: <56C8B4C0.3020009@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Varada Kari <Varada.Kari@sandisk.com>

On Sat, Feb 20, 2016 at 7:47 PM, Alex Elder <elder@ieee.org> wrote:
> On 02/20/2016 10:45 AM, Ilya Dryomov wrote:
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>
> Please just reorder your patches and squash this in with
> your [2/4] patch.

Can't do - this code in ceph_msg_revoke() is new in 4.5, while 2/4
needs to be backported.

Thanks,

                Ilya
