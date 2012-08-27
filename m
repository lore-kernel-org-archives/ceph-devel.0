From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: About sparse images
Date: Mon, 27 Aug 2012 12:56:36 -0700
Message-ID: <503BD0F4.5060102@inktank.com>
References: <CAOLwVUnGz4ZvWdNo6JKHuS06YZYCeT7WjaDdGiDipRv8UZVLhA@mail.gmail.com> <649A15670E764B2E9397EDA1919205C7@inktank.com> <503A7EBE.1060500@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47495 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab2H0T4j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 15:56:39 -0400
Received: by pbbrr13 with SMTP id rr13so8002424pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 12:56:39 -0700 (PDT)
In-Reply-To: <503A7EBE.1060500@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Gregory Farnum <greg@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 08/26/2012 12:53 PM, Wido den Hollander wrote:
> As far as I know TRIM / Discard only works with KVM and SCSI disks,
> VirtIO still seems to lack this functionality, not sure about kernel RBD.

Kernel rbd doesn't support TRIM/discard yet 
(http://www.tracker.newdream.net/issues/190).
