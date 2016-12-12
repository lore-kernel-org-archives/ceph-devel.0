From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: use ceph-ci.git to get repositories out of dev branches
Date: Mon, 12 Dec 2016 20:44:03 +0100
Message-ID: <fb0b5283-d482-629d-31ee-ddf1ef651455@digiware.nl>
References: <CAC-Np1y=2DY7Rve+ao73i7EtKrFY1K_jnDR86Yhhgt9XF7gsQw@mail.gmail.com>
 <CAC-Np1wgRYptDTeF7=MSmWMW1B1tP_=RNp8EtTGkSy+ZqrP-rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:55994 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752435AbcLLToI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Dec 2016 14:44:08 -0500
In-Reply-To: <CAC-Np1wgRYptDTeF7=MSmWMW1B1tP_=RNp8EtTGkSy+ZqrP-rA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: Andrew Schoen <aschoen@redhat.com>

On 12-12-2016 13:48, Alfredo Deza wrote:
> **REMINDER**
> 
> Please, push development branches to ceph-ci.git to get
> repositories/binaries built.
> 
> We are scheduled to restrict permissions to ceph.git in a few days.
> 
> Thanks!
> 
> On Wed, Dec 7, 2016 at 7:34 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> As announced on November 23rd, please start pushing development
>> branches to ceph-ci.git (https://github.com/ceph/ceph-ci) to get
>> repositories.
>>
>> This doesn't change reporting in https://shaman.ceph.com and it
>> shouldn't affect testing via teuthology.
>>
>> The ceph.git repository will continue to build binaries and
>> repositories for another week to help transitioning.
>>
>> If you have any issues, please mention them in the #sepia or
>> #ceph-devel channels to me (alfredodeza) or Andrew Schoen
>> (andrewschoen).

Hi Alfredo,

Not being a native git-citizen, this is perhaps a bit to cryptic for me.

So instead of makeing PRs in my ceph-fork, I should
	fork ceph-ci
        new PRs should be submitted from this fork against ceph-ci.
??

Any suggestions on how to migrate my current ceph-fork to a
ceph-ci-fork? Or am I going to "lose" all my changes in the log of the
current, and transfer the changes thru diff/patch..

Thanx,
--WjW


