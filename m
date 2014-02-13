From: Alex Elder <elder@ieee.org>
Subject: Re: rbd: use watch/notify for changes in rbd header
Date: Thu, 13 Feb 2014 06:27:41 -0600
Message-ID: <52FCBA3D.6020804@ieee.org>
References: <20140213095005.GA27350@elgon.mountain> <CALFYKtABsA6TazxRZUFH35ynQqhbm2TP97npLtuqy1Wt_eQAvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:47092 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaBMM1n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2014 07:27:43 -0500
Received: by mail-ie0-f178.google.com with SMTP id rl12so3176811iec.37
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2014 04:27:43 -0800 (PST)
In-Reply-To: <CALFYKtABsA6TazxRZUFH35ynQqhbm2TP97npLtuqy1Wt_eQAvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: yehuda@hq.newdream.net, Ceph Development <ceph-devel@vger.kernel.org>

On 02/13/2014 06:04 AM, Ilya Dryomov wrote:
> On Thu, Feb 13, 2014 at 11:50 AM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
>> Hello Yehuda Sadeh,
>>
>> The patch 59c2be1e4d42: "rbd: use watch/notify for changes in rbd
>> header" from Mar 21, 2011, leads to the following static checker
>> warning:
>>
>>         drivers/block/rbd.c:687 parse_rbd_opts_token()
>>         warn: we tested 'token < 0' before and it was 'false'
>>
>> drivers/block/rbd.c
>>    677  static int parse_rbd_opts_token(char *c, void *private)
>>    678  {
>>    679          struct rbd_options *rbd_opts = private;
>>    680          substring_t argstr[MAX_OPT_ARGS];
>>    681          int token, intval, ret;
>>    682
>>    683          token = match_token(c, rbd_opts_tokens, argstr);
>>    684          if (token < 0)
>>                     ^^^^^^^^^
>>    685                  return -EINVAL;
>>    686
>>    687          if (token < Opt_last_int) {
>>                     ^^^^^^^^^^^^^^^^^^^^
>> Opt_last_int is zero so this is never true.  Should the < be == or
>> something?
> 
> Probably not.  It's there in case an integer option gets added to rbd
> in the future.  See parse_fsopt_token() and the enums above it in
> fs/ceph/super.c.

Yes, that's correct.  There were once integer options and this
code is a holdover from that time.

I think it should remain in case it's needed, but it could be
#ifdef'd or something.  (Or we could do some magic to get the
warning to go away.)

					-Alex

> 
> Thanks,
> 
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

