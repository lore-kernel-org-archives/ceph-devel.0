From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: commit ad12d5d5be41ce introduces a mkcephfs regression?
Date: Wed, 20 Oct 2010 15:27:54 -0700
Message-ID: <AANLkTi=4F4ujKD1bkfZYNNhccVSUbPcjB-pbyodFBVL7@mail.gmail.com>
References: <1287587307.6806.15.camel@sale659.sandia.gov>
	<AANLkTi=GukFwnuYg0VcprwXi7fkPKU-o4aO1Z6ZtQw_V@mail.gmail.com>
	<1287607793.6806.46.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45796 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab0JTW1z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 18:27:55 -0400
Received: by fxm4 with SMTP id 4so3175815fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Oct 2010 15:27:54 -0700 (PDT)
In-Reply-To: <1287607793.6806.46.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Fixed by 18b1f78b3df1a611e0c7932a2053d6b19a1ddc01.

cheers,
Colin


On Wed, Oct 20, 2010 at 1:49 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi Colin,
>
> On Wed, 2010-10-20 at 13:28 -0600, Colin McCabe wrote:
>> Hi Jim,
>>
>> I think you're right. Commit ad12d5d5be41ce fixed a bug for users
>> creating a journal that resided in a regular file, but introduced an
>> inconvenience for users who put the journal on a raw block device. If
>> no size is specified, but a raw block device is given as an argument,
>> we should discover the size of the raw block device and set the
>> journal size appropriately.
>
> Thanks for taking a look.
>
> -- Jim
>
>>
>> cheers,
>> Colin
>>
>>
>
>
>
