From: han vincent <hangzws@gmail.com>
Subject: Re: Beta testing crush optimization
Date: Thu, 1 Jun 2017 18:07:30 +0800
Message-ID: <CANNfkuYgnSYfGq3hF0cKG6XXHtXrvfYBj8+L1giHP5qHw4=e4g@mail.gmail.com>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org> <d3cee009-9187-d90a-4a40-6ab98e619897@dachary.org>
 <CANNfkubxHfAYn-aLkHCQV_YZoMuVTzug9nRbvaTSE4UyKiQLuw@mail.gmail.com> <9c4d5c65-4bd3-19e0-2e0e-59331f952c46@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34762 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdFAKHc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 06:07:32 -0400
Received: by mail-io0-f170.google.com with SMTP id k91so31434306ioi.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 03:07:31 -0700 (PDT)
In-Reply-To: <9c4d5c65-4bd3-19e0-2e0e-59331f952c46@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi loic:
   I still have two questions, in the following to commands:

   1. crush optimize --crushmap /tmp/han-vincent-report.json
--out-path /tmp/han-vincent-report-optimized.txt --out-format txt
--pool 49
   Is "--pool" options must specified in this command? if not, will it
optimize all the pools without "--pool" option?
   if there are several pools in my cluster and each pool has a lot of
pgs. If I optimize one of the, will it affect the other pools?
   how to use it to optimize multiple pools in a cluster of hammer?

   2. crush analyze --crushmap /tmp/han-vincent-report-optimized.txt
--pool 49 --replication-count=2 --pg-num=1024 --pgp-num=1024
--rule=replicated_ruleset --choose-args=49
   In this command, the value of the "--choose-args" option is 49, it
is same as the pool id, what is the mean of "--choose-args" option?
