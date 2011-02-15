From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: librados api cleanup
Date: Mon, 14 Feb 2011 16:04:30 -0800
Message-ID: <AANLkTim0kgb3LfhdpxXzjfxZ55eyhfWg1BtZ7RyzusQN@mail.gmail.com>
References: <Pine.LNX.4.64.1102141453450.20210@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35778 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab1BOAEb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Feb 2011 19:04:31 -0500
Received: by fxm20 with SMTP id 20so5826279fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Feb 2011 16:04:30 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102141453450.20210@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Feb 14, 2011 at 3:00 PM, Sage Weil <sage@newdream.net> wrote:
> There are a few problems with the current librados api (at least the =
C
> bindings). =A0The main one is that there is an implicit assumption th=
at you
> can only interact with a single cluster from the same process.
> rados_initalize() takes argc/argv, allowing you to pass in configurat=
ion
> options and/or a config file location, and it is assume that is the
> cluster that is referenced when you open up a pool.

One idea would be to have a C API like this:

rados_cluster_t ctx;
rados_initialize(&ctx);
rados_read_configuration(ctx, "my_ceph_config.conf");
rados_set_conf("log dir", "/my/log/dir");

[leaving out error handling for brevity]

So essentially, you have this rados_cluster_t which encapsulates the
cluster you're talking to and the configuration options you're using.
It should be fairly easy to create a function like rados_set_conf,
which sets arbitrary configuration options to new values in case
library users want to force particular settings.

The nice thing about doing it like this, rather than adding arguments
to rados_initialize, is that it's open-ended. We won't need to keep
creating more and more versions of rados_initialize as people discover
new options they want to set.

> In order to make it really work the way it looks, though, we need to
> identiy and eliminate as many remaining instances of common static
> variables. =A0Currently, for example, the configuration state is stat=
ic
> (in this case, shared between clusters). =A0For things like
> debugging/logging, that's fine, but for other options it can be
> problematic.

I think we should bite the bullet and put the configuration into a
ceph_context_t.

Then to cosd.cc, cmon.cc, etc, we add
ceph_context_t *g_ctx;

Then the daemon code can be converted just by doing:
s/g_conf/g_ctx->conf/g

The code that's shared between daemons and libraries would need to add
ceph_context_t as a parameter to certain functions. The linker will
find any "mistakes" since references to g_ctx will not be resolved in
non-daemon code.
So it may be easier than it seems.

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
