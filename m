From: Samuel Just <sam.just@inktank.com>
Subject: Re: watch/notify changes ready for review
Date: Mon, 17 Nov 2014 17:03:46 -0800
Message-ID: <CA+4uBUbXRoyUZa=n+9kfH4J3-rwXAhgvtw9gj9ckAUAYTx1MLg@mail.gmail.com>
References: <alpine.DEB.2.00.1411131645430.10048@cobra.newdream.net>
	<alpine.DEB.2.00.1411171635590.23009@cobra.newdream.net>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:40994 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbaKRBDs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 20:03:48 -0500
Received: by mail-lb0-f169.google.com with SMTP id 10so16911517lbg.14
        for <ceph-devel@vger.kernel.org>; Mon, 17 Nov 2014 17:03:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1411171635590.23009@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think I agree that the failed notify api is superfluous.  Also,
would that not imply that the handle_error callback had already fired
with an ETIMEDOUT?
-Sam

On Mon, Nov 17, 2014 at 4:42 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 13 Nov 2014, Sage Weil wrote:
>> My pile of watch/notify changes are ready for review:
>>
>>       https://github.com/ceph/ceph/pull/2924
>
> Okay, I did another round of cleanup (including moving most of the code
> into Objecter) and it's now way cleaner and passing all the basic tests
> (hasn't gone through full yet).
>
> I still have a big outstanding question:
>
> Does the failed notify API make sense?  I'm leaning no, but want another
> opinion before I go rip it back out.  To summarize: it notifies a watcher
> if it was slow to respond to an earlier notify and caused the notifier to
> time out.  Counterargument: if the notifier wants to tell everyone they
> saw a timeout, they could send another notify; at least then they would
> know if the second piece of information was delivered (quickly).  I don't
> think that librbd or rgw will make use of it.
>
> The last bit of work remaining is to migrate RGW over to the new API and
> make it use watch_check().  Will work with Yehuda on that, but in the
> meantime, this is ready for review!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
