From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Is Hammer end of life now?
Date: Tue, 13 Dec 2016 23:35:02 +0100
Message-ID: <28ef8a99-2736-0351-6b04-5973885b65a3@suse.cz>
References: <CALqRxCxMvAZTgA5sO4cJzFhzVjL=0xYnXrLO2n57VZf21R3b9Q@mail.gmail.com>
 <71343bb5-fb1f-a389-3e8c-bbb38a42496e@suse.cz>
 <CADRKj5SJ4C57HSG4Ys3eC0LUWGXid=E7oCGRNjbsV0pKaaT3Eg@mail.gmail.com>
 <32f8de21-677f-812f-dfae-3dc4b4ebb42b@suse.cz>
 <20161213212515.GA2959@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932629AbcLMWfI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Dec 2016 17:35:08 -0500
In-Reply-To: <20161213212515.GA2959@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <to.my.trociny@gmail.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>

Hi Mykola:

> If it is not too late, could you please include this PR to your test
> branch:
>
> https://github.com/ceph/ceph/pull/12446

That one is included in the integration branch wip-hammer-backports - 
see http://tracker.ceph.com/issues/17151#note-28

> I am going to test this myself too, still the more tests the better :-)

I am unable to convince Shaman to build my hammer-based testing branch, 
maybe you'll have better luck?

In my case, the build log says:

configure: creating ./config.status
config.status: creating Makefile
config.status: creating scripts/gtest-config
config.status: creating build-aux/config.h
config.status: executing depfiles commands
config.status: executing libtool commands
+ mkdir -p release
+ releasedir=release
+ versionfile=release/version
+ git diff --quiet
+ echo

+ echo '**** REPOSITORY IS DIRTY ****'
**** REPOSITORY IS DIRTY ****

Also, I'm confused about where to push the testing branch. For now I'm 
pushing to both ceph/ceph-ci and ceph/ceph.

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
