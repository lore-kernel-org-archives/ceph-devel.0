From: Loic Dachary <loic@dachary.org>
Subject: Re: Upcoming 10.2.4
Date: Tue, 11 Oct 2016 12:36:34 +0200
Message-ID: <57FCC0B2.3060801@dachary.org>
References: <57FB7494.1010309@dachary.org>
 <CALe9h7c=doR1DiahZceq2+i-5i=X4rQqXnprwGDTO7mgS8V4Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35394 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbcJKKhC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 06:37:02 -0400
In-Reply-To: <CALe9h7c=doR1DiahZceq2+i-5i=X4rQqXnprwGDTO7mgS8V4Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi John,

On 11/10/2016 12:15, John Spray wrote:
> On Mon, Oct 10, 2016 at 11:59 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Abhishek,
>>
>> Since you're now release manager, it is my understanding that we'll be asking you if the release should be cut or not. I updated the issue tracking the progress of 10.2.4 accordingly. This is a heads up to let you know we'll most likely ask that question for 10.2.4 some time next week ;-)
> 
> I've just done a test run of the following jewel PRs:
> [11389]  mon: don't crash on invalid standby_for_fscid
> [10997]  jewel: multimds: allow_multimds not required when max_mds is
> set in ceph.conf at startup
> [10958]  jewel: client: fix shutdown with open inodes
> [10921]  jewel client: add missing client_lock for get_root
> [10107]  jewel: client: FAILED assert(root_ancestor->qtree == __null)
> 
> http://pulpito.ceph.com/jspray-2016-10-10_15:27:25-fs-wip-jcsp-backports-20161010-distro-basic-mira/
> 
> No (real) failures -- can we go ahead and merge all these before 10.2.4?

Done ! Thanks for testing them. The tracker is 502 and a number of VPS run fail because of environmental failures. 10.2.4 may not happen next week after all ;-)

Cheers

> 
> Cheers,
> John
> 
>> Cheers
>>
>> [1] http://tracker.ceph.com/journals/diff/79457?detail_id=76318
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
