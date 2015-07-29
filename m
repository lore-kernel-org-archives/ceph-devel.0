From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Wed, 29 Jul 2015 18:40:01 -0500
Message-ID: <55B96451.30706@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com> <20150729175515.GA16804@infradead.org> <55B95ACC.2030306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <55B95ACC.2030306@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 07/29/2015 05:59 PM, Mike Christie wrote:
> On 07/29/2015 12:55 PM, Christoph Hellwig wrote:
>> On Wed, Jul 29, 2015 at 04:23:38AM -0500, mchristi@redhat.com wrote:
>>> From: Mike Christie <michaelc@cs.wisc.edu>
>>>
>>> LIO uses scatterlist for its page/data management. This patch
>>> adds a scatterlist messenger data type, so LIO can pass its sg
>>> down directly to rbd.
>>
>> Just as I mentioned for David's patches this is the wrong way to attack
>> your problem.  The block layer already supports WRITE SAME, and COMPARE
>> and WRITE nees to be supported at that level too insted of creating
>> artifical bypasses.
> 
> Why do I have to use the block layer? I just want to map the se_cmd to a
> ceph request and then put it back on the wire. I don't think I need any
> of the block layer services. We will do things like io scheduling on the
> OSD side. We just want to use LIO as more of a passthrough.

Maybe I misunderstood you.

I guess I was viewing this similar to cephfs where it does not use rbd
and the block layer. It just makes ceph/rados calls directly using
libceph. I am using rbd.c for its helper/wrapper functions around the
libceph ones, but I could just make libceph calls directly too.

Were you saying because for lio support we need to do more block
layer'ish operations like write same, compare and write, etc than
cephfs, then I should not do the lio backend and we should always go
through rbd for lio support?

Is that for all operations? For distributed TMFs and PRs then are you
thinking I should make those more block layer based (some sort of queue
or block deivce callouts or REQ_ types), or should those still have some
sort of lio callouts which could call different locking/cluster APIs
like libceph?
