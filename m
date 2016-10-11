From: Loic Dachary <loic@dachary.org>
Subject: Re: Upcoming 10.2.4
Date: Tue, 11 Oct 2016 20:48:07 +0200
Message-ID: <57FD33E7.3050502@dachary.org>
References: <57FB7494.1010309@dachary.org>
 <CABo9giTwwWPs0F_t+FrMR=QpDfHjpH14YKDgG43HQNJqQe6W5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55495 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753626AbcJKSty (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 14:49:54 -0400
In-Reply-To: <CABo9giTwwWPs0F_t+FrMR=QpDfHjpH14YKDgG43HQNJqQe6W5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Orit,

Please ping me as soon as it is merged and I'll do the needful.

Cheers

On 11/10/2016 20:38, Orit Wasserman wrote:
> Hi,
> I have a fix for the old radosgw-admin corruption (upgrade issue) that
> will be good to be included in 10.2.4
> https://github.com/ceph/ceph/pull/11426.
> it still need to pass teuthology and than we can merge it.
> 
> Orit
> 
> On Mon, Oct 10, 2016 at 12:59 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Abhishek,
>>
>> Since you're now release manager, it is my understanding that we'll be asking you if the release should be cut or not. I updated the issue tracking the progress of 10.2.4 accordingly. This is a heads up to let you know we'll most likely ask that question for 10.2.4 some time next week ;-)
>>
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
