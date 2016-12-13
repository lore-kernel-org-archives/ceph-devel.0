From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Is Hammer end of life now?
Date: Tue, 13 Dec 2016 09:31:58 +0100
Message-ID: <32f8de21-677f-812f-dfae-3dc4b4ebb42b@suse.cz>
References: <CALqRxCxMvAZTgA5sO4cJzFhzVjL=0xYnXrLO2n57VZf21R3b9Q@mail.gmail.com>
 <71343bb5-fb1f-a389-3e8c-bbb38a42496e@suse.cz>
 <CADRKj5SJ4C57HSG4Ys3eC0LUWGXid=E7oCGRNjbsV0pKaaT3Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbcLMIcB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Dec 2016 03:32:01 -0500
In-Reply-To: <CADRKj5SJ4C57HSG4Ys3eC0LUWGXid=E7oCGRNjbsV0pKaaT3Eg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Yehuda:

> Need to have 18187 and 17985 backported.

Both of those are already staged. I will schedule another round of tests 
today.

I see you marked http://tracker.ceph.com/issues/16122 for backport to 
hammer. I gave it a try, but it is beyond my capabilities. Depending on 
if this backport is a "must-have" or a "nice-to-have", either someone 
other than me would have to do it or we could just omit it.

Thanks,
Nathan
