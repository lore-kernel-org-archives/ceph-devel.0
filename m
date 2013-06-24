From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: ceph-mon vs leveldb status
Date: Mon, 24 Jun 2013 10:29:52 -0500
Message-ID: <51C865F0.4030300@inktank.com>
References: <alpine.DEB.2.00.1306191304230.7089@cobra.newdream.net> <pan.2013.06.24.10.51.37.437785@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:59350 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab3FXP3z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 11:29:55 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so24082934ieb.24
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 08:29:54 -0700 (PDT)
In-Reply-To: <pan.2013.06.24.10.51.37.437785@googlemail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Holger Hoffstaette <holger.hoffstaette@googlemail.com>
Cc: ceph-devel@vger.kernel.org

On 06/24/2013 05:51 AM, Holger Hoffstaette wrote:
> On Wed, 19 Jun 2013 13:09:42 -0700, Sage Weil wrote:
>
> [snip]
>
>> Meanwhile, the next development release will be changing the way all the
>> pg metadata in the monitor is stored to be much more efficient and to take
>> advantage of leveldb's capabilities; this will be present in 0.66
>> (dumpling - 1).
>
> Have you considered using one of the recently annoucned LevelDB forks? The
> HyperDex folks recently published their HyperLevelDB fork (still
> compatible though) and it has significantly improved behaviour, less
> performance variance etc.
> See http://hyperdex.org/performance/leveldb/ or github.
>
> -h

Very Interesting Holger!  Waiting to hear from some of the others, but I 
may need to play with this at some point. :)

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

