From: Loic Dachary <loic@dachary.org>
Subject: Re: rbd-mirror related jewel backports
Date: Wed, 10 Aug 2016 23:00:41 +0200
Message-ID: <57AB95F9.3050101@dachary.org>
References: <57AAEEC2.3060108@dachary.org>
 <CA+aFP1CFahNravqJ3RuVLnAO9gXsOcsDoPy8=QRBPQ+=txUtLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35644 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbcHJVAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 17:00:48 -0400
In-Reply-To: <CA+aFP1CFahNravqJ3RuVLnAO9gXsOcsDoPy8=QRBPQ+=txUtLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Mykola Golub <mgolub@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 10/08/2016 22:14, Jason Dillaman wrote:
> Loic,
> 
> If you want, I can create the backport PRs for those tickets.

That would be great. Alternatively, if that's less time consuming for you, just suggest a backport order and I'll figure it out.

Cheers

> 
> 
> On Wed, Aug 10, 2016 at 5:07 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Mykola,
>>
>> There are seven rbd-mirror related backports which do not cherry-pick cleanly. I've not looked at each of them yet and I would very much appreciate your advice about the best way to proceed.
>>
>> http://tracker.ceph.com/issues/16511
>> http://tracker.ceph.com/issues/16512
>> http://tracker.ceph.com/issues/16658
>> http://tracker.ceph.com/issues/16701
>> http://tracker.ceph.com/issues/16747
>> http://tracker.ceph.com/issues/16902
>> http://tracker.ceph.com/issues/16978
>>
>> Maybe they should be cherry-picked in a specific order in order to avoid conflicts ? For instance, maybe one of the pending backports that you can see at
>>
>> https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ajewel+label%3Arbd
>>
>> would avoid some of the conflicts if merged ? I'm thinking specifically
>>
>> https://github.com/ceph/ceph/pull/10646
>> https://github.com/ceph/ceph/pull/10644
>>
>> What I'm looking for, ideally, is a way to order the cherry-picks to avoid any conflict. That may involve backporting a few additional pull requests (for instance when the type of an argument changes from int64_t to uint64_t, that creates a lot of potential conflicts and backporting that change could help, even if it is not required to fix a given bug.
>>
>> There are three backports that also do not apply because of a conflict but do not seem to be related to rbd-mirror. Unless you advise otherwise, I'll attempt to resolve these individually and assume there is complex interaction with other backports.
>>
>> http://tracker.ceph.com/issues/16950
>> http://tracker.ceph.com/issues/16904
>> http://tracker.ceph.com/issues/16735
>>
>> Thanks in advance for your guidance !
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
