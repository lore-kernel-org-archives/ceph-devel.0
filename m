From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH 2/6] ceph: hold extra reference to r_parent over life of
 request
Date: Thu, 9 Jan 2020 21:16:02 +0800
Message-ID: <95938157-3d47-52e5-d847-b058e1191151@redhat.com>
References: <20200106153520.307523-1-jlayton@kernel.org>
 <20200106153520.307523-3-jlayton@kernel.org>
 <e8e28503-bda4-df57-6a42-33761e716fe4@redhat.com>
 <7baad50a9e9f8d8f93171e5d4756bc35ab36a319.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729266AbgAINQO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2020 08:16:14 -0500
In-Reply-To: <7baad50a9e9f8d8f93171e5d4756bc35ab36a319.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com

On 2020/1/9 19:20, Jeff Layton wrote:
> On Thu, 2020-01-09 at 10:05 +0800, Xiubo Li wrote:
>> On 2020/1/6 23:35, Jeff Layton wrote:
>>> Currently, we just assume that it will stick around by virtue of the
>>> submitter's reference, but later patches will allow the syscall to
>>> return early and we can't rely on that reference at that point.
>>>
>>> Take an extra reference to the inode when setting r_parent and releas=
e
>>> it when releasing the request.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/ceph/mds_client.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>> index 94cce2ab92c4..b7122f682678 100644
>>> --- a/fs/ceph/mds_client.c
>>> +++ b/fs/ceph/mds_client.c
>>> @@ -708,8 +708,10 @@ void ceph_mdsc_release_request(struct kref *kref=
)
>>>    		/* avoid calling iput_final() in mds dispatch threads */
>>>    		ceph_async_iput(req->r_inode);
>>>    	}
>>> -	if (req->r_parent)
>>> +	if (req->r_parent) {
>>>    		ceph_put_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
>>> +		ceph_async_iput(req->r_parent);
>>> +	}
>>>    	ceph_async_iput(req->r_target_inode);
>>>    	if (req->r_dentry)
>>>    		dput(req->r_dentry);
>>> @@ -2706,8 +2708,10 @@ int ceph_mdsc_submit_request(struct ceph_mds_c=
lient *mdsc, struct inode *dir,
>>>    	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
>>>    	if (req->r_inode)
>>>    		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
>>> -	if (req->r_parent)
>>> +	if (req->r_parent) {
>>>    		ceph_get_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
>>> +		ihold(req->r_parent);
>>> +	}
>> This might also fix another issue when the mdsc request is timedout an=
d
>> returns to the vfs, then the r_parent maybe released in vfs. And then =
if
>> we reference it again in mdsc handle_reply() -->
>> ceph_mdsc_release_request(),  some unknown issues may happen later ??
>>
> AIUI, when a timeout occurs, the req is unhashed such that handle_reply
> can't find it. So, I doubt this affects that one way or another.

If my understanding is correct, such as for rmdir(), the logic will be :

req =3D ceph_mdsc_create_request()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=
 ref =3D=3D 1

ceph_mdsc_do_request(req) -->

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_mdsc_submit_request(req)=
 -->

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 __register_request(req) // ref =3D=3D 2

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_mdsc_wait_request(req)=C2=
=A0 // If timedout

ceph_mdsc_put_request(req)=C2=A0 // ref =3D=3D 1

Then in handled_reply(), only when we get a safe reply it will call=20
__unregister_request(req), then the ref could be 0.

Though it will ihold()/ceph_async_iput() the req->r_unsafe_dir(=3D=20
req->r_parent) , but the _iput() will be called just before we reference=20
the req->r_parent in the _relase_request(). And the _iput() here may=20
call the iput_final().

BRs



>>>    	if (req->r_old_dentry_dir)
>>>    		ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
>>>    				  CEPH_CAP_PIN);
>>
