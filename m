From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Thu, 6 Apr 2017 15:30:36 +0200
Message-ID: <db761315-61b5-bcac-e9ae-519ae8f769dc@corp.ovh.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
 <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo302.mail-out.ovh.net ([137.74.110.74]:41342 "EHLO
        1.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933707AbdDFNak (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 09:30:40 -0400
In-Reply-To: <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/06/2017 03:25 PM, Sage Weil wrote:
> On Thu, 6 Apr 2017, Piotr Dałek wrote:
>> Hello,
>>
>> We recently had an interesting issue with RBD images and filestore on Jewel
>> 10.2.5:
>> We have a pool with RBD images, all of them mostly untouched (large areas of
>> those images unused), and once we added 3 new OSDs to cluster, objects
>> representing these images grew substantially on new OSDs: objects hosting
>> unused areas of these images on original OSDs remained small (~8K of space
>> actually used, 4M allocated), but on new OSDs were large (4M allocated *and*
>> actually used). After investigation we concluded that Ceph didn't propagate
>> sparse file information during cluster rebalance, resulting in correct data
>> contents on all OSDs, but no sparse file data on new OSDs, hence disk space
>> usage increase on those.
>>
>> [..]
>
> I think the solution here is to use sparse_read during recovery.  The
> PushOp data representation already supports it; it's just a matter of
> skipping the zeros.  The recovery code could also have an option to check
> for fully-zero regions of the data and turn those into holes as well.  For
> ReplicatedBackend, see build_push_op().

Can we abuse that to reduce amount of regular (client/inter-osd) network 
traffic?

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
