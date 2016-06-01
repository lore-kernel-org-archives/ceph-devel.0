From: Samuel Just <sjust@redhat.com>
Subject: Re: sortbitwise
Date: Wed, 1 Jun 2016 16:05:42 -0700
Message-ID: <CAN=+7FVzQgbvrqte2ykTAA2gZEdYmcBMXkQas93z+2oTNvrCvQ@mail.gmail.com>
References: <CAN=+7FVAAMZSeZDDeUdqt_cA7TR50jLWCnyh0ZjXXFrYzMNkBA@mail.gmail.com>
	<CAN=+7FUFoQnNLcUa1Brkt4vh4QbxgPNT6Nf=GvMvaKEq=9UiyA@mail.gmail.com>
	<CAMMFjmFXMMyBM6-AJVDVLyvjLw4yN4ES=0hqRDoeU2n2mw6CmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34441 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbcFAXFn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 19:05:43 -0400
Received: by mail-qk0-f174.google.com with SMTP id y126so26626306qke.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2016 16:05:43 -0700 (PDT)
In-Reply-To: <CAMMFjmFXMMyBM6-AJVDVLyvjLw4yN4ES=0hqRDoeU2n2mw6CmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Weil, Sage" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Do we specifically run the /tiering sub-suite?  Or do we always just
run the whole thing?
-Sam

On Wed, Jun 1, 2016 at 4:04 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> yes we run hammer-x on jewel on regular basis.
>
> On Wed, Jun 1, 2016 at 3:48 PM, Samuel Just <sjust@redhat.com> wrote:
>> Or maybe they do?  I see hammer-x/tiering has it.  Do we run that one regularly?
>> -Sam
>>
>> On Wed, Jun 1, 2016 at 3:47 PM, Samuel Just <sjust@redhat.com> wrote:
>>> I think the hammer-x tests aren't setting sortbitwise at all.  At
>>> least, I don't see it in the yamls.
>>> -Sam
