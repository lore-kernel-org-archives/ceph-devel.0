From: Samuel Just <sjust@redhat.com>
Subject: Re: libradosstriper
Date: Wed, 29 Jun 2016 08:30:26 -0700
Message-ID: <CAN=+7FWi1pMFa-=fYYiaaNNyaKmm_8E8dbQOOdOwdTz5n8x34A@mail.gmail.com>
References: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
 <CAN=+7FVmmgAuVF6cjwvGdyAU4YEXr8jLX-qiNjH50w6_YMs02g@mail.gmail.com>
 <1467084445.32200.8.camel@cern.ch> <CAN=+7FXrt6Y=TPRRdjkXZathXXKneV0eqT5VA6hQ5LOrxKoF3Q@mail.gmail.com>
 <1467212620.603.13.camel@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35646 "EHLO
	mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbcF2PbM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 11:31:12 -0400
Received: by mail-qt0-f172.google.com with SMTP id f89so27305769qtd.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 08:30:28 -0700 (PDT)
In-Reply-To: <1467212620.603.13.camel@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Ponce <sebastien.ponce@cern.ch>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ah, sorry.  See src/test/osd/RadosModel.* and
src/test/osd/TestRados.cc.  It's gotten to be a somewhat kludgy mess,
but it's a really valuable stress test for verifying that the osd and
librados are behaving properly, especially when combined with failure
injection and osd thrashing.  I'd like to either create a (less
kludgy, I can only hope) seperate version for librados striper, or add
a flag to the existing one which causes it to use the striper instead
(and only allows ops where it makes sense).  libradosstriper should
have the same ordering properties for piplined writes as normal
librados (right?), so modifying the existing test would probably get
us the most coverage for the least effort.
-Sam

On Wed, Jun 29, 2016 at 8:03 AM, Sebastien Ponce
<sebastien.ponce@cern.ch> wrote:
> Well, I'm not sure what you are exactly looking for : I see now that I
> look more carefully that there is a file called ceph_test_rados that
> looks like a wrapper around the ceph_test_rados_* tests.
> The equivalent does not seem to exist for striper (although the same
> wrapper would probably work), but the ceph_test_rados_striper_* tests
> do exist.
> Should we/I create a wrapper for striper ? I'm not sure I have the
> whole understanding of the structure of the whole test system...
>
> Sebastien
>
>
> On Tue, 2016-06-28 at 09:07 -0700, Samuel Just wrote:
>> I don't remember anything like ceph_test_rados which uses
>> libradosstriper.  Did I miss it?
>> -Sam
>>
>> On Mon, Jun 27, 2016 at 8:27 PM, Sebastien Ponce
>> <sebastien.ponce@cern.ch> wrote:
>> >
>> > Would be great indeed. As it's already there, it can be done
>> > already
>> > now.
>> >
>> > Sebastien
>> >
>> > On Mon, 2016-06-27 at 15:25 -0700, Samuel Just wrote:
>> > >
>> > > The something like ceph_test_rados could then be wired into
>> > > ceph-qa-suite to be tested with osd thrashing to ensure that
>> > > ordering
>> > > works and continues to work as expected.
>> > > -Sam
>> > >
>> > > On Mon, Jun 27, 2016 at 3:18 PM, Sage Weil <sweil@redhat.com>
>> > > wrote:
>> > > >
>> > > >
>> > > > Hi Sebastien,
>> > > >
>> > > > Do you mind updating us on the current status of
>> > > > libradosstriper?  Where
>> > > > does it stand feature-wise with what you need, how are you
>> > > > currently using
>> > > > it or how do you plan to use it, and what is still missing?
>> > > >
>> > > > Also, one thing we really want to see is test coverage for the
>> > > > code
>> > > > so
>> > > > that we can comfortably point users toward it.  This ideally
>> > > > would
>> > > > look
>> > > > something like the ceph_test_rados_api_* tests that verify
>> > > > individual
>> > > > operations behave as expected, and/or something like
>> > > > ceph_test_rados that
>> > > > throws random operations at is and verifies it returns correct
>> > > > results
>> > > > that match its in-memory model.
>> > > >
>> > > > Thanks!
>> > > > sage
>> > > > --
>> > > > To unsubscribe from this list: send the line "unsubscribe ceph-
>> > > > devel" in
>> > > > the body of a message to majordomo@vger.kernel.org
>> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h
>> > > > tml
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
