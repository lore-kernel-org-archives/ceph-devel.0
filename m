From: kefu chai <tchaikov@gmail.com>
Subject: Re: Shall we remove static libraries from *-dev debian pacakges?
Date: Mon, 6 Jun 2016 11:59:26 +0800
Message-ID: <CAJE9aOMurCMg-r4_LPjGPYQTUmLpU0tA5fMjLaPfK8XHoV51-Q@mail.gmail.com>
References: <CAJE9aOMma9roYzaTnPE7WdSf4s93QDqTvy6N87YcMgRuyQiR4w@mail.gmail.com>
 <20160603173953.GA27895@ultraspiritum.eng.arb.redhat.com> <alpine.DEB.2.11.1606031342460.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36271 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbcFFD72 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Jun 2016 23:59:28 -0400
Received: by mail-yw0-f170.google.com with SMTP id x189so129785583ywe.3
        for <ceph-devel@vger.kernel.org>; Sun, 05 Jun 2016 20:59:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606031342460.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Thanks Adam and Sage! As a follow-up, I posted
https://github.com/ceph/ceph/pull/9476.

On Sat, Jun 4, 2016 at 1:43 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 3 Jun 2016, Adam C. Emerson wrote:
>> On 04/06/2016, kefu chai wrote:
>> > Hi Cephers,
>> >
>> > As your know, we are trying to ditch autotools and moving to the cmake
>> > building system. Currently, we ship both static (.a) and shared
>> > libraries (.so) and their .la files in
>> > lib{rbd,rgw,rados,cephfs,radosstriper}-dev debian packages, but only
>> > package the shared libraries in rpm packages. When working on the
>> > cmake, I find it's a little bit tricky to prepare both static and
>> > shared libraries in cmake, see [1].
>> >
>> > So questions:
>> >
>> > - Is it fine if we don't ship static libraries any more in the *-dev
>> > .deb packages just like .rpms?
>>
>> Debian policy does not, to my understanding, require us to provide
>> static libraries. It demands only that if we have them they should be
>> in the -devel package.
>>
>> All other things being equal I have a soft preference to ship static
>> libraries.
>>
>> All other things are not equal.
>
> I'm also happy to drop the static libraries if it makes life easier.  We
> can also do the work to add them back later if there is a compelling need.
> That seems pretty unlikely!
>
> sage



-- 
Regards
Kefu Chai
