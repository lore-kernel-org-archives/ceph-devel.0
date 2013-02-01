From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadowGW and multiple parts upload
Date: Fri, 1 Feb 2013 10:19:23 -0800
Message-ID: <CAC-hyiGFfafct0zNnX4+N9y-Eaw9sjsgmoVyn4heTN7hhzfwXw@mail.gmail.com>
References: <CAJH6TXgfL8CVKyV71fsobi6e=AxOWZczbZa-TjosYodGJCbzEg@mail.gmail.com>
	<CAC-hyiHi-GoPcjj+A08OjKdsQZiLf6c02mdyC+zPxT5jnU2CSA@mail.gmail.com>
	<CAJH6TXjeUAVdFosZTiuxeePUOVhLfXiZ_iQ-VfM-boC1fNyCbA@mail.gmail.com>
	<CAC-hyiEJd-zwtU5oeKBTeAyfN832TqZE3aPZmcGSe_O8iU2=pg@mail.gmail.com>
	<CAJH6TXgqaP59Ph4dRUYK75AfFeAhcZWTxEse55v9LnCniUFg2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:46704 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab3BASTY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 13:19:24 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so3691611ieb.17
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 10:19:24 -0800 (PST)
In-Reply-To: <CAJH6TXgqaP59Ph4dRUYK75AfFeAhcZWTxEse55v9LnCniUFg2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Feb 1, 2013 at 9:51 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/2/1 Yehuda Sadeh <yehuda@inktank.com>:
>> Can you get just the sequence that fails (not the entire history)?
>
> Is the following enough?
> http://pastebin.com/CS4MwdRf


From what I can see, it looks like it's just receiving part of the
expected data, might be the client disconnects early.

Yehuda
