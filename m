From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RBD: periodic cephx issue ? "CephxAuthorizeHandler::verify_authorizer
 isvalid=0"
Date: Thu, 29 Nov 2012 22:24:50 +0100
Message-ID: <CAF6-1L7m3y_iZf10Z-xkFzMj9rXN9uA0UNG+w+V+5O9zDAes-Q@mail.gmail.com>
References: <CAF6-1L7sBWbEUNma4QLm1DgSJbJLdpXOPzzuJzs_uhZP7ivJHw@mail.gmail.com>
	<alpine.DEB.2.00.1211290837140.30450@cobra.newdream.net>
	<CAF6-1L4FJfRPyq7_=nhkSFs8za967pxVTwn_qhpQegLZ_KJmtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44934 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab2K2VYv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 16:24:51 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so15022285oag.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 13:24:51 -0800 (PST)
In-Reply-To: <CAF6-1L4FJfRPyq7_=nhkSFs8za967pxVTwn_qhpQegLZ_KJmtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

fwding to the list as I forgot to hit "reply all" ...

>> Can you attach/post the whole log somewhere?  I'm curious what is leading
>> up to it not having secret_id=0.  Ideally with 'debug auth = 20' and
>> 'debug osd = 20' and 'debug ms = 1'.
>
> Well without the debug options there isn't anything else than that in
> the log, just this snippet several time.
>
> I haven't caught him with the log active ... unfortunately I can't
> leave it more than a couple of hours with those options as it fills up
> the root filesystem with log way too fast and it seems to not happen
> when you just restarted an OSD ...
>
> Usually it show up by "burst" (so like 10 times or so in an hour then
> nothing for a day for example).
>
> Cheers,
>
>     Sylvain
