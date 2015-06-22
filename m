From: Wido den Hollander <wido@42on.com>
Subject: RGW with Civetweb and HTTP Keep-Alive
Date: Mon, 22 Jun 2015 17:20:43 +0200
Message-ID: <558827CB.50205@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:39432 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbbFVPUe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Jun 2015 11:20:34 -0400
Received: from [IPv6:2001:980:7936:0:a816:8a37:fe50:e9a6] (unknown [IPv6:2001:980:7936:0:a816:8a37:fe50:e9a6])
	by websrv.42on.com (Postfix) with ESMTPSA id 92E70C3635
	for <ceph-devel@vger.kernel.org>; Mon, 22 Jun 2015 17:20:32 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

When running Varnish in front of RGW+Civetweb you want to pipe [0]
request from Varnish to Civetweb.

Varnish will act as a simple TCP Proxy and sends a "Connecton: close"
header to the backend.

Civetweb doesn't seem to honor this query, so it doesn't send back a
"Connection: close" header in the response.

This causes a client to retry the request to Varnish, but it gets back
ad "Broken Pipe" since Varnish already closed the connection to Civetweb.

Any ideas on how we can turn this behavior of Civetweb off? With Varnish
in front I actually don't want Civetweb to do KeepAlive. Varnish talks
keepalive with my clients, but not between Varnish and Civetweb.

It's Civetweb which doesn't honor the "Connection: close" header
properly, but that might be harder to fixed.

I opened a new issue [1] where we should make it configurable if HTTP
KeepAlive is enabled for Civetweb or not.

Wido

[0]: https://www.varnish-software.com/blog/using-pipe-varnish
[1]: http://tracker.ceph.com/issues/12110
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
