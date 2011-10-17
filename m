From: Martin Mailand <martin@tuxadero.com>
Subject: Re: OSD blocked for more than 120 seconds
Date: Mon, 17 Oct 2011 16:13:12 +0200
Message-ID: <4E9C37F8.9050601@tuxadero.com>
References: <4E974C87.2070204@tuxadero.com> <1318585099.2999.10.camel@wido-laptop> <CAO47_-8wOFxzjy-n2W_q75D=h7z8spswgghJ9iy8p6eQu-2kFA@mail.gmail.com> <4E99E68F.9090005@tuxadero.com> <CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:48907 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1JQONU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 10:13:20 -0400
In-Reply-To: <CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Am 17.10.2011 11:40, schrieb Christian Brunner:
> Our bugreport with RedHat didn't make any progress for a long time,
> but last week RedHat made two sugestions:
>
> - If you configure ceph with 'filestore flusher = false', do you see
> any different behavior?
> - If you mount with -o noauto_da_alloc does it change anything?

Hi,
after a quick test I think 'filestore flusher = false' did the trick.
What does it do?

Best Regards,
  martin

