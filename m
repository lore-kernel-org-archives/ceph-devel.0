From: Mark Nelson <mnelson@redhat.com>
Subject: Re: OSD journal sizing
Date: Thu, 22 Sep 2016 15:14:05 -0500
Message-ID: <e2b9392c-cf56-b625-3e3f-caeffa0dffe2@redhat.com>
References: <90b637e7-8cac-ab6e-2363-65eb83760c2d@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933451AbcIVUOI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Sep 2016 16:14:08 -0400
In-Reply-To: <90b637e7-8cac-ab6e-2363-65eb83760c2d@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/22/2016 03:02 PM, Nathan Cutler wrote:
> I've been researching OSD journals lately, and just realized something
> that's not particularly nice.
>
> SSDs are getting bigger and bigger. It's typical for customers to use
> e.g. a 500GB SSD for their journals. If the OSDs themselves are on
> spinners, there is no use in having journals bigger than 10GB because
> the 7200 RPMs impose a hard ceiling on throughput that spinners can
> achieve.
>
> Now, SSDs need wear-leveling to avoid premature failure. If only a small
> region of the SSD is partitioned/used, users may fear (regardless of the
> reality, whatever it may be) that this small region will be "pummeled to
> death" by Ceph and cause the expensive SSD to fail prematurely.
>
> I *thought* this could be addressed by creating the journal partitions
> large enough to fill the entire disk and using the "osd journal size"
> parameter to limit how much disk capacity is actually used for
> journaling, but now I just noticed that the "osd journal size" parameter
> "is ignored if the journal is a block device, and the entire block
> device is used."

Have you seen evidence that journal writes are hitting the same cells on 
SSDs when the journals are typically sized?  It seems a little premature 
to me to create huge journals based on the fear that wear leveling isn't 
functioning without any evidence.

>
> And while working on http://tracker.ceph.com/issues/16878 it occurred to
> me that large journals are not getting tested much. Is that a valid
> assumption?
>
> Next week I plan to attempt to make a reproducer for the bug, and then
> try to come up with a patch to fix it. Any ideas/pointers, either here
> or in the tracker, would be appreciated.
>
