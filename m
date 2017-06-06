From: Dan Mick <dmick@redhat.com>
Subject: Re: make check failures on arm64
Date: Tue, 6 Jun 2017 11:17:06 -0700
Message-ID: <0ce9b5e6-338d-bf34-600c-d75e0f235884@redhat.com>
References: <f30c77d2-76f6-5028-dca7-848b624acb70@redhat.com>
 <CAJE9aOM4Z_NPLeq85P+b-DhwNbtAz5MR_cMuts8SdoNpJOisOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751239AbdFFSRG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Jun 2017 14:17:06 -0400
In-Reply-To: <CAJE9aOM4Z_NPLeq85P+b-DhwNbtAz5MR_cMuts8SdoNpJOisOw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

That looks like it got them all.  Thanks.

On 06/06/2017 06:43 AM, kefu chai wrote:
> On Tue, Jun 6, 2017 at 12:33 PM, Dan Mick <dmick@redhat.com> wrote:
>> Haven't looked into these yet; just in process of redoing the build to
>> make sure it wasn't spurious.  Looks like some things crept in.
> 
> see https://github.com/ceph/ceph/pull/15515
> 
>>
>> The following tests FAILED:
>>          13 - unittest_bufferlist.sh (Failed)
>>          31 - unittest_bufferlist (Failed)
>>          62 - unittest_sloppy_crc_map (Failed)
>>          68 - unittest_crc32c (Failed)
>>          76 - unittest_bit_vector (Failed)
>>         114 - unittest_journal (Failed)
>>         140 - unittest_bluestore_types (Failed)
