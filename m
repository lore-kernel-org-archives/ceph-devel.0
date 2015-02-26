From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 11:27:00 -0700
Message-ID: <CAANLjFovnkKRuKnUKYVRPczQZMxbrwVbDh-ygP+_-+weZtQV_w@mail.gmail.com>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
	<CAANLjFpHND2uyUvdzJ-pz4QOXp6SpYK=sD1WQz=rT-Two6izqw@mail.gmail.com>
	<alpine.DEB.2.00.1502251348170.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34014 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbbBZS1C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 13:27:02 -0500
Received: by wghn12 with SMTP id n12so13616979wgh.1
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 10:27:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502251348170.25838@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks, we were able to get it up and running very quickly. If it
performs well, I don't see any reason to use Apache+fast_cgi. I don't
have any problems just focusing on civetweb.

On Wed, Feb 25, 2015 at 2:49 PM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 25 Feb 2015, Robert LeBlanc wrote:
>> We tried to get radosgw working with Apache + mod_fastcgi, but due to
>> the changes in radosgw, Apache, mode_*cgi, etc and the documentation
>> lagging and not having a lot of time to devote to it, we abandoned it.
>> Where it the documentation for civetweb? If it is appliance like and
>> easy to set-up, we would like to try it to offer some feedback on your
>> question.
>
> In giant and hammer, it is enabled by default on port 7480.  On firefly,
> you need to add the line
>
>  rgw frontends = fastcgi, civetweb port=7480
>
> to ceph.conf (you can of course adjust the port number if you like) and
> radosgw will run standalone w/ no apache or anything else.
>
> sage
>
>
>>
>> Thanks,
>> Robert LeBlanc
>>
>> On Wed, Feb 25, 2015 at 12:31 PM, Sage Weil <sweil@redhat.com> wrote:
>> > Hey,
>> >
>> > We are considering switching to civetweb (the embedded/standalone rgw web
>> > server) as the primary supported RGW frontend instead of the current
>> > apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here means
>> > both the primary platform the upstream development focuses on and what the
>> > downstream Red Hat product will officially support.
>> >
>> > How many people are using RGW standalone using the embedded civetweb
>> > server instead of apache?  In production?  At what scale?  What
>> > version(s) (civetweb first appeared in firefly and we've backported most
>> > fixes).
>> >
>> > Have you seen any problems?  Any other feedback?  The hope is to (vastly)
>> > simplify deployment.
>> >
>> > Thanks!
>> > sage
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
