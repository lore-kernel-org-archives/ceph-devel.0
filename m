From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Wed, 29 Jul 2015 17:59:24 -0500
Message-ID: <55B95ACC.2030306@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com> <20150729175515.GA16804@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <20150729175515.GA16804@infradead.org>
Sender: target-devel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 07/29/2015 12:55 PM, Christoph Hellwig wrote:
> On Wed, Jul 29, 2015 at 04:23:38AM -0500, mchristi@redhat.com wrote:
>> From: Mike Christie <michaelc@cs.wisc.edu>
>>
>> LIO uses scatterlist for its page/data management. This patch
>> adds a scatterlist messenger data type, so LIO can pass its sg
>> down directly to rbd.
> 
> Just as I mentioned for David's patches this is the wrong way to attack
> your problem.  The block layer already supports WRITE SAME, and COMPARE
> and WRITE nees to be supported at that level too insted of creating
> artifical bypasses.

Why do I have to use the block layer? I just want to map the se_cmd to a
ceph request and then put it back on the wire. I don't think I need any
of the block layer services. We will do things like io scheduling on the
OSD side. We just want to use LIO as more of a passthrough.
