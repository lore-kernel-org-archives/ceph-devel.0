From: "Yan, Zheng " <yanzheng@21cn.com>
Subject: Re: [PATCH] rbd: Clear ceph_msg->bio_iter for retransmitted message
Date: Thu, 7 Jun 2012 06:35:08 +0800
Message-ID: <CAAM7YAmV7nG5fKuFuDKTRTggE4RKQGiDi9Bcf4tASr4_S43YOw@mail.gmail.com>
References: <1338969797-8412-1-git-send-email-zheng.z.yan@intel.com>
	<4FCFD56C.9050103@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39131 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758968Ab2FFWfJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 18:35:09 -0400
Received: by obbtb18 with SMTP id tb18so10891132obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 15:35:09 -0700 (PDT)
In-Reply-To: <4FCFD56C.9050103@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On Thu, Jun 7, 2012 at 6:10 AM, Alex Elder <elder@dreamhost.com> wrote:
> On 06/06/2012 03:03 AM, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> The bug can cause NULL pointer dereference in write_partial_msg_page=
s
>>
>> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
>> ---
>> =A0net/ceph/messenger.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 1a80907..785b953 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -598,6 +598,7 @@ static void prepare_write_message(struct ceph_co=
nnection *con)
>> =A0 =A0 =A0 =A0 =A0 =A0le32_to_cpu(con->out_msg->footer.front_crc),
>> =A0 =A0 =A0 =A0 =A0 =A0le32_to_cpu(con->out_msg->footer.middle_crc))=
;
>>
>> + =A0 =A0 m->bio_iter =3D NULL;
>> =A0 =A0 =A0 /* is there a data payload? */
>> =A0 =A0 =A0 if (le32_to_cpu(m->hdr.data_len) > 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* initialize page iterator */
>
> OK, now that I've looked at this a little bit I think I have a small
> preference for doing this assignment earlier in that function, where
> there is already special handling that is dependent on whether the
> message being processed is being re-sent or not:
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * only assign outgoing seq # if we haven't sent this =
message
> =A0 =A0 =A0 =A0 * yet. =A0if it is requeued, resend with it's origina=
l seq.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (m->needs_out_seq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->hdr.seq =3D cpu_to_le64(++con->out_=
seq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->needs_out_seq =3D false;
> =A0 =A0 =A0 =A0}
>
> So I'd suggest it look like:
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * only assign outgoing seq # if we haven't sent this =
message
> =A0 =A0 =A0 =A0 * yet. =A0if it is requeued, resend with it's origina=
l seq.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (m->needs_out_seq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->hdr.seq =3D cpu_to_le64(++con->out_=
seq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->needs_out_seq =3D false;
> =A0 =A0 =A0 =A0}
> #ifdef CONFIG_BLOCK
> =A0 =A0 =A0 =A0else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Need to reinitialize the iterator o=
n resends */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->bio_iter =3D NULL;
> =A0 =A0 =A0 =A0}
> #endif
>
> Please let me know if you concur with my proposed modification or
> whether you feel strongly we should go with your original fix.
>
I'm OK with it.

Thanks
Yan, Zheng
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
