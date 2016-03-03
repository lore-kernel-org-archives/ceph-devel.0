From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: question on rbd mirror feature
Date: Wed, 2 Mar 2016 22:02:08 -0500 (EST)
Message-ID: <787694555.33082090.1456974128233.JavaMail.zimbra@redhat.com>
References: <06681238D8946F44A60AA400760A1CBF022B2D24@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:50709 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944AbcCCDCK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 22:02:10 -0500
In-Reply-To: <06681238D8946F44A60AA400760A1CBF022B2D24@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuan Zhou <yuan.zhou@intel.com>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>


> Hi Jason,

> I=E2=80=99m a software engineer in Intel. We=E2=80=99re trying to do =
some tests with the new
> rbd mirror feature and got some basic questions here:
> 1. Each rbd_write will be append to journal then ACK to clients. Rbd =
journal
> will flush the contents back to rados with some policy. In the flush =
period,
> will the rbd journal read data out from the journal objects and then =
do the
> flush?

Correct, a write will first append the event to the journal before proc=
eeding with the actual write to the image.  If caching is enabled, the =
write is immediately applied to the in-memory cache but any writeback o=
f the affected extent will be paused until the event and its predecesso=
rs are safe in the journal.  Once the journal event append is acked by =
rados, the actual write to the RBD objects can proceed (i.e. unpause an=
y writeback if the cache is enabled or actually perform the write if ca=
che is disabled).  The default configuration will append the events to =
the journal without batching.  There are configurable options to batch =
the journal append for X seconds, or Y bytes, or Z events -- depending =
on how much data you are comfortable losing in the event of a crash.  N=
ote that any flush request to librbd will flush out any batched journal=
 events.  There is an open tracker ticket [1] to optionally throttle li=
brbd flush requests if, again, a user doesn't mind losing X seconds of =
data even in the presence of flush requests.

> 2. If a rbd_read is accessing the contents that just got written(in r=
bd
> journal but not flushed back), will it serviced from the rbd journal?

If cache is enabled, we service the read from the in-memory cache (sinc=
e I didn't want to develop essentially another cache layer).  If the ca=
che is disabled, we won't ack the librbd write request until the RBD im=
age has been updated.

> 3. Is rbd journal feature working with the existing rbd cache? If yes=
 then
> rbd journal should be laying under of rbd cache?

Yes, the tentacles of journaling reach into the cache for tracking whic=
h extents are associated to which journal event.  When librbd adds an e=
xtent to the cache, it provides the associated journal event identifier=
=2E   The cache layer will provide this identifier back to librbd when =
requesting writeback so that librbd can "pause" the request until the j=
ournal event is safe (if needed).  The cache also tracks when extents a=
re overwritten by future write requests and again informs librbd that i=
t should never expect to receive a writeback for a particular journal e=
vent extent.  There is some possible future optimization with this if j=
ournal event batching is enabled where a complete event overwrite could=
 result in the batched journal event being removed from the pending app=
end-to-journal list.

> Thanks for implementing this amazon feature!

> -yuan

[1] http://tracker.ceph.com/issues/13983

--=20

Jason Dillaman=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
