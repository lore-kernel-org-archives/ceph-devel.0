From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] fix librados aio read buffer handling
Date: Mon, 30 Sep 2013 15:52:08 -0700
Message-ID: <524A0098.4060005@inktank.com>
References: <l2bire$iue$1@ger.gmane.org> <alpine.DEB.2.00.1309300834080.12714@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39651 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab3I3WwG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Sep 2013 18:52:06 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so4229948oag.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Sep 2013 15:52:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309300834080.12714@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On 09/30/2013 08:38 AM, Sage Weil wrote:
> On Mon, 30 Sep 2013, Rutger ter Borg wrote:
>>
>> Dear all,
>>
>> please find attached a patch that enables a user to pass user-owned buffers
>> into librados' aio_read. The patch (against dumpling) removes the buf and pbl
>> data members in AioCompletionImpl.
>>
>> * The 'buf' argument to read() used to be passed into AioCompletionImpl, and
>> the results would be copied back after reading. This is replaced with the
>> creation of a static buffer of that buf.
>>
>> * The pbl argument in AioCompletionImpl is removed.
>>
>> The patch is tested against an application using librados. I've assumed that
>> 'pbl' in
>>
>> aio_read( ...., pbl, )
>>
>> is allocated by the user. It may even speed things up: a buffer copy is
>> prevented.
>
> I am a little worried that one path of aio_read uses c->bl and the other
> doesn't, but that probably is no big deal provided it is noted in the
> structure definition.

It does clean up the existing usage, where the destination may be
c->buf or c->pbl though.

> My larger concern is that we're about to do some major changes in the
> messenger and other code to use splice/tee/vmsplice to avoid copies
> to/from userspace when possible.  That will involve removing some of the
> currently 'use the existing buffer' code.  I'm hoping it will work out
> that in the librados case we just carry the kernel pages around a bit
> longer and delay the final copy into userspace, but it's hard to say until
> the code gets written.  Josh plans to start working on it this week.
>
> Josh, do you think we should apply this now or wait until we see where
> things end up?

I'm fine applying this now (with one fix). It's a nice cleanup
even if things change more soon.

For the C interface, the return value stored in the AioCompletionImpl
needs to be the length read, so the caller can tell if a short read
occurred (this is only possible when trying to read past the end of an
object). This was being set in C_aio_Ack::finish(), but was removed by
this patch.

One thing I'm not sure about is whether the bufferlist is guaranteed
not to be split anywhere in the lower levels. rados_read()
accounts for this case:

     if (bl.c_str() != buf)
       bl.copy(0, bl.length(), buf);

Sage, is that actually necessary?

Josh
