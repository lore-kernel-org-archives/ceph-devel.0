From: Victor Araujo <ve.ar91@gmail.com>
Subject: Cache tiering [GSoC 2016]
Date: Thu, 10 Mar 2016 22:52:30 +0200
Message-ID: <CA+skQMsiv7A5MLZmiUZy50_pb07pRkGO-Vo=Bsho3FoAjOUH8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35455 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcCJUwb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 15:52:31 -0500
Received: by mail-wm0-f52.google.com with SMTP id l68so3601754wml.0
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 12:52:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I am a first year master's student in Finland. I recently discovered
Ceph and have been getting acquainted with the concepts and the
codebase.

I noticed the blueprint
http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Tiering_II_(Warm-%3ECold)
and I was wondering if there is a particular piece of it  that would
be suitable for this year's GSoC.

I also noticed several other blueprints related to cache tiering, like
http://tracker.ceph.com/projects/ceph/wiki/Improvement_on_the_cache_tiering_eviction
suggesting improvements or other implementations like ARC. Would it
make sense to enable some sort of cache plugins, similar to what was
done with erasure code plugins, to allow different strategies for
particular use cases and facilitate testing other implementations? If
it makes sense and it could be scoped for GSoC I'd be very interested.

Thanks in advance for any guidance you can provide on these subjects.
Best regards,


Victor Araujo
