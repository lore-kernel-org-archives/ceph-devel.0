From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph init script does not start
Date: Mon, 16 Jul 2012 08:50:02 -0700
Message-ID: <CADvuQRE9SHHV94U0gqyNmXKZMZQNvVXgeCheMfB5T0KM9qK+7A@mail.gmail.com>
References: <50012AF1.4040300@gmail.com> <alpine.DEB.2.00.1207140741070.3898@cobra.newdream.net>
 <3046989.AgMSmANe5F@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40266 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab2GPPub convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 11:50:31 -0400
Received: by pbbrp8 with SMTP id rp8so10229160pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 08:50:31 -0700 (PDT)
In-Reply-To: <3046989.AgMSmANe5F@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Sz=C3=A9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 15, 2012 at 11:05 AM, Sz=C3=A9kelyi Szabolcs <szekelyi@niif=
=2Ehu> wrote:
> Just a humble remark here: actually the host=3D setting has to match =
the
> hostname *until the first dot*. If your hostname contains a dot, this=
 will not
> work. This can be useful in a number of cases, like setting the hostn=
ame to
> indicate the group of a hierarchy level in the name so that the admin=
istrator
> can extactly know what he's working on after logging in (I mean hostn=
ames like
> node<X>.rack<Y> in a datacenter or node<X>.<site> when running a
> geographically distributed cluster).
>
> From this comes my request: do you think it's possible to change (I m=
ean, in
> the repository) ceph_common.sh not to cut the output of `hostname` at=
 the first
> dot? I'm running a cluster with hostnames like that, and now I have t=
o edit
> that file after each upgrade.

There are two concepts here:

- the "short" hostname is just a string, stored in the kernel, can be
changed with "sudo hostname foo.bar" and seen with "hostname"
- the "fqdn" (fully qualified domain name) is what you get from
"hostname -f"; that is reached by taking the "short" hostname,
resolving it to an IP address, and then reverse resolving the IP to
dns name; usually all the info needed is in /etc/hosts, but it'll use
DNS if it has to. If this cannot be done, the "fqdn" is the same as
the "short" hostname.

I see ceph_common.sh currently does hostname=3D`hostname | cut -d . -f =
1`.

I think ceph.conf should use the "short" hostname, without
modification. So whatever you tell your kernel the hostname is, that's
what it'd use. For example, you could set up a hostname of foo.bar,
and make the fqdn be foo.bar.baz.example.com.

But that change might break existing setups..
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
