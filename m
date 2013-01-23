From: Dan Mick <dan.mick@inktank.com>
Subject: Re: /etc/init.d/ceph bug  for multi-host when using -a option
Date: Wed, 23 Jan 2013 00:35:48 -0800
Message-ID: <50FFA0E4.9000803@inktank.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC5E5A56@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:37599 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab3AWIfw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 03:35:52 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so3682000dad.24
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 00:35:52 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5E5A56@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sage@inktank.com" <sage@inktank.com>

On 01/22/2013 11:18 PM, Chen, Xiaoxi wrote:
> Hi List,
>       Here is part of /etc/init.d/ceph script:
> case "$command" in
>          start)
>              # Increase max_open_files, if the configuration calls for it.
>              get_conf max_open_files "8192" "max open files"
>              if [ $max_open_files != "0" ]; then
>                  # Note: Don't try to do math with these numbers, because POSIX shells
>                  # can't do 64-bit math (natively). Just treat them as strings.
>                  cur=`ulimit -n`xjkk
>                  if [ "x$max_open_files" != "x$cur" ]; then
> Line253:                  ulimit -n $max_open_files
>                  fi
>              fi
>
>        When using with -a option, for **remote** osd , this script also run ulimit on **local**, and results in ulimit -n didn't change in remote nodes. I think the Line 253 shoud use do_cmd instead of run directly,also line 251.

I think you're right.  I opened http://tracker.newdream.net/issues/3900 
to track this.
>
> Here is the output of local osd daemon's limits:
> root@ceph-4:~# cat /proc/13131/limits  | grep file
> Max file size             unlimited            unlimited            bytes
> Max core file size        unlimited            unlimited            bytes
> Max open files            131072               131072               files
> Max file locks            unlimited            unlimited            locks
>
> Here is a remote one:
> root@snb-15:~# cat /proc/23709/limits | grep file
> Max file size             unlimited            unlimited            bytes
> Max core file size        unlimited            unlimited            bytes
> Max open files            1024                 4096             files
> Max file locks            unlimited            unlimited            locks
>
> 																																					Xiaoxi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

