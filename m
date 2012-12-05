From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: New configuration / command line handling
Date: Tue, 04 Dec 2012 19:04:25 -0800
Message-ID: <50BEB9B9.3080005@inktank.com>
References: <CAN04cT6XTzaqQuLyQUUWY34F9ZQ1xoLwK3uJt5+SS-Ui+MCUCg@mail.gmail.com> <50BD1EE9.909@inktank.com> <CAN04cT5UgSipUOG9Ch=nXOwh-AGvmhtFzHOKDamuN6zxBtg9iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47386 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab2LEDEj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 22:04:39 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3229392pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 19:04:37 -0800 (PST)
In-Reply-To: <CAN04cT5UgSipUOG9Ch=nXOwh-AGvmhtFzHOKDamuN6zxBtg9iQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/03/2012 02:46 PM, Roald van Loon wrote:
> On Mon, Dec 3, 2012 at 10:51 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> It looks like you've got a good start on integrating it into the main
>> ceph infrastructure. Skimming over it, the general structure makes sense
>> to me. One part that might be a bit tricky is making the new parsing
>> backwards compatible with the old parsing.
>>
>> 1) For config options in general, '-', '_', and ' ' are all equivalent.
>> 2) In ceph's config file format, we treat ';' as a comment in addition to
>> '#'.
>>
>> I'm not sure how difficult those are to handle with the built-in
>> boost::program_options parsers.
>
> Well, there is another (maybe larger) problem; metavalues. Boost::po
> can't handle them. That's why I am implementing the raw config file
> parsing separately (partly using boost::property_tree actually), load
> all options in a tree hierarchy (for example [osd.1] -> [osd] ->
> [global]) and then do metavalue lookups top-down with static regexps.
> Then, I have a parsed and complete set in the top of the tree (osd.1
> in this case) which I can feed to boost::po to be parsed. Still have
> to work out some of the details though, but I think this is generally
> a nice way of config parsing. I'll see if I can find the time this
> week to implement it if you're interested.

I think this makes sense. I guess the alternative is expanding the
metavalues after boost::po breaks them down, but I don't see any
big advantages either way.

>> Converting some of the individual command line tools that use
>> subcommands might be a little cumbersome too, but I think they'll
>> be better off once it's done.
>
> My biggest concern is that most code directly accesses members of
> md_config_t by means of g_conf->foo. It's very difficult to port that
> to the new class without actually loading all of the available config
> options as class members - something I'm personally not a big fan of.
> I haven't had the time to think of a nice solution, yet (something
> like getter/setter methods maybe, or macros?). If you have any
> thoughts about this I'd very much like to hear them.

I'm not sure this is the best solution, but we have a small number of
types of config values. We could have a getter for each type (like
md_config_t::get_val(), but nicer to use in C++ and asserting that
the configuration option is valid and of the appropriate type), i.e.:

     uint64_t get_uint64_t(const std::string &name);

This could work for internal users (i.e. anyone using g_conf->foo right
now). The library users (e.g. rados_conf_get()) would still want an
interface like md_config_t::get_val() that returns an error if the
option doesn't exist.

Josh
