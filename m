From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Does anyone know if Automake has a way of expressing
 dependencies?
Date: Fri, 17 Jun 2011 11:58:57 -0700
Message-ID: <20110617185857.GA25210@dreamer>
References: <BANLkTikD=VCqf+JDK=21yhMwx6mir0mN6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37857 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab1FQS66 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2011 14:58:58 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikD=VCqf+JDK=21yhMwx6mir0mN6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jun 16, 2011 at 05:31:44PM -0700, Colin Patrick McCabe wrote:
> Does anyone know if Automake has a way of expressing dependencies between
> libraries?
> 
> For instance, currently our code has this set of (logical) dependencies:
> rbd -> librbd -> librados -> libcommon
> 
> Where a -> b means "a depends on symbols found in b".
> 
> Unfortunately, the problem that I've run into is that automake seems to have
> no way of expressing dependencies between libraries.
> 
> You can do:
> > librbd_la_LIBADD += librados.la
> 
> This line does seem to take care of the business of making the final librbd.so
> depend on librados.so.
> 
> But you'll still get undefined symbols if you try to use librbd.la later in
> the Makefile.am without also remembering to include librados. So remembering
> the dependencies is up to the developer, which could be a problem if we decide
> to create more libraries (say, by splitting libcommon.) Is there a workaround
> for this?

This (and the next sections from there on) seem to talk exactly about
this:

http://sources.redhat.com/autobook/autobook/autobook_76.html#SEC76

The Autobook is heavy reading, but is very very good. Later sections
cover automate integration.

http://sources.redhat.com/autobook/autobook/autobook_toc.html

> Another problem that I've experienced is that Automake seems to view a
> particular library as either 'shared' or 'static' inherently, and can't handle
> mixing the two. For example, if you do:
> 
> > librbd_la_LIBADD += libcommon.a

As explained in Autobook, libtool does *both*, I think that automake
snippet is just trying to cram a static library in a place that only
expects shared a one.

-- 
:(){ :|:&};:
