From: John Nielsen <lists@jnielsen.net>
Subject: Re: RGW object purging in upstream caches
Date: Tue, 7 May 2013 17:01:25 -0600
Message-ID: <514386E8-5C3B-4B15-8FEB-1D1F28F17B7C@jnielsen.net>
References: <50FEC144.2050304@widodh.nl> <6E8D5B25-841F-4130-A22F-A0AFA5CFD936@jnielsen.net> <CAC-hyiEPxT-=Vt3Zh0b00VrQ1bzW4tHLqrDkhBcyM-+zoJkgJg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from secure.freebsdsolutions.net ([69.55.234.48]:50638 "EHLO
	ns1.jnielsen.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752167Ab3EGXBT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 19:01:19 -0400
In-Reply-To: <CAC-hyiEPxT-=Vt3Zh0b00VrQ1bzW4tHLqrDkhBcyM-+zoJkgJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On May 7, 2013, at 4:25 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:

>> Responding to an old thread, but I've been thinking about this again lately.
>> 
>> I agree it would be nice for an upstream cache to know when its content is invalid. I realized today that RGW already does this for itself--multiple gateways on the same RADOS cluster share cache state with each other by updating and rados_watch()ing the notify_oid's in the .rgw.control pool.
> 
> Not quite. The gateway only caches metadata, not data. I don't think
> doing it for data would make much sense, performance wise.

If we only want to know when an object has changed (so we can invalidate it in our external cache), isn't the metadata sufficient? Presumably it changes whenever the data changes. If the external cache wants a fresh copy of the data it can request it directly; there's no need for the helper utility I have in mind to pass any actual object data.

Is my idea of watching the (rados) control objects to learn about updates to rgw objects feasible? The watcher would just need to supply the outside cache with a key to identify the object that should be evicted--maybe the etag?


