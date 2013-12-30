From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] fix librados aio read buffer handling
Date: Mon, 30 Dec 2013 12:00:36 -0800
Message-ID: <52C1D0E4.9060108@inktank.com>
References: <l2bire$iue$1@ger.gmane.org> <alpine.DEB.2.00.1309300834080.12714@cobra.newdream.net> <524A0098.4060005@inktank.com> <l74blq$9ia$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f179.google.com ([209.85.161.179]:38674 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136Ab3L3UHv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 15:07:51 -0500
Received: by mail-gg0-f179.google.com with SMTP id l4so2346596ggi.38
        for <ceph-devel@vger.kernel.org>; Mon, 30 Dec 2013 12:07:49 -0800 (PST)
In-Reply-To: <l74blq$9ia$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>, ceph-devel@vger.kernel.org

On 11/27/2013 12:49 AM, Rutger ter Borg wrote:
> On 2013-10-01 00:52, Josh Durgin wrote:
>>
>> I'm fine applying this now (with one fix). It's a nice cleanup
>> even if things change more soon.
>>
>> For the C interface, the return value stored in the AioCompletionImpl
>> needs to be the length read, so the caller can tell if a short read
>> occurred (this is only possible when trying to read past the end of an
>> object). This was being set in C_aio_Ack::finish(), but was removed by
>> this patch.
>
> Please find attached a revised patch against 0.72.1. I've added a fix
> for setting the return value in C_aio_Ack::finish(),
>
> if (c->bl.length() > 0) {
>    c->rval = c->bl.length();
> }

Sorry for the delay - I just added this to the master branch.

Thanks!
Josh

