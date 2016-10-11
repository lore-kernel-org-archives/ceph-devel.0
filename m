From: Loic Dachary <loic@dachary.org>
Subject: jewel backport of https://github.com/ceph/ceph/pull/11326
Date: Tue, 11 Oct 2016 11:54:18 +0200
Message-ID: <57FCB6CA.8060904@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46733 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbcJKJyj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 05:54:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>, Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Trying to cherry pick commits instead of resolving conflicts and it looks like I'm going to end up adding a number of commits. Before I go down this path, I'd like a confirmation from you that it's the right call (see below for more information about what I did).

Thanks !

git cherry-pick -x dc77a62 from https://github.com/ceph/ceph/pull/11326 conflicts on

unmerged   src/journal/JournalRecorder.cc
@@@ -279,8 -281,7 +276,12 @@@ void JournalRecorder::create_next_objec
        new_object_recorder->get_object_number());
    }
  
++<<<<<<< HEAD
 +  new_object_recorder->append(append_buffers, false);
 +
++=======
+   new_object_recorder->append_unlock(std::move(append_buffers));
++>>>>>>> dc77a62... journal: avoid holding lock while sending journal append
    m_object_ptrs[splay_offset] = new_object_recorder;
  }

----------------------------------------------------------------------

git log --no-merges --oneline --cherry-mark --left-right ceph/jewel...ceph/master -- src/journal/JournalRecorder.cc

> dc77a62 journal: avoid holding lock while sending journal append
> 7b740f5 journal: make librados call async in ObjectRecorder
> 5c88edd journal: increase concurrency of journal recorder
= b4b9843 journal: improve debug log messages
= 11475f4 journal: improve debug log messages
= 30c7f4d journal: update commit entry object number upon overflow
= 5fbf5f8 journal: update commit entry object number upon overflow
= 18f663d journal: close, advance, and open object set ordering
= 27fba6a journal: new ObjectRecorder closed callback
= de83005 journal: close, advance, and open object set ordering
= bba9143 journal: new ObjectRecorder closed callback
= f1a2e6a journal: prohibit journal entries larger than the soft object size
= d5f307d journal: prohibit journal entries larger than the soft object size

git cherry-pick -x 5c88edd conflicts on

unmerged   src/librbd/Journal.cc
@@@ -17,8 -16,11 +17,9 @@@
  #include "common/Timer.h"
  #include "common/WorkQueue.h"
  #include "include/rados/librados.hpp"
 -#include "librbd/journal/RemoveRequest.h"
 -#include "librbd/journal/CreateRequest.h"
  
  #include <boost/scope_exit.hpp>
+ #include <utility>
  
  #define dout_subsys ceph_subsys_rbd
  #undef dout_prefix
@@@ -705,40 -671,56 +706,70 @@@ int Journal<I>::demote() 
    CephContext *cct = m_image_ctx.cct;
    ldout(cct, 20) << __func__ << dendl;
  
++<<<<<<< HEAD
 +  Mutex::Locker locker(m_lock);
 +  assert(m_journaler != nullptr && is_tag_owner());
++=======
+   int r;
+   C_SaferCond ctx;
+   Future future;
+   C_SaferCond flush_ctx;
++>>>>>>> 7b740f5... journal: make librados call async in ObjectRecorder

----------------------------------------------------------------------
git log --no-merges --oneline --cherry-mark --left-right ceph/jewel...ceph/master -- src/librbd/Journal.cc

> 953561f librbd: async method to check journal tag owner
> 7b740f5 journal: make librados call async in ObjectRecorder
> 5c88edd journal: increase concurrency of journal recorder
> fd00549 librbd: new journal listener event for force promotion
> dbbcecf librbd: unify journal event callbacks into single interface
> b8eafef librbd: optionally flag "laggy" journal clients disconnected
> 551d7ea librbd: remove use of owner_lock on IO path
= e83866b librbd: do not record journal events if append is disabled by policy
= 1f63307 librbd: optimize header file dependency & modify related file.
= 549aada librbd: new configuration option to restrict journal payload size
= 99195e8 librbd: wait for journal commit op event to be safely recorded
= 91c70f3 journal: helper class for organizing optional settings
= f71dc87 librbd: improve journaling debug log messages
= 14db535 librbd: separate journal event decoding and processing
> ac590e8 librbd: normalize journal promotion/demotion events
> 718befd librbd: separate journal::TagData predecessor data into new struct
> 47d1e62 rbd-mirror: include tag tid in bootstrap debug log messages
= c2b786c rbd: journal: Support for listening updates on client metadata
> 3492153 journaler: remove ununsed synchronous API routines
> d5fa466 librbd / journal: async journal creation state machine
> c4e439d librbd / journal: async journal removal state machine
> 1416f1c librbd / ImageCtx: singleton safetimer instance helper
= 405142c librbd: do not record journal events if append is disabled by policy
= 11d7500 librbd: new configuration option to restrict journal payload size
= 47e0fbf librbd: wait for journal commit op event to be safely recorded
= dad8328 journal: helper class for organizing optional settings
= 270cb74 librbd: improve journaling debug log messages
= 57cd75e librbd: separate journal event decoding and processing
= f3f4a4a librbd: journal callback to interrupt replay
= deb6ca8 librbd: force-remove journal when disabling feature and removing image
= 2185a62 librbd: optimize header file dependency & modify related file.
= 9687e5e librbd: journal callback to interrupt replay
= d83aa1e librbd: force-remove journal when disabling feature and removing image
= 0dd8573 rbd: journal: Support for listening updates on client metadata
= f0bf15e librbd: stop journal recorder before starting external replay
= 0014a9e librbd: flush journal commit positions before starting op
= ef12536 librbd: resize and snap create can hang on journal replay failure
= c8b4cab librbd: missing journal state for flushing/restarting replay
= de29be7 librbd: Journal no longer requires AioCompletion for IO events
= 65556aa librbd: bubble journal error up via existing AioObjectRequests
= 5aa6eb2 librbd: stop journal recorder before starting external replay
= 6361296 librbd: flush journal commit positions before starting op
= 1032f19 librbd: resize and snap create can hang on journal replay failure
= a7f5bc1 librbd: missing journal state for flushing/restarting replay
= 82587a3 librbd: Journal no longer requires AioCompletion for IO events
= 79c9347 librbd: bubble journal error up via existing AioObjectRequests
= bf4c458 librbd: integrate with async journaler shutdown API
= 0780230 rbd-mirror: Added implementation of image-deleter thread
= ad29785 librbd: integrate with async journaler shutdown API
= 6cc6e66 rbd-mirror: Added implementation of image-deleter thread
= 5ec1f79 librbd: split large AioWrite journal events
= f221fed librbd: assertion to ensure no concurrent processing of replay events
= 44827a3 librbd: assertion to ensure no concurrent processing of replay events
= 70b9fbf librbd: split large AioWrite journal events

-- 
Loïc Dachary, Artisan Logiciel Libre
