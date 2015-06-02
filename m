From: Gregory Farnum <greg@gregs42.com>
Subject: Re: MDS auth caps for cephfs
Date: Tue, 2 Jun 2015 16:40:21 -0700
Message-ID: <CAC6JEv_DoJakOQPq=fURu7Y13ucLX6tpXHUBwKFFqi9syeJvQw@mail.gmail.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
	<alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net>
	<CAC6JEv_Kpkgra-w=yrfyNh_WEdy5ouCOyx-hosup69h0VaxVzQ@mail.gmail.com>
	<alpine.DEB.2.00.1505271542410.6462@cobra.newdream.net>
	<CAC6JEv8BfMX+jHq8PCONFM4sMN81Nk+YfYkHJbHWK90kKnC+TQ@mail.gmail.com>
	<alpine.DEB.2.00.1505271646360.6462@cobra.newdream.net>
	<CAC6JEv_Jw5S94E2yiW-g-t1Ro3gjiYXnoRKGNf=721CjoLESkA@mail.gmail.com>
	<alpine.DEB.2.00.1505271728250.6462@cobra.newdream.net>
	<CAC6JEv8pmJ-PhMUVqoP_VNsGR-STyjiyfcPqqpEQRv8x=UTjwA@mail.gmail.com>
	<CAANLjFqA+X7WYQ6NX_-L--vZorerSCQs6YcNSfUrurjsQFOsYA@mail.gmail.com>
	<CAC6JEv-MH=1uJD1HudhHJ=8wfg+dP3d9euhwLNEB-idsogGu+Q@mail.gmail.com>
	<alpine.DEB.2.00.1505280957450.6462@cobra.newdream.net>
	<CAANLjFrs6xrQXJHu-Z7bqw_FWmGbqbc-HT1SKBxi0=Ls2SmBbg@mail.gmail.com>
	<alpine.DEB.2.00.1505281024560.6462@cobra.newdream.net>
	<CAANLjFqoZ0hBjXEHAcc4VLygCuzwzxtKpNH+nJHE3X00dvfKqQ@mail.gmail.com>
	<alpine.DEB.2.00.1506011131270.10340@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33251 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbFBXkX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2015 19:40:23 -0400
Received: by qgfa63 with SMTP id a63so65710367qgf.0
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jun 2015 16:40:23 -0700 (PDT)
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com. [209.85.192.42])
        by mx.google.com with ESMTPSA id o65sm8141302qge.34.2015.06.02.16.40.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 16:40:22 -0700 (PDT)
Received: by qgg60 with SMTP id 60so65640010qgg.2
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jun 2015 16:40:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1506011131270.10340@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Robert LeBlanc <robert@leblancnet.us>, John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Mon, Jun 1, 2015 at 12:39 PM, Sage Weil <sage@newdream.net> wrote:
> I have a pull request posted at
>
>         https://github.com/ceph/ceph/pull/4809
>
> that updates the mds cap parser and defines a check method.  Please take
> a look and see if this makes sense.

Couple comments on the internal interfaces but the syntax seems good
and so do the MDSCap changes.

>
> For the path restrictions, I think the next steps are something like
>
>  - generate a path string and pass it in to that method
>  - write some simple tests
>  - make sure the hook is called from everywhere it needs to be (all of the
> other request handlers in Server.cc)
>  - call the hook from the cap writeback path (tricky)
>  - figure out how to handle files in the stray dir (tricky)

This path access function was my concern (we need to push that down
inside of the MDSCaps rather than exposing their internal state);
making that change will probably impact how we do these. But this
general set of tasks seems right to me. Probably we do unit tests
first, which we can do once it's all MDSCap internal. ;)

I'm not sure if including the inode is actually going to be helpful to
us? We can't use it instead of the path, for instance. Users might
have access via one path but not another and we need to check both
that they can reach the inode and that they came in the right way.

> For the user-based restrictions,
>
>  - I think we need to expand the allows() method so that it has a couple
> output arguments (uid and gid list) that subsequent permissions should be
> validated against.  Then we can change the function in Server.cc so
> that when those are populated it does an actually unix permissions check.
> This seems like the simplest thing to me, although it does have the
> slightly-odd property that if you are doing an operation that requires
> permission on two inodes (directory and file, say) you might have to
> different 'allow ...' lines granting access to each.  (I think this is
> both painful to avoid and also harmless?)

Why don't we just pass in the UID and GID the request is being made
as? Then it's either allowed or denied.
-Greg
