From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: New configuration / command line handling
Date: Mon, 3 Dec 2012 13:04:16 +0100
Message-ID: <CAN04cT7eS9szpOoeKN3dra3P66-HoPS9fQZWNiDLrfRAqrJMGA@mail.gmail.com>
References: <CAN04cT6XTzaqQuLyQUUWY34F9ZQ1xoLwK3uJt5+SS-Ui+MCUCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42032 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab2LCMEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 07:04:16 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so1486342vby.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 04:04:16 -0800 (PST)
In-Reply-To: <CAN04cT6XTzaqQuLyQUUWY34F9ZQ1xoLwK3uJt5+SS-Ui+MCUCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've pushed a "working" (read: compiling) branch to github with the
basics of the new configuration handling I mentioned earlier;

http://github.com/roaldvanloon/ceph.git

branch = wip-config

As an example, I've copied the ceph_osd to ceph_osd2 and altered the
initialization in main() such that it uses the new config.

A make ceph-osd2 && ./ceph_osd2 --help should work.

- Roald


On Mon, Dec 3, 2012 at 10:57 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
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
>
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
>
> Of course it's an extremely long long long way from ready, but maybe
> you're interested. Maybe you think this is not needed at all... I'd
> love to have some feedback on it either way.
>
> Anyway, let me know if you want to check it out and I'll push my
> branch to github for you to pull.
>
>
> - Roald
