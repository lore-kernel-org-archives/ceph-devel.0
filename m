From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: Re: Question on extended attributes
Date: Thu, 21 Feb 2013 17:47:27 -0800 (PST)
Message-ID: <20130221.174727.92817039.yasu@soe.ucsc.edu>
References: <20130221.171343.75467379.yasu@soe.ucsc.edu>
	<CAC-hyiFVp7VMZyBLHMqh-HMBE77Wiktye60uj=LqZRSE7JZzhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:46202 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab3BVBrd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 20:47:33 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so89452dae.3
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 17:47:33 -0800 (PST)
In-Reply-To: <CAC-hyiFVp7VMZyBLHMqh-HMBE77Wiktye60uj=LqZRSE7JZzhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@inktank.com
Cc: ceph-devel@vger.kernel.org


It worked. Thanks :)

regards,
Yasu

From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Question on extended attributes
Date: Thu, 21 Feb 2013 17:43:14 -0800
Message-ID: <CAC-hyiFVp7VMZyBLHMqh-HMBE77Wiktye60uj=LqZRSE7JZzhQ@mail.gmail.com>

> On Thu, Feb 21, 2013 at 5:13 PM, Yasuhiro Ohara <yasu@soe.ucsc.edu> wrote:
>>
>> Hi.
>>
>> Can we add extended attributes on a file stored in the Ceph
>> mounted space ? I'm running the Ceph FS using Btrfs.
>>
>> The setfattr command returns Operation not supported.
>> Is it not supported ?
>>
> 
> It is supported. What's the exact command that you're running? Maybe
> your xattr is not in a valid namespace, try doing the following:
> 
> # setfattr -n user.foo <filename>
> 
> 
> 
> Yehuda
