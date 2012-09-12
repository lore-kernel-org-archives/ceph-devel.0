From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Gceph not working in V0.51
Date: Wed, 12 Sep 2012 14:16:44 +0100
Message-ID: <50508B3C.4040306@inktank.com>
References: <CAGfy=6kWusHtXiYVW=SH9jwM9iyyhuuKw9+fi86QkTLWTHPbUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63305 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab2ILNQy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 09:16:54 -0400
Received: by eaac11 with SMTP id c11so843101eaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 06:16:53 -0700 (PDT)
In-Reply-To: <CAGfy=6kWusHtXiYVW=SH9jwM9iyyhuuKw9+fi86QkTLWTHPbUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 09/12/2012 02:12 PM, hemant surale wrote:
> Hi Community,
>         I hv started Ceph v0.51 on single node as per instructions
> given at ceph.com/docs . "Ceph -w"  works fine but I am observing
> problme with Gceph , Its unable to show live mds & osds .
>         "Error: hunting for new mon . "
> 
> Please help me to figure it out.

gceph has been discontinued for a while now. I believe it got removed
from the repository back in 0.48 or 0.47 (was it?).

I would even be amazed if gceph worked after some significant changes
that have been happening in the monitor subsystem in the last couple of
months.

  -Joao
