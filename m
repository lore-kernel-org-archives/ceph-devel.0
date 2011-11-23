From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: [PATCH] debian init: Do not stop or start daemons when
 installing or upgrading
Date: Thu, 24 Nov 2011 00:52:09 +0100
Message-ID: <1322092329.18718.32.camel@julia.gcs.org.hu>
References: <1321472475-19115-1-git-send-email-wido@widodh.nl>
	 <1321472475-19115-2-git-send-email-wido@widodh.nl>
	 <Pine.LNX.4.64.1111161152550.22555@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:52367 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab1KWXwU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 18:52:20 -0500
In-Reply-To: <Pine.LNX.4.64.1111161152550.22555@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Wed, 2011-11-16 at 11:53 -0800, Sage Weil wrote:
> Ooh, that would certainly make things less annoying for me as well.  
> Unless that's contrary to some debian policy/best practice, Laszlo?
 The following change is fine with me. Please commit it sage and I'll do
the same in the next upload.

> On Wed, 16 Nov 2011, Wido den Hollander wrote:
> > diff --git a/debian/rules b/debian/rules
> > index a20258d..4f3fe62 100755
> > --- a/debian/rules
> > +++ b/debian/rules
> > @@ -98,7 +98,7 @@ binary-arch: build install
> >  	dh_installexamples
> >  	dh_install --sourcedir=$(DESTDIR) --list-missing
> >  	dh_installlogrotate
> > -	dh_installinit
> > +	dh_installinit --no-start
> >  	dh_installman
> >  	dh_lintian
> >  	dh_link

Regards,
Laszlo/GCS

