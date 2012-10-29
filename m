From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Mon, 29 Oct 2012 13:19:48 -0700
Message-ID: <508EE4E4.7060802@inktank.com>
References: <CAGfy=6=se6CXExQyyA7TrAjUVkGqRwGL=E1wqo4h4_6ORzS-MA@mail.gmail.com> <f46d0438909985742c04cc3f658c@google.com> <CAGfy=6n6WJOKvQTO1LfsnY+_SRdh714HmoPKGgTSpjhE06qZBQ@mail.gmail.com> <CAGfy=6mwAD6A4Z3GXzmMwJnu7W0uPan1m1FYAnRuna9a3rDG=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36485 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2J2UTw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 16:19:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4514164pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 13:19:52 -0700 (PDT)
In-Reply-To: <CAGfy=6mwAD6A4Z3GXzmMwJnu7W0uPan1m1FYAnRuna9a3rDG=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

Last time you asked this, I responded (on 18 Oct):

So, clearly something went wrong with the installation step, and this 
file was not created.  How did you install after building?

On 10/29/2012 02:27 AM, hemant surale wrote:
> Hi Folks ,
>
> I have executed all required steps to build Ceph from source but now
> when I execute "service Ceph start" it shows
>
> ---------------------------------------//Error--------------------------------------------
> root@atish-virtual-machine:/ceph_data# service ceph start
> /etc/init.d/ceph: 37: .: Can't open /usr/lib/ceph/ceph_common.sh
> -------------------------------------------------------------------------------------------
>
>
> Please help me out .
