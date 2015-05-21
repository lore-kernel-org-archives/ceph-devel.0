From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: RBD mirroring design draft
Date: Thu, 21 May 2015 08:34:29 -0700
Message-ID: <555DFB05.4080603@redhat.com>
References: <55529E04.1070202@redhat.com>	<CACJqLyZA2+eXd=cqDwYOyqeE+O+kovHOF=HavGp=SWkrJ-LgVw@mail.gmail.com>	<555422DC.6050400@redhat.com>	<CAAW3nmh+XxB8K2XsWgnD_cWWPZGw=VpsuomodMM1SNad8LmZAQ@mail.gmail.com>	<555CFCD8.5060404@redhat.com> <CAAW3nmjWQTOOhym5t6LQ8E0P8AsHnD0c0MkfbF2zre_oUJFudw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105AbbEUPe3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 May 2015 11:34:29 -0400
In-Reply-To: <CAAW3nmjWQTOOhym5t6LQ8E0P8AsHnD0c0MkfbF2zre_oUJFudw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris H <fuzz19881@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/21/2015 07:56 AM, Chris H wrote:
> I am assuming your client's do proper syncs and flushes? What about
> applications that traditionally write to a BBU backed RAID card and
> don't explicitly call sync and flushes? I just ask because the only way
> I can think of handling this is to force sync/flush to a log device of
> some sort before returning the write was successful. I know this is
> probably a new use case but this is the best time to address these sort
> of concerns.

Yeah, that's exactly what we do by default with our existing rbd client
side cache. It's writethrough until it sees a flush from the user. For
mirroring this wouldn't change, and we could ack writes to the client
after only writing them to the rbd journal. This would still be safe
since we'd replay any unfinished work in the journal the next time
the image was used. Optionally, we could wait for the write to the
journal and the regular image data in case the journal is stored in a
pool with lower fault tolerance.


