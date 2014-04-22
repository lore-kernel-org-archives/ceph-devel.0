From: Gregory Farnum <greg@inktank.com>
Subject: Re: xio-rados-firefly branch update
Date: Tue, 22 Apr 2014 12:58:21 -0700
Message-ID: <CAPYLRzj9BnvAHHCvUuX7C4fj=2_UhycrPMNB=Q8XrH2EzqDAig@mail.gmail.com>
References: <586483842.112.1398195579489.JavaMail.root@thunderbeast.private.linuxbox.com>
	<182441649.114.1398195877116.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:42724 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaDVT6W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 15:58:22 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so5485302qaq.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 12:58:22 -0700 (PDT)
In-Reply-To: <182441649.114.1398195877116.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

Awesome! I'll try and take a preliminary look at this in the next day
or two. What kind of feedback are you interested in right now?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

On Tue, Apr 22, 2014 at 12:44 PM, Matt W. Benjamin <matt@linuxbox.com> wrote:
> Hi,
>
> We've completed a trial merge of our current XioMessenger branches to Ceph
> upstream master.  The resulting branch is on our public Ceph development
> repo, on banch xio-rados-firefly:
>
> https://github.com/linuxbox2/linuxbox-ceph/commits/xio-rados-firefly
>
> This branch isn't fully vetted.  We haven't re-run librados tests on it, and
> there may be issues.  In addition, the core XioMessenger code on this branch
> has at least one open bug (a race condition) that appeared after we switched
> to Accelio one-way messages (which streamline the workflow, and are faster than
> the original request-response code).  We'll send an update on this to the
> list as soon as we can (later this week).
>
> There is also ongoing merge work (making XioMessenger work with the rest of
> Ceph), and open items (e.g., XioMessenger doesn't implement CephX).
>
> What I think is good about this branch is it has all the commits broken out,
> starting with general changes to the Messenger class family, for review.
>
> Thanks and regards,
>
> Matt
>
> --
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
>
> http://linuxbox.com
>
> tel.  734-761-4689
> fax.  734-769-8938
> cel.  734-216-5309
