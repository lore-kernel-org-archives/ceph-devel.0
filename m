From: Haomai Wang <haomaiwang@gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogam91cm5hbCBhbGlnbm1lbnQ=?=
Date: Fri, 20 Nov 2015 21:03:19 +0800
Message-ID: <CACJqLybiXZC01ZDD2nUz58PmOWNBSNk01Dr6dNrnTzd6poNOLA@mail.gmail.com>
References: <019801d1236e$206f12e0$614d38a0$@com>
	<d742f6275e1645cdb02b0bad23110eec@R01UKEXCASM115.r01.fujitsu.local>
	<023e01d12373$941f1050$bc5d30f0$@com>
	<alpine.DEB.2.00.1511200339470.25088@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34897 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbKTNDU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 08:03:20 -0500
Received: by obbnk6 with SMTP id nk6so85525750obb.2
        for <ceph-devel@vger.kernel.org>; Fri, 20 Nov 2015 05:03:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511200339470.25088@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: changtao381 <changtao381@163.com>, =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 20, 2015 at 7:41 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 20 Nov 2015, changtao381 wrote:
>> Hi All,
>>
>> Thanks for you apply!
>>
>> If directioIO + async IO requirement that alignment, it shouldn't aligned by PAGE for each journal entry.
>> For it may write many entries of journal once time
>
> We also want to avoid copying the data around in memory to change the
> alignment.  The messenger takes care to read data off the wire into
> buffers with the correct alignment so that we can later use them for
> direct-io.
>
> If you're worried about the small io case, I think this is just a matter
> of setting a threshold for small ios so that we don't bother with all of
> the padding when the memory copy isn't that expensive.  But... given that
> we have a header *and* footer in the journal format and almost all IOs are
> 4k multiples I think it'd save you a single 4k block at most.
>
> (Also, I thought we already did something like this, but perhaps not!)

Hmm, based on our recently test, the data from messenger is aligned.
But the encoded data(pglog, transaction) will make thing worse, like
PR(https://github.com/ceph/ceph/pull/6368) solved, we even will get 14
ptr in the bufferlist which passed into filejournal before. So it make
we rebuild each time within filejournal thread. Like this
PR(https://github.com/ceph/ceph/pull/6484), we try to make it rebuild
not in filejournal thread which is single.



>
> sage



-- 
Best Regards,

Wheat
