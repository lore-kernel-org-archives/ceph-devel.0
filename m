From: Timofey Titovets <nefelim4ag@gmail.com>
Subject: [BUG] rbd hard lookup -> kernel crush by some crush maps
Date: Mon, 11 May 2015 12:37:50 +0300
Message-ID: <CAGqmi74aCmT1=ai5sFg1GEQd2MTYzAP8wNnp8uDBh_X2k8D1vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35721 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbEKJic (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 05:38:32 -0400
Received: by wgbhc8 with SMTP id hc8so22120370wgb.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 02:38:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sorry list, i just can't find how send bugs to tracking system -_-

How reporduce:
1. Use crush rule
rule replicated_ruleset {
  ruleset 0
  type replicated
  min_size 1
  max_size 10
  step take default
  step choose firstn 0 type room
  step choose firstn 0 type rack
  step choose firstn 0 type host
  step chooseleaf firstn 0 type osd
  step emit
}
2. inject into cluster
3. do:
rbd map <rbd name>

crushtool passed test successful, but if you inject map into cluster
(i use 0.94.1)
All kernel rbd Clients who use rbd map, immadentely crush.
i don't know which kernel not affected, but i catch it with 4.0.1

With long stucktrace in kernel and message like "Hard lookup detected"
Sorry but i realy have a problems with find logs =_=



-- 
Have a nice day,
Timofey.
