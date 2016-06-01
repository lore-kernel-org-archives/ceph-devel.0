From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: sortbitwise
Date: Wed, 1 Jun 2016 16:04:23 -0700
Message-ID: <CAMMFjmFXMMyBM6-AJVDVLyvjLw4yN4ES=0hqRDoeU2n2mw6CmQ@mail.gmail.com>
References: <CAN=+7FVAAMZSeZDDeUdqt_cA7TR50jLWCnyh0ZjXXFrYzMNkBA@mail.gmail.com>
	<CAN=+7FUFoQnNLcUa1Brkt4vh4QbxgPNT6Nf=GvMvaKEq=9UiyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38523 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbcFAXEZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 19:04:25 -0400
Received: by mail-wm0-f46.google.com with SMTP id a20so45672948wma.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2016 16:04:24 -0700 (PDT)
In-Reply-To: <CAN=+7FUFoQnNLcUa1Brkt4vh4QbxgPNT6Nf=GvMvaKEq=9UiyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "Weil, Sage" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

yes we run hammer-x on jewel on regular basis.

On Wed, Jun 1, 2016 at 3:48 PM, Samuel Just <sjust@redhat.com> wrote:
> Or maybe they do?  I see hammer-x/tiering has it.  Do we run that one regularly?
> -Sam
>
> On Wed, Jun 1, 2016 at 3:47 PM, Samuel Just <sjust@redhat.com> wrote:
>> I think the hammer-x tests aren't setting sortbitwise at all.  At
>> least, I don't see it in the yamls.
>> -Sam
