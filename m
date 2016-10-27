From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next jewel release v10.2.4
Date: Thu, 27 Oct 2016 23:55:04 +0200
Message-ID: <581277B8.9020708@dachary.org>
References: <5811C853.1070706@dachary.org>
 <robbat2-20161027T210703-533951955Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59350 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965581AbcJ0VzK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 17:55:10 -0400
In-Reply-To: <robbat2-20161027T210703-533951955Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Yehuda Sadeh <yehuda@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Hi Robin,

Since it's not yet merged in master I'm deferring to Yehuda's decision. I'd be happy to delay 10.2.4 if necessary.

Cheers

On 27/10/2016 23:10, Robin H. Johnson wrote:
> On Thu, Oct 27, 2016 at 11:26:43AM +0200, Loic Dachary wrote:
>> Hi Yehuda,
>>
>> The next jewel release as found at
>> https://github.com/ceph/ceph/tree/jewel passed the rgw suite
>> (http://tracker.ceph.com/issues/17487#note-18). Do you think the jewel
>> branch is ready for QE to start their own round of testing ?
> Can you please bring in the StaticSites fix in
> https://github.com/ceph/ceph/pull/11280
> 
> This issue has been dragging since late August now :-(.
> (it got reverted last time because it exposed a test suite bug)
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
