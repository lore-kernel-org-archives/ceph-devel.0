From: John Nielsen <lists@jnielsen.net>
Subject: Re: RGW object purging in upstream caches
Date: Tue, 7 May 2013 13:45:06 -0600
Message-ID: <6E8D5B25-841F-4130-A22F-A0AFA5CFD936@jnielsen.net>
References: <50FEC144.2050304@widodh.nl>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from secure.freebsdsolutions.net ([69.55.234.48]:50853 "EHLO
	ns1.jnielsen.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752454Ab3EGTpF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 15:45:05 -0400
In-Reply-To: <50FEC144.2050304@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Jan 22, 2013, at 9:41 AM, Wido den Hollander <wido@widodh.nl> wrote:

> To improve performance I still think using a proxy like Varnish or Nginx can help a lot.
> 
> Now, when running just one Varnish instance which does loadbalancing over multiple RGW instances is not a real problem. When it sees a PUT operation it can "purge" (called banning in Varnish) the object from it's cache.
> 
> When looking at the scenario where you have multiple caches you run into the cache-consistency problem. If an object is modified the caches are not notified and will continue to serve an outdated object.
> 
> Looking at the Last-Modified header is not an option since the cache will not contact RGW when serving out of it's cache.
> 
> To handle this there has to be some kind of "hook" inside RGW that can notify Varnish (or some other cache) when an object changes.
> 
> Is this something that's on the roadmap? Thoughts?

Responding to an old thread, but I've been thinking about this again lately.

I agree it would be nice for an upstream cache to know when its content is invalid. I realized today that RGW already does this for itself--multiple gateways on the same RADOS cluster share cache state with each other by updating and rados_watch()ing the notify_oid's in the .rgw.control pool.

I would like to see a small "RGW cache notifier" utility that just does the "watch" half. It could be a standalone read-only librados client with configurable output. You would tell it what pool to watch (i.e. ".rgw.control") and it would spit out event details as they happen. A small amount of scripting or other glue could turn this utility in to a real-time cache invalidator for Varnish or anything else.

Any comments or volunteers? If I'm not mistaken (which is by no means certain), someone familiar with the code could add such a utility by creating a new .cc file with a simple main() function and a modified RGWCache::watch_cb() function, then linking it to the build with a stanza in Makefile.am similar to that for radosgw-admin. I might even take a crack at it myself but my C++ is more than a bit rusty.

In any case, comments welcome.

JN

