From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: jewel: bad rados_buffer_free from librados python bindings
Date: Mon, 24 Oct 2016 08:57:16 -0700
Message-ID: <2f802c6e-bf7b-9137-4335-7e991a95f4a6@redhat.com>
References: <580881D6.2070603@dachary.org>
 <alpine.DEB.2.11.1610201352030.21052@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965167AbcJXP5S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Oct 2016 11:57:18 -0400
In-Reply-To: <alpine.DEB.2.11.1610201352030.21052@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 10/20/2016 06:52 AM, Sage Weil wrote:
> On Thu, 20 Oct 2016, Loic Dachary wrote:
>> H Sage,
>>
>> It looks like http://tracker.ceph.com/issues/15454 surfaced in jewel (failed twice in a row at http://tracker.ceph.com/issues/17487#note-19). It did not occur before, therefore I suspect it's a side effect of some of the commits in the jewel backports integration branch ( http://tracker.ceph.com/issues/17487#note-16 ), but I don't see which commit in that branch could have caused that kind of misbehavior.
>>
>> Since you marked http://tracker.ceph.com/issues/15454 as Resolved with no commits attached, I suppose it means it went away for some reason. Could you please confirm ?
>
> Hmm, unfortunately I don't remember working on this one.  My guess is it
> came up during a bug scrub discussion and that's when it got closed.
> Hopefully Kefu or Josh remember?

I don't think I've seen that particular bug before, so hopefully Kefu
remembers it.

