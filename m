From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk and 'make'
Date: Wed, 21 Sep 2016 07:07:18 +0200
Message-ID: <57E21586.2020306@dachary.org>
References: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
 <57DF7DA0.2050007@dachary.org> <57DF9525.5050904@dachary.org>
 <CAJ4mKGb4ELCPgQOeiC_RWGtBZ44L1anrKX4eRJZx=p25cVCyMg@mail.gmail.com>
 <CAJE9aONfH9uWx4vtYUTjJMo_udRU_vEOMBYag8H6gY8+jGNSCA@mail.gmail.com>
 <CALqRxCy629qBDOobD==3B9M_-QkLjeg7xuPcVkkOQ1ycrotVrw@mail.gmail.com>
 <CAJE9aOMNC1ApUUKR3RVr+QBT1hEMLCbPddtA03F-wCvYMgBUWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48221 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbcIUFHZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 01:07:25 -0400
In-Reply-To: <CAJE9aOMNC1ApUUKR3RVr+QBT1hEMLCbPddtA03F-wCvYMgBUWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Ken Dreyer <kdreyer@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Marcus Watts <mwatts@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 21/09/2016 04:39, kefu chai wrote:
> On Wed, Sep 21, 2016 at 2:04 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> On Tue, Sep 20, 2016 at 9:28 AM, kefu chai <tchaikov@gmail.com> wrote:
>>> agreed, actually, a test-ready ceph-disk needs venv which pip to install the
>>> dependencies, but debian pbuilder uses a cleanroom for building packages
>>> in which no network access is allowed by default.
>>
>> I'm curious why we need a virtualenv at all (or why we "pip install" anything) ?
>>
>> The distros should have all the packaged python-* and python3-*
>> dependencies already, right?
>>
>> If we could switch to using the packaged python dependencies for
>> everything, we'd fix the pbuilder USENETWORK issue, and avoid the
>> indeterminate nature of depending on whatever happens to be going on
>> with pypi. Maybe I'm missing something, though?
> 
> we could. the python modules installed by pip are only used for
> testing purpose, like tox, pytest, flake8, testtools, fixtures, i
> think we can add them to the Build-Depends list. and let pbuilder to
> take care of them.
> 
> @loic what do you think?

It's worth a shot.

The primary reason for encapsulating this into install-deps.sh was to cope with all supported operating systems with just two package file / directories (I.e. one debian directory with no #if/#else capability and one spec file). More often than not satisfying python requirements with packages is challenging, to say the least (even pip).

That being said, the older operating systems are no longer supported and this may not be an issue right now. And when/if it becomes an issue once again in the future we can probably deal with it in a better way.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
