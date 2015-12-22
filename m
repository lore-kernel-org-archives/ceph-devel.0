From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: RFC: tool for applying 'ceph daemon <osd>' command to all OSDs
Date: Mon, 21 Dec 2015 23:29:20 -0800
Message-ID: <CAJ4mKGbeO+OQ0oLk+sZmv8rdT0wQCtXvyE3rq6QG2yfRmOqfSw@mail.gmail.com>
References: <5678E6C2.40007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33222 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbLVH3V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Dec 2015 02:29:21 -0500
Received: by mail-wm0-f53.google.com with SMTP id p187so96425738wmp.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Dec 2015 23:29:21 -0800 (PST)
In-Reply-To: <5678E6C2.40007@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Dec 21, 2015 at 9:59 PM, Dan Mick <dmick@redhat.com> wrote:
> I needed something to fetch current config values from all OSDs (sorta
> the opposite of 'injectargs --key value), so I hacked it, and then
> spiffed it up a bit.  Does this seem like something that would be useful
> in this form in the upstream Ceph, or does anyone have any thoughts on
> its design or structure?
>
> It requires a locally-installed ceph CLI and a ceph.conf that points to
> the cluster and any required keyrings.  You can also provide it with
> a YAML file mapping host to osds if you want to save time collecting
> that info for a statically-defined cluster, or if you want just a subset
> of OSDs.
>
> https://github.com/dmick/tools/blob/master/osd_daemon_cmd.py
>
> Excerpt from usage:
>
> Execute a Ceph osd daemon command on every OSD in a cluster with
> one connection to each OSD host.
>
> Usage:
>     osd_daemon_cmd [-c CONF] [-u USER] [-f FILE] (COMMAND | -k KEY)
>
> Options:
>    -c CONF   ceph.conf file to use [default: ./ceph.conf]
>    -u USER   user to connect with ssh
>    -f FILE   get names and osds from yaml
>    COMMAND   command other than "config get" to execute
>    -k KEY    config key to retrieve with config get <key>

I naively like the functionality being available, but if I'm skimming
this correctly it looks like you're relying on the local node being
able to passwordless-ssh to all of the nodes, and for that account to
be able to access the ceph admin sockets. Granted we rely on the ssh
for ceph-deploy as well, so maybe that's okay, but I'm not sure in
this case since it implies a lot more network openness.

Relatedly (perhaps in an opposing direction), maybe we want anything
exposed over the network to have some sort of explicit permissions
model?

Maybe not and we should just ship the script for trusted users. I
would have liked it on the long-running cluster I'm sure you built it
for. ;)
Indecisively yours,
-Greg
