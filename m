From: =?UTF-8?B?0K7RgNC40Lkg0KHQvtC60L7Qu9C+0LI=?=
	<funny.falcon@gmail.com>
Subject: Crush Map compactness
Date: Wed, 13 Apr 2016 11:48:27 +0300
Message-ID: <CAL-rCA10dnSHnxroBd6Mim3gtQRsiHQMu91MMiWjwK3T13j_1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37546 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934539AbcDMIs3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 04:48:29 -0400
Received: by mail-wm0-f54.google.com with SMTP id n3so64298682wmn.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 01:48:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello, all.

I suggest couple of improvements to CrushWrapper.

Mostly safe change is replace std::map with btree::btree_map.
It is straightforward change and it looks to be safe.

More complicated change is replacing std::string with custom allocated strings:
- use custom allocator binded to CrushWrapper, - just a bump allocator
with from list of blobs,
- custom strings, used in CrushWrapper's maps are allocated from this
allocator and never freed in one-by-one manner
- custom data-structure for maps to be able to search by std::string
(or tuned btree::btree_map)
- for CrushWrapper's api results, newly allocated std::string are
returned (with C++11 this is already a case, cause reference counting
is forbidden)
- whole allocator with its blobs is freed together with CrushWrapper.
This approach is workable if and only if CrushWrapper is not changed
after construction.
I'm not too confident with Ceph sources to be sure about this property.

Is CrushWrapper "immutable" after it is fully constructed?

If so, I will try to implement this approach.

With regards,
Sokolov Yura aka funny_falcon
