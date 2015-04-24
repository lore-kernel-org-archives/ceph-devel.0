From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCH 0/3] rbd: header read/refresh improvements
Date: Fri, 24 Apr 2015 09:25:27 -0400
Message-ID: <4953EC7A-27D2-4846-8C1D-99F9C21A7D92@redhat.com>
References: <cover.1429814290.git.dfuller@redhat.com> <553A411A.8060902@ieee.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52623 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbbDXNZb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Apr 2015 09:25:31 -0400
In-Reply-To: <553A411A.8060902@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: ceph-devel@vger.kernel.org


> On Apr 24, 2015, at 9:11 AM, Alex Elder <elder@ieee.org> wrote:
>=20
> On 04/23/2015 02:06 PM, Douglas Fuller wrote:
>> Support multiple class op calls in one ceph_msg and consolidate rbd =
header
>> read and refresh processes to use this feature to reduce the number =
of
>> ceph_msgs sent for that process. Refresh features on header refresh =
and
>> begin returning EIO if features have changed since mapping.
>>=20
>> Douglas Fuller (3):
>>   ceph: support multiple class method calls in one ceph_msg
>>   rbd: combine object method calls in header refresh using fewer
>>     ceph_msgs
>>   rbd: re-read features during header refresh and detect changes.
>>=20
>>  drivers/block/rbd.c             | 518 +++++++++++++++++++++++++++++=
-----------
>>  include/linux/ceph/osd_client.h |   3 +-
>>  net/ceph/messenger.c            |   4 +
>>  net/ceph/osd_client.c           |  92 ++++++-
>>  4 files changed, 470 insertions(+), 147 deletions(-)
>>=20
>=20
> In case Ilya or others don't get to it soon, I plan to review this
> series tomorrow.
>=20
> 					-Alex

Much appreciated. I sent an update this morning, as well.

=97Doug--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
