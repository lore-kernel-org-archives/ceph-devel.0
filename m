From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Hi + question
Date: Sun, 25 Nov 2012 20:14:36 +0000
Message-ID: <50B27C2C.9070002@inktank.com>
References: <CAN04cT5E3YCojDFGYa2xKMbUEbf2dvNnFdr322dCCaxcb-LPSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52491 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab2KYUOk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 15:14:40 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so4140593eek.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 12:14:39 -0800 (PST)
In-Reply-To: <CAN04cT5E3YCojDFGYa2xKMbUEbf2dvNnFdr322dCCaxcb-LPSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 11/25/2012 07:02 PM, Roald van Loon wrote:
> Like I said I'm toying away with ceph since an hour or two, and one of
> the things I noticed was that setting up my test env and getting to
> know ceph wasn't all that easy to do (gentoo btw). Things like ceph -h
> not showing the setcrushmap option, the 'ceph osd crush set' only
> returning '(22) Invalid argument' etc etc... So, I decided to take a
> real good look at the sources - any dev's number one source for
> documentation :-) There I... well.. kind of got lost. Cpp files,
> devops tools (python tools, shell scripts, perl scripts), fooclass,
> barclass ofcourse, valgrind supps, ... all in ~/src :-)
> 
> So I was curious if I was the only one finding this a bit confusing.
> If not, I was wondering if you have some clean-up subproject running
> somewhere. Might be a nice way for me to really familiarize myself
> with the code base.
> 
> Let me know,
> 
> Roald

Welcome Roald!

I must say I can relate to that feeling, from back when I started
working with ceph. But I guess that most of my early confusion was
basically due to not being aware where the stuff I wanted was located.

Nowadays I find the sources division fairly consistent with their
purpose. See, in src/ you will mostly find the daemons and the tools; on
mon/ you will find the files that are mostly mon-related, and same goes
for most of the other subdirectories (osd/, mds/, crush/,...). There are
a couple of exceptions, such as global/ or common/, but those by
themselves are pretty self-explanatory ;-)

To be honest, the only thing that keeps annoying me is that the build
process will end up leaving all the objects, libraries and binaries in
src/ after the build, but that's one of the things I've learned to live
with without trying to find an alternative (shame!).

If you need pointers on how to get familiarized with the code base, or
any doubts arise, just let us know and we'd be pleased to point you in
the right direction. You might also find it useful to join us on #ceph
at OFTC.

And, fwiw, the 'ceph' tool itself (which is on tools/, btw), won't
provide you the insight you're looking for. It mostly sends commands
directly to the monitor, and the monitor will send replies the tool will
output. What you are looking for, in this case, can be found on
mon/OSDMonitor.cc


Cheers,
  -Joao



