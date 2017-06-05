From: Loic Dachary <loic@dachary.org>
Subject: understanding bucket_straw2_choose
Date: Mon, 5 Jun 2017 19:52:02 +0200
Message-ID: <1422f34a-6a4d-45a8-85ad-32b6a7cc4a5f@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41773 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdFERwG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jun 2017 13:52:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

The following lines of bucket_straw2_choose are part black magic to me and I would very much appreciate
pointers to better understand what they do.

			u = crush_hash32_3(bucket->h.hash, x, ids[i], r);
			u &= 0xffff;

			/*
			 * for some reason slightly less than 0x10000 produces
			 * a slightly more accurate distribution... probably a
			 * rounding effect.
			 *
			 * the natural log lookup table maps [0,0xffff]
			 * (corresponding to real numbers [1/0x10000, 1] to
			 * [0, 0xffffffffffff] (corresponding to real numbers
			 * [-11.090355,0]).
			 */
			ln = crush_ln(u) - 0x1000000000000ll;

I understand the general idea (I think) which is to hash the parameters and calculate the log of the hash so that it can be multiplied by the weight without overflowing. What I don't get is the details such as: why &= 0xffff ? I suppose that's because crush_ln is only capable of returning the log for this range of values. If that's the case how come it does not hurt the hashing function (in the sense that it increases the likelyhood that values have very similar hash) because it discards the higher bits ? Also why is it necessary to subtract 0x1000000000000ll ? And why this number and not another one ?

There is no immediate urgency to answer these questions, of course. I'm asking because I worked on tests to verify the C implementation of the algorithm to balance buckets and got into trouble. I think the reason is because I used straw values that are outside of the possible range for ln. But maybe it is because they are in the range and their distribution is very unlikely. Or something else ... ;-) 

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
