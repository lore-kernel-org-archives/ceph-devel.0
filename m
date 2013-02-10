From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Links to various language bindings
Date: Sun, 10 Feb 2013 13:24:39 -0800
Message-ID: <30CAB946-70A4-46E7-A0A2-7C6325199F27@cs.ucsc.edu>
References: <5114BFFD.1060807@widodh.nl> <7ADDC8C0-BB74-44DC-8BE7-2837796DDCCF@cs.ucsc.edu> <51161BCA.6060005@42on.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:62079 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705Ab3BJVYl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 16:24:41 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so2474768dak.14
        for <ceph-devel@vger.kernel.org>; Sun, 10 Feb 2013 13:24:41 -0800 (PST)
In-Reply-To: <51161BCA.6060005@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Feb 9, 2013, at 1:50 AM, Wido den Hollander <wido@42on.com> wrote:

> Hi Noah,
> 
> On 02/08/2013 04:42 PM, Noah Watkins wrote:
>> 
>> On Feb 8, 2013, at 1:06 AM, Wido den Hollander <wido@widodh.nl> wrote:
>> 
>>> Hi,
>>> 
>>> I knew that there were Java bindings for RADOS, but they weren't linked.
>>> 
>>> Well, some searching on Github lead me to Noah's bindings [0], but it was a bit of searching.
>> 
>> The RADOS Java bindings on my Github page should be taken down--they are very old and not stable. Any links to it should probably be taken down. If there is interest in the RADOS Java bindings, I'd be happy to get that ball rolling.
>> 
> 
> Could you then update the README?

Sure.

> I did a quick test yesterday with them and they worked fine, but I just created a Cluster object and a pool, didn't do anything fancy.

Yes, they do "work", and in fact I think some people might be playing with them. They are however full of various problems, and likely need a re-write. I wouldn't rely on them for anything important.

- Noah

