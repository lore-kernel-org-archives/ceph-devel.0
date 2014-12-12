From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: Ceph's custom apache: ok to drop?
Date: Fri, 12 Dec 2014 09:34:28 -0800
Message-ID: <CABBk=J_3Xfn2yYKdER=n4Q_GC22uiCffk5=2G_zFkwH_DnO6FA@mail.gmail.com>
References: <548B21E0.80102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:60595 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbaLLRe3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 12:34:29 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so1830975igb.7
        for <ceph-devel@vger.kernel.org>; Fri, 12 Dec 2014 09:34:28 -0800 (PST)
In-Reply-To: <548B21E0.80102@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Dec 12, 2014 at 9:12 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> Hi folks,
>
> The Apache fork that we ship on Ceph.com
> (https://github.com/ceph/apache2) is several versions behind upstream
> and has a couple CVEs by now.
>
> I've heard from the developers (I don't remember if it was Dan, Yehuda,
> or someone else) refer on IRC to the idea that the changes in our Ceph
> Apache fork were cosmetic, and it's ok to simply use upstream Apache.
>
> I wanted to confirm this with a wider audience: it's ok to stop
> maintaining and shipping our custom Apache?
>
> In other words, we would remove references to our custom Apache from
> Teuthology, and our docs, and eventually from our repositories?
>
>
> -----
>
> Diving into our changes, there are two patches that we have on top of
> Apache 2.2.22:
>
> 1. "rgw: don't unset Content-Length header on HEAD response (this was
> being done when content length was 0)"
> https://github.com/ceph/apache2/commit/5ae1b4a081b05fcacf55e7114eec87d9b2a0a5da
> . (See also the original patch submission at
> http://tracker.ceph.com/issues/897)
>
> 2. "don't complain on badly formatted expectations"
> https://github.com/ceph/apache2/commit/0d9948f1e483386adef0841896484db8422127b2
>
> Both of these were submitted to Apache upstream in December 2013 (thread
> on apache-dev "Ceph patches for httpd") and merged in
> http://svn.apache.org/r1554303 .

Oh, awesome!

>
> So his will be controllable via new directives in httpd 2.5:
> "HttpContentLengthHeadZero" (defaults to off, ie, continue to squelch
> the zero-length header) and HttpExpectStrict (defaults to off, ie,
> continue to log the error).
>
> So for httpd 2.5 we have something that gives us what we need.

I don't think we really need either of these changes. One was really
only triggered in a very synthetic use case (the Expect header), and
the other one only happened with a very old version of boto, and we've
managed to send an upstream fix for it 3-4 years ago. I'm all for
dropping it.


Yehuda
