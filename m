From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: New configuration / command line handling
Date: Mon, 3 Dec 2012 23:46:04 +0100
Message-ID: <CAN04cT5UgSipUOG9Ch=nXOwh-AGvmhtFzHOKDamuN6zxBtg9iQ@mail.gmail.com>
References: <CAN04cT6XTzaqQuLyQUUWY34F9ZQ1xoLwK3uJt5+SS-Ui+MCUCg@mail.gmail.com>
	<50BD1EE9.909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36464 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab2LCWqE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 17:46:04 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2612591iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 14:46:04 -0800 (PST)
In-Reply-To: <50BD1EE9.909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Dec 3, 2012 at 10:51 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> It looks like you've got a good start on integrating it into the main
> ceph infrastructure. Skimming over it, the general structure makes sense
> to me. One part that might be a bit tricky is making the new parsing
> backwards compatible with the old parsing.
>
> 1) For config options in general, '-', '_', and ' ' are all equivalent.
> 2) In ceph's config file format, we treat ';' as a comment in addition to
> '#'.
>
> I'm not sure how difficult those are to handle with the built-in
> boost::program_options parsers.

Well, there is another (maybe larger) problem; metavalues. Boost::po
can't handle them. That's why I am implementing the raw config file
parsing separately (partly using boost::property_tree actually), load
all options in a tree hierarchy (for example [osd.1] -> [osd] ->
[global]) and then do metavalue lookups top-down with static regexps.
Then, I have a parsed and complete set in the top of the tree (osd.1
in this case) which I can feed to boost::po to be parsed. Still have
to work out some of the details though, but I think this is generally
a nice way of config parsing. I'll see if I can find the time this
week to implement it if you're interested.

> Converting some of the individual command line tools that use
> subcommands might be a little cumbersome too, but I think they'll
> be better off once it's done.

My biggest concern is that most code directly accesses members of
md_config_t by means of g_conf->foo. It's very difficult to port that
to the new class without actually loading all of the available config
options as class members - something I'm personally not a big fan of.
I haven't had the time to think of a nice solution, yet (something
like getter/setter methods maybe, or macros?). If you have any
thoughts about this I'd very much like to hear them.

- Roald
