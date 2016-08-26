From: KIMURA Osamu <kimura.osamu@jp.fujitsu.com>
Subject: rgw: Bug #13207 has not been backported to Hammer?
Date: Fri, 26 Aug 2016 10:38:49 +0900
Message-ID: <18745577-e50b-eb93-bb7b-12409a67a8de@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:49144 "EHLO
        mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbcHZCBV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 22:01:21 -0400
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 835CDAC0184
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2016 10:38:59 +0900 (JST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

It may be too late for v0.94.8 time frame, but...

Is the bug#13207 http://tracker.ceph.com/issues/13207 backported to Hammer?
I just received a issue from an our customer: buckets or objects that
are granted for "AuthenticatedUsers" are accessible by anonymous users.
Then I found this issue#13207.

Regarding the code on latest hammer branch, it seems this fix is not applied.
Is it possible to backport this fix into Hammer?

I have a more question.
The issue#13207 mentions only for read. If a object is granted FULL_CONTROL
for Authenticated Users, is it writable?

Regards,

-- 
KIMURA Osamu / 木村 修
Engineering Department, Storage Development Division,
Data Center Platform Business Unit, FUJITSU LIMITED
