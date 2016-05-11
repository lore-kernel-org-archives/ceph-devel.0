From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: jewel v10.2.1 status update
Date: Tue, 10 May 2016 17:31:43 -0700
Message-ID: <CADRKj5Q0tFwBaH1Cx93b6WKaUwdB_Pj-RVyk2SeGo7Tb3Zm6eg@mail.gmail.com>
References: <5731B60E.3090603@dachary.org>
	<robbat2-20160511T001522-032231734Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34923 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbcEKAbo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 20:31:44 -0400
Received: by mail-vk0-f43.google.com with SMTP id f66so37783356vkh.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 17:31:44 -0700 (PDT)
In-Reply-To: <robbat2-20160511T001522-032231734Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 10, 2016 at 5:21 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Tue, May 10, 2016 at 12:21:02PM +0200,  Loic Dachary wrote:
>> Hi,
>>
>> All jewel pull requests (
>> https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ajewel
>> ) except two ( https://github.com/ceph/ceph/pull/8868 and
>> https://github.com/ceph/ceph/pull/9010 ) have been merged into the
>> jewel-backports integration branch (
>> http://tracker.ceph.com/issues/15317#note-4 ). They include all
>> backports done by Yehuda and Jason (except 9010) in the past 24h
>> hours. The suites are going to be scheduled later today (when
>> gitbuilder is done creating the packages) and their progress can be
>> tracked at http://tracker.ceph.com/issues/15317#note-5 etc.
>
> I've been waiting 3 weeks now for my staticsites PRs to be merged :-(.
> https://github.com/ceph/ceph/pull/8633
> https://github.com/ceph/ceph/pull/8669
>
> The matching issues:
> http://tracker.ceph.com/issues/15531
> http://tracker.ceph.com/issues/15532


Right. I didn't get to review these as I was working on getting a few
critical fixes sorted out. I will get to your fixes now and we'll
probably get them into 10.2.2.

Yehuda
