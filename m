From: Sage Weil <sage@inktank.com>
Subject: Re: subdir-objects
Date: Sun, 8 Sep 2013 16:16:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309081615100.19576@cobra.newdream.net>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com> <CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com> <alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net> <CAN04cT74h7QjWhOCQqc3e7HM__qaw+BrbaCy3NW_ZzC1xzX4Kg@mail.gmail.com>
 <CA+Hcz59qJgWY2gukY8h-=c_HXj5Dxj-UCEHrEnBXZKEckWEgJg@mail.gmail.com> <CAN04cT6FOspeq0NEN798ChLAJUuXsV2cFnzDLbQVNj0=pO6PPw@mail.gmail.com> <CA+Hcz5_JRZVWn6iohEyy7iTnHTGH=tbqd+MrxaDwWbD_p3V_cQ@mail.gmail.com> <CA+Hcz5-BgMzomAeGna8bMGjMv4Y2MsknBaSrmHEQHB-0-yFzCQ@mail.gmail.com>
 <CAN04cT4P4ELASm1VoxmHKaje8DHiCpB-bSyMWugjOo19k6j4hg@mail.gmail.com> <CA+Hcz58E7OKaGto0pF_ZYoge-FcDLtc66cbqx9a9+z-=Op3YWQ@mail.gmail.com> <CAN04cT4Pida1ie-11ptSL7R-rgJfYyhWYQ168NLfWOAKDYKApg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40738 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3IHXQM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Sep 2013 19:16:12 -0400
In-Reply-To: <CAN04cT4Pida1ie-11ptSL7R-rgJfYyhWYQ168NLfWOAKDYKApg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: Noah Watkins <noah.watkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 8 Sep 2013, Roald van Loon wrote:
> Hi Noah, Sage,
> 
> The build time has improved in wip-automake somewhat (mainly because
> almost all files are now only compiled to objects once instead of
> per-target), but much of the time goes into linking.
> 
> > I was just looking through build-refactor, and it doesn't really look
> > like there is much that could be reused for the non-recrusive
> > approach. I'll leave it up for a few days, just in case.
> 
> It would be great if you could look at wip-automake and see if you
> have ideas/improvements or stuff you implemented that I didn't. All
> non-automake changes that I needed to make this branch work just got
> merged to master, so this branch is now only about changes .am files.
> Of course every src/Makefile.am adjustment in master will require a
> rebase, so this branch is a real work-in-progress and gets
> force-pushed regularly :-)

I took a quick look and it looks pretty great.  The builds are coming back 
okay, too.. any compelling reason not to merge it now?

BTW, Roald, I think the obj_bencher cct change did something strange... 
see http://tracker.ceph.com/issues/6256.  Trying to reproduce it now.

sage

