From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCH 4/6] osd_client, rbd: update event interface for watch/notify2
Date: Wed, 17 Jun 2015 09:28:35 -0400
Message-ID: <16ACAFCB-0E28-4762-BDF9-E68B7FE5D817@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com> <1e922f4d9ba0ea00be5a387247866f44cb0b6488.1434124007.git.dfuller@redhat.com> <5580AEC9.9020908@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56847 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081AbbFQN2h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jun 2015 09:28:37 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id B66FA3702D5
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 13:28:37 +0000 (UTC)
In-Reply-To: <5580AEC9.9020908@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: ceph-devel@vger.kernel.org


> On Jun 16, 2015, at 7:18 PM, Josh Durgin <jdurgin@redhat.com> wrote:
>=20
> On 06/12/2015 08:56 AM, Douglas Fuller wrote:
>>=20
>> @@ -3132,6 +3132,26 @@ static void rbd_watch_cb(u64 ver, u64 notify_=
id, u8 opcode, s32 return_code,
>>  		rbd_warn(rbd_dev, "notify_ack ret %d", ret);
>>  }
>>=20
>> +static void rbd_watch_error_cb(void *arg, u64 cookie, int err)
>> +{
>> +	struct rbd_device *rbd_dev =3D (struct rbd_device *)arg;
>> +	int ret;
>> +
>> +	dout("%s: watch error %d on cookie %llu\n", rbd_dev->header_name,
>> +		err, cookie);
>> +	rbd_warn(rbd_dev, "%s: watch error %d on cookie %llu\n",
>> +	         rbd_dev->header_name, err, cookie);
>> +
>> +	/* reset watch */
>> +	rbd_dev_refresh(rbd_dev);
>> +	rbd_dev_header_unwatch_sync(rbd_dev);
>> +	ret =3D rbd_dev_header_watch_sync(rbd_dev);
>> +	BUG_ON(ret); /* XXX: was the image deleted? can we be more gracefu=
l? */
>> +	rbd_dev_refresh(rbd_dev);
>=20
> Why refresh before and after unwatching? Only the second one seems
> necessary.

The first one isn=92t strictly necessary; I can remove it if you want.

If we get a watch error, we may very well have a situation in which we =
need to stop I/O to the device because the underlying image has been de=
leted or its features have changed. We don=92t actually do that yet (we=
 just print a warning message), but the extra refresh was to handle tha=
t case early, even before we bothered trying to re-establish the watch.=
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
