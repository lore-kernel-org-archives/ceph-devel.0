From: Gregory Farnum <greg@inktank.com>
Subject: Re: Very bad behavior when
Date: Tue, 4 Dec 2012 11:41:06 -0800
Message-ID: <CAPYLRzh0Fu5DjjAh1RuYY70iM=pfqekCp9qOoJSRCWgoQ+XnZQ@mail.gmail.com>
References: <CAF6-1L5WSukXaDfy64wxUuuHDdhZ3G3AW_=fkjiVLzbm_g-rng@mail.gmail.com>
	<D988AE88A2484A23AA62CF8112AA9B7A@inktank.com>
	<CAF6-1L5WZaqVNpcnuSMQJC0-KMB8xgzJA_O21gG=+EhULFdsQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39666 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2LDTlH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 14:41:07 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6781478ieb.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 11:41:07 -0800 (PST)
In-Reply-To: <CAF6-1L5WZaqVNpcnuSMQJC0-KMB8xgzJA_O21gG=+EhULFdsQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Nov 24, 2012 at 9:04 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>> In addition to Sam's question about version, are you using cephx?
>
> I'm running 0.48.2 on Ubuntu Precise and cephx auth is enabled.
>
> Cheers,
>
>      Sylvain

Sorry to let this drop for so long, but is this something you've seen
happen before/again or otherwise reproduced? I'm not entirely sure how
to best test for it (other than just jerking the time around), and
while I can come up with scenarios where the OSD leaks memory, I've
got nothing for how that happens to the monitors. We've also fixed a
number of leaks recently that could account for part of the problem.
-Greg
