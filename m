From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: New configuration / command line handling
Date: Mon, 03 Dec 2012 13:51:37 -0800
Message-ID: <50BD1EE9.909@inktank.com>
References: <CAN04cT6XTzaqQuLyQUUWY34F9ZQ1xoLwK3uJt5+SS-Ui+MCUCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59301 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab2LCVvs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 16:51:48 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2224546pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 13:51:48 -0800 (PST)
In-Reply-To: <CAN04cT6XTzaqQuLyQUUWY34F9ZQ1xoLwK3uJt5+SS-Ui+MCUCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/03/2012 01:57 AM, Roald van Loon wrote:
> Hi list, ceph devs,
>
> I've been doing some toying with Ceph lately in my spare time and one
> of the things I'm doing is trying to refactor some of the
> configuration handling / argument parsing. I had some trouble finding
> specific runtime options and configuration settings, so I thought this
> was a good way to get to know the code somewhat better :-) Because
> boost was already used in some places, and some tests also used
> boost::program_options, I've created a new config framework based on
> this. This framework allows for more advanced configuration files in
> the future, beter command line handling, and reduces the amount of
> code in argument parsing somewhat. I also created a different observer
> system, where different parts of the code base can subscribe to
> changes in specific parameters and get notified on changes.

Awesome! We've needed better command line parsing and usage for a while.
It looks like boost::program_options does a lot of nice things there.

> To allow somewhat of a smoother transition and backwards
> compatibility, I've made the new configuration class inherit from the
> one one (md_config_t) and switched all references (like g_conf) to the
> new class. There were also some small changes in files with references
> directly to md_config_t, like pidfile_write. Global_init and
> common_init were duplicated such that it 'injects' the new
> configuration class in the ceph_context object. Most config entries
> are read directly from the md_config_t class (e.g. g_conf->pid_file),
> so it will take some more changes to allow my configuration framework
> to function properly.

This seems like a nice way to allow it to be used gradually by more
and more tools.

> Of course it's an extremely long long long way from ready, but maybe
> you're interested. Maybe you think this is not needed at all... I'd
> love to have some feedback on it either way.

It looks like you've got a good start on integrating it into the main
ceph infrastructure. Skimming over it, the general structure makes sense
to me. One part that might be a bit tricky is making the new parsing
backwards compatible with the old parsing.

1) For config options in general, '-', '_', and ' ' are all equivalent.
2) In ceph's config file format, we treat ';' as a comment in addition 
to '#'.

I'm not sure how difficult those are to handle with the built-in
boost::program_options parsers.

Converting some of the individual command line tools that use
subcommands might be a little cumbersome too, but I think they'll
be better off once it's done.

Josh
