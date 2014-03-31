From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH][RESEND] vfs: Make __d_materialise_dentry() set the materialised
 dentry name correctly
Date: Mon, 31 Mar 2014 17:01:14 +0800
Message-ID: <53392EDA.7000904@intel.com>
References: <1394115376-17109-1-git-send-email-zheng.z.yan@intel.com> <6487FCC2-FB5C-4A32-94EF-5D3352A39781@primarydata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25162 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbaCaJB4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 Mar 2014 05:01:56 -0400
In-Reply-To: <6487FCC2-FB5C-4A32-94EF-5D3352A39781@primarydata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Viro Alexander <viro@zeniv.linux.org.uk>
Cc: Trond Myklebust <trond.myklebust@primarydata.com>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, sage@inktank.com

Hi Al,

Could you include this in 3.15

Regards
Yan, Zheng

On 03/06/2014 10:35 PM, Trond Myklebust wrote:
>=20
> On Mar 6, 2014, at 9:16, Yan, Zheng <zheng.z.yan@intel.com> wrote:
>=20
>> From: David Howells <dhowells@redhat.com>
>>
>> Make __d_materialise_dentry() set the materialised dentry name corre=
ctly by
>> flipping the arguments to switch_names().
>>
>> switch_names() is lazy: if both names are internal to their dentries=
, it'll
>> overwrite that of the first dentry with that of the second, and won'=
t update
>> that of the second.
>>
>> In the case of __d_materialise_dentry(), the second is an already ex=
tant
>> anonymous dentry that we want to insert into the tree in place of th=
e dentry we
>> just looked up[*].  However, the dentry we just looked up carries th=
e name we
>> actually want to use.
>>
>> [*] This is used by NFS to join a mount of a subtree into a mount of=
 a tree
>> nearer the root when the two meet, where both mounts share a superbl=
ock and
>> thus a set of dentries.
>>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> ---
>> fs/dcache.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index 265e0ce..ff779d4 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -2698,7 +2698,7 @@ static void __d_materialise_dentry(struct dent=
ry *dentry, struct dentry *anon)
>>
>> 	dparent =3D dentry->d_parent;
>>
>> -	switch_names(dentry, anon);
>> +	switch_names(anon, dentry);
>> 	swap(dentry->d_name.hash, anon->d_name.hash);
>>
>> 	dentry->d_parent =3D dentry;
>=20
> Well spotted...
>=20
> We ought to better document the fact that =92switch_names=92 is asymm=
etrical. Perhaps change it to =91update_target_name=92, and then switch=
 the argument names so that the =92target=92 really is the thing that g=
ets updated?
>=20
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, PrimaryData
> trond.myklebust@primarydata.com
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
