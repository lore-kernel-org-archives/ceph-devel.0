From: Sage Weil <sage@newdream.net>
Subject: Re: Crush Map compactness
Date: Wed, 13 Apr 2016 08:39:22 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604130835330.29593@cpach.fuggernut.com>
References: <CAL-rCA10dnSHnxroBd6Mim3gtQRsiHQMu91MMiWjwK3T13j_1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-894269362-1460551165=:29593"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44947 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbcDMMjZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 08:39:25 -0400
In-Reply-To: <CAL-rCA10dnSHnxroBd6Mim3gtQRsiHQMu91MMiWjwK3T13j_1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?KOI8-R?B?4NLJyiDzz8vPzM/X?= <funny.falcon@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-894269362-1460551165=:29593
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Apr 2016, Юрий Соколов wrote:
> Hello, all.
> 
> I suggest couple of improvements to CrushWrapper.
> 
> Mostly safe change is replace std::map with btree::btree_map.
> It is straightforward change and it looks to be safe.

+1
 
> More complicated change is replacing std::string with custom allocated strings:
> - use custom allocator binded to CrushWrapper, - just a bump allocator
> with from list of blobs,
> - custom strings, used in CrushWrapper's maps are allocated from this
> allocator and never freed in one-by-one manner
> - custom data-structure for maps to be able to search by std::string
> (or tuned btree::btree_map)
> - for CrushWrapper's api results, newly allocated std::string are
> returned (with C++11 this is already a case, cause reference counting
> is forbidden)
> - whole allocator with its blobs is freed together with CrushWrapper.
> This approach is workable if and only if CrushWrapper is not changed
> after construction.
> I'm not too confident with Ceph sources to be sure about this property.

This is a lot more work, but might be worth it.  Most of the time the map 
*is* immutable.  And when it is updated, we do it by decoding a new 
version of the map...

> Is CrushWrapper "immutable" after it is fully constructed?

The problem is that we also have a bunch of mutators (set_*() methods) 
that are called in OSDMonitor.cc when making updates, and they need to be 
supported to.  I would figure out how to support those as well before 
moving forward.

It is probably worth doing some analysis to determine that these 
allocations are really that expensive, too.  Half of the allocations are 
for the map structs themselves, and those aren't going away.

sage
--8323329-894269362-1460551165=:29593--
