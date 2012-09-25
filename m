From: Guilhem LETTRON <guilhem.lettron@gmail.com>
Subject: Problem with "rados cppool"
Date: Tue, 25 Sep 2012 15:24:27 +0200
Message-ID: <CAMQoE_002d1m2gqPTaeH_DV+GGmJHTPmXZ-Sz4V-9u5RUaYZ3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43022 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2IYNYs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 09:24:48 -0400
Received: by ieak13 with SMTP id k13so13805250iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 06:24:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I use ceph in production with radosgw.
I just see a configuration problem with my radosgw pool, the number of
pgs is really too low.

To correct, I want to copy all my data to a new pool with "rados
cppool" and switch between the old and the new pool.

The problem : when I try to copy, I have an error where rados can't
find find a file

# rados cppool ys-streaming ys-streaming-new
ys-streaming:12_91923020c45da5e68e93657ff93674a31d22b498.eot =>
ys-streaming-new:12_91923020c45da5e68e93657ff93674a31d22b498.eot
[...]
ys-streaming:18__shadow_8d9bfdc60d1e5b57bddce191da38e8d30cc25c90.png._IoNls-xb2dyaQ9uzHaE6IRzWpaWg1zx(@18_8d9bfdc60d1e5b57bddce191da38e8d30cc25c90.png)
=> ys-streaming-new:18__shadow_8d9bfdc60d1e5b57bddce191da38e8d30cc25c90.png._IoNls-xb2dyaQ9uzHaE6IRzWpaWg1zx(@18_8d9bfdc60d1e5b57bddce191da38e8d30cc25c90.png)
error copying object: No such file or directory
error copying pool ys-streaming => ys-streaming-new: No such file or directory

Here is the full log : https://gist.github.com/cc27ae5a8c2d178501bc

What can I do to fix it ? (or to increase the number of PGs)

Thank you.

Guilhem LETTRON
Youscribe - www.youscribe.com
