From: Martin Millnert <martin@millnert.se>
Subject: Re: [ceph-users] who is using radosgw with civetweb?
Date: Mon, 02 Nov 2015 18:01:24 +0100
Message-ID: <1446483684.7969.371.camel@millnert.se>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
	 <54EF008C.2050706@42on.com>
	 <107057245.16991.1424972320227.open-xchange@websrv>
	 <183263292.17021.1424976208041.open-xchange@websrv.42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:45029 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbbKBRBb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Nov 2015 12:01:31 -0500
In-Reply-To: <183263292.17021.1424976208041.open-xchange@websrv.42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Developers <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>, Wido den Hollander <wido@42on.com>

Hi devs,

it seems the below fell between chairs or similar:

On Thu, 2015-02-26 at 19:43 +0100, Wido den Hollander wrote:
> >> It seems like Civetweb listens on 0.0.0.0 by default and that doesn't seem
> >> safe to me.
> I'd just suggest to bind on localhost by default and let the user choose otherwise.

I +1 that it should default to localhost.

The civetweb-way to configure this is documented at section
"listening_ports" in
https://github.com/civetweb/civetweb/blob/master/docs/UserManual.md

In ceph radosgw terms it'd be akin to:
  rgw frontends = civetweb port=127.0.0.1:7488

As a side-note, I notice the config parser is
https://github.com/ceph/ceph/blob/master/src/rgw/rgw_main.cc#L1192 , 
the value of key "port" is parsed into an int.

Luckily, the parser ignores errors and throws $random data into the
process as-is. When setting e.g:
  rgw frontends = civetweb port=[::]:7488

"radosgw -d" throws
error parsing int: [::]:7488: strict_strtoll: expected integer, got:
'[::]:7488' 

followed by:

2015-11-02 17:51:00.287529 7f2e671db880  0 framework: civetweb
2015-11-02 17:51:00.287536 7f2e671db880  0 framework conf key: port,
val: [::]:7488
2015-11-02 17:51:00.287555 7f2e671db880  0 starting handler: civetweb

Input validation/schmalidation :-)

-- To get back to the original question, it is a simple fix at
https://github.com/ceph/ceph/blob/master/src/common/config_opts.h#L1134
to change the default to "fastcgi, civetweb port=127.0.0.1:7480".

The tricky thing is operators relying on the default being world
accessible of course... Theoretically, an upgrade script could ...
explicitly add the running config before upgrade, to the config file or
similar, or at the very least warn.

Minimum the documentation at
http://docs.ceph.com/docs/master/radosgw/config-ref/ could be blessed
with an entry on 'rgw frontends', including notes on how to configure it
for loopback-binding access only.

Best,
Martin

