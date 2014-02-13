From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: rbd: use watch/notify for changes in rbd header
Date: Thu, 13 Feb 2014 14:04:00 +0200
Message-ID: <CALFYKtABsA6TazxRZUFH35ynQqhbm2TP97npLtuqy1Wt_eQAvg@mail.gmail.com>
References: <20140213095005.GA27350@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:38880 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbaBMMEB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2014 07:04:01 -0500
Received: by mail-qa0-f46.google.com with SMTP id k15so2590669qaq.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2014 04:04:00 -0800 (PST)
In-Reply-To: <20140213095005.GA27350@elgon.mountain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: yehuda@hq.newdream.net, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Feb 13, 2014 at 11:50 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> Hello Yehuda Sadeh,
>
> The patch 59c2be1e4d42: "rbd: use watch/notify for changes in rbd
> header" from Mar 21, 2011, leads to the following static checker
> warning:
>
>         drivers/block/rbd.c:687 parse_rbd_opts_token()
>         warn: we tested 'token < 0' before and it was 'false'
>
> drivers/block/rbd.c
>    677  static int parse_rbd_opts_token(char *c, void *private)
>    678  {
>    679          struct rbd_options *rbd_opts = private;
>    680          substring_t argstr[MAX_OPT_ARGS];
>    681          int token, intval, ret;
>    682
>    683          token = match_token(c, rbd_opts_tokens, argstr);
>    684          if (token < 0)
>                     ^^^^^^^^^
>    685                  return -EINVAL;
>    686
>    687          if (token < Opt_last_int) {
>                     ^^^^^^^^^^^^^^^^^^^^
> Opt_last_int is zero so this is never true.  Should the < be == or
> something?

Probably not.  It's there in case an integer option gets added to rbd
in the future.  See parse_fsopt_token() and the enums above it in
fs/ceph/super.c.

Thanks,

                Ilya
