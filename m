From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: https://github.com/ceph/rocksdb
Date: Tue, 5 Sep 2017 10:14:02 -0500
Message-ID: <c908e0ef-2a05-443e-cd10-c64a7bfa60fa@gmail.com>
References: <59ae8d6e.19c3620a.f5a02.1b4c@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36764 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdIEPOE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Sep 2017 11:14:04 -0400
Received: by mail-qk0-f174.google.com with SMTP id z143so12498326qkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Sep 2017 08:14:04 -0700 (PDT)
In-Reply-To: <59ae8d6e.19c3620a.f5a02.1b4c@mx.google.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit <amitkuma@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/05/2017 06:41 AM, Amit wrote:
> Hello,
>
> To submit PR for issues in rocksdb.
>
> Do we need to send commits to this upstream? Or other place?
>
> I submitted few: https://github.com/ceph/rocksdb/pulls
>
> Again I find this is fork of facebook/rocksdb?
>
>

I think we probably want any changes to rocksdb to be approved upstream 
before we start using it.  Probably the first order of business is to 
get feedback from the rocksdb devs here:

https://www.facebook.com/groups/rocksdb.dev/

Mark
