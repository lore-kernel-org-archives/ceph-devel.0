From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: Several patches for CEPH
Date: Thu, 30 Sep 2010 00:29:22 +0800
Message-ID: <AANLkTikbbO48kojFbV3jQ8L2A77mr5rRGd_=fKE+XB3W@mail.gmail.com>
References: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
	<AANLkTimSQKsa60B1i1FyxDQDu91SKCPLF9yAEARY3nks@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50495 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab0I2QaI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Sep 2010 12:30:08 -0400
Received: by qyk36 with SMTP id 36so1239261qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Sep 2010 09:29:40 -0700 (PDT)
In-Reply-To: <AANLkTimSQKsa60B1i1FyxDQDu91SKCPLF9yAEARY3nks@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Sep 23, 2010 at 1:14 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> On Wed, Sep 22, 2010 at 8:29 AM, Henry C Chang
> <henry_c_chang@tcloudcomputing.com> wrote:
>> 1. http://github.com/tcloud/ceph/commit/3c91d0c0e20425f94eaa374f39b2a1f398270255
>>
>> This fixed a monitor bug we hit several times. When some osds report
>> that other osds are down,
>> there is a chance that the leading monitor would enter an infinite loop (you can
>> see the CPU usage of cmon is 100% from "top").
> You diagnosed the problem correctly, but it looks like your patch can
> make the monitor discard the wrong report! Fixed this by sticking an
> "&& i != fail_notes.end()" into the while loop, in
> commit:2c5a3d99aa3be5ce114072e84f73a0a6426e63fd.

With this commit, however, if i == fail_notes.end() and leaves the while loop,
it will cause segfault/abort in the following if-else when
fail_notes.erase(i) is called.
(I wonder if my patch is right.)

Henry
