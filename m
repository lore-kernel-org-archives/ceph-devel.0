From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH/RFC 0/6]: Introduction
Date: Mon, 5 Dec 2011 13:09:25 -0800
Message-ID: <CAORUGqCOqMALc6RX3E3Jwn3CraoaSb3M-L=fT9Joeu-e-DHrfw@mail.gmail.com>
References: <20111121180656.GO13394@systemlinux.org> <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45001 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756408Ab1LEVJr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 16:09:47 -0500
Received: by faar15 with SMTP id r15so1098678faa.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2011 13:09:46 -0800 (PST)
In-Reply-To: <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Nov 28, 2011 at 06:04, Andre Noll <maan@systemlinux.org> wrote:
> Here is what I have so far. This patch set imports the documentation
> of the OSD subcommands from the wiki to the preciously emtpy file
> doc/ops/monitor.rst of the git repo. The first patch is just the
> result of a cut & paste operation of the corresponding wiki page
> while the other patches try to improve on this. The aim is to have
> a complete and up to date documentation for all osd subcommands.
>
> I don't believe the series is ready for inclusion yet as some
> subcommands (cluster_snap, lost, in, out, ...) still lack useful
> descriptions. It would be nice to add one sentence to each such command
> that explains its purpose and the circumstances under which one might
> want to use this particular command.
>
> So please review and comment. I will fold in your suggestions and
> follow up with a re-rolled series provided there is substantial
> feedback.

Good work! I want to roll this in the docs asap, even if it is still partial.

For that to happen, we need to do two things:

1. get you to add Signed-off-by lines as per SubmittingPatches
2. figure out where this documentation belongs

For ops/monitor is meant for "how do I reassure myself my service
works the right way". Think nagios, collectd, munin, etc. Apologies
for not having much content there yet..

The ops/ hierarchy as a whole is meant to be "user/goal oriented".
That is, I don't want to put in a section "ceph monitor commands".
Instead, we need to ask the question "what is the admin trying to do",
and that's the guiding principle for ops/.

A reference-style document that exhaustively lists all possible
actions should go into some other top-level section. Right now, the
closest parallels we have are config/ ("Configuration reference") and
api/, both meant to be comprehensive references.

Let's do this: make your patch put things in doc/control.rst, with the
title "Control commands", and have doc/index.rst toctree have, below
config, an entry for control. I can take it from there if we want to
reorganize the document more.
