From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: increasingly large packages and longer build times
Date: Tue, 22 Aug 2017 10:27:54 +0200
Message-ID: <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
 <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37361 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932126AbdHVI14 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Aug 2017 04:27:56 -0400
In-Reply-To: <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>, Ken Dreyer <kdreyer@redhat.com>

> my main concern would be the downstream. how shall we accommodate the
> packaging of downstream? for example, what if the boost package
> maintainers of SuSE/fedora/debian/ubuntu are not ready to package the
> boost version we want to use in future?
> 
> but as long as we don't require newer boost to build, we are safe on
> debian and ubuntu at this moment. as boost 1.61 is required for
> building ceph, and both debian unstable and ubuntu artful package
> boost v1.62.

The very latest cutting-edge versions of the distros may ship boost >= 
1.61 but the stable versions most likely do not.

For luminous we (SUSE) need to support the latest stable versions of 
openSUSE and SLE, i.e. Leap 42.3 and SLE-12-SP3. Both of these come with 
boost 1.54.

Nathan
