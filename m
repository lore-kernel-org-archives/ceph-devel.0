From: Hidekazu Nakamura <hid-nakamura@vf.jp.nec.com>
Subject: Plugin for querying rgw metadata
Date: Wed, 2 Nov 2016 04:08:28 +0000
Message-ID: <8FC2060F93794D44942D588B8B547287121F993F@BPXM03GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from TYO200.gate.nec.co.jp ([210.143.35.50]:44414 "EHLO
        tyo200.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750698AbcKBEJ2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2016 00:09:28 -0400
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
        by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id uA249PAU010045
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Wed, 2 Nov 2016 13:09:26 +0900 (JST)
Received: from mailgate3.nec.co.jp ([10.7.69.195])
        by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id uA249Mxt000017
        for <ceph-devel@vger.kernel.org>; Wed, 2 Nov 2016 13:09:22 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
        id uA249M227894 for <ceph-devel@vger.kernel.org>; Wed, 2 Nov 2016 13:09:22 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id uA249Mos018971
        for <ceph-devel@vger.kernel.org>; Wed, 2 Nov 2016 13:09:22 +0900 (JST)
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Haruhiko Katou <har-katou@ts.jp.nec.com>

Hi ceph developers,

I heard at OpenStack Summit Barcelona[*] that community will develop plugin
which put metadata into elasticsearch for querying metadata.
Could anyone teach me spec of it?

My concern is whether operator could know object sync status between zones.

[*]https://www.openstack.org/videos/video/ceph-now-and-later-our-plan-for-open-unified-cloud-storage

Thanks,
Hidekazu Nakamura

