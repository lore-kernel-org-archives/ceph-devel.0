From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCHv2 5/6] osd_client: add support for notify payloads via notify event
Date: Wed, 17 Jun 2015 13:07:59 -0400
Message-ID: <A4779E09-21B7-408C-9F56-427B2CB24B89@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com> <c486ba353fea150db8bc78b9ad03f07f03882b46.1434550968.git.dfuller@redhat.com> <55819C39.4010002@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60150 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890AbbFQRIA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jun 2015 13:08:00 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id B7A7EB8BBD
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 17:08:00 +0000 (UTC)
In-Reply-To: <55819C39.4010002@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org


> On Jun 17, 2015, at 12:11 PM, Mike Christie <mchristi@redhat.com> wro=
te:
>=20
> On 06/17/2015 09:25 AM, Douglas Fuller wrote:
>> @@ -2486,6 +2579,7 @@ static void __do_event(struct ceph_osd_client =
*osdc, u8 opcode,
>> 		case CEPH_WATCH_EVENT_NOTIFY_COMPLETE:
>> 			if (event) {
>> 				event->notify.notify_data =3D data;
>> +				event->notify.notify_data_len =3D data_len;
>> 				if (event->osd_req) {
>> 					ceph_osdc_cancel_request(event->osd_req);
>> 					event->osd_req =3D NULL;
>> @@ -2532,11 +2626,13 @@ static void handle_watch_notify(struct ceph_=
osd_client *osdc,
>> 	if (msg->hdr.version >=3D 2)
>> 		ceph_decode_32_safe(&p, end, return_code, bad);
>>=20
>> -	if (msg->hdr.version >=3D 3)
>> +	if (msg->hdr.version >=3D 3) {
>> 		ceph_decode_64_safe(&p, end, notifier_gid, bad);
>> +		data =3D list_first_entry(&msg->data, struct ceph_msg_data, links=
);
>> +	}
>>=20
>> 	__do_event(osdc, opcode, cookie, notify_id, payload_len, payload,
>> -		return_code, notifier_gid, data);
>> +		return_code, notifier_gid, data->pages, data->length);
>>=20
>> 	return;
>>=20
>> @@ -3055,12 +3151,33 @@ static struct ceph_msg *alloc_msg(struct cep=
h_connection *con,
>> 	struct ceph_osd *osd =3D con->private;
>> 	int type =3D le16_to_cpu(hdr->type);
>> 	int front =3D le32_to_cpu(hdr->front_len);
>> +	struct ceph_msg *m;
>> +	size_t len =3D con->in_hdr.data_len;
>>=20
>> 	*skip =3D 0;
>> 	switch (type) {
>> 	case CEPH_MSG_OSD_MAP:
>> 	case CEPH_MSG_WATCH_NOTIFY:
>> -		return ceph_msg_new(type, front, GFP_NOFS, false);
>> +		m =3D ceph_msg_new(type, front, GFP_NOFS, false);
>> +		if (!m)
>> +			goto out;
>> +
>> +		if (len > 0) {
>> +			struct page **pages;
>> +			struct ceph_osd_data osd_data;
>> +			pages =3D ceph_alloc_page_vector(
>> +				      calc_pages_for(0, len), GFP_NOFS);
>> +			if (!pages)
>> +				goto out2;
>> +			osd_data.type =3D CEPH_OSD_DATA_TYPE_PAGES;
>> +			osd_data.pages =3D pages;
>> +			osd_data.length =3D len;
>> +			osd_data.alignment =3D 0;
>> +			osd_data.pages_from_pool =3D false;
>> +			osd_data.own_pages =3D false;
>> +			ceph_osdc_msg_data_add(m, &osd_data);
>> +		}
>> +		return m;
>> 	case CEPH_MSG_OSD_OPREPLY:
>> 		return get_reply(con, hdr, skip);
>> 	default:
>> @@ -3069,6 +3186,12 @@ static struct ceph_msg *alloc_msg(struct ceph=
_connection *con,
>> 		*skip =3D 1;
>> 		return NULL;
>> 	}
>> +out2:
>> +	ceph_msg_put(m);
>> +out:
>> +	pr_err("couldn't allocate reply, will skip\n");
>> +	*skip =3D 1;
>> +	return NULL;
>> }
>>=20
>> /*
>>=20
>=20
> When is the data freed?

The data itself is not, the user has to free it.

> Does it get freed when we do dispatch->ceph_msg_put [is this the last
> put so we do] -> ceph_msg_release?

No. For some reason, ceph_msg_release only frees pagelists and does not=
 touch page vectors.

Generally, users calling osd ops expecting replies as page vectors have=
 to free them when they=92re finished. I=92m not sure why this is the d=
efault behavior, but it seems to be. For this case, it might make more =
sense to free the data in __release_event.

> If so, then I think when __do_event() does complete_all() the thread
> that did the ceph_osdc_wait_event could end up accessing freed memory=
=2E

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
