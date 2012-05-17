From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Journal too small
Date: Thu, 17 May 2012 11:59:52 -0700
Message-ID: <4FB54AA8.7080906@inktank.com>
References: <201205171259.55967.karol.jurak@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45543 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967604Ab2EQS7z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 14:59:55 -0400
Received: by pbbrp8 with SMTP id rp8so2898238pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 11:59:54 -0700 (PDT)
In-Reply-To: <201205171259.55967.karol.jurak@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Jurak <karol.jurak@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/17/2012 03:59 AM, Karol Jurak wrote:
> How serious is such situation? Do the OSDs know how to handle it
> correctly? Or could this result in some data loss or corruption? After the
> recovery finished (ceph -w showed that all PGs are in active+clean state)
> I noticed that a few rbd images were corrupted.

As Sage mentioned, the OSDs know how to handle full journals correctly.

I'd like to figure out how your rbd images got corrupted, if possible.

How did you notice the corruption?

Has your cluster always run 0.46, or did you upgrade from earlier
versions?

What happened to the cluster between your last check for corruption and
now? Did your use of it or any ceph client or server configuration
change?
