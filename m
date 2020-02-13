From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: fs add reconfiguring superblock parameters support
Date: Thu, 13 Feb 2020 09:48:41 +0800
Message-ID: <bcfb8841-dbae-e9cc-b509-c8b7a77dc337@redhat.com>
References: <20200212085454.35665-1-xiubli@redhat.com>
 <c2571e75d3fe3f37ea77c5b1acaa5e3dcc45cb2b.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48092 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729289AbgBMBsx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Feb 2020 20:48:53 -0500
In-Reply-To: <c2571e75d3fe3f37ea77c5b1acaa5e3dcc45cb2b.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/12 20:01, Jeff Layton wrote:
> On Wed, 2020-02-12 at 03:54 -0500, xiubli@redhat.com wrote:
[...]
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index 9a21054059f2..8df506dd9039 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -1175,7 +1175,57 @@ static void ceph_free_fc(struct fs_context *fc)
>>  =20
>>   static int ceph_reconfigure_fc(struct fs_context *fc)
>>   {
>> -	sync_filesystem(fc->root->d_sb);
>> +	struct super_block *sb =3D fc->root->d_sb;
>> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(sb);
>> +	struct ceph_mount_options *fsopt =3D fsc->mount_options;
>> +	struct ceph_parse_opts_ctx *pctx =3D fc->fs_private;
>> +	struct ceph_mount_options *new_fsopt =3D pctx->opts;
>> +	int ret;
>> +
>> +	sync_filesystem(sb);
>> +
>> +	ret =3D ceph_reconfigure_copts(fc, pctx->copts, fsc->client->options=
);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (new_fsopt->snapdir_name !=3D fsopt->snapdir_name)
>> +		return invalf(fc, "ceph: reconfiguration of snapdir_name not allowe=
d");
>> +
>> +	if (new_fsopt->mds_namespace !=3D fsopt->mds_namespace)
>> +		return invalf(fc, "ceph: reconfiguration of mds_namespace not allow=
ed");
>> +
>> +	if (new_fsopt->wsize !=3D fsopt->wsize)
>> +		return invalf(fc, "ceph: reconfiguration of wsize not allowed");
>> +	if (new_fsopt->rsize !=3D fsopt->rsize)
>> +		return invalf(fc, "ceph: reconfiguration of rsize not allowed");
>> +	if (new_fsopt->rasize !=3D fsopt->rasize)
>> +		return invalf(fc, "ceph: reconfiguration of rasize not allowed");
>> +
> Odd. I would think the wsize, rsize and rasize are things you _could_
> reconfigure at remount time.
>
> In any case, I agree with Ilya. Not everything can be changed on a
> remount. It'd be best to identify some small subset of mount options
> that you do need to allow to be changed, and ensure we can do that.

Checked this again, the wsize/rasize should be okay for this.

But for the rsize, we need to apply the change to the bdi->io_pages,=20
which will be used in the ondemand_readahead(), likes:

392=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
393=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the reques=
t exceeds the readahead window, allow the=20
read to
394=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * be up to the =
optimal hardware IO size
395=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
396=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (req_size > max_pa=
ges && bdi->io_pages > max_pages)
397=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 max_pages =3D min(req_size, bdi->io_pages);

For example:

Assume the max_pages =3D 100, req_size =3D 1000, the old bdi->io_pages =3D=
 10.

If the bdi->io_pages get changed from 10 --> 1000, between Line#396 and=20
Line#397, after Line#397 we are expecting to get max_pages =3D 10, but=20
actually we get 1000 instead.

But this should be okay for the page cache readahead stuff, it doesn't=20
matter here, right ? If so we can reconfigure the rsize then.

Thanks.
