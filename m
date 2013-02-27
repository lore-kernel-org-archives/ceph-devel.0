From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rename whilst in use
Date: Wed, 27 Feb 2013 14:01:32 -0800
Message-ID: <512E823C.4080902@inktank.com>
References: <512E0347.4040009@risc-software.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:51794 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3B0WB5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Feb 2013 17:01:57 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so696154pad.38
        for <ceph-devel@vger.kernel.org>; Wed, 27 Feb 2013 14:01:56 -0800 (PST)
In-Reply-To: <512E0347.4040009@risc-software.at>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Cc: ceph-devel@vger.kernel.org

On 02/27/2013 04:59 AM, Wolfgang Hennerbichler wrote:
> hi,
>
> I've accidently renamed a rbd object that has been in use within a
> kvm-domain.
>
> After detaching the rbd object I could rename it, but the source seems
> still to be around in space:
>
> # rbd ls -l rd | grep mysql3
> mysql3.new  12000M          2
>
> # rbd create rd/test --size 1
> # rbd rename rd/test rd/mysql3
> rbd: rename error: 2013-02-27 13:53:29.817863 7f3424ba8780 -1 librbd:
> rbd image mysql3 already exists
> (17) File exists

Since it doesn't appear in rbd ls, this suggests that the old
rbd_id.mysql3 object still exists.

> unfortunately my scrollback buffer isn't long enough to find out about
> the actual error I got during the first rename, but it should be easy to
> reproduce.

I can't reproduce it (at least not with format 2 images). Can you?
I'd expect this problem with format 1 images, since they don't separate
the header object from the name of the image.

> I assume this is a bug, that's why I posted it to ceph-devel directly.

Thanks, it certainly seems like a bug.

Josh
