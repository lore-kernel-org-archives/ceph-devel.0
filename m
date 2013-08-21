From: Sage Weil <sage@inktank.com>
Subject: Re: subdir-objects
Date: Wed, 21 Aug 2013 13:41:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com> <CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47884 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab3HUUlB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 16:41:01 -0400
In-Reply-To: <CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Roald van Loon <roaldvanloon@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 21 Aug 2013, Noah Watkins wrote:
> On Wed, Aug 21, 2013 at 12:45 PM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> >
> > from auto-registering the plugins in the RGW core. The only fix for
> > this is making the RGW core aware of the subdirs/plugins, but I think
> > that's nasty design. I'd like to have it in my make conf.
> 
> This patch will turn on the option (which should also fix your problem
> if I understand correctly?), and should probably be committed anyway
> as newer versions of autotools will complain loudly about our current
> Makefile structure.
> 
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 93f3331..fb7c9dd 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -1,4 +1,4 @@
> -AUTOMAKE_OPTIONS = gnu
> +AUTOMAKE_OPTIONS = gnu subdir-objects
>  SUBDIRS = ocf java
>  DIST_SUBDIRS = gtest ocf libs3 java
> 
> > So, the question is; is there a reason why we don't use subdir objects?
> 
> I believe it is just historical, and unfortunately has just been
> repeated over and over. Ideally I think that there should be a
> restructuring to place a Makefile.am in every subdirectory. This would
> address your issue and make it significantly easier to deal with
> situations where we want to build a subset of Ceph, such as just FUSE
> and librados, for example.

Yes, the Makefile.am is in dire need of from TLC from someone who knows a 
bit of autotools-fu.  It is only this way because in the beginning I 
didn't know any better.

sage
