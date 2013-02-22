From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Question on extended attributes
Date: Thu, 21 Feb 2013 17:43:14 -0800
Message-ID: <CAC-hyiFVp7VMZyBLHMqh-HMBE77Wiktye60uj=LqZRSE7JZzhQ@mail.gmail.com>
References: <20130221.171343.75467379.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:53832 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab3BVBnQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 20:43:16 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so141208lab.23
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 17:43:15 -0800 (PST)
In-Reply-To: <20130221.171343.75467379.yasu@soe.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 21, 2013 at 5:13 PM, Yasuhiro Ohara <yasu@soe.ucsc.edu> wrote:
>
> Hi.
>
> Can we add extended attributes on a file stored in the Ceph
> mounted space ? I'm running the Ceph FS using Btrfs.
>
> The setfattr command returns Operation not supported.
> Is it not supported ?
>

It is supported. What's the exact command that you're running? Maybe
your xattr is not in a valid namespace, try doing the following:

# setfattr -n user.foo <filename>



Yehuda
