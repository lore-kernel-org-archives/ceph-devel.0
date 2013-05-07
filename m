From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW object purging in upstream caches
Date: Tue, 7 May 2013 15:25:01 -0700
Message-ID: <CAC-hyiEPxT-=Vt3Zh0b00VrQ1bzW4tHLqrDkhBcyM-+zoJkgJg@mail.gmail.com>
References: <50FEC144.2050304@widodh.nl>
	<6E8D5B25-841F-4130-A22F-A0AFA5CFD936@jnielsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:60559 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab3EGWZC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 18:25:02 -0400
Received: by mail-ia0-f180.google.com with SMTP id 21so1208918iay.25
        for <ceph-devel@vger.kernel.org>; Tue, 07 May 2013 15:25:01 -0700 (PDT)
In-Reply-To: <6E8D5B25-841F-4130-A22F-A0AFA5CFD936@jnielsen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Nielsen <lists@jnielsen.net>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 7, 2013 at 12:45 PM, John Nielsen <lists@jnielsen.net> wrote:
> On Jan 22, 2013, at 9:41 AM, Wido den Hollander <wido@widodh.nl> wrote:
>
>> To improve performance I still think using a proxy like Varnish or Nginx can help a lot.
>>
>> Now, when running just one Varnish instance which does loadbalancing over multiple RGW instances is not a real problem. When it sees a PUT operation it can "purge" (called banning in Varnish) the object from it's cache.
>>
>> When looking at the scenario where you have multiple caches you run into the cache-consistency problem. If an object is modified the caches are not notified and will continue to serve an outdated object.
>>
>> Looking at the Last-Modified header is not an option since the cache will not contact RGW when serving out of it's cache.
>>
>> To handle this there has to be some kind of "hook" inside RGW that can notify Varnish (or some other cache) when an object changes.
>>
>> Is this something that's on the roadmap? Thoughts?
>
> Responding to an old thread, but I've been thinking about this again lately.
>
> I agree it would be nice for an upstream cache to know when its content is invalid. I realized today that RGW already does this for itself--multiple gateways on the same RADOS cluster share cache state with each other by updating and rados_watch()ing the notify_oid's in the .rgw.control pool.

Not quite. The gateway only caches metadata, not data. I don't think
doing it for data would make much sense, performance wise.
>
> I would like to see a small "RGW cache notifier" utility that just does the "watch" half. It could be a standalone read-only librados client with configurable output. You would tell it what pool to watch (i.e. ".rgw.control") and it would spit out event details as they happen. A small amount of scripting or other glue could turn this utility in to a real-time cache invalidator for Varnish or anything else.
>
> Any comments or volunteers? If I'm not mistaken (which is by no means certain), someone familiar with the code could add such a utility by creating a new .cc file with a simple main() function and a modified RGWCache::watch_cb() function, then linking it to the build with a stanza in Makefile.am similar to that for radosgw-admin. I might even take a crack at it myself but my C++ is more than a bit rusty.
>
> In any case, comments welcome.
>
> JN
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
