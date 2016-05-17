From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [ceph-users] v10.2.1 Jewel released
Date: Tue, 17 May 2016 10:14:59 -0600
Message-ID: <CALqRxCzMYLZzWaO+USdXPsREU3huF8F9YoDeqta2G0M+52_mTA@mail.gmail.com>
References: <alpine.DEB.2.11.1605160910080.2730@cpach.fuggernut.com>
	<CAL017hCBz01LFsg4PbVtPwdbQs=WL=qEw_GGmO5sHE4SUC+9hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33097 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcEQQPB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 12:15:01 -0400
Received: by mail-vk0-f45.google.com with SMTP id z184so26410657vkg.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2016 09:15:00 -0700 (PDT)
In-Reply-To: <CAL017hCBz01LFsg4PbVtPwdbQs=WL=qEw_GGmO5sHE4SUC+9hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karsten Heymann <karsten.heymann@gmail.com>
Cc: Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com

On Mon, May 16, 2016 at 11:14 PM, Karsten Heymann
<karsten.heymann@gmail.com> wrote:
> the updated debian packages are *still* missing ceph-{mon,osd}.target.
> Was it intentional to release the point release without the fix?

It was not intentional.

Teuthology does not test systemd, so these sort of things tend to fall
off the radar when it comes to pre-release testing.

- Ken
