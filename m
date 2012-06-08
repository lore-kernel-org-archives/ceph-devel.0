From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] rbd: Clear ceph_msg->bio_iter for retransmitted message
Date: Fri, 08 Jun 2012 08:17:37 +0200
Message-ID: <4FD19901.3010100@suse.de>
References: <1338969797-8412-1-git-send-email-zheng.z.yan@intel.com> <4FCF64C8.7060506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51799 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933517Ab2FHGRk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Jun 2012 02:17:40 -0400
In-Reply-To: <4FCF64C8.7060506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: Alex Elder <elder@dreamhost.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On 06/06/2012 04:10 PM, Alex Elder wrote:
> On 06/06/2012 03:03 AM, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> The bug can cause NULL pointer dereference in write_partial_msg_page=
s
>=20
> Although this looks simple enough, I want to study it a little more
> before committing it.  I've been wanting to walk through this bit
> of code anyway so I'll do that today.
>=20
> One quick observation though:  m->bio_iter really ought to be
> initialized only within #ifdef CONFIG_BLOCK (although I see it's
> defined without it in the structure definition).  At some point
> I'll put together a cleanup patch to do that everywhere; feel free
> to do that yourself if you are so inclined.
>=20
> 					-Alex
>=20
>> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
>> ---
>>  net/ceph/messenger.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 1a80907..785b953 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -598,6 +598,7 @@ static void prepare_write_message(struct ceph_co=
nnection *con)
>>  	     le32_to_cpu(con->out_msg->footer.front_crc),
>>  	     le32_to_cpu(con->out_msg->footer.middle_crc));
>> =20
>> +	m->bio_iter =3D NULL;
>>  	/* is there a data payload? */
>>  	if (le32_to_cpu(m->hdr.data_len) > 0) {
>>  		/* initialize page iterator */
>=20
Incidentally, we've come across the same issue. First thing which
struck me was this:

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 524f4e4..759d4d2 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -874,7 +874,7 @@ static int write_partial_msg_pages(struct
ceph_connection *c
on)
                        page =3D list_first_entry(&msg->pagelist->head,
                                                struct page, lru);
 #ifdef CONFIG_BLOCK
-               } else if (msg->bio) {
+               } else if (msg->bio_iter) {
                        struct bio_vec *bv;

                        bv =3D bio_iovec_idx(msg->bio_iter, msg->bio_se=
g);

We've called bio_list_init() a few lines above; however, it might
return with a NULL bio_iter. So for consistency we should be
checking for ->bio_iter here, as this is what we'll be using
afterwards anyway.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
