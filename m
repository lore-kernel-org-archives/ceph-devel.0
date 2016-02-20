From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/4] libceph: use the right footer size when skipping a message
Date: Sat, 20 Feb 2016 21:05:33 +0100
Message-ID: <CAOi1vP-3TvUMVL+SMcagJ_wf1RE7Z3PbeUhUzUvOUJkX+1D_Ww@mail.gmail.com>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
	<1455986729-12544-3-git-send-email-idryomov@gmail.com>
	<56C8B40D.90602@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37534 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcBTUFe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 15:05:34 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so113899884wme.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 12:05:34 -0800 (PST)
In-Reply-To: <56C8B40D.90602@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Varada Kari <Varada.Kari@sandisk.com>

On Sat, Feb 20, 2016 at 7:44 PM, Alex Elder <elder@ieee.org> wrote:
> +On 02/20/2016 10:45 AM, Ilya Dryomov wrote:
>> ceph_msg_footer is 21 bytes long, while ceph_msg_footer_old is only 13.
>> Don't skip too much when CEPH_FEATURE_MSG_AUTH isn't negotiated.
>
> This looks good, but I have a few suggestions.
>
> You could done some factoring in prepare_write_message_footer()
> to use the new function for setting iov_len and updating
> out_kvec_bytes.

I considered it, but we'd still need the if on MSG_AUTH bit, so
I decided it wasn't worth it.  TBH I'm more inclined to rip this
old_footer stuff entirely - it's supported since v0.55, that's
pre-bobtail...

>
> Consider my suggestions, but otherwise I believe this
> is correct.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> Cc: stable@vger.kernel.org # 3.19+
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  net/ceph/messenger.c | 17 ++++++++++-------
>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index fec20819a5ea..dd7c1b7f932b 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -2284,6 +2284,13 @@ static int read_partial_msg_data(struct ceph_connection *con)
>>       return 1;       /* must return > 0 to indicate success */
>>  }
>>
>> +static size_t sizeof_footer(struct ceph_connection *con)
>
> I understand why this is named this way.  But it's supplying a
> connection as argument, but a footer is a message attribute.
> So I might call this con_msg_footer_size().

The *size* of footer is a connection attribute though ;)

Thanks,

                Ilya
