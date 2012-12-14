From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: OSDMonitor: don't allow creation of pools with > 65535 pgs
Date: Fri, 14 Dec 2012 16:59:40 +0000
Message-ID: <50CB5AFC.3070802@inktank.com>
References: <50CB488E.3090005@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33206 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab2LNQ7p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 11:59:45 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1871888bkw.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Dec 2012 08:59:43 -0800 (PST)
In-Reply-To: <50CB488E.3090005@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Greg Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/14/2012 03:41 PM, Jim Schutt wrote:
> Hi,
>
> I'm looking at commit e3ed28eb2 in the next branch,
> and I have a question.
>
> Shouldn't the limit be pg_num > 65536, because
> PGs are numbered 0 thru pg_num-1?
>
> If not, what am I missing?
>
> FWIW, up through yesterday I've been using the next branch and this:
>
>    ceph osd pool set data pg_num 65536 --allow-experimental-feature
>    ceph osd pool set metadata pg_num 65536 --allow-experimental-feature
>    ceph osd pool set data pgp_num 65536 --allow-experimental-feature
>    ceph osd pool set metadata pgp_num 65536 --allow-experimental-feature
>
> using cephfs clients, and have seen no trouble with
> misdirected ops, etc.
>
> -- Jim
>

Hi Jim,

To the best of my knowledge, one of the things that triggered the 
required hard cap on the number of pgs was that the kernel side is still 
limited to 16 bits, despite that on the osd side this is no longer true.

I'm not familiar with what's going on on the kernel side, but if there's 
a slight chance that we are indeed keeping the 'pg_num' on a 16-bit 
variable, then that value must be capped to 65535. If that's not the 
case and we're just limited by the pg's number/id, then I guess that 
accepting up to 65636 would be fine (0..65535).

Just in case I'll look into this and further implications.

Thanks.

   -Joao


