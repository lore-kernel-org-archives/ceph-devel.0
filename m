From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] v10.1.0 Jewel release candidate available
Date: Wed, 30 Mar 2016 15:18:13 -0400
Message-ID: <CAC-Np1w8Lt+uPG9r7ZDGH7bC+ckRVmHTbGe5rG-ubkh=RNTNYg@mail.gmail.com>
References: <alpine.DEB.2.11.1603281029290.6074@cpach.fuggernut.com>
	<aaegaupo3v.fsf@switch.ch>
	<CAEYCsVJPLv2X9Mj_eLzvFHvH6oZLwN80abCm-bM=-bCXcBJs_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36926 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbcC3TSP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 15:18:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id p65so85177237wmp.0
        for <ceph-devel@vger.kernel.org>; Wed, 30 Mar 2016 12:18:14 -0700 (PDT)
In-Reply-To: <CAEYCsVJPLv2X9Mj_eLzvFHvH6oZLwN80abCm-bM=-bCXcBJs_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Simon Leinen <simon.leinen@switch.ch>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

On Wed, Mar 30, 2016 at 11:49 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> I am seeing package for precise in
> http://download.ceph.com/debian-jewel/dists/precise/,   is that
> by-accident or we plan to support precise for one more LTS?

The configuration is there but there aren't any packages built for it:

http://download.ceph.com/debian-jewel/pool/main/c/ceph/

This is a side-effect of the readiness on our build system that will,
by default, allow other distros to be configured to get included
in the repo even if there aren't any actual binaries.


>
> Or, in other word, is it safe for user in precise to upgrade to jewel?
>
> 2016-03-29 0:24 GMT+08:00 Simon Leinen <simon.leinen@switch.ch>:
>> Sage Weil writes:
>>> The first release candidate for Jewel is now available!
>>
>> Cool!
>>
>> [...]
>>> Packages for aarch64 will also be posted shortly!
>>
>> According to the announcement, Ubuntu Xenial should now be supported
>> instead of Precise; but I don't see Xenial packages on
>> download.ceph.com.  Will those arrive, or should we get them from
>> Canonical's Xenial repo?
>> --
>> Simon.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
