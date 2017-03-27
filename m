From: Loic Dachary <loic@dachary.org>
Subject: storing multiple weights in crush
Date: Mon, 27 Mar 2017 18:45:46 +0200
Message-ID: <e731d3ad-4cde-2f12-0871-962c46df698a@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51160 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdC0Qp5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Mar 2017 12:45:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

I added a proposal[1] to the next CDM[2] to be able to store and use multiple weights for each item in the crushmap. 

I'm not sure about the naming (probabilities is a long word...) but it would be good to not have a third variable named weight with yet another meaning. Although we could modify the builder functions, I'm not sure this is a good idea. They are not complete enough to hide the crush data structures and it is probably enough to document the new data members. And the caller can allocate it and fill it after creating a bucket. In practice that is going to be used by CrushWrapper or python-crush which will define an API.

It is probably best if the crush modification is the bare minimum:

- allowing the choose function to pick a probability from a table indexed by the round instead of relying on a single weight
- storing the probability table in each item

Feel free to modify the pad if you have other ideas, this is a first draft done today and I won't be offended if it is discarded ;-)

Cheers

[1] http://pad.ceph.com/p/crush-multiweight
[2] http://tracker.ceph.com/projects/ceph/wiki/CDM_05-APR-2017

-- 
Loïc Dachary, Artisan Logiciel Libre
