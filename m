From: YuFan Chen <wiz.chen@gmail.com>
Subject: About the "temperature histogram" of tier-agent
Date: Tue, 28 Nov 2017 14:38:03 +0800
Message-ID: <CAHMqkF7XOhzrQJODwOGnz-0Y8echtdQPEamcNL126w5ctW4+Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36113 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdK1GiE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 01:38:04 -0500
Received: by mail-it0-f49.google.com with SMTP id y71so12696711ita.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 22:38:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

   Before Jewel, the code uses "atime" to distinguish hot/cold data:

          agent_estimate_atime_temp() calculates the distance.
          It means colder data gets longer distance (larger value)


   In Jewel, it changes to use temperature with weight.
            So, colder data gets smaller value.

    However, it still use the "old semantics" to determine evicting or not in
           ReplicatedPG::agent_estimate_atime_temp();

    if (1000000 - temp_upper >= agent_state->evict_effort)
       return false;


     if there is no misunderstanding, should it change to that:

--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -12211,7 +12211,7 @@ bool
ReplicatedPG::agent_maybe_evict(ObjectContextRef& obc, bool
after_flush)
     delete f;
     *_dout << dendl;

-    if (1000000 - temp_upper >= agent_state->evict_effort)
+    if (temp_upper >= agent_state->evict_effort)
       return false;
   }

Yu Fan
