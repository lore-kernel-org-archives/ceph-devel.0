From: Gregory Farnum <greg@inktank.com>
Subject: Re: xattr spillout appears broken :(
Date: Fri, 6 Jun 2014 11:59:35 -0700
Message-ID: <CAPYLRzgvem=pVAXSZFm_tXZ6YJGvb7JEA4BaxfWOkbuF0VKzkQ@mail.gmail.com>
References: <CAPYLRzh7bno0Ppb7hayJrc-TQM24iO-+RgtHYWZmYYVAtBYjVg@mail.gmail.com>
	<CACJqLybuxRR1hgL+b+ijmRzySFH054ZHqOYm50PmLNf-W01JOg@mail.gmail.com>
	<CAPYLRzi8HpyxEmJgyde9yrmpZP2t9_1odEwff_9Tck40tCiSCA@mail.gmail.com>
	<CACJqLyYiUcveR4-CxNsjA7PZjWyc30GjriQ_XfyaB8W+eJopbg@mail.gmail.com>
	<CACJqLyYECXY6p92Kr5G5y3mdPjDavGjFyVq6Ry5UP8fUAgJBqA@mail.gmail.com>
	<CACJqLyb3cNVE=w6th0C4PavGxcppYOkVs0D+XsURyKL9=U4jww@mail.gmail.com>
	<CACJqLyZrGkHBURR-swEwO7+ZK=HpJM3cYvjNhVmMDHCoM+wtxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:50832 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbaFFS7g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 14:59:36 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so5317018qgd.18
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jun 2014 11:59:36 -0700 (PDT)
In-Reply-To: <CACJqLyZrGkHBURR-swEwO7+ZK=HpJM3cYvjNhVmMDHCoM+wtxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jun 6, 2014 at 11:55 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> The fix should make clone method copy "cephos" prefix xattrs
>
> On Sat, Jun 7, 2014 at 2:54 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Hi Greg,
>>
>> I have found the reason. "user.cephos.spill_out" can't be apply to new
>> object when calling clone method. So if the origin object is spill
>> out, the new object still has no spill out marker.
>>
>> I pushed a commit (https://github.com/ceph/ceph/pull/1932) to help
>> cover this situation.

Awesome, thanks!

So that commit is a test that reveals the issue, but we still need to
come up with a fix?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
