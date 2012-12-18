From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: OSDMonitor: don't allow creation of pools with > 65535 pgs
Date: Tue, 18 Dec 2012 00:14:59 +0000
Message-ID: <50CFB583.3070305@inktank.com>
References: <50CB488E.3090005@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:47175 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab2LRAUk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 19:20:40 -0500
Received: by mail-we0-f175.google.com with SMTP id z53so4459wey.20
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 16:20:39 -0800 (PST)
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

Jim,

A new patch went into next that increases the default maximum pg_num to 
65536, and also adds an option ('mon max pool pg num') that will allow 
this value to be adjusted.


   -Joao
